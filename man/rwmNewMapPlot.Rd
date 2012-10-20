\name{rwmNewMapPlot}
\Rdversion{1.1}
\alias{rwmNewMapPlot}

\title{
Internal function to set up an existing device for plotting maps
}
\description{
Sets the region, aspect and ocean colour for a new map plot
}
\usage{
rwmNewMapPlot(mapToPlot, oceanCol, mapRegion, xlim, ylim, aspect)
}
\arguments{
  \item{mapToPlot}{the worldmap to be plotted}
  \item{oceanCol}{a colour for the ocean}
  \item{mapRegion}{a string specifying the map region, see setMapExtents()}
  \item{xlim}{ map extents c(west,east), can be overidden by mapRegion }
  \item{ylim}{ map extents c(south,north), can be overidden by mapRegion }  
  \item{aspect}{aspect for the map, defaults to 1, if set to 'variable' uses same default as plot.Spatial in sp }
}

\details{
Called by mapCountryData() and mapGriddedData()
}

\author{andy south}


\keyword{misc}

