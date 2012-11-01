`isoToName` <-
  
  function( iso = ""
          , lookup = getMap()@data  
          , nameColumn ='ADMIN'
            
          ){
    
    #iso can be a string of 2 or 3 chars or a number
    
    #get iso 2 or 3 from the string
    isoColumn <- NA
    if ( is.numeric(iso) )
        isoColumn <- 'ISO_N3'
    else if ( is.character(iso) && nchar(iso) == 3 )
        isoColumn <- 'ISO_A3'
    else if ( is.character(iso) && nchar(iso) == 2 )
        isoColumn <- 'ISO_A2' 
    else
    {
        warning(paste("iso= should be a 2 or 3 char string or a number, yours is",iso,"returning NA"))
        return(NA)
    }

    #if a character make sure it's in uppercase for comparison
    if ( is.character(iso) )  iso <- toupper(iso)
 
    index <- which( lookup[isoColumn] == iso )

    name <- NA
    if (length(index) == 0)
    {
       warning(paste("no matching name for",iso,"returning NA"))
    } else
    {  
       name <- as.character( lookup[,nameColumn][index] )
    }
    
    return(name)
  }

#testing
#isoToName('gb')
#isoToName('gbr')
#isoToName(826)
#isoToName('uk') #generates a warning and returns NA
#beware that using nameColumn may be vulnerable to future changes in column names in Natural Earth data
#isoToName('gb',nameColumn='ABBREV') #returns abbreviation
#isoToName('gb',nameColumn='ISO_A3') #returns iso3 for this iso2
#isoToName('gb',nameColumn='continent') #returns continent for this iso2
