\name{getMap}
\Rdversion{1.1}
\alias{getMap}

\title{
A simple way to access maps stored in the package.
}
\description{
A simple way to access maps stored in the package.
}
\usage{
getMap(resolution = "coarse", projection=NA)
}
\arguments{
  \item{resolution}{options "coarse","low","less islands","li","high". For "high" you need to install the package rworldxtra}
  \item{projection}{DEPRECATED OCTOBER 2012 to reproject maps see spTransform in rgdal}
}
\value{
A SpatialPolygonsDataFrame object.
}

\author{
Barry Rowlingson & Andy South
}

\examples{
plot(getMap())
}

\keyword{ misc }

