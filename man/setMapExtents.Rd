\name{setMapExtents}
\alias{setMapExtents}

\title{ Internal function allowing map extents to be set from area names  }

\description{
Allows map extents to be set from country or area names (e.g. India, Africa )
}

\usage{
setMapExtents(mapRegion = "world")
}


\arguments{
  \item{mapRegion}{ a country name from getMap()[['NAME']] or one of 'eurasia','africa','latin america','uk','oceania','asia' }
}

\details{
Can be called by \code{\link{mapCountryData}} and \code{\link{mapGriddedData}}
}

\value{
a dataframe containing we,ea,so,no values in degrees between -180 & +180
}

\author{ andy south }


\examples{
mapCountryData( mapRegion='Africa' )
mapCountryData( mapRegion='India' )
}

\keyword{ dplot }

