\name{mapPies}
\Rdversion{1.1}
\alias{mapPies}
\title{function to produce pie charts on a map}
\description{
The function will produce a map with pie charts centred on country centroids (or other chosen points).
The size of the circles is determined by the sum of the attribute columns and each section is coloured.
}
\usage{
mapPies(dF = ""
       , nameX = "longitude"
       , nameY = "latitude"
       , nameZs=c(names(dF)[3],names(dF)[4])
       , zColours=c(1:length(nameZs))         
       , ratio = 1
       , addCatLegend = TRUE
       , addSizeLegend = TRUE                        
       , symbolSize = 1 
       , maxZVal=NA
       , xlim=c(-160,160)
       , ylim=c(-80,90)                        
       , mapRegion = "world"                                                      
       , borderCol = "grey"
       , oceanCol=NA
       , landCol=NA
       , add=FALSE                                                
       , main=''
       , ...)
}
\arguments{
  \item{dF}{data frame or SpatialPolygonsDataFrame}
  \item{nameX}{name of column containing the X variable (longitude), not needed if dF is a SpatialPolygonsDataFrame }  
  \item{nameY}{name of column containing the Y variable (latitude), not needed if dF is a SpatialPolygonsDataFrame }
  \item{nameZs}{name of columns containing numeric variables to determine pie sections}
  \item{zColours}{colours to apply to the pie section for each attribute column}

  \item{ratio}{ the ratio of Y to N in the output map, set to 1 as default}  
  
  \item{addCatLegend}{whether to add a legend for categories}
  \item{addSizeLegend}{whether to add a legend for symbol size}
  
  \item{symbolSize}{multiplier of default symbol size}
  \item{maxZVal}{the attribute value corresponding to the maximum symbol size, 
  this can be used to set the scaling the same between multiple plots }  
 
  \item{xlim}{ map extents c(west,east), can be overidden by mapRegion }
  \item{ylim}{ map extents c(south,north), can be overidden by mapRegion }
  \item{mapRegion}{ a country name from getMap()[['NAME']] or 'world','africa','oceania','eurasia','uk' sets map extents, overrides xlim,ylim } 
  \item{borderCol}{ the colour for country borders  }
  \item{oceanCol}{a colour for the ocean}
  \item{landCol}{a colour to fill countries}
  
  \item{add}{whether to add the symbols to an existing map, TRUE/FALSE} 
  \item{main}{title for the map}
  \item{\dots}{any extra arguments to points()}
}
\details{
Beware of creating plots that are difficult for the reader to interpret. More than 3 or 4 categories may be too many.  

}
\value{
currently doesn't return anything
}
\author{andy south}

\examples{

#getting example data
dF <- getMap()@data  

## these examples repeat the same column in 'nameZs' 
## to show that equal sized pies are created  

#mapPies( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA') )

#mapPies( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA')
#       , mapRegion='africa' )

mapPies( dF,nameX="LON", nameY="LAT"
       , nameZs=c('POP_EST','POP_EST','POP_EST','POP_EST'),mapRegion='africa' )
  

}


\keyword{ aplot }

