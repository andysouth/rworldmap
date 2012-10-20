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
  ..@ data       :'data.frame':	134 obs. of  2 variables:
  .. ..$ ScaleRank : int [1:134] 1 0 0 0 1 1 1 0 1 1 ...
  .. ..$ FeatureCla: Factor w/ 2 levels "Coastline","Country": 1 1 1 1 1 1 1 1 1 1 ...
  .. ..- attr(*, "data_types")= chr [1:2] "N" "C"
  ..@ lines      :List of 134
  .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
  .. .. .. ..@ Lines:List of 1
  .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slots
  .. .. .. .. .. .. ..@ coords: num [1:11, 1:2] -164 -163 -161 -160 -159 ...
  .. .. .. ..@ ID   : chr "0"


  .. .. [list output truncated]
  ..@ bbox       : num [1:2, 1:2] -180 -85.6 180 83.6
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:2] "x" "y"
  .. .. ..$ : chr [1:2] "min" "max"
  ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slots
  .. .. ..@ projargs: chr NA
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
#mapGriddedData(addBorders='coasts')
}
\keyword{datasets}
