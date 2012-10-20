\name{mapCountryData}
\alias{mapCountryData}
\title{Map country-level data.}
\description{
  Draw a map of country-level data, allowing countries to be coloured, from an object created in joinCountryData2Map().
}
\usage{
mapCountryData( 
                mapToPlot =         ""
              , nameColumnToPlot =  ""
              , numCats =           7
              , xlim =              NA
              , ylim =              NA
              , mapRegion =         "world"
              , catMethod =         "quantiles"
              , colourPalette =     "heat"
              , addLegend =         TRUE
              , borderCol =         'grey'
              , mapTitle =          'columnName'
              , oceanCol =          NA
              , aspect =            1
              , missingCountryCol = NA
              , add =               FALSE
              , nameColumnToHatch = ""
              )   
}
\arguments{
  \item{mapToPlot}{ a spatial polygons dataframe from joinCountryData2Map() containing country polygons and data, if none specified an internal example data is used }
  \item{nameColumnToPlot}{ name of column containing the data you want to plot }
  \item{numCats}{ number of categories to put the data in, may be modified if this number is incompatible with the catMethod chosen}
  \item{xlim}{ map extents c(west,east), can be overidden by mapRegion }
  \item{ylim}{ map extents c(south,north), can be overidden by mapRegion }
  \item{mapRegion}{ a country name from getMap()[['NAME']] or 'world','africa','oceania','eurasia','uk' sets map extents, overrides xlim,ylim }
  \item{catMethod}{ method for categorisation of data "pretty", "fixedWidth", "diverging", "logfixedWidth","quantiles","categorical", or a numeric vector defining breaks }
  \item{colourPalette}{ string describing the colour palette to use, choice of:
    \enumerate{
               \item{}"palette" for the current palette 
               \item{}a vector of valid colours, e.g. =c('red','white','blue') or output from RColourBrewer 
               \item{}one of "heat","diverging","white2Black","black2White","topo","rainbow","terrain","negpos8","negpos9"
               }}
  \item{addLegend}{ whether to add a legend or not }
  \item{borderCol}{ the colour for country borders  }
  \item{mapTitle}{ title to add to the map, any string or 'columnName' to set it to the name of the data column  }
  \item{oceanCol}{a colour for the ocean}
  \item{aspect}{aspect for the map, defaults to 1, if set to 'variable' uses same method as plot.Spatial in sp }
  \item{missingCountryCol}{a colour for missing countries}
  \item{add}{whether to add this map on top of an existing map, TRUE/FALSE}
  \item{nameColumnToHatch}{allows hatching of country fills (e.g. to represent uncertainty)
                          , specify a column containing numeric data
                          , highest values will be solid and lower values will
                          have a decreasing density of hatching
                          , new feature more documentation will be added soon}    
  
}

\section{Warning}{will generate unhelpful errors in data categorisation if inappropriate 
options are chosen, e.g. with catMethod:Quantiles if numCats too high so that unique breaks cannot be defined.
}

\details{
Certain catMethod and colourPalette options go well together. e.g. "diverging" and "diverging", 
"categorical" and "rainbow" 

There are two styles of legend available. 
If catMethod='categorical' or the packages fields and spam are not installed a simple legend with coloured boxes is created.
Otherwise a colour bar legend is created. Finer control can be achieved by \code{\link{addMapLegendBoxes}} 
or \code{\link{addMapLegend}} repectively. 
}

\value{
invisibly returns a list containing the data and main options used for the map, 
the list can be passed to \code{\link{addMapLegend}} or \code{\link{addMapLegendBoxes}}
along with additional options to allow greater flexibility in legend creation.
}

\author{ andy south }

\seealso{ classInt, RColorBrewer }

\examples{
mapCountryData()
data("countryExData",envir=environment(),package="rworldmap")
sPDF <- joinCountryData2Map(countryExData
              , joinCode = "ISO3"
              , nameJoinColumn = "ISO3V10"
              )
mapCountryData( sPDF
              , nameColumnToPlot="BIODIVERSITY" 
              )
              
#user defined map colour scheme for categorical data              
mapParams <- mapCountryData(nameColumnToPlot='GEO3major'
              , catMethod='categorical'
              , addLegend='FALSE'
              , colourPalette=c('white','green','red','yellow','blue','black') 
              )
#changing legendText
mapParams$legendText <- c('antarctic','africa','oceania','americas','s.asia','eurasia')              
do.call( addMapLegendBoxes, c(mapParams,x='bottom',title="Region",horiz=TRUE))

##showing how rworldmap can be used with the classInt and RColorBrewer packages
library(classInt)
library(RColorBrewer)
#getting example data and joining to a map
data("countryExData",envir=environment(),package="rworldmap")
sPDF <- joinCountryData2Map(countryExData,joinCode = "ISO3"
                           ,nameJoinColumn = "ISO3V10")
#getting class intervals using a 'jenks' classification in classInt package
classInt <- classIntervals( sPDF$EPI, n=5, style="jenks")
catMethod = classInt$brks
#getting a colour scheme from the RColorBrewer package
colourPalette <- brewer.pal(5,'RdPu')
#calling mapCountryData with the parameters from classInt and RColorBrewer
mapParams <- mapCountryData( sPDF, nameColumnToPlot="EPI", addLegend=FALSE
                           , catMethod = catMethod, colourPalette=colourPalette )
do.call(addMapLegend, c(mapParams
                       ,legendLabels="all"
                       ,legendWidth=0.5
                       ,legendIntervals="data"))

              

}

\keyword{ aplot }

