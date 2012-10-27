labelCountries <- function( dF=""
                          , nameCountryColumn="NAME" #?maybe change this to nameCountry
                          , nameX="LON"
                          , nameY="LAT"
                          , nameColumnToPlot=""
                          , col = 'grey'
                          , cex = 0.8
                          , ...){
  
#27/10/12 initially make the first part identical to identifyCountries
#can then put common bits into it's own function  
  
  #^^!! start of bit initially copied from identifyCountries()
  
  #also possible to get centroids from a sPDF
  if (class(dF)=="SpatialPolygonsDataFrame")
  {
    #!9/10/12 BUG correction, don't get coords from internal map if an sPDF is passed
    #centroidCoords <- coordinates(getMap())
    centroidCoords <- coordinates(dF)    
    #within this function just need the dF bit of the sPDF
    dF2 <- dF@data
    #adding extra attribute columns to contain centroids (even though such columns may already be there)
    dF2[['nameX']] <- centroidCoords[,1]
    dF2[['nameY']] <- centroidCoords[,2]    
    nameX <- 'nameX'
    nameY <- 'nameY'    
  } else
    #this assumes that the dF already has columns for lat & lon
    if (class(dF)=="data.frame")
    {
      #this assumes that nameX, nameY & nameCountryColumn columns have been passed correctly
      dF2 <- dF
    } else
    {
      #if no object is passed use the internal map
      dF2 <- getMap()@data
      nameX <- 'LON'
      nameY <- 'LAT'    
    }
  
  labels <- dF2[[nameCountryColumn]]
  
  #if an attribute column name is passed paste it's value onto end of country label
  if ( nameColumnToPlot != "" ) labels <- paste(labels,dF2[[nameColumnToPlot]])  
  
  #^^!! end of bit initially copied from identifyCountries()
  

  #plotting the labels
  text( dF2[[nameX]], dF2[[nameY]], labels=labels, col=col, cex=cex, ... )
  
  
}