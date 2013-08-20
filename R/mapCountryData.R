mapCountryData <- function(
                mapToPlot =         ""
              , nameColumnToPlot =  ""
              , numCats =           7
              , xlim =              NA
              , ylim =              NA
              , mapRegion =         "world"
              , catMethod =         "quantiles"
              , colourPalette =     "heat"
              , addLegend =         TRUE
              , borderCol =         'grey'
              , mapTitle =          'columnName'
              , oceanCol =          NA
              , aspect =            1
              , missingCountryCol = NA
              , add =               FALSE
              , nameColumnToHatch = ""    
              , lwd =               0.5  
              ){
                           
  functionName <- as.character(sys.call()[[1]])
                           
  #browser()  #n to enter the step through debugger, Q to exit
  
  #29/9/2012 to avoid a polypath error, needs sp version >= 0.9-101 
  #added usePolypath=FALSE in plot calls because safer and should work now
  #set_Polypath(FALSE)
  

  #28/6/2013 refactoring
  new <- TRUE
  if (new)
  {
    #mapToPlot <- rwmCheckAndLoadInput( mapToPlot, requireSPDF = TRUE, callingFunction=functionName )    
    mapToPlot <- rwmCheckAndLoadInput( mapToPlot, inputNeeded="sPDF", callingFunction=functionName )  
  } else
  {
    if ( class(mapToPlot)=="SpatialPolygonsDataFrame" ) {
      ## checking if there is any data in the dataFrame
      if ( length(mapToPlot@data[,1]) < 1 ){
        stop("seems to be no data in your chosen file or dataframe in ",functionName) 
        return(FALSE)
      } 
    } else if ( mapToPlot == "" ) {
      message(paste("using example data because no file specified in",functionName))
      mapToPlot <- getMap(resolution="coarse")
      
      ## also setting a default nameColumnToPlot if it isn't set
      if ( nameColumnToPlot == "" ) nameColumnToPlot <- "POP_EST" #
    } else {
      stop(functionName," requires a SpatialPolygonsDataFrame object created by the joinCountryData2Map() function \n")
      return(FALSE) 
    } 
       
  } #end of replaced bit 28/6/2013
  
  ## setting a default nameColumnToPlot if it isn't set
  # moved out of above loop replaced by rwmCheckAndLoadInput
  if ( nameColumnToPlot == "" ) nameColumnToPlot <- "POP_EST" #  
  
  ## check that the column name exists in the data frame
  if ( is.na(match(nameColumnToPlot, names(mapToPlot@data)) )){
    stop("your chosen nameColumnToPlot :'",nameColumnToPlot,"' seems not to exist in your data, columns = ",paste(names(mapToPlot@data),""))
    return(FALSE)
  } 
  
  ##classify data into categories   
  dataCategorised <- mapToPlot@data[[nameColumnToPlot]]

  #30/5/12 if the data are not numerical then set catMethod to categorical
  if ( ! is.numeric(dataCategorised) && catMethod != "categorical" )
     {
     catMethod = "categorical"
     message(paste("using catMethod='categorical' for non numeric data in",functionName))
     }
  
  #checking whether method is categorical, length(catMethod)==1 needed to avoid warning if a vector of breaks is passed  
  if( length(catMethod)==1 && catMethod=="categorical" ) #if categorical, just copy the data, add an as.factor() to convert any data that aren't yet as a factor   
    { 
      dataCategorised <- as.factor( dataCategorised )
      cutVector <- levels(dataCategorised) #doesn't do cutting but is passed for use in legend
      numColours <- length(levels(dataCategorised))
    
    }else if( is.numeric(catMethod) ) 	 
    {	
      #if catMethod is numeric it is already a vector of breaks
      cutVector <- catMethod
      #set numColours from the passed breaks
      numColours <- -1 + length(catMethod)
      #Categorising the data, using a vector of breaks.	
      dataCategorised <- cut( dataCategorised, cutVector, include.lowest=TRUE)          
      
  	} else if( is.character(catMethod) )
  	{
  	  cutVector <- rwmGetClassBreaks( dataCategorised, catMethod=catMethod, numCats=numCats, verbose=TRUE )
  	  #Categorising the data, using a vector of breaks.	
  	  dataCategorised <- cut( dataCategorised, cutVector, include.lowest=TRUE)   
  	  #set numColours from the classified data
      #numColours <- length(dataCategorised) #!*! BUG 7/11/12
  	  numColours <- length(levels(dataCategorised))
  	}
      
  
  ## add extra column to map attribute data
  colNameRaw <- nameColumnToPlot
  colNameCat <- paste(colNameRaw,"categorised",sep='')    
  mapToPlot@data[[colNameCat]] <- dataCategorised     
  
  ## how many colours : numCats may be overriden (e.g. for 'pretty') 	
  #5/11/12 issue that numCOlours got from the data
  #so difficult to keep constant between plots
  #move it further up so I can control it
  #numColours <- length(levels(dataCategorised))
  
  ## get vector of the colours to be used in map (length=num categories)    
  colourVector <- rwmGetColours(colourPalette,numColours)
  
  ## get numeric index of which category each datapoint is in (length = num points)  
  dataCatNums <- as.numeric(dataCategorised)
  
  #adding missing country colour
  if(!is.na(missingCountryCol)){
    #adding missing country colour as the last element
    colourVector<- c(colourVector,missingCountryCol)
    #setting all missing values to the last element
    dataCatNums[is.na(dataCatNums)]<-length(colourVector)
  }

  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  #need to check this
  #Scale hatching variable (and invert). Then threshold above a certain value to secure solid status
  hatchVar = NULL
  if (nameColumnToHatch=='')
     {
      #setting up the map plot
      if (!add) rwmNewMapPlot(mapToPlot,mapRegion=mapRegion,xlim=xlim,ylim=ylim,oceanCol=oceanCol,aspect=aspect)
      #plotting the map
      #plot(mapToPlot,col=colourVector[dataCatNums],border=borderCol,add=TRUE)#,density=c(20:200))#angle=c(1:360),)
      plot(mapToPlot, col=colourVector[dataCatNums], border=borderCol, add=TRUE, usePolypath=FALSE, lwd=lwd)#29/9/2012
      } else  
    {
    #*HATCHING OPTION*
    #setting up the map plot    
     
      hatchVar = mapToPlot@data[[nameColumnToHatch]]
      
      hatchVar = (hatchVar - min(hatchVar, na.rm=TRUE))/max(hatchVar, na.rm=TRUE)
      hatchVar = 1-hatchVar
      hatchVar = (hatchVar*50) + 30
      hatchVar[hatchVar > 79] = -1
      #hatchVar = (hatchVar*70) + 40
      #hatchVar = (hatchVar*70) + (hatchVar^2)/1000

      #setting up the map plot
      if(!add)  rwmNewMapPlot(mapToPlot,mapRegion=mapRegion,xlim=xlim,ylim=ylim,oceanCol=oceanCol,aspect=aspect)
      #plotting the map
      #plot(mapToPlot,col=colourVector[mapToPlot@data$dataCatNums],border=borderCol,add=TRUE, density=hatchVar, angle=135, lty=1)
      #plot(mapToPlot,col=colourVector[mapToPlot@data$dataCatNums],border=borderCol,add=TRUE, density=hatchVar, angle=45, lty=1)
      plot(mapToPlot,col=colourVector[dataCatNums],border=borderCol, density=hatchVar, angle=135, lty=1,add=TRUE,usePolypath=FALSE, lwd=lwd)#29/9/2012
      plot(mapToPlot,col=colourVector[dataCatNums],border=borderCol, density=hatchVar, angle=45, lty=1,add=TRUE,usePolypath=FALSE, lwd=lwd)#29/9/2012
                 
     }  #end of hatching option



  if (addLegend){
      
      #if((length(catMethod)==1 && catMethod=="categorical") || !require("spam") || !require("fields")){
      #20/8/13 removed require bits
			if((length(catMethod)==1 && catMethod=="categorical") ){
      
        # simpler legend for categorical data OR if you don't have packages spam or fields.
        addMapLegendBoxes(colourVector=colourVector,cutVector=cutVector,catMethod=catMethod) #,plottedData=dataCategorised)          
      
      }else{
        #colour bar legend based on fields package
        addMapLegend(cutVector=cutVector,colourVector=colourVector,catMethod=catMethod) # ,plottedData=mapToPlot@data[[nameColumnToPlot]],catMethod=catMethod,colourPalette=colourPalette)
      }  
  
  } #end of addLegend
  
  ## add title
  if ( mapTitle == 'columnName' ){
    title(nameColumnToPlot)
  } else {
    title( mapTitle )
  }
   
  ##returning parameter list that can be used by do.call(addMapLegend,*)  
  invisible(list(colourVector=colourVector
                ,cutVector=cutVector
                ,plottedData=mapToPlot[[nameColumnToPlot]]
                ,catMethod=catMethod
                ,colourPalette=colourPalette
                )
           ) 
  
  #failed attempt at creating something that could be directly used in addMapLegend()         
  #invisible(list(plottedData=paste("'",sys.call()[[2]],"'",sep='')
  #              ,nameColumnToPlot=paste("'",nameColumnToPlot,"'",sep='')
  #              ,catMethod=paste("'",catMethod,"'",sep='')
  #              ,colourPalette=paste("'",colourPalette,"'",sep='')
  #              ,numCats=numCats
  #              )
  #         )            
           
            
} #end of mapCountryData()

