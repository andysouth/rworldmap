\name{rwmCheckAndLoadInput}
\alias{rwmCheckAndLoadInput}
\title{internal function to check and load input data to mapping functions}
\description{
Internal function checking and loading dFs or sPDFs to \code{\link{mapCountryData}}, \code{\link{mapPolys}}, \code{\link{mapPies}}, \code{\link{mapBubbles}}, \code{\link{mapBars}}.
}
\usage{
rwmCheckAndLoadInput(
						    inputData =         ""
						  #, nameColumnToPlot =  ""
						  , requireSPDF =       TRUE
						  , callingFunction = "" #currently optional may be useful later
              )
              
}
\arguments{
  \item{inputData}{ a dF, sPDF or "", for latter an internal example data is used }
  #\item{nameColumnToPlot}{ name of column containing the data you want to plot }
  \item{requireSPDF}{ whether calling function requires a sPDF, if not a dF is accepted}
  \item{callingFunction}{ name of the calling function }
}

\details{
a rworldmap internal function, unlikely to be of use to users
}

\value{
invisibly returns a dF or sPDF
}

\author{ andy south }

\keyword{ aplot }

