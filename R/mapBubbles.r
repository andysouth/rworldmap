#! still in development, andy south 11/11/09
mapBubbles <- function( dF=""
                          ,nameX="longitude"
                          ,nameY="latitude"
                          ,nameZSize=""
                          ,nameZColour=""
                          
                          ,fill = TRUE
                          ,pch=21 #circles where col defines borders, & bg defines fill
                          ,symbolSize = 1 #multiplier relative to the default
                          ,maxZVal=NA
                          
                          ,main=nameZSize
                                                   
                         , numCats = 5  
                         , catMethod="categorical"   
                         , colourPalette= "heat" 
                         
                         , mapRegion = "world"   #sets map extents, overrides we,ea etc.                                                    
                         , borderCol = "grey"
                         , oceanCol=NA
                         , landCol=NA
                          
                          
                          #,plotNums = TRUE, numSigFigs = 3  #prob not needed
                          
                          ,addLegend = TRUE
                          ,legendBg="white" #set to NULL for transparent
                          ,legendVals="" #allows user to set values & hence symbol sizing in legend
                          ,legendPos="bottomright"
                          ,legendHoriz=FALSE
                          ,legendTitle=nameZSize

                          ,addColourLegend = TRUE
                          ,colourLegendPos = "bottomleft"
                          ,colourLegendTitle = nameZColour                          
                                                    
                          ,add=FALSE
                          ,plotZeroVals=TRUE
                          ,... ) #any extra arguments to points
{

functionName <- as.character(sys.call()[[1]])

#use example data if no file specified
if ( class(dF)=="character" && dF=="" )
   {
    message(paste("using example data because no file specified in",functionName))   
    dF=getMap()@data
    nameX="LON"
    nameY="LAT"
    nameZSize="POP_EST"
    nameZColour="GEO3"
   }

#allows just a sPDF to be passed and it will get the label points, so doesn't need nameX & nameY to be specified
if (class(dF)=="SpatialPolygonsDataFrame")
   {
    if (!add) 
      {
        #use passed sPDF as the background map
        rwmNewMapPlot(mapToPlot=dF,oceanCol=oceanCol,mapRegion=mapRegion)
        plot( dF, add=TRUE, border=borderCol, col=landCol )
      }
  
    #22/4/10 changing this to get centroid coords from the spdf
    centroidCoords <- coordinates(dF)    
    
    #within this function just need the dF bit of the sPDF
    dF <- dF@data
    #adding extra attribute columns to contain centroids (even though such columns may already be there)
    dF[['nameX']] <- centroidCoords[,1]
    dF[['nameY']] <- centroidCoords[,2]    
    nameX <- 'nameX'
    nameY <- 'nameY'  
   } else if (!add) 
   {
    #background map
    #these set the most common params, if user wanted finer control over map
    #they can call rwmNewMapPlot, and then call mapBubbles with add=TRUE     
    rwmNewMapPlot(mapToPlot=getMap(),oceanCol=oceanCol,mapRegion=mapRegion)
    plot( getMap(), add=TRUE, border=borderCol, col=landCol )
   }

#a bunch of code here that is repeated from mapCountryData
#so it could probably be put into its own function
#maybe rwmGetCategoriesAndColours, that would need to return a list
#of both the categorised data and the colourVector

#2/10/12 to allow single colour bubbles
#check if nameZColour is one of column names
#if not is it a colour ?
#colours()
## check that the column name exists in the data frame
singleColour<-FALSE
if (nameZColour == "") nameZColour <- 'red' #setting colour to red as default
if ( is.na(match(nameZColour, names(dF)) )){
  
  #now test whether it is a colour
  if ( is.na(match(nameZColour, colours()) ))
     {  
      stop("your chosen nameZColour :'",nameZColour,"' is not a colour and seems not to exist in your data, columns = ",paste(names(dF),""))
      return(FALSE)
     } else singleColour<-TRUE
}


cutVector <- colourVector <- NA
if (!singleColour)
{
#start of new bit from mapCountryData
#~^ marks changes
  #~^dataCategorised <- mapToPlot@data[[nameColumnToPlot]]
  dataCategorised <- dF[,nameZColour]

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
      if ( length(cutVector) > 15 ) warning("with catMethod='categorical' you have > 15 categories, you may want to try a different catMethod, e.g. quantile")
    }else
    { 
      if(is.character(catMethod)==TRUE)
    	{	
    		cutVector <- rwmGetClassBreaks( dataCategorised, catMethod=catMethod, numCats=numCats, verbose=TRUE )
    	  
      } else if(is.numeric(catMethod)==TRUE)
    	#if catMethod is numeric it is already a vector of breaks	
    	{
    		cutVector <- catMethod
    	}
  	#Categorising the data, using a vector of breaks.	
  	dataCategorised <- cut( dataCategorised, cutVector, include.lowest=TRUE)
    
 	  #! want to set cutVector to 1-2,2-3,3-4 etc. for legend
	  #there is probably a much more efficient way of doing this
	  #foo <- function(x) c(paste(x[],"-",x[+1],sep=""))
    #sapply(cutVector,foo)	  
    #!!!neither of these quite works   
    #tmp <- ""
	  #for(i in 1:length(cutVector)-1) tmp <- c(tmp,paste(cutVector[i],"-",cutVector[i+1]),sep="")
	  #cutVector <- tmp

 	  #to set cutVector to 1-2,2-3,3-4 etc. for legend 
    #this is an ugly way of doing but it does work    
    func <- function(x,y) c(paste(x,"-",y[1+which(y==x)],sep=""))
    tmp <- sapply(cutVector,cutVector,FUN=func)
    cutVector <- tmp[1:length(tmp)-1] #removing last element from vector
        	
	  } #end of if data are not categorical
 
  
  ## add extra column to map attribute data
  #~^colNameRaw <- nameColumnToPlot
  colNameRaw <- nameZColour
  colNameCat <- paste(colNameRaw,"categorised",sep='')    
  #~^mapToPlot@data[[colNameCat]] <- dataCategorised     
  dF[[colNameCat]] <- dataCategorised 
  
  ## how many colours : numCats may be overriden (e.g. for 'pretty') 	
  numColours <- length(levels(dataCategorised))
  
  ## get vector of the colours to be used in map (length=num categories)    
  colourVector <- rwmGetColours(colourPalette,numColours)
  
  ## get numeric index of which category each datapoint is in (length = num points)  
  dataCatNums <- as.numeric(dataCategorised)
  
  #adding missing country colour
  #~^if(!is.na(missingCountryCol)){
    #adding missing country colour as the last element
    #~^colourVector<- c(colourVector,missingCountryCol)
    #setting all missing values to the last element
    #~^dataCatNums[is.na(dataCatNums)]<-length(colourVector)
  
#end of new bit from mapCountryData
} #end of if (!singleColour)
  
