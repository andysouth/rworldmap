\name{countryExData}
\alias{countryExData}
\docType{data}
\title{ Example dataset for country level data (2008 Environmental Performance Index) }
\description{
A dataframe containing example country level data for 149 countries. 
This is the 2008 Environmental Performance Index (EPI) downloaded from http://epi.yale.edu/. 
Used here with permission, further details on the data can be found there. 
The data are referenced by ISO 3 letter country codes and country names. 
}
\usage{data(countryExData)}
\format{
  A data frame with 149 observations on the following 80 variables.
  \describe{
    \item{\code{ISO3V10}}{a character vector}
    \item{\code{Country}}{a character vector}
    \item{\code{EPI_regions}}{a character vector}
    \item{\code{GEO_subregion}}{a character vector}
    \item{\code{Population2005}}{a numeric vector}
    \item{\code{GDP_capita.MRYA}}{a numeric vector}
    \item{\code{landlock}}{a numeric vector}
    \item{\code{landarea}}{a numeric vector}
    \item{\code{density}}{a numeric vector}
    \item{\code{EPI}}{a numeric vector}
    \item{\code{ENVHEALTH}}{a numeric vector}
    \item{\code{ECOSYSTEM}}{a numeric vector}
    \item{\code{ENVHEALTH.1}}{a numeric vector}
    \item{\code{AIR_E}}{a numeric vector}
    \item{\code{WATER_E}}{a numeric vector}
    \item{\code{BIODIVERSITY}}{a numeric vector}
    \item{\code{PRODUCTIVE_NATURAL_RESOURCES}}{a numeric vector}
    \item{\code{CLIMATE}}{a numeric vector}
    \item{\code{DALY_SC}}{a numeric vector}
    \item{\code{WATER_H}}{a numeric vector}
    \item{\code{AIR_H}}{a numeric vector}
    \item{\code{AIR_E.1}}{a numeric vector}
    \item{\code{WATER_E.1}}{a numeric vector}
    \item{\code{BIODIVERSITY.1}}{a numeric vector}
    \item{\code{FOREST}}{a numeric vector}
    \item{\code{FISH}}{a numeric vector}
    \item{\code{AGRICULTURE}}{a numeric vector}
    \item{\code{CLIMATE.1}}{a numeric vector}
    \item{\code{ACSAT_pt}}{a numeric vector}
    \item{\code{WATSUP_pt}}{a numeric vector}
    \item{\code{DALY_pt}}{a numeric vector}
    \item{\code{INDOOR_pt}}{a numeric vector}
    \item{\code{PM10_pt}}{a numeric vector}
    \item{\code{OZONE_H_pt}}{a numeric vector}
    \item{\code{SO2_pt}}{a numeric vector}
    \item{\code{OZONE_E_pt}}{a numeric vector}
    \item{\code{WATQI_pt}}{a numeric vector}
    \item{\code{WATSTR_pt}}{a numeric vector}
    \item{\code{WATQI_GEMS.station.data}}{a numeric vector}
    \item{\code{FORGRO_pt}}{a numeric vector}
    \item{\code{CRI_pt}}{a numeric vector}
    \item{\code{EFFCON_pt}}{a numeric vector}
    \item{\code{AZE_pt}}{a numeric vector}
    \item{\code{MPAEEZ_pt}}{a numeric vector}
    \item{\code{EEZTD_pt}}{a numeric vector}
    \item{\code{MTI_pt}}{a numeric vector}
    \item{\code{IRRSTR_pt}}{a numeric vector}
    \item{\code{AGINT_pt}}{a numeric vector}
    \item{\code{AGSUB_pt}}{a numeric vector}
    \item{\code{BURNED_pt}}{a numeric vector}
    \item{\code{PEST_pt}}{a numeric vector}
    \item{\code{GHGCAP_pt}}{a numeric vector}
    \item{\code{CO2IND_pt}}{a numeric vector}
    \item{\code{CO2KWH_pt}}{a numeric vector}
    \item{\code{ACSAT}}{a numeric vector}
    \item{\code{WATSUP}}{a numeric vector}
    \item{\code{DALY}}{a numeric vector}
    \item{\code{INDOOR}}{a numeric vector}
    \item{\code{PM10}}{a numeric vector}
    \item{\code{OZONE_H}}{a numeric vector}
    \item{\code{SO2}}{a numeric vector}
    \item{\code{OZONE_E}}{a numeric vector}
    \item{\code{WATQI}}{a numeric vector}
    \item{\code{WATQI_GEMS.station.data.1}}{a numeric vector}
    \item{\code{WATSTR}}{a numeric vector}
    \item{\code{FORGRO}}{a numeric vector}
    \item{\code{CRI}}{a numeric vector}
    \item{\code{EFFCON}}{a numeric vector}
    \item{\code{AZE}}{a numeric vector}
    \item{\code{MPAEEZ}}{a numeric vector}
    \item{\code{EEZTD}}{a numeric vector}
    \item{\code{MTI}}{a numeric vector}
    \item{\code{IRRSTR}}{a numeric vector}
    \item{\code{AGINT}}{a numeric vector}
    \item{\code{AGSUB}}{a numeric vector}
    \item{\code{BURNED}}{a numeric vector}
    \item{\code{PEST}}{a numeric vector}
    \item{\code{GHGCAP}}{a numeric vector}
    \item{\code{CO2IND}}{a numeric vector}
    \item{\code{CO2KWH}}{a numeric vector}
  }
}
\details{
2008 Environmental Performance Index (EPI) data downloaded from : http://epi.yale.edu/Downloads 

Disclaimers 
This 2008 Environmental Performance Index (EPI) tracks national environmental results on a quantitative basis, 
measuring proximity to an established set of policy targets using the best data available. Data constraints 
and limitations in methodology make this a work in progress. Further refinements will be undertaken over the 
next few years. 
Comments, suggestions, feedback, and referrals to better data sources are welcome at: 
http://epi.yale.edu or epi@yale.edu.
}
\source{
http://epi.yale.edu/Downloads
}
\references{
Esty, Daniel C., M.A. Levy, C.H. Kim, A. de Sherbinin, T. Srebotnjak, and V. Mara. 2008. 
2008 Environmental Performance Index. New Haven: Yale Center for Environmental Law and Policy.
}
\examples{
data(countryExData,envir=environment(),package="rworldmap")
str(countryExData)
}
\keyword{datasets}
