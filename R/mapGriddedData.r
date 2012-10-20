mapGriddedData <- function(
                           dataset =          ""
                         , nameColumnToPlot = "" 
                         , numCats =          5  
                         , catMethod =        "quantiles"   
                         , colourPalette =    "heat"  
                         , xlim =             c(-180,180)
                         , ylim =             c(-80,90) 
                         , mapRegion =        "world"   
                         , addLegend =        TRUE
                         , addBorders =       'low' 
                         , borderCol =        'grey'
                         , oceanCol =         NA
                         , landCol =          NA
                         , plotData =         TRUE
                         , aspect =           1
                         )
   {

    #browser()
    #print("test")

    functionName <- as.character(sys.call()[[1]])

    require(maptools)
    require(sp)
    
    ## filename or nothing ##
    if (class(dataset)=='character')
       {
        if (dataset=="") #if no dataset passed
           {
            #open example one
            data(gridExData,envir=environment(),package="rworldmap")
            sGDF <- get("gridExData")
           } else
            sGDF <- readAsciiGrid(dataset)
    ## matrix or array ##        
       } else if (class(dataset)=='matrix' || class(dataset)=='array')   
       {
        if ( length(dim(dataset)) == 2 )
           {
            #assume that it's just 2 dimensions
            gridVals <- data.frame(att=as.vector(dataset))
           
            #this assumes that the matrix covers the whole globe -180 to 180, -90 to 90
            gt <- GridTopology( cellcentre.offset = c(-180,-90)
                      , cellsize = c( 360/dim(dataset)[1], 180/dim(dataset)[2] )
                      , cells.dim = dim(dataset)[1:2] )
    
            sGDF <- SpatialGridDataFrame(gt, data = gridVals)
           } else
           {
            stop("the first argument to ",functionName," if a matrix or array should have 2 dimensions, yours has, ", length(dim(dataset))) 
            return(FALSE)
           }           
    ## SGDF passed ##           
       } else if (class(dataset)=='SpatialGridDataFrame')
       {   
        sGDF <- dataset
       } else
       {
    ## !! I could add option here for dataFrame with nameX & nameY columns   
        stop("the first argument to ",functionName," should be a file name, 2D array or matrix, or SpatialGridDataFrame, yours is, ", class(dataset)) 
        return(FALSE)
       } 


     #if the sGDF contains multiple attribute columns, decide which to plot
     if ( length(sGDF@data) == 1 ) attrName <- names(sGDF)[1] #to be able to get at data using original filename
     else if ( length(sGDF@data) > 1 && nameColumnToPlot != "" )
     {
        attrName <- nameColumnToPlot
        #!then want to check wkether this column is an attribute column in the sGDF
        
     } else if ( length(sGDF@data) > 1 && nameColumnToPlot == "" )
     {
         attrName <- names(sGDF)[1]
         message("plotting the first data column because nameColumnToPlot not specified in mapGridAscii()\n")
     }

    #CLASSIFYING THE DATA
    
    #first get the raw data    

    dataCategorised <- sGDF[[attrName]]
    
    #print(dataCategorised[1:10])  
    
    #browser()
    
    ####################### categorical 
    #length(catMethod)==1 needed to avoid warning if a vector of breaks is passed  
    if( length(catMethod)==1 && catMethod=="categorical" )    
      {
       #if categorical, just copy the data, add an as.factor() to convert any data that aren't yet as a factor 
       dataCategorised <- as.factor( dataCategorised )
       cutVector <- levels(dataCategorised) #doesn't do cutting but is passed for use in legend
  		 #6/5/10 bug fix
       #numColours <- -1 + length(levels(dataCategorised))
       #12/10/10 the above seemed to cause one less colour than cat
       numColours <- length(levels(dataCategorised))
       
       #1/11/10 STILL A PROBLEM WITH THIS 
       #SEEMS THAT NOW WITH ELISABETHS EXAMPLE IT GIVES SAME NUM BREAKS AS COLOURS WHICH
       #GENERATES AN ERROR ???
       #******temp fix********
       #numColours <- -1 + length(levels(dataCategorised))
       
       #12/10/10 added in here to avoid problem when doing the same as non-categorical
       #this deliberately gets the numeric index of each factor
       sGDF$indexToPlot <-  as.numeric(dataCategorised) 
       
       #13/11/10 fixing breaks difference between categorical and non-categorical
       breaks <- c(0:(length(cutVector)) )
       
      }else
      ####################### all other catMethods except categorical 
      {
       #if catMethod is not a vector of numbers 
       if(is.character(catMethod)==TRUE)
      	{	
      		cutVector <- rwmGetClassBreaks( dataCategorised, catMethod=catMethod, numCats=numCats, verbose=TRUE )
      		#6/5/10 bug fix
      		#28/7/10 removed to avoid bug with default params
          #numColours <- -1 + length(levels(dataCategorised))
          numColours <- -1 + length(cutVector)
        } else if(is.numeric(catMethod)==TRUE)
      	#if catMethod is numeric it is already a vector of breaks	
      	{
      		cutVector <- catMethod
      		#6/5/10 bug fix
      		numColours <- -1 + length(cutVector)
      	}
    	#Categorising the data, using a vector of breaks.	     
      dataCategorised <- cut( dataCategorised, cutVector, include.lowest=TRUE,labels=FALSE)
      
      #12/10/10 moved into non-categorical loop from below
      sGDF$indexToPlot <- as.numeric( as.character( dataCategorised )) 
      #cut : labels for the levels of the resulting category.  By default,
      #    labels are constructed using ‘"(a,b]"’ interval notation.
      #    If ‘labels = FALSE’, simple integer codes are returned instead of a factor.
      
      #13/11/10 fixing breaks difference between categorical and non-categorical
      breaks <- c(0:(length(cutVector)-1) )
        	
  	  } #end of if data are not categorical
  

    
    colourVector <- rwmGetColours(colourPalette,numColours)

    #setting up the map plot 
    #fills in the ocean but will get overpainted by the grid data if it doesn't have NAs in the ocean
    rwmNewMapPlot(mapToPlot=sGDF,oceanCol=oceanCol,mapRegion=mapRegion,aspect=aspect,xlim=xlim,ylim=ylim)


    #to fill in any countries with NA values in the grid
    if(!is.na(landCol))
       {
        plot( getMap(), add=TRUE, border=borderCol, col=landCol )
       }

    #only plot ascii data if plotData=T (allows legend to be plotted on its own by setting plotData=F)
    if (plotData)
       {
        #image(sGDF,add=TRUE,attr='indexToPlot',col=colourVector, xaxs='i', yaxs='i' ) #xaxs=i ensures maps fill plot area
        #7/5/10 !BUG without a breaks param then image fits colours to just those cats present
        #image(sGDF,add=TRUE,attr='indexToPlot',col=colourVector, xaxs='i', yaxs='i',breaks=c(0:(length(cutVector)-1) )) #xaxs=i ensures maps fill plot area
        #31/10/10 setting add=FALSE otherwise breaks doesn't work
        #browser()
        #image(sGDF,add=FALSE,attr='indexToPlot',col=colourVector, xaxs='i', yaxs='i',breaks=c(0:(length(cutVector)-1) ))
        #breaks still didn't work
        #the below does by seprating out the sp bit from the graphics bit : perhaps is a problem in sp ?
        xyz <- as.image.SpatialGridDataFrame(sGDF,attr='indexToPlot')
        #image(xyz,add=TRUE,col=colourVector, xaxs='i', yaxs='i',breaks=c(0:(length(cutVector)-1) ))
        #13/11/10 fixing breaks difference between categorical and non-categorical
        image(xyz,add=TRUE,col=colourVector, xaxs='i', yaxs='i',breaks=breaks)
       }
       
       
    borderOptions = c('low','coarse','coasts',NA,'','none')
    if (addBorders=='low'){
       plot( getMap(resolution='low'), add=TRUE, border=borderCol )
       } else
    if (addBorders=='coarse'){
       plot( getMap(resolution='coarse'), add=TRUE, border=borderCol )
       } else
    if (addBorders=='coasts'){
       #30/9/2012 replacing use of maps library
       #library(maps) 
       #map(interior=FALSE,add=TRUE, col=borderCol )
       coastsCoarse <- NULL #to avoid build warning
       data(coastsCoarse)
       plot(coastsCoarse, add=TRUE, col=borderCol) 
       } else 
    if ( ! addBorders %in% borderOptions){
       warning("unrecognised addBorders = ",addBorders, "none plotted, choose one of",paste(borderOptions,""))
       }             
    
    ## adding a default legend, can be modified by calling addMapLegend() independently  
    if (addLegend){
    
      ## simpler legend for categorical data OR if you don't have packages spam or fields.
      if((length(catMethod)==1 && catMethod=="categorical") || !require("spam") || !require("fields")){
        
        #legend(x='bottomleft', legend=c(rev(levels(dataCategorised)),"no data"), pch = 22, pt.cex=2, col=borderCol,pt.bg=c(coloursForMap[numColours:1],"white"), title="category",bg="white" )
        addMapLegendBoxes(colourVector=colourVector,cutVector=cutVector,plottedData=dataCategorised,catMethod=catMethod)          
         
      }else{
        #colour bar legend based on fields package
        addMapLegend(colourVector=colourVector,cutVector=cutVector,plottedData=sGDF[[attrName]],catMethod=catMethod,colourPalette=colourPalette)   
        }
      }

    #could add title
    #!but need to set it to the filename for gridascii files,
    #!and the column name for multi-attribute sGDFs
    #if ( mapTitle == 'columnName' ) title(nameColumnToPlot)
    #else title( mapTitle )

    #returning data to be used by addMapLegend
    invisible(list(plottedData=sGDF[[attrName]]
                  ,catMethod=catMethod
                  ,colourVector=colourVector
                  ,cutVector=cutVector
                  ,colourPalette=colourPalette
                  )
             )              

    } #end of mapGriddedData()





