#symbol colours
#! later allow the single symbol colour to be changed here
#if (nameZColour != "") col=colourVector[dataCatNums]
#else col='black'
#2/10/12
if (singleColour) col=nameZColour
else col=colourVector[dataCatNums]



#symbol fill
if (fill) bg=col
else bg=NA

#symbol size
#maxZVal & symbolSize can be set by user
if ( is.na(maxZVal) ) maxZVal <- max( dF[,nameZSize], na.rm=TRUE )
#4 in here is just a good sizing default found by trial & error
fMult = symbolSize * 4 / sqrt(maxZVal)
cex= fMult*sqrt(dF[,nameZSize])

#plotting the symbols
points( dF[,nameX], dF[,nameY],pch=pch,cex=cex,col=col,bg=bg,... )#, 


#points( dF[,nameX], dF[,nameY], cex= fMult*sqrt(dF[,nameZ]) )#, col=dF[,nameZCategory], ... ) #@@@
#if (nameZColour != "")
#    points( dF[,nameX], dF[,nameY], cex= fMult*sqrt(dF[,nameZSize]), col=dF[,nameZColour], ... ) #@@@
#else
#    points( dF[,nameX], dF[,nameY], cex= fMult*sqrt(dF[,nameZSize]),col='black',... )#, col=dF[,nameZCategory], ... ) #@@@

#to sort colours perhaps first create a colour column
#dF$catColour <- as.integer( as.factor( dF[,nameZColour]))

#this is just a size legend
#what to do about the colour/category legend ?
#rapidly getting too many args to the function
#AHA! I can just call addMapLegendBoxes, but will still want to send various params to that
#or perhaps just 

#adding Legend for symbol sizes
            if ( addLegend && sum(as.numeric(abs(dF[,nameZSize])),na.rm=TRUE) != 0 )
               {
                if ( length(legendVals) > 1 ) #i.e. if legendVals are spceified by the user
                   {
                    legendSymbolSizes <- fMult*sqrt(legendVals)
                   }else
                   {
                    sigFigs <- 3
                    maxVal <- max(dF[,nameZSize],na.rm=TRUE)
                    minVal <- min(dF[,nameZSize],na.rm=TRUE)
                    legendVals <- c( signif(minVal,sigFigs), signif(minVal+0.5*(maxVal-minVal),sigFigs), signif(maxVal,sigFigs) )
                    legendSymbolSizes <- fMult*sqrt(legendVals)
                   }
                   
                #pch <- pch   
                #legendSymbolChars=c(par("pch"),par("pch"),par("pch"))
                legendSymbolChars=c(pch,pch,pch)
                                
                #determining colour of symbols in the legend
                #if ( ! pointColours %in% colors() )
                    colour4LegendPoints <- "black"
                #else
                #    colour4LegendPoints <- pointColours

                #if plotting zero values can add that symbol to legend
                if ( plotZeroVals && legendSymbolSizes[1] == 0 )
                       {
                        legendSymbolSizes[1] <- 1
                        legendSymbolChars[1] <- 3 #3 for +
                        #legendSymbolChars[1] <- 20 #20 for small dot
                       }

                #modifying inter-symbol spacing to try to stop symbols from overlapping
                #doesn't quite work when symbols get big they overlap the legend box
                #I may need to calculate rectangle box myself
                x.intersp = symbolSize*1.3
                y.intersp = symbolSize*1.3

                legend(x=legendPos, legend=legendVals, pt.cex = legendSymbolSizes, pch=legendSymbolChars, col=colour4LegendPoints, bg=legendBg, title=legendTitle, horiz=legendHoriz, y.intersp=y.intersp, x.intersp=x.intersp )#, trace=TRUE ) trace good for seeing what it's doing

                } #end of if (addLegend)

#legend for colours, not all params can be controlled from here, it can be controlled separately too
if ( addColourLegend && !singleColour )
   {
    addMapLegendBoxes(colourVector=colourVector,cutVector=cutVector,x=colourLegendPos, title=colourLegendTitle)
   }

#! I should get this to return data that can be used by addMapLegend
#! perhas just for the colour legend, would be difficult to get it to return for the size legend too
invisible(list(colourVector=colourVector
              ,cutVector=cutVector
              #,plottedData=mapToPlot[[nameColumnToPlot]]
              #,catMethod=catMethod
              #,colourPalette=colourPalette
              )
         )  
      
} #end of mapBubbles() function
