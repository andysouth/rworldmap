`aggregateHalfDegreeGridToCountries` <-
function( inFile=""
                         ,aggregateOption="sum"  #"mean","max","min"
                         )
   {
    
    #a function to aggregate half degree grid data to country level
    #based upon a grid country file obtained from IIASA
    #returns a dataframe with numeric country code & aggregated values
    #can do sum, mean, max or min        
    require(maptools)
    #can fail to load data without this
    require(sp)

    #sGDF <- readAsciiGrid(fname=inFile) 

    #added an option to work on an existing loaded spatialGridDataFrame

    if ( is.character(inFile) )
    {
       if ( !file.exists(inFile) )
          {
           warning("the file: ",inFile," seems not to exist, exiting aggregateHalfDegreeGridToCountries()\n")
           return(FALSE)
          }
       #reading file into a SpatialGridDataFrame   
       sGDF <- readAsciiGrid(fname=inFile)
            
    } else if ( class(inFile)=="SpatialGridDataFrame" ) 
    {
       #if its already a SpatialGridDataFrame just copy it
       #!!!! 6/3/09 this allows for the potential for multiple attribute columns 
       #!!!! which is not coped with below
       sGDF <- inFile
    } else
    {
       warning(inFile," seems not to be a valid file name or a SpatialGridDataFrame, exiting aggregateHalfDegreeGridToCountries()\n") 
    }
         
    #further checking grid resolution
    if ( gridparameters(sGDF)$cellsize[1]!=0.5 )
        warning(inFile," seems not to be a half degree grid, in aggregateHalfDegreeGridToCountries()\n")
     

    #prompting user for file to open
    #if ( inFile == "" ) inFile <- tclvalue(tkgetOpenFile(title="choose a data file to plot"))

    
    #??? how can I get at the countries grid file from within the package
    #inFileGridCountries <- "M:\\Quest\\questCountryData\\IIASA\\country.asc"
    #sGDFcountries <- readAsciiGrid(fname=inFileGridCountries) #readAsciiGrid is a maptools method

    #getting data from within package
    data("gridCountriesNumeric",envir=environment(),package="rworldmap")
    #temporary solution copying it
    sGDFcountries <- get("gridCountriesNumeric")

            
    #getting the names of the columns containing the data
    attrNameGrid <- names(sGDF)[1]
    attrNameGridCountries <- names(sGDFcountries)[1]
    
    dF <- data.frame(attribute = sGDF[[attrNameGrid]]
                    ,UN = sGDFcountries[[attrNameGridCountries]])
    
    #4 aggregate cell values by numeric country code
    #! later offer option for user to specify which
    dFbyCountry <- aggregate(dF$attribute
                         #, by=list(ISO3166_numeric = dF$ISO3166_numeric)
                         , by=list(UN = dF$UN)
                         , FUN = aggregateOption
                         , na.rm=TRUE )
                         #, mean, na.rm=TRUE )
                         
    #renaming the aggregated column name from x, with filename if the input was a file (if a sGDF it causes error use names instead)
    if ( is.character(inFile) )
    {
       names(dFbyCountry)[2] <- paste(aggregateOption,"_",basename(inFile), sep='')            
    } else #if inFile is a sGDF 
    {
       #!!!6/3/09 this causes an error if the SGDF contained multiple attribute columns
       #!!!
       names(dFbyCountry)[2] <- paste(aggregateOption,"_",names(inFile), sep='') 
    }
    
    
    return(dFbyCountry)
      
    } #end of aggregateHalfDegreeGridToCountries()

