#joinData2Map.r
#andy south 29/7/2010

#to create a flexible function for joining column data to polygons
#it can have a companion function : mapPolys()
#it should accept :
## nameMap
# either
# 1 named internal options, e.g. countries, EEZs, highSeasAreas, china
# 2 the filename of an esri polygons shapefile
# 3 a spatialPolygonsDataFrame 
## nameJoinColumnData
## nameNameColumnData
## nameJoinIDMap

#(joinData2Map could then be called by joinCountryData2Map, specifying nameJoinIDMap=joinCode)

#add new maps to the getMap() function

`joinData2Map` <-
function( dF = ""
        , nameMap = ""
        , nameJoinIDMap = "ISO3"
        #, joinCode = "ISO3" #options "ISO2","ISO3","FIPS","NAME","UN"
        , nameJoinColumnData = "ISO3V10"
        , nameNameColumnData = "Country"
        , suggestForFailedCodes = FALSE 
        , projection=NA  #deprecated june 2012
        , mapResolution="coarse" 
        , verbose = FALSE #if set to FALSE it doesn't print progress messages to console                         
        )
   {
    functionName <- as.character(sys.call()[[1]])

    #browser()

    if ( dF=="" || ( class(nameMap)=='character' && nameMap=="" ) )
       {
        stop("you haven't specfied data (dF) and/or a map to join it to (nameMap)") 
        return(FALSE)
       } # else add other checks for dF & nameMap
    #if ( dF="" || nameMap="" )
    #   {
    #    stop("the first argument to ",functionName," should be a file name, 2D array or matrix, or SpatialGridDataFrame, yours is, ", class(dataset)) 
    #    return(FALSE)
    #   }       

    #getting the map polygons to join the data to
    if ( class(nameMap)=='SpatialPolygonsDataFrame' )
       {
        mapWithData <- nameMap
       } else if ( nameMap != "" && class(nameMap)=="character" )
       {
        mapWithData <- eval(parse(text=nameMap))
       } else
        mapWithData <- getMap(resolution=mapResolution)
    
    #test whether user nameJoinIDMap is one of permitted
    #listJoinCodes <- c("ISO2","ISO3","FIPS","NAME","UN") 
    #if (joinCode %in% listJoinCodes == FALSE)
    #   {
    #    stop("your joinCode (",joinCode,") in ",functionName," is not one of those supported. Options are :",paste(listJoinCodes,""),"\n")
    #    return(FALSE)
    #   }
       
    ## check that the join column exists in the user data
    if ( is.na(match(nameJoinColumnData, names(dF)) )){
      stop("your chosen nameJoinColumnData :'",nameJoinColumnData,"' seems not to exist in your data, columns = ", paste(names(dF),""))
      return(FALSE)
    }       
       

    #dF2 <- merge.data.frame(dF, dFlookupCodes, by=nameJoinColumn)
    
    #using match rather than merge, faster and enables greater reporting of success & failure
    
    #match returns a vector of the positions of (first) matches of its first argument in its second. 
    #so perhaps I would also want to check that codes aren't repeated
    #!also want to find a way of coping with Namibia, the code NA gets interpreted as no data
           
    #copy the users nameJoinColumn to a new column named the same as the column in the map for the join code
    #e.g if user has ISO3166_3 it will be copied to ISO3
    #6/2/13 not sure why I did this
    #can't I just remove & use nameJoinColumnData below
    #dF[[nameJoinIDMap]] <- dF[[nameJoinColumnData]]
    
    
    matchPosnsInLookup <- match(as.character(dF[[nameJoinColumnData]])
                              , as.character(mapWithData@data[[nameJoinIDMap]]))


    #count the NAs to find user countries that have failed to match
    failedCodes <- dF[[nameJoinColumnData]][is.na(matchPosnsInLookup)]
    numFailedCodes <- length(failedCodes) 
    
    #count num successful matches
    numMatchedCountries <- nrow(dF) - numFailedCodes
    #printing info to console    
    cat(numMatchedCountries,"codes from your data successfully matched countries in the map\n")
           

    #failedCountries : reports on names of failed countries 
    #if user has specified the name of a country column in the function call
    failedCountries <- dF[[nameNameColumnData]][is.na(matchPosnsInLookup)]
    failedCountries <- cbind(failedCodes,"failedCountries"=as.character(failedCountries))
    
    #printing info to console    
    cat(numFailedCodes,"codes from your data failed to match with a country code in the map\n")
    if (verbose) print(failedCountries)
    
 #     failedCodes failedCountries                 
 #[1,] "CIV"       "Ivory Coast"                   
 #[2,] "COD"       "Congo, Democratic Republic"    
                       
    #!could create an optional loop here to go through the failed codes 
    #& prompt the user for a choice fro a suggested list 
    if ( suggestForFailedCodes )
       {
        for( i in 1 : numFailedCodes)
           {
            #search for similar codes/countried & ask user to choose one
            
           }
       }
    #can also get at countries in the lookup that don't appear in user data, by reversing match arguments
    matchPosnsInUserData <- match(as.character(mapWithData@data[[nameJoinIDMap]])
                                , as.character(dF[[nameJoinColumnData]])) 
                                
    #these are the codes in lookup that aren't found in user data
    codesMissingFromUserData <- as.character( mapWithData@data[[nameJoinIDMap]][is.na(matchPosnsInUserData)] )                            
    countriesMissingFromUserData <- as.character( mapWithData@data[["NAME"]][is.na(matchPosnsInUserData)] )
    #  
    numMissingCodes <- length(codesMissingFromUserData) 
    
    #printing info to console
    cat(numMissingCodes,"codes from the map weren't represented in your data\n")
    if (verbose) #if (verbose) print more messages to console
       {
        if (nameJoinColumnData!="NAME")                             
        {   print(cbind(codesMissingFromUserData,countriesMissingFromUserData))
        }else #if joined on NAME don't want to print names twice 
            print(codesMissingFromUserData)
       } # 


    ###############################################################
    #merging lookup table onto user data for those codes that match
    #dF2 <- cbind(dFlookupCodes[matchPosnsInLookup,],dF)    
    #the other way around to before, i.e. joining data onto map    
    #mapWithData@data <- cbind(mapWithData@data, dF[matchPosnsInUserData,])

    #6/2/13 to avoid having the join column repeated
    dF2 <- dF[,-which(names(dF)==nameJoinColumnData), drop=FALSE] #drop=FALSE stops it from converting from dF if just 1 column
    mapWithData@data <- cbind(mapWithData@data, dF2[matchPosnsInUserData,,drop=FALSE], deparse.level = 0) #deparse stops R creating new column label when just 1 column    
    

    #test colouring map by region & subregion seems to show order has been retained
    #plot(mapWithData,col=mapWithData@data$REGION)
    #plot(mapWithData,col=mapWithData@data$SUBREGION)

    #returning the sPDF with the user data joined to the map polygons
    invisible(mapWithData)
   
   } #end of joinData2Map()

