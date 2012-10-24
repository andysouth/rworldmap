\name{countrySynonyms}
\alias{countrySynonyms}
\docType{data}
\title{
Synonyms of country names for each ISO 3 letter country code to enable conversion.
}
\description{
contains a variable number of synonyms (mostly English language) for each country
}
\usage{data(countrySynonyms)}
\format{
  A data frame with 281 observations on the following 10 variables.
  \describe{
    \item{\code{ID}}{a numeric vector}
    \item{\code{ISO3}}{ISO 3 letter country code}
    \item{\code{name1}}{country name - most common}
    \item{\code{name2}}{country name - alternative}
    \item{\code{name3}}{country name - alternative}
    \item{\code{name4}}{country name - alternative}
    \item{\code{name5}}{country name - alternative}
    \item{\code{name6}}{country name - alternative}
    \item{\code{name7}}{country name - alternative}
    \item{\code{name8}}{country name - alternative}
  }
}
\details{
This is used by joinCountryData2Map() when country names are used as the joinCode.
Note that using ISO codes is preferable if they are available. 
}
\source{
This was derived and used with permission from the Perl Locale package. \cr
Locale::Codes::Country_Codes.\cr
Thanks to Sullivan Beck for pulling this together.\cr
Data sources are acknowledged here :\cr
http://search.cpan.org/~sbeck/Locale-Codes-3.23/lib/Locale/Codes/Country.pod
}

\examples{
data(countrySynonyms)

}
\keyword{datasets}
