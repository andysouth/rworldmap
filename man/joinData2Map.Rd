% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/joinData2Map.R
\name{joinData2Map}
\alias{joinData2Map}
\title{Joins user polygon attribute data to a map}
\usage{
joinData2Map(
  dF = "",
  nameMap = "",
  nameJoinIDMap = "ISO3",
  nameJoinColumnData = "ISO3V10",
  nameNameColumnData = "Country",
  suggestForFailedCodes = FALSE,
  projection = NA,
  mapResolution = "coarse",
  verbose = FALSE
)
}
\arguments{
\item{dF}{R data frame with at least one column of polygon IDs and one
column of data}

\item{nameMap}{the map to join the attribute data too}

\item{nameJoinIDMap}{the name of the joinIDs in the map}

\item{nameJoinColumnData}{name of column in the data containing country
referencing}

\item{nameNameColumnData}{optional name of column in the data containing
polygon names (used in reporting of success/failure)}

\item{suggestForFailedCodes}{NOT YET ENABLED T/F whether you want system to
suggest for failed codes}

\item{projection}{DEPRECATED JUNE 2012}

\item{mapResolution}{resolution of the borders in the internal map: options
'coarse','low', 'less islands'}

\item{verbose}{if set to FALSE progress messages to console are restricted}
}
\value{
An R 'SpatialPolygonsDataFrame' [package "sp"] object with the data
joined to it
}
\description{
Joins user polygon attribute data to a map of polygon boundaries.  The map
can either be one stored in the package or provided by the user.  Returns a
spatialPolygonsDataFrame ready for plotting using \code{\link{mapPolys}}.
Reports join successes and failures.
}
\details{
Joins user polygon attribute data provided in a 'data frame' to a map of
polygon boundaries.  The map can either be one stored in the package or
provided by the user.  Returns a spatialPolygonsDataFrame ready for plotting
using \code{\link{mapPolys}}.  Reports join successes and failures.

The user specifies the name of the column in their data containing polygon
referencing.

The user can choose from different internal map resolutions.  Uses the
function \code{\link{getMap}} to retrieve the map.
}
\examples{


## this example uses downloaded files
## to run it download the files
## and remove the comment symbols '#' from all the lines starting with a single '#'

## US states map downloaded from :
## http://www2.census.gov/cgi-bin/shapefiles2009/national-files

#inFile <- 'tl_2009_us_stateec.shp'
#sPDF <- readShapePoly(inFile)

##################
## use mapPolys to map the sPDF
#mapPolys(sPDF,nameColumnToPlot = "ALANDEC")
#mapPolys(sPDF,nameColumnToPlot = "AWATEREC",mapRegion='North America')

##################
## join some other data to it
## education data downloaded from here as xls then saved as csv
## http://nces.ed.gov/ccd/drpcompstatelvl.asp

#dataFile <- 'SDR071A_xls.csv'
#dF <- read.csv(dataFile,as.is=TRUE)
#str(dF)
## STATENAME
## DRP912 Dropout Rate, Grades 9 through 12

## joining the data to the map
## based upon state names (column NAMEEC in map, and STATENAME in the data)
#sPDF2 <- joinData2Map(dF
#        , nameMap = sPDF
#        , nameJoinIDMap = "NAMEEC"
#        , nameJoinColumnData = "STATENAME")

#################
## plot one of the attribute variables
#mapDevice()# to set nice shape map window
#mapPolys(sPDF2,nameColumnToPlot = "DRP912",mapRegion='North America')


}
\seealso{
\code{\link{mapPolys}}, \code{\link{getMap}}
}
\author{
andy south
}
\keyword{dplot}
