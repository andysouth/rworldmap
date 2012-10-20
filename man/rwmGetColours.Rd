\name{rwmGetColours}
\alias{rwmGetColours}

\title{ Internal function to choose map colours for classified data }

\description{
Internal function to choose map colours for classified data.
}
\usage{
rwmGetColours(colourPalette, numColours)
}

\arguments{
  \item{colourPalette}{ string describing the colour palette to use, choice of:
    \enumerate{
               \item{}"palette" for the current palette 
               \item{}a vector of valid colours, e.g. =c('red','white','blue') or output from RColourBrewer 
               \item{}one of "heat","diverging","white2Black","black2White","topo","rainbow","terrain","negpos8","negpos9"
               }}
  \item{numColours}{ the number of colour categories desired }
}

\details{
Returns a vector of colours based upon the palette specified and number of colours specified. 
If colourPalette specifies a number of colours and this is different from numColours, numColours takes precedence and colours are interpolated to make the number fit.
}
\value{
A vector specifiying a number of colours. 
}

\author{ andy south and matthew staines }

\seealso{ RColorBrewer }

\examples{
rwmGetColours(colourPalette='topo', numColours=10)
}


\keyword{ dplot }

