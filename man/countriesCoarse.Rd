\name{countriesCoarse}
\alias{countriesCoarse}
\docType{data}
\title{ a coarse resolution world map, a vector map of 244 country boundaries,suitable for global maps }
\description{
A 'SpatialPolygonsDataFrame' [package "sp"] object containing a simplified world map. 
Polygons are attributed with country codes.
244 countries. Based on Natural Earth data.
}
\usage{data(countriesCoarse)}
\format{
  The format is:
Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots

}
\details{
Derived fron version 1.4.0 of Natural Earth data 1:110 m data.      
Added in countries from the higher resolution data.

The different country boundaries in rworldmap are processed from Natural Earth Data as follows : \cr
All :                                                                                            \cr
~ rename any non-ASCII country names that cause R trouble                                        \cr
~ rename Curacao which is particularly troublesome !                                             \cr
~ check polygon geometries using checkPolygonsHoles                                              \cr
~ set projections, e.g. proj4string(countriesCoarse) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")\cr
~ set polygon IDs to country names (from ADMIN field)                                            \cr
~ copy ISO_A3 to ISO3                                                                            \cr
~ replace missing ISO3 codes (6 in this version) with ADM0_A3                                    \cr
~ check for duplicate ISO3 codes (2 in this version)                                             \cr
~ set ISO3 for Gaza to Gaza and 'Ashmore and Cartier Islands' to Ashm                            \cr
~ replace POP_EST of -99 with NA                                                                 \cr
~ join on countryRegions data                                                                    \cr

countriesCoarseLessIslands :  ne_110                                                             \cr
countriesCoarse : ne_110 plus extra countries from ne_50 plus Tuvalu from ne_10                  \cr
countriesLow :    ne_50 plus Tuvalu from ne_10                                                   \cr
countriesHigh (in package rworldxtra) :   ne_10                                                  \cr
}
\source{
http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/
}
\examples{
data(countriesCoarse)
}
\keyword{datasets}
