`mapByRegion` <- 
function(inFile, nameDataColumn
       , joinCode
       , nameJoinColumn
       , regionType=''
       , FUN = "mean"
       , na.rm=TRUE
       , mapTitle = ''
       , lwd=0.5   
       ,...)
{
dF<-inFile
data("countryRegions",envir=environment(),package="rworldmap")
countryRegions <- get("countryRegions")

valid_classification_types<-c("GEO3","GEO3major","IMAGE24","GLOCAF","Stern","SRESmajor","SRES","GBD","AVOIDnumeric","AVOIDname","LDC","SID","LLDC")

#prompt the user for a regionType if one is not specified    
while(!(regionType %in% valid_classification_types))
   {
    regionTypeOptions <- paste(valid_classification_types,collapse=" ")
    regionType <- readline(paste("Please enter a valid regionType. The options are:\n",regionTypeOptions,"\n"))
   }

##################
#there is repetitiion of code between here and countr2region 
   
#Create a temporary, simple lookup table from the master look up table.
#This just contains the country codes and groupings asked for in the 1st and 2nd column respectively.
subLookUpTable<-countryRegions[,c(joinCode,regionType)]

#Countries will not always have a code for every code type.
#e.g. Palestine has a code under ISO3 but not FIPS, which has seperate codes for the West Bank and the Gaza Strip.
#This removes rows that have an NA in the code column. Otherwise NAs in the data column will match with it,
#causing mis-classification.
subLookUpTable<-subLookUpTable[!is.na(subLookUpTable[,joinCode]),]

classified<-subLookUpTable[match(dF[,nameJoinColumn],subLookUpTable[,joinCode]),regionType]


#Problem, it would be nice to use ... to pass things to FUN in tapply as well as to mapCountryData.
#This causes problems. The most common use would be to pass na.rm to the following list of functions.
#So this is dealt with automatically.
commonFunctions<-c("mean","min","max","median","range","var","sd","mad","IQR")

if( !is(FUN,"character") )
  {
   warning(paste("option FUN should be a character string enclosed in quotes, e.g.", commonFunctions, "using 'mean'") )
   FUN = "mean"
  }

if(is(FUN,"character") && length(FUN)==1 && FUN %in% commonFunctions){
summaryStats<-tapply(dF[,nameDataColumn],classified,FUN=FUN,na.rm=na.rm)
}else{
summaryStats<-tapply(dF[,nameDataColumn],classified,FUN=FUN)
}

#calling country2Region instead to save code repetition
#!but still need classified from above
#if(is(FUN,"character") && length(FUN)==1 && FUN %in% commonFunctions){
#summaryStats <- country2Region(dF, nameDataColumn=nameDataColumn, joinCode=joinCode, nameJoinColumn=nameJoinColumn, regionType=regionType, FUN = FUN, na.rm=na.rm)
#}else{
#summaryStats <- country2Region(dF, nameDataColumn=nameDataColumn, joinCode=joinCode, nameJoinColumn=nameJoinColumn, regionType=regionType, FUN = FUN)
#}


#adding an extra column to the dataFrame
#dF[,ncol(dF)+1] <- summaryStats[classified]
dF[[paste(FUN,nameDataColumn,'by',regionType,sep='')]] <- summaryStats[classified]


#andy 28/9/09, need to add joinCountryData2Map in here
#not going to offer the user all of the functionality from here
sPDF <- joinCountryData2Map(dF
              , joinCode = "ISO3"
              , nameJoinColumn = nameJoinColumn
              , mapResolution = 'coarse'
              )

if (mapTitle == '') mapTitle=paste(FUN,nameDataColumn,'by',regionType,'regions')

#mapping the final column
mapParams <- mapCountryData(sPDF,names(dF)[ncol(dF)],mapTitle=mapTitle, lwd=lwd, ...)

#returning mapParams so they can be used by addMapLegend()
invisible(mapParams)
    
} # end of mapByRegion()




