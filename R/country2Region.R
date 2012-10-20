`country2Region` <-
function(regionType = ''
        ,inFile = ''
        ,nameDataColumn = ''
        ,joinCode = ''
        ,nameJoinColumn = ''
        ,FUN=mean
        ,...)
{
#the data specifiying which countries are in which regions
data("countryRegions",envir=environment(),package="rworldmap")
countryRegions <- get("countryRegions")

valid_classification_types<-c("REGION","continent","GEO3","GEO3major","IMAGE24","GLOCAF","Stern","SRESmajor","SRES","GBD","AVOIDnumeric","AVOIDname","LDC","SID","LLDC")

#prompt the user for a regionType if one is not specified    
while(!(regionType %in% valid_classification_types))
   {
    regionTypeOptions <- paste(valid_classification_types,collapse=" ")
    regionType <- readline(paste("Please enter a valid regionType. The options are:\n",regionTypeOptions,"\n"))
   }
    

#if only a regionType is specified then return which countries belong to it
if ( !is.data.frame(inFile) && inFile == '' && nameDataColumn == '' && joinCode == '' && nameJoinColumn == '' )
   {
    message(paste('Countries are classified into the following ', regionType, 'regions'))
    FUN <- 'identity'
    tapply(countryRegions$ADMIN,countryRegions[[regionType]],FUN,...)  
    
   } else
   {
    #copying the dataFrame passed to the function
    dF<-inFile  
    
    #checking that the function is a character string
    if( !is(FUN,"character") )
      {
       warning(paste("option FUN should be a character string enclosed in quotes, e.g. 'mean', 'sum' using 'mean'") )
       FUN = "mean"
      }
    
    #valid_code_types<-c("ISO3","ISO2","Numeric","Name","FIPS")
    valid_code_types<-c("ISO3","ADMIN")
    
    #checking that the country join code is valid
    if(!(joinCode %in% valid_code_types))stop("joinCode is invalid. The options are: ",paste(valid_code_types,collapse=" "))
    
    #check whether nameJoinColumn is in the user data
    ## check that the column name exists in the data frame
    if ( is.na(match(nameDataColumn, names(dF)) )){
      stop("your chosen nameDataColumn :'",nameDataColumn,"' seems not to exist in your data, columns = ", paste(names(dF),""))
      return(FALSE)
    }     
    if ( is.na(match(nameJoinColumn, names(dF)) )){
      stop("your chosen nameJoinColumn :'",nameJoinColumn,"' seems not to exist in your data, columns = ", paste(names(dF),""))
      return(FALSE)
    } 
   
    #Create a temporary, simple lookup table from the master look up table.
    #This just contains the country codes and groupings asked for in the 1st and 2nd column respectively.
    subLookUpTable<-countryRegions[,c(joinCode,regionType)]
    
    #Countries will not always have a code for every code type.
    #e.g. Palestine has a code under ISO3 but not FIPS, which has seperate codes for the West Bank and the Gaza Strip.
    #This removes rows that have an NA in the code column. Otherwise NAs in the data column will match with it,
    #causing mis-classification.
    subLookUpTable<-subLookUpTable[!is.na(subLookUpTable[,joinCode]),]
    
    classified<-subLookUpTable[match(dF[,nameJoinColumn],subLookUpTable[,joinCode]),regionType]
    
    output <- tapply(dF[,nameDataColumn],classified,FUN,...)
    
    ###########
    #looking at returning in a more useful format
    idString <- paste(FUN,nameDataColumn,'by',regionType,sep='')
    dFout <- data.frame( x=output )
    names(dFout)[1] <- idString
    
    #if there is more than one element per region (e.g.identity) return as a list
    #else return as a dat frame, easier to access & output
    if ( is.list(dFout[,1]) )
         return(dFout[,1])
    else return(dFout)    
    
    #write.csv(output,'test.csv') #to output to a csv file
    
    #FUN='summary' outputs summary stats as a list which is tricky to deal with
    #perhaps can modify output ?
    #how to get from list to dataframe
    
    
   } #end of if inFile etc. are specified

} #end of country2Region

