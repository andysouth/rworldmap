\name{aggregateHalfDegreeGridToCountries}
\alias{aggregateHalfDegreeGridToCountries}

\title{ Aggregates global half degree gridded data to countries }
\description{
Aggregates global half degree gridded data to countries (options for sum, mean, min, max ).
Uses a very simple grid map defining a single country identity for each half degree cell. 
(other more sophisticated approaches dividing cells between multiple countries will be investigated in future).
The country identity at each cell is specified in data(gridCountriesNumeric). 
}
\usage{
aggregateHalfDegreeGridToCountries(inFile = "", aggregateOption = "sum")
}

\arguments{
  \item{inFile}{ either a gridascii filename or an sp SpatialGridDataFrame object specifying a global half degree grid dataset }
  \item{aggregateOption}{ how to aggregate the data ('sum','mean','min','max') }
}

\value{
  a dataframe with 2 columns : numeric country codes and the aggregated value for each country
}

\author{ andy south }

\seealso{ \code{\link{mapHalfDegreeGridToCountries}} }
\examples{

data(gridExData,envir=environment(),package="rworldmap")
gridExData <- get("gridExData")
#aggregating the gridded data to countries
dF <- aggregateHalfDegreeGridToCountries(gridExData)
#joining the aggregated data to a country map
sPDF <- joinCountryData2Map(dF, nameJoinColumn='UN', joinCode='UN')
#plotting the map
mapCountryData(sPDF,nameColumnToPlot='sum_pa2000.asc')

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ dplot }

