\name{gridCountriesNumeric}
\alias{gridCountriesNumeric}
\docType{data}
\title{ A gloabl half degree grid specifying the country at each cell }
\description{
A grid covering the globe at half degree resolution, specifying the country (UN numeric code) at each cell.
}
\usage{data(gridCountriesNumeric)}
\format{
  The format is:
\preformatted{
Formal class 'SpatialGridDataFrame' [package "sp"] with 6 slots
  ..@ data       :'data.frame':	259200 obs. of  1 variable:
  .. ..$ country.asc: num [1:259200] NA NA NA NA NA NA NA NA NA NA ...
  ..@ grid       :Formal class 'GridTopology' [package "sp"] with 3 slots
  .. .. ..@ cellcentre.offset: num [1:2] -179.8  -89.8
  .. .. ..@ cellsize         : num [1:2] 0.5 0.5
  .. .. ..@ cells.dim        : int [1:2] 720 360
  ..@ grid.index : int(0) 
  ..@ coords     : num [1:2, 1:2] -179.8  179.8  -89.8   89.8
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : NULL
  .. .. ..$ : chr [1:2] "coords.x1" "coords.x2"
  ..@ bbox       : num [1:2, 1:2] -180 -90 180 90
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:2] "coords.x1" "coords.x2"
  .. .. ..$ : chr [1:2] "min" "max"
  ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slots
  .. .. ..@ projargs: chr " +proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
}
}
\details{
Uses a simple grid map defining a single country identity for each half degree cell.  
(sp, SpatialGridDataFrame), used by the function aggregateHalfDegreeGridToCountries()
}
\source{
IIASA
}
\references{
http://www.iiasa.ac.at/Research/GGI/DB/
}
\examples{
data(gridCountriesNumeric)
}
\keyword{datasets}
