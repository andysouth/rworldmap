\name{coastsCoarse}
\alias{coastsCoarse}
\docType{data}
\title{A map of world coasts at coarse resolution.
}                                    
\description{
A spatial lines dataframe containing world coasts at a coarse resolution.

}
\usage{data(coastsCoarse)}
\format{
  The format is:
Formal class 'SpatialLinesDataFrame' [package "sp"] with 4 slots
}
\details{
Used in mapGriddedData(addBorders='coasts').
This is the 1:110m coasts data from Natural Earth version 1.3.0.
}
\source{
http://www.naturalearthdata.com/downloads/110m-physical-vectors/
}
\examples{
data(coastsCoarse)
mapGriddedData(addBorders='coasts')
plot(coastsCoarse,add=TRUE,col='blue')
}
\keyword{datasets}
