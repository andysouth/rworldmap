\name{isoToName}
\alias{isoToName}

\title{
Returns the country name corresponding to the passed iso code 
(3 letter, 2 letter or numeric).
}
\description{
Searches getMap()@data to find the iso code. By default it returns the string in 
the ADMIN column. By modifying nameColumn you can also get it to return values from 
any other columns in getMap()@data - see the examples. 
Thus it can also be used to convert between ISO codes.
}
\usage{
isoToName( iso = ""
         , lookup = getMap()@data  
         , nameColumn ='ADMIN' )
}

\arguments{
  \item{iso}{ iso code to convert to a country name}
  \item{lookup}{ the dataframe containing iso codes and country names }
  \item{nameColumn}{ which column to get the name from, see examples }  
}

\details{
You could optionally provide a dataframe containing alternate iso conversions using 
lookup= . The passe dataframe would need to contain at least one of the following 
columns containing 2 letter, 3 letter or numeric iso codes respectively : 
ISO_A2, ISO_A3, ISO_N3.
}

\value{
The country name (or other field) associated with the ISO code passed. 
NA is returned if no matching code is found.
}

\author{
Andy South
}

\examples{
isoToName('gb')
isoToName('gbr')
isoToName(826)
isoToName('uk') #generates a warning and returns NA
#beware that using nameColumn may be vulnerable to future changes 
#in column names in Natural Earth data
isoToName('gb',nameColumn='ABBREV') #returns abbreviation
isoToName('gb',nameColumn='ISO_A3') #returns iso3 for this iso2
isoToName('gbr',nameColumn='continent') #returns continent for this iso3
}

\keyword{manip}
