\name{mapGriddedData}
\alias{mapGriddedData}
\title{ Produce maps of global gridded data at half degree resolution }
\description{Produce maps of global gridded data at half degree resolution}

\usage{
mapGriddedData(  dataset =          ""
               , nameColumnToPlot = "" 
               , numCats =          5  
               , catMethod =        "quantiles"   
               , colourPalette =    "heat"  
               , xlim =             c(-180,180)
               , ylim =             c(-80,90) 
               , mapRegion =  "world"   
               , addLegend =  TRUE
               , addBorders = 'coarse' 
               , borderCol =  'grey'
               , oceanCol =   NA
               , landCol =    NA
               , plotData =   TRUE
               , aspect =     1
               , lwd =        1
               )         
}

\arguments{
  \item{dataset}{gridded data either as a :
        \enumerate{
               \item{} SpatialGridDataFrame (R object defined in package sp) 
               \item{} file name of a GridAscii file - this is an Esri format
               \item{} 2D R matrix or array (rows by columns) 
               }}
  \item{nameColumnToPlot}{ name of column containing the data to plot }
  \item{numCats}{ number of categories to put the data in, may be overidden if catMethod ='pretty' }
  \item{catMethod}{ method for categorisation of data "pretty", "fixedWidth","diverging", "logFixedWidth","quantiles","categorical", or a numeric vector defining breaks } 
  \item{colourPalette}{ a string describing the colour palette to use, choice of :
    \enumerate{
               \item{}"palette" for the current palette 
               \item{}a vector of valid colours, e.g. =c('red','white','blue') or output from RColourBrewer 
               \item{}one of "heat", "diverging", "white2Black", "black2White", "topo", "rainbow", "terrain", "negpos8", "negpos9"
               }}
  \item{xlim}{ map extents c(west,east), can be overidden by mapRegion }
  \item{ylim}{ map extents c(south,north), can be overidden by mapRegion } 
  \item{mapRegion}{ a country name from getMap()[['NAME']] or 'world','africa','oceania','eurasia','uk' sets map extents, overrides xlim,ylim }
  \item{addLegend}{ whether to add a legend or not }
  \item{addBorders}{ options for country borders, 'low','coarse' = low or coarse resolution, 'coasts' = coasts only, 'none' or NA for none   }
  \item{borderCol}{ the colour for country borders  } 
  \item{oceanCol}{a colour for the ocean if the grid values are NA}
  \item{landCol}{a colour to fill countries if the grid values are NA over land}
  \item{plotData}{ whether to plotData, if FALSE a legend can be added on its own  }
  \item{aspect}{aspect for the map, defaults to 1, if set to 'variable' uses same method as plot.Spatial in sp }
  \item{lwd}{line width for country borders}  
  %\item{\dots}{ extra args }
}

 
\details{
Plots a map of global half degree gridded data, allowing classification, colours and regions to be set.

Certain catMethod and colourPalette options go well together. e.g. "diverging" and "diverging", 
"categorical" and "rainbow" 
}

\value{
invisibly returns a list containing the data and main options used for the map, 
the list can be passed to \code{\link{addMapLegend}} along with additional options
to allow greater flexibility in legend creation.
}

\author{ andy south and matthew staines}

\seealso{ classInt, RColorBrewer }

\examples{
## mapping continuous data
data(gridExData,envir=environment(),package="rworldmap")
gridExData <- get("gridExData")
mapGriddedData(gridExData)

## reclassing continuous data to categorical & mapping
data(gridExData,envir=environment(),package="rworldmap")
#find quartile breaks
cutVector <- quantile(gridExData@data[,1],na.rm=TRUE)
#classify the data to a factor
gridExData@data$categories <- cut( gridExData@data[,1]
                                      , cutVector, include.lowest=TRUE)
#rename the categories
levels(gridExData@data$categories) <- c('low', 'med', 'high', 'vhigh')
#mapping
mapGriddedData( gridExData, nameColumnToPlot= 'categories'
              , catMethod='categorical')


}
\keyword{ hplot }

