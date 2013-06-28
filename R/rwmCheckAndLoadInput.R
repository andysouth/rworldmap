#rwmCheckAndLoadInput
#andy south 28/6/2013

#to check and load the input data for any rwm function
#if "" is passed it should load example data (which later could be specific to the calling function)

#I could set up two main alternatives
#if requireSPDF
#   =="" : get example SPDF
#   is SPDF : use it
#   not SPDF : give warning about using joinCountry2Map
#if !requireSPDF
#   =="" : get example dF
#   is SPDF : use dF bit
#   is DF : use it
#   is something else : error

#then maybe later put nameColumnToPlot checking in here
#BUT PROB better to put in another function

rwmCheckAndLoadInput <- function(
    inputData =         ""
  #, nameColumnToPlot =  ""
  , requireSPDF =       TRUE
  , callingFunction = "" #currently optional may be useful later  
){
  
  functionName <- as.character(sys.call()[[1]])
  
  message(paste("In", functionName, "called by", callingFunction))  
  
  #browser()  #n to enter the step through debugger, Q to exit
  
  #if (requireSPDF) 
  
  if ( class(inputData)=="SpatialPolygonsDataFrame" ) 
  {
    ## checking if there is any data in the dataFrame
    if ( length(inputData@data[,1]) < 1 ){
      stop("seems to be no data in your chosen input in ",functionName, "from", callingFunction) 
      return(FALSE)
    } 
  } else if ( inputData == "" ) 
  {
    message(paste("using example data because no file specified in",functionName))
    
    inputData <- getMap(resolution="coarse")
    
    ## also setting a default nameColumnToPlot if it isn't set
    #can't have this here because not passed
    #if ( nameColumnToPlot == "" ) nameColumnToPlot <- "POP_EST" #
  } else 
  {
    stop(callingFunction," requires a SpatialPolygonsDataFrame object created by the joinCountryData2Map() or joinData2Map() functions \n")
    return(FALSE) 
  }
  
  
  #later may add this here or put in another function
  ## check that the column name exists in the data frame
  #if ( is.na(match(nameColumnToPlot, names(mapToPlot@data)) )){
  #  stop("your chosen nameColumnToPlot :'",nameColumnToPlot,"' seems not to exist in your data, columns = ",paste(names(mapToPlot@data),""))
  #  return(FALSE)
  #} 
  
  
  invisible(inputData)
  
} # end of rwmCheckAndLoadInput 