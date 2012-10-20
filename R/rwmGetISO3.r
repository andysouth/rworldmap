
#to gets ISO3 code from synonyms of a country name

`rwmGetISO3` <-

function( oddName ){
  
  oddName <- as.character( oddName )
  
  #first get the synonyms data
  data("countrySynonyms",envir=environment(),package="rworldmap")
  countrySynonyms <- get("countrySynonyms")
  
  #oldway using an input file
  #inFile <- "countrySynonyms.txt"
  #ncol <- max(count.fields(inFile, sep = "\t"))
  #countrySynonyms <- read.table(inFile,sep='\t', as.is=TRUE, fill=TRUE, header = FALSE
  #                              ,quote=""
  #                              ,col.names=c('ID','ISO3', paste("name", seq_len(ncol-2), sep = "")) )
   

  #firstNameColumn <- 2 #actually it's not 2 but won't do any harm to search through the ISO codes first
  
  #this works. indexing goes beyond end of rows for later columns
  #rowNum <- which( countrySynonyms[,2:length(countrySynonyms)] ==  oddName )
  
  #using tolower to avoid case things, start from col2 to include all synonyms
  #but tolower messes up dF into a char vector
  #rowNum <- which( tolower(dFcountries[,2:length(dFcountries)]) ==  tolower(oddName) )
  
  #keeping it simple
  cLow <- data.frame(lapply(countrySynonyms,tolower))
  
  rowNum <- which(cLow == tolower(oddName))
  
  #do I want it to return the oddName or NA if no match found ?
  
  #if no match no correct name
  if (length(rowNum)==0)
    {ISO3 <- NA} else 
    #this gets row nums for later columns      
    {
     #rowNum <- rowNum%%nrow(dFcountries)
     colNum <- 1+(rowNum-1)%/%nrow(countrySynonyms)   
     rowNum <- rowNum - (colNum-1)*nrow(countrySynonyms)    
     ISO3 <- countrySynonyms$ISO3[rowNum]
    }

  #I want as uppercase
  ISO3 <- toupper(ISO3)
  
  #just return the first one if there is more than one match
  return(ISO3[1])
}

#testing
#rwmGetISO3("Vietnam")
#rwmGetISO3("US")
#rwmGetISO3("USA")
#rwmGetISO3("Laos") 
#rwmGetISO3("Brunei") 
#rwmGetISO3("Republic of Lithuania")
#rwmGetISO3("Commonwealth of Dominica") #this is last one & can be a problem
#rwmGetISO3("China")
#rwmGetISO3("not a country") #returns what you passed to it. NA
