\name{mapBars}
\Rdversion{1.1}
\alias{mapBars}
\title{function to produce bar plots on a map}
\description{
The function will produce a map with bars centred on country centroids (or other chosen points).
The length of the bars is determined by the sum of the attribute columns and each section is coloured.
}
\usage{
mapBars(dF = ""         
        , nameX="longitude", nameY="latitude" 
        , nameZs=c(names(dF)[3],names(dF)[4])
        , zColours=c(1:length(nameZs))
  
        , barWidth = 1
        , barOrient = 'vert' 
        , barRelative = TRUE
  
        , ratio = 1
        , addCatLegend = TRUE
        , addSizeLegend = TRUE
        
        , symbolSize = 1 
        , maxZVal=NA

        , xlim=NA
        , ylim=NA                        
        , mapRegion = "world"                                                      
        , borderCol = "grey"
        , oceanCol=NA
        , landCol=NA
        , add=FALSE                        
        , main=''
        , lwd=0.5
        , lwdSymbols=1
        ,... )          
          
}
\arguments{
  \item{dF}{data frame or SpatialPolygonsDataFrame}
  \item{nameX}{name of column containing the X variable (longitude), not needed if dF is a SpatialPolygonsDataFrame }  
  \item{nameY}{name of column containing the Y variable (lattitude), not needed if dF is a SpatialPolygonsDataFrame }
  \item{nameZs}{name of columns containing numeric variables to determine bar sections}
  \item{zColours}{colours to apply to the bar section for each attribute column}
  
  \item{barWidth}{multiple for the width of bar symbols, relative to barOrient see below}
  \item{barOrient}{orientation of bars, options 'horiz' and 'vert'} 
  \item{barRelative}{default is TRUE, each variable (column) is scaled to it's maximum value} 
  
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
  \item{lwd}{line width for country borders}  
  \item{lwdSymbols}{line width for symbols} 
	  
  \item{\dots}{any extra arguments to points()}
}
\details{
Horizontal or vertical bars can be achieved by using the barOrient argument 'horiz' or 'vert'.

}
\value{
currently doesn't return anything
}
\author{andy south}

\examples{

#getting example data
#dF <- getMap()@data  
sPDF <- getMap()
  
## these examples repeat the same column in 'nameZs' to show that equal sized bars are created 

#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('POP_EST','POP_EST') )

#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('POP_EST','POP_EST'),mapRegion='africa' )

#mapBars( dF,nameX="LON", nameY="LAT"
#       , nameZs=c('POP_EST','POP_EST','POP_EST','POP_EST'),mapRegion='africa' )

#mapBars( dF,nameX="LON", nameY="LAT"
#       , nameZs=c('POP_EST','POP_EST','POP_EST','POP_EST'),mapRegion='africa',symbolSize=2 )

mapBars( sPDF, 
       , nameZs=c('POP_EST','GDP_MD_EST')
       , mapRegion='africa'
       , symbolSize=4 )

# this does work too
#mapBars( dF,nameX="LON", nameY="LAT" 
#       , nameZs=c('POP_EST','GDP_MD_EST')
#       , mapRegion='africa'
#       , symbolSize=4 )       

  

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ aplot }

