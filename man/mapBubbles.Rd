\name{mapBubbles}
\Rdversion{1.1}
\alias{mapBubbles}
\title{function to produce bubble plots on a map, size and colour determined by attribute data}
\description{
The function will produce a map with bubbles (circles) centred on country centroids (or other chosen points).
Bubbles can be sized and coloured according to specified attribute values.
}
\usage{
mapBubbles(dF = ""
          , nameX = "longitude"
          , nameY = "latitude"
          , nameZSize = ""
          , nameZColour = ""
          
          , fill = TRUE
          , pch = 21
          , symbolSize = 1
          , maxZVal = NA          
          
          , main = nameZSize
          
          , numCats = 5
          , catMethod = "categorical"
          , colourPalette = "heat"
          
          , mapRegion = "world"
          , borderCol = "grey"
          , oceanCol = NA
          , landCol = NA
              
          , addLegend = TRUE
          , legendBg = "white"
          , legendVals = ""
          , legendPos = "bottomright"
          , legendHoriz = FALSE
          , legendTitle = nameZSize
          , addColourLegend = TRUE
          , colourLegendPos = "bottomleft"
          , colourLegendTitle = nameZColour
          , add = FALSE
          , plotZeroVals = TRUE
          , ...)
}
\arguments{
  \item{dF}{data frame or SpatialPolygonsDataFrame}
  \item{nameX}{name of column containing the X variable (longitude), not needed if dF is a SpatialPolygonsDataFrame }  
  \item{nameY}{name of column containing the Y variable (lattitude), not needed if dF is a SpatialPolygonsDataFrame }
  \item{nameZSize}{name of column containing numeric variable to set symbol size}
  \item{nameZColour}{name of column containing variable to set symbol colour}
  
  \item{fill}{whether or not to fill symbols TRUE/FALSE}
  \item{pch}{symbol type, default of 21 for circles, will work with other filled 
  symbol types e.g. 22=square, 23=diamond, 24=triangle }
  \item{symbolSize}{multiplier of default symbol size}
  \item{maxZVal}{the attribute value corresponding to the maximum symbol size, 
  this can be used to set the scaling the same between multiple plots }  
  
  \item{main}{title for the map, set to nameZSize by default}
  
  \item{numCats}{ number of categories to put the data in, may be modified if this number is incompatible with the catMethod chosen}
  \item{catMethod}{ method for categorisation of data "pretty", "fixedWidth", "diverging", "logfixedWidth","quantiles","categorical", or a numeric vector defining breaks }
  \item{colourPalette}{ a string describing the colour palette to use, choice of :
    \enumerate{
               \item{}{="palette" for the current palette} 
               \item{}{a vector of valid colours, e.g. =c('red','white','blue') or output from RColourBrewer} 
               \item{}{= one of "heat","diverging","white2Black","black2White","topo","rainbow","terrain","negpos8","negpos9" }
               }}
  
  \item{mapRegion}{ a country name from getMap()\$NAME or 'world','africa','oceania','eurasia','uk' sets map extents, overrides xlim,ylim }
  \item{borderCol}{ the colour for country borders  }
  \item{oceanCol}{a colour for the ocean}
  \item{landCol}{a colour to fill countries}

  \item{addLegend}{ whether to add a legend for symbol sizes }
  \item{legendBg}{ background colour for the legend, NA=transparent }
  \item{legendVals}{allows user to set values & hence symbol sizing in legend}
  \item{legendPos}{positioning of legend e.g. 'bottomleft', 'topright'}
  \item{legendHoriz}{whether to arrange legend elements horizontally TRUE/FALSE}
  \item{legendTitle}{title for the symbol size legend }
  
  \item{addColourLegend}{whether to add a legend for symbol colour}
  \item{colourLegendPos}{positioning of colour legend e.g. 'bottomleft', 'topright'}
  \item{colourLegendTitle}{title for the colour size legend}
  
  \item{add}{whether to add the symbols to an existing map, TRUE/FALSE}
  \item{plotZeroVals}{whether to plot zero values as a cross, TRUE/FALSE}
  
  \item{\dots}{any extra arguments to points()}
}
\details{
By default separate legends are added fro symbol size and colouring on either 
side of the plot, these can be modified by altering legend parameters.

}
\value{
currently doesn't return anything
}
\author{andy south}

\examples{
mapBubbles()
#square symbols
mapBubbles(pch=22)

mapBubbles(dF=getMap(), nameZSize="POP_EST", nameZColour="GEO3")

#change colour
mapBubbles(dF=getMap(), nameZSize="POP_EST", nameZColour="GEO3"
          ,colourPalette='rainbow', oceanCol='lightblue', landCol='wheat') 


data("countryExData",envir=environment(),package="rworldmap")
sPDF <- joinCountryData2Map(countryExData,joinCode = "ISO3"
                           ,nameJoinColumn = "ISO3V10")
                           
mapBubbles(sPDF, nameZSize="POP_EST",nameZColour="BIODIVERSITY"
          ,colourPalette='topo',numCats=5,catMethod="quantiles")

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ aplot }

