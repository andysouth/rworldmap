\name{addMapLegendBoxes}
\Rdversion{1.1}
\alias{addMapLegendBoxes}
\title{Add a legend of coloured boxes to a map}
\description{
Creates a colour box legend, showing the range of colours and the values the 
colours correspond to. This works well for categorical data with relatively few 
categories.
}
\usage{
addMapLegendBoxes(
                    cutVector=""
                    ,colourVector = ""
                    ,x='bottomleft'
                    ,horiz=FALSE
                    ,title="category"
                    ,cex=1 
                    ,pt.cex=2 
                    ,col="gray" 
                    ,bg="white" 
                    ,legendText="" 
                    
                    ,catMethod="categorical"
                    
                    ,plottedData=""                       
                    ,colourPalette="heat"         
                    ,sigFigs=2                    
                    ,missingCountryCol="white"   

                    ,... 
                    )
}

\arguments{
  \item{cutVector}{the categories or breaks used in the map}
  \item{colourVector}{colours used in the map}
  
  \item{x}{positioning of legend e.g. 'bottomleft', 'topright'}
  \item{horiz}{ if TRUE horizontal legend}  
  \item{title}{ title for Legend }
  \item{cex}{controls the font size, default is 1}
  \item{pt.cex}{controls size of colour boxes relative to cex, default is 2}
  \item{col}{colour for boundary of colour boxes, default is "gray"}
  \item{bg}{colour for legend background, default is "white", NA makes the legend 
  background transparent}
  \item{legendText}{the text to put against each legend box, if left blank 
  cutVector is used, needs to be a vector the same length as length cutVector}  

  \item{catMethod}{the categorisation method used influences what text added to 
  legend elements, for 'categorical' just the category names are used for other 
  options limits are used }
    
  \item{plottedData}{not used yet but maybe in future}
  \item{colourPalette}{not used yet but maybe in future}
  \item{sigFigs}{not used yet but maybe in future}
  \item{missingCountryCol}{not used yet but maybe in future}  

  \item{\dots}{to allow other params to be set in legend}
}
\details{
This creates a legend with separate boxes of colour rather than addMapLegend() 
which creates a colour bar. This method is used as the default for categorical data.

See the examples for how to use a parameter list returned from mapping functions.

}
\value{
Adds a legend to a plot.
}

\author{Andy South}

\seealso{ addMapLegend, mapCountryData, mapGriddedData}
\examples{
#Set up the plot so the world map uses the full width.
mapDevice() 
#map example categorical data with no legend              
mapParams <- mapCountryData(nameColumnToPlot='GEO3major'
              , catMethod='categorical'
              , addLegend='FALSE' 
              )
              
#add default legend using the same parameters as mapCountryData               
do.call( addMapLegendBoxes, c( mapParams))

#adding a modified legend by specifying extra parameters               
do.call( addMapLegendBoxes, c(mapParams,x='bottom',horiz=TRUE,title="Region"))

#user defined map colour sceme              
mapParams <- mapCountryData(nameColumnToPlot='GEO3major'
              , catMethod='categorical'
              , addLegend='FALSE'
              , colourPalette=c('white','green','red','yellow','blue','black') 
              )
#changing legendText
mapParams$legendText <- c('antarctic','africa','oceania'
                         ,'americas','s.asia','eurasia')              
do.call( addMapLegendBoxes, c(mapParams,x='bottom',title="Region",horiz=TRUE))

#or this way
#do.call( addMapLegendBoxes
#        , c(mapParams
#           ,list(legendText=c('antarctic','africa','oceania'
#                              ,'americas','s.asia','eurasia')
#                ,x='bottom',title="Region",horiz=TRUE)))


}
\keyword{ aplot }
