% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{coastsCoarse}
\alias{coastsCoarse}
\title{A map of world coasts at coarse resolution.}
\format{
The format is: Formal class 'SpatialLinesDataFrame' [package "sp"]
with 4 slots
}
\source{
http://www.naturalearthdata.com/downloads/110m-physical-vectors/
}
\description{
A spatial lines dataframe containing world coasts at a coarse resolution.
}
\details{
Used in mapGriddedData(addBorders='coasts'). This is the 1:110m coasts data
from Natural Earth version 1.3.0.
}
\examples{

data(coastsCoarse)
mapGriddedData(addBorders='coasts')
plot(coastsCoarse,add=TRUE,col='blue')

}
\keyword{datasets}
