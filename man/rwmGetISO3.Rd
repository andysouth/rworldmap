\name{rwmGetISO3}
\alias{rwmGetISO3}

\title{
Internal function for getting the ISO3 country code for a country name synonymn.
}
\description{
Searches countrySynonyms to get the ISO3 code. If the name is not found NA is returned.
Allows joining of imperfect names to other country data in joinCountryData2Map( joinCode='NAME' )
}
\usage{
rwmGetISO3(oddName)
}

\arguments{
  \item{oddName}{ country name that user wishes to find code for}
}

\value{
the ISO3 code (3 letters) corresponding to the country name passed, or NA if one is not found
}
\references{
This was derived and used with permission from the Perl Locale package. Locale::Codes::Country_Codes.
Thanks to Sullivan Beck for pulling this together.
Data sources are acknowledged here :
http://search.cpan.org/~sbeck/Locale-Codes-3.23/lib/Locale/Codes/Country.pod
}
\author{
Andy South
}

\examples{
rwmGetISO3("vietnam")
}

\keyword{manip}
