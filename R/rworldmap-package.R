

#' A map of world coasts at coarse resolution.
#' 
#' A spatial lines dataframe containing world coasts at a coarse resolution.
#' 
#' Used in mapGriddedData(addBorders='coasts'). This is the 1:110m coasts data
#' from Natural Earth version 1.3.0.
#' 
#' @name coastsCoarse
#' @docType data
#' @format The format is: Formal class 'SpatialLinesDataFrame' [package "sp"]
#' with 4 slots
#' @source http://www.naturalearthdata.com/downloads/110m-physical-vectors/
#' @keywords datasets
#' @examples
#' 
#' data(coastsCoarse)
#' mapGriddedData(addBorders='coasts')
#' plot(coastsCoarse,add=TRUE,col='blue')
#' 
NULL





#' a coarse resolution world map, a vector map of 244 country
#' boundaries,suitable for global maps
#' 
#' A 'SpatialPolygonsDataFrame' [package "sp"] object containing a simplified
#' world map.  Polygons are attributed with country codes. 244 countries. Based
#' on Natural Earth data.
#' 
#' Derived from version 1.4.0 of Natural Earth data 1:110 m data.  Missing
#' countries at this resolution are added in from the higher resolution 1:50 m
#' data so that these countries are included e.g. in \code{\link{mapBubbles}}.
#' 
#' The different country boundaries in rworldmap are processed from Natural
#' Earth Data as follows : \cr All : \cr ~ rename any non-ASCII country names
#' that cause R trouble \cr ~ rename Curacao which is particularly troublesome
#' !  \cr ~ check polygon geometries using checkPolygonsHoles \cr ~ set
#' projections, e.g. proj4string(countriesCoarse) <- CRS("+proj=longlat
#' +ellps=WGS84 +datum=WGS84 +no_defs")\cr ~ set polygon IDs to country names
#' (from ADMIN field) \cr ~ copy ISO_A3 to ISO3 \cr ~ replace missing ISO3
#' codes (6 in this version) with ADM0_A3 \cr ~ check for duplicate ISO3 codes
#' (2 in this version) \cr ~ set ISO3 for Gaza to Gaza and 'Ashmore and Cartier
#' Islands' to Ashm \cr ~ replace POP_EST of -99 with NA \cr ~ join on
#' countryRegions data \cr
#' 
#' countriesCoarseLessIslands : ne_110 \cr countriesCoarse : ne_110 plus extra
#' countries from ne_50 plus Tuvalu from ne_10 \cr countriesLow : ne_50 plus
#' Tuvalu from ne_10 \cr countriesHigh (in package rworldxtra) : ne_10 \cr
#' 
#' @name countriesCoarse
#' @docType data
#' @format The format is: Formal class 'SpatialPolygonsDataFrame' [package
#' "sp"] with 5 slots
#' @source
#' http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/
#' @keywords datasets
#' @examples
#' 
#' data(countriesCoarse)
#' 
NULL





#' a coarse resolution world map, a vector map of 177 country boundaries,
#' suitable for global maps
#' 
#' A 'SpatialPolygonsDataFrame' [package "sp"] object containing a simplified
#' world map.  Polygons are attributed with country codes. 177 countries.
#' Derived fronm version 1.4.0 of Natural Earth data 1:110 m data.
#' 
#' 
#' The different country boundaries in rworldmap are processed from Natural
#' Earth Data as follows : \cr All : \cr ~ rename any non-ASCII country names
#' that cause R trouble \cr ~ rename Curacao which is particularly troublesome
#' !  \cr ~ check polygon geometries using checkPolygonsHoles \cr ~ set
#' projections, e.g. proj4string(countriesCoarse) <- CRS("+proj=longlat
#' +ellps=WGS84 +datum=WGS84 +no_defs")\cr ~ set polygon IDs to country names
#' (from ADMIN field) \cr ~ copy ISO_A3 to ISO3 \cr ~ replace missing ISO3
#' codes (6 in this version) with ADM0_A3 \cr ~ check for duplicate ISO3 codes
#' (2 in this version) \cr ~ set ISO3 for Gaza to Gaza and 'Ashmore and Cartier
#' Islands' to Ashm \cr ~ replace POP_EST of -99 with NA \cr ~ join on
#' countryRegions data \cr
#' 
#' countriesCoarseLessIslands : ne_110 \cr countriesCoarse : ne_110 plus extra
#' countries from ne_50 plus Tuvalu from ne_10 \cr countriesLow : ne_50 plus
#' Tuvalu from ne_10 \cr countriesHigh (in package rworldxtra) : ne_10 \cr
#' 
#' @name countriesCoarseLessIslands
#' @docType data
#' @format The format is: Formal class 'SpatialPolygonsDataFrame' [package
#' "sp"] with 5 slots
#' @source
#' http://www.naturalearthdata.com/downloads/110m-cultural-vectors/110m-admin-0-countries/
#' @keywords datasets
#' @examples
#' 
#' data(countriesCoarseLessIslands)
#' 
NULL





#' a low resolution world map, a vector map of 244 country boundaries, suitable
#' for zooming in on regions or large global maps
#' 
#' A 'SpatialPolygonsDataFrame' [package "sp"] object containing country
#' boundaries derived from Natural Earth data.  Polygons are attributed with
#' country codes. Derived from version 1.4.0 of Natural Earth data 1:50 m data.
#' 
#' The different country boundaries in rworldmap are processed from Natural
#' Earth Data as follows : \cr All : \cr ~ rename any non-ASCII country names
#' that cause R trouble \cr ~ rename Curacao which is particularly troublesome
#' !  \cr ~ check polygon geometries using checkPolygonsHoles \cr ~ set
#' projections, e.g. proj4string(countriesCoarse) <- CRS("+proj=longlat
#' +ellps=WGS84 +datum=WGS84 +no_defs")\cr ~ set polygon IDs to country names
#' (from ADMIN field) \cr ~ copy ISO_A3 to ISO3 \cr ~ replace missing ISO3
#' codes (6 in this version) with ADM0_A3 \cr ~ check for duplicate ISO3 codes
#' (2 in this version) \cr ~ set ISO3 for Gaza to Gaza and 'Ashmore and Cartier
#' Islands' to Ashm \cr ~ replace POP_EST of -99 with NA \cr ~ join on
#' countryRegions data \cr
#' 
#' countriesCoarseLessIslands : ne_110 \cr countriesCoarse : ne_110 plus extra
#' countries from ne_50 plus Tuvalu from ne_10 \cr countriesLow : ne_50 plus
#' Tuvalu from ne_10 \cr countriesHigh (in package rworldxtra) : ne_10 \cr
#' 
#' @name countriesLow
#' @docType data
#' @format The format is: Formal class 'SpatialPolygonsDataFrame' [package
#' "sp"] with 5 slots
#' @source http://www.naturalearthdata.com/downloads/50m-cultural-vectors/
#' @keywords datasets
#' @examples
#' 
#' data(countriesLow)
#' 
NULL





#' Example dataset for country level data (2008 Environmental Performance
#' Index)
#' 
#' A dataframe containing example country level data for 149 countries.  This
#' is the 2008 Environmental Performance Index (EPI) downloaded from
#' http://epi.yale.edu/.  Used here with permission, further details on the
#' data can be found there.  The data are referenced by ISO 3 letter country
#' codes and country names.
#' 
#' 2008 Environmental Performance Index (EPI) data downloaded from :
#' http://epi.yale.edu/Downloads
#' 
#' Disclaimers This 2008 Environmental Performance Index (EPI) tracks national
#' environmental results on a quantitative basis, measuring proximity to an
#' established set of policy targets using the best data available. Data
#' constraints and limitations in methodology make this a work in progress.
#' Further refinements will be undertaken over the next few years.  Comments,
#' suggestions, feedback, and referrals to better data sources are welcome at:
#' http://epi.yale.edu or epi@yale.edu.
#' 
#' @name countryExData
#' @docType data
#' @format A data frame with 149 observations on the following 80 variables.
#' \describe{ \item{list("ISO3V10")}{a character vector}
#' \item{list("Country")}{a character vector} \item{list("EPI_regions")}{a
#' character vector} \item{list("GEO_subregion")}{a character vector}
#' \item{list("Population2005")}{a numeric vector}
#' \item{list("GDP_capita.MRYA")}{a numeric vector} \item{list("landlock")}{a
#' numeric vector} \item{list("landarea")}{a numeric vector}
#' \item{list("density")}{a numeric vector} \item{list("EPI")}{a numeric
#' vector} \item{list("ENVHEALTH")}{a numeric vector}
#' \item{list("ECOSYSTEM")}{a numeric vector} \item{list("ENVHEALTH.1")}{a
#' numeric vector} \item{list("AIR_E")}{a numeric vector}
#' \item{list("WATER_E")}{a numeric vector} \item{list("BIODIVERSITY")}{a
#' numeric vector} \item{list("PRODUCTIVE_NATURAL_RESOURCES")}{a numeric
#' vector} \item{list("CLIMATE")}{a numeric vector} \item{list("DALY_SC")}{a
#' numeric vector} \item{list("WATER_H")}{a numeric vector}
#' \item{list("AIR_H")}{a numeric vector} \item{list("AIR_E.1")}{a numeric
#' vector} \item{list("WATER_E.1")}{a numeric vector}
#' \item{list("BIODIVERSITY.1")}{a numeric vector} \item{list("FOREST")}{a
#' numeric vector} \item{list("FISH")}{a numeric vector}
#' \item{list("AGRICULTURE")}{a numeric vector} \item{list("CLIMATE.1")}{a
#' numeric vector} \item{list("ACSAT_pt")}{a numeric vector}
#' \item{list("WATSUP_pt")}{a numeric vector} \item{list("DALY_pt")}{a numeric
#' vector} \item{list("INDOOR_pt")}{a numeric vector} \item{list("PM10_pt")}{a
#' numeric vector} \item{list("OZONE_H_pt")}{a numeric vector}
#' \item{list("SO2_pt")}{a numeric vector} \item{list("OZONE_E_pt")}{a numeric
#' vector} \item{list("WATQI_pt")}{a numeric vector} \item{list("WATSTR_pt")}{a
#' numeric vector} \item{list("WATQI_GEMS.station.data")}{a numeric vector}
#' \item{list("FORGRO_pt")}{a numeric vector} \item{list("CRI_pt")}{a numeric
#' vector} \item{list("EFFCON_pt")}{a numeric vector} \item{list("AZE_pt")}{a
#' numeric vector} \item{list("MPAEEZ_pt")}{a numeric vector}
#' \item{list("EEZTD_pt")}{a numeric vector} \item{list("MTI_pt")}{a numeric
#' vector} \item{list("IRRSTR_pt")}{a numeric vector} \item{list("AGINT_pt")}{a
#' numeric vector} \item{list("AGSUB_pt")}{a numeric vector}
#' \item{list("BURNED_pt")}{a numeric vector} \item{list("PEST_pt")}{a numeric
#' vector} \item{list("GHGCAP_pt")}{a numeric vector}
#' \item{list("CO2IND_pt")}{a numeric vector} \item{list("CO2KWH_pt")}{a
#' numeric vector} \item{list("ACSAT")}{a numeric vector}
#' \item{list("WATSUP")}{a numeric vector} \item{list("DALY")}{a numeric
#' vector} \item{list("INDOOR")}{a numeric vector} \item{list("PM10")}{a
#' numeric vector} \item{list("OZONE_H")}{a numeric vector}
#' \item{list("SO2")}{a numeric vector} \item{list("OZONE_E")}{a numeric
#' vector} \item{list("WATQI")}{a numeric vector}
#' \item{list("WATQI_GEMS.station.data.1")}{a numeric vector}
#' \item{list("WATSTR")}{a numeric vector} \item{list("FORGRO")}{a numeric
#' vector} \item{list("CRI")}{a numeric vector} \item{list("EFFCON")}{a numeric
#' vector} \item{list("AZE")}{a numeric vector} \item{list("MPAEEZ")}{a numeric
#' vector} \item{list("EEZTD")}{a numeric vector} \item{list("MTI")}{a numeric
#' vector} \item{list("IRRSTR")}{a numeric vector} \item{list("AGINT")}{a
#' numeric vector} \item{list("AGSUB")}{a numeric vector}
#' \item{list("BURNED")}{a numeric vector} \item{list("PEST")}{a numeric
#' vector} \item{list("GHGCAP")}{a numeric vector} \item{list("CO2IND")}{a
#' numeric vector} \item{list("CO2KWH")}{a numeric vector} }
#' @references Esty, Daniel C., M.A. Levy, C.H. Kim, A. de Sherbinin, T.
#' Srebotnjak, and V. Mara. 2008.  2008 Environmental Performance Index. New
#' Haven: Yale Center for Environmental Law and Policy.
#' @source http://epi.yale.edu/Downloads
#' @keywords datasets
#' @examples
#' 
#' data(countryExData,envir=environment(),package="rworldmap")
#' str(countryExData)
#' 
NULL





#' Regional Classification Table
#' 
#' A number of regional classifications exist, e.g. SRES, Stern, etc. This
#' table can be used to find which grouping a country belongs to, given its
#' country code. A variety of different codes or groupings can be used.
#' 
#' Joined onto vector country maps. Used by \code{\link{country2Region}} and
#' \code{\link{mapByRegion}}.
#' 
#' @name countryRegions
#' @docType data
#' @format A data frame with the following variables.  \describe{
#' \item{list("ISO3")}{ISO 3 letter country code} \item{list("ADMIN")}{country
#' name} \item{list("REGION")}{7 region continent classification}
#' \item{list("continent")}{6 continents classification}
#' \item{list("GEO3major")}{Global Environment Outlook GEO3 major region names}
#' \item{list("GEO3")}{Global Environment Outlook GEO3 major region names}
#' \item{list("IMAGE24")}{Image24 region names} \item{list("GLOCAF")}{GLOCAF
#' region names} \item{list("Stern")}{Stern report region names}
#' \item{list("SRESmajor")}{SRES major region names} \item{list("SRES")}{SRES
#' region names} \item{list("GBD")}{Global Burden of Disease GBD region names}
#' \item{list("AVOIDnumeric")}{numeric codes for AVOID regions}
#' \item{list("AVOIDname")}{AVOID regions} \item{list("LDC")}{UN Least
#' Developed Countries} \item{list("SID")}{UN Small Island Developing states}
#' \item{list("LLDC")}{UN Landlocked Developing Countries} }
#' @keywords datasets
#' @examples
#' 
#' data(countryRegions,envir=environment(),package="rworldmap")
#' str(countryRegions)
#' 
#' #joining example data onto the regional classifications
#' data(countryExData,envir=environment(),package="rworldmap")
#' dF <- merge(countryExData,countryRegions,by.x='ISO3V10',by.y='ISO3')
#' #plotting ENVHEALTH for Least Developed Countries (LDC) against others
#' #plot( dF$ENVHEALTH ~ dF$LDC)
#' #points( y=dF$ENVHEALTH, x=dF$LDC)
#' 
#' 
NULL





#' Synonyms of country names for each ISO 3 letter country code to enable
#' conversion.
#' 
#' contains a variable number of synonyms (mostly English language) for each
#' country
#' 
#' This is used by joinCountryData2Map() when country names are used as the
#' joinCode. Note that using ISO codes is preferable if they are available.
#' 
#' @name countrySynonyms
#' @docType data
#' @format A data frame with 281 observations on the following 10 variables.
#' \describe{ \item{list("ID")}{a numeric vector} \item{list("ISO3")}{ISO 3
#' letter country code} \item{list("name1")}{country name - most common}
#' \item{list("name2")}{country name - alternative}
#' \item{list("name3")}{country name - alternative}
#' \item{list("name4")}{country name - alternative}
#' \item{list("name5")}{country name - alternative}
#' \item{list("name6")}{country name - alternative}
#' \item{list("name7")}{country name - alternative}
#' \item{list("name8")}{country name - alternative} }
#' @source This was derived and used with permission from the Perl Locale
#' package. \cr Locale::Codes::Country_Codes.\cr Thanks to Sullivan Beck for
#' pulling this together.\cr Data sources are acknowledged here :\cr
#' http://search.cpan.org/~sbeck/Locale-Codes-3.23/lib/Locale/Codes/Country.pod
#' @keywords datasets
#' @examples
#' 
#' data(countrySynonyms)
#' 
#' 
NULL





#' A gloabl half degree grid specifying the country at each cell
#' 
#' A grid covering the globe at half degree resolution, specifying the country
#' (UN numeric code) at each cell.
#' 
#' Uses a simple grid map defining a single country identity for each half
#' degree cell.  (sp, SpatialGridDataFrame), used by the function
#' aggregateHalfDegreeGridToCountries()
#' 
#' @name gridCountriesDegreesHalf
#' @docType data
#' @format The format is: \preformatted{ Formal class 'SpatialGridDataFrame'
#' [package "sp"] with 6 slots ..@ data :'data.frame': 259200 obs. of 1
#' variable: .. ..$ country.asc: num [1:259200] NA NA NA NA NA NA NA NA NA NA
#' ...  ..@ grid :Formal class 'GridTopology' [package "sp"] with 3 slots .. ..
#' ..@ cellcentre.offset: num [1:2] -179.8 -89.8 .. .. ..@ cellsize : num [1:2]
#' 0.5 0.5 .. .. ..@ cells.dim : int [1:2] 720 360 ..@ grid.index : int(0) ..@
#' coords : num [1:2, 1:2] -179.8 179.8 -89.8 89.8 .. ..- attr(*,
#' "dimnames")=List of 2 .. .. ..$ : NULL .. .. ..$ : chr [1:2] "coords.x1"
#' "coords.x2" ..@ bbox : num [1:2, 1:2] -180 -90 180 90 .. ..- attr(*,
#' "dimnames")=List of 2 .. .. ..$ : chr [1:2] "coords.x1" "coords.x2" .. ..
#' ..$ : chr [1:2] "min" "max" ..@ proj4string:Formal class 'CRS' [package
#' "sp"] with 1 slots .. .. ..@ projargs: chr " +proj=longlat +datum=WGS84
#' +ellps=WGS84 +towgs84=0,0,0" }
#' @source created from getMap(resolution='low')
#' @keywords datasets
#' @examples
#' 
#' data(gridCountriesDegreesHalf)
#' 
NULL





#' A gloabl half degree grid specifying the country at each cell
#' 
#' A grid covering the globe at half degree resolution, specifying the country
#' (UN numeric code) at each cell.
#' 
#' Uses a simple grid map defining a single country identity for each half
#' degree cell.  (sp, SpatialGridDataFrame), used by the function
#' aggregateHalfDegreeGridToCountries()
#' 
#' @name gridCountriesNumeric
#' @docType data
#' @format The format is: \preformatted{ Formal class 'SpatialGridDataFrame'
#' [package "sp"] with 6 slots ..@ data :'data.frame': 259200 obs. of 1
#' variable: .. ..$ country.asc: num [1:259200] NA NA NA NA NA NA NA NA NA NA
#' ...  ..@ grid :Formal class 'GridTopology' [package "sp"] with 3 slots .. ..
#' ..@ cellcentre.offset: num [1:2] -179.8 -89.8 .. .. ..@ cellsize : num [1:2]
#' 0.5 0.5 .. .. ..@ cells.dim : int [1:2] 720 360 ..@ grid.index : int(0) ..@
#' coords : num [1:2, 1:2] -179.8 179.8 -89.8 89.8 .. ..- attr(*,
#' "dimnames")=List of 2 .. .. ..$ : NULL .. .. ..$ : chr [1:2] "coords.x1"
#' "coords.x2" ..@ bbox : num [1:2, 1:2] -180 -90 180 90 .. ..- attr(*,
#' "dimnames")=List of 2 .. .. ..$ : chr [1:2] "coords.x1" "coords.x2" .. ..
#' ..$ : chr [1:2] "min" "max" ..@ proj4string:Formal class 'CRS' [package
#' "sp"] with 1 slots .. .. ..@ projargs: chr " +proj=longlat +datum=WGS84
#' +ellps=WGS84 +towgs84=0,0,0" }
#' @references http://www.iiasa.ac.at/Research/GGI/DB/
#' @source IIASA
#' @keywords datasets
#' @examples
#' 
#' data(gridCountriesNumeric)
#' 
NULL





#' Example half degree grid data : population estimates for 2000 from IIASA
#' 
#' Example half degree grid data : people per cell estimates for 2000 from
#' IIASA (International Institute for Applied System Analysis) (sp,
#' SpatialGridDataFrame).
#' 
#' From International Institute for Applied System Analysis (IIASA) GGI
#' Scenario Database, 2007 Available at:
#' http://www.iiasa.ac.at/Research/GGI/DB/ The data are made available for
#' individual, academic research purposes only and on a "as is" basis, subject
#' to revisions without further notice.  Commercial applications are not
#' permitted.
#' 
#' The data is used as the default dataset in other functions, e.g.
#' mapGriddedData(), when no data file is given.
#' 
#' @name gridExData
#' @docType data
#' @format The format is: \preformatted{ Formal class 'SpatialGridDataFrame'
#' [package "sp"] with 6 slots ..@ data :'data.frame': 259200 obs. of 1
#' variable: .. ..$ pa2000.asc: num [1:259200] NA NA NA NA NA NA NA NA NA NA
#' ...  ..@ grid :Formal class 'GridTopology' [package "sp"] with 3 slots .. ..
#' ..@ cellcentre.offset: num [1:2] -179.8 -89.8 .. .. ..@ cellsize : num [1:2]
#' 0.5 0.5 .. .. ..@ cells.dim : int [1:2] 720 360 ..@ grid.index : int(0) ..@
#' coords : num [1:2, 1:2] -179.8 179.8 -89.8 89.8 .. ..- attr(*,
#' "dimnames")=List of 2 .. .. ..$ : NULL .. .. ..$ : chr [1:2] "coords.x1"
#' "coords.x2" ..@ bbox : num [1:2, 1:2] -180 -90 180 90 .. ..- attr(*,
#' "dimnames")=List of 2 .. .. ..$ : chr [1:2] "coords.x1" "coords.x2" .. ..
#' ..$ : chr [1:2] "min" "max" ..@ proj4string:Formal class 'CRS' [package
#' "sp"] with 1 slots .. .. ..@ projargs: chr " +proj=longlat +datum=WGS84
#' +ellps=WGS84 +towgs84=0,0,0" }
#' @references Grubler, A., O'Neill, B., Riahi, K., Chirkov, V., Goujon, A.,
#' Kolp, P., Prommer, I., Scherbov, S. & Slentoe, E. (2006) Regional, national
#' and spatially explicit scenarios of demographic and economic change based on
#' SRES. Technological Forecasting and Social Change
#' doi:10.1016/j.techfore.2006.05.023
#' @source
#' http://www.iiasa.ac.at/web-apps/ggi/GgiDb/dsd?Action=htmlpage&page=about
#' @keywords datasets
#' @examples
#' 
#' data(gridExData)
#' 
NULL





#' For mapping global data.
#' 
#' Enables mapping of country level and gridded user datasets by facilitating
#' joining to modern world maps and offering visualisation options. Country
#' borders are derived from Natural Earth data v 1.4.0.
#' 
#' \tabular{ll}{ Package: \tab rworldmap\cr Type: \tab Package\cr Version: \tab
#' 1.3-4\cr Date: \tab 2014-11-11\cr License: \tab GPL (>= 2)\cr }
#' 
#' Country Level Data can be joined to a map using
#' \code{\link{joinCountryData2Map}}, then mapped using
#' \code{\link{mapCountryData}}. These functions can cope with a range of
#' country names and country codes.
#' 
#' Country boundaries are derived from version 1.4.0 of Natural Earth data as
#' described in \code{\link{countriesCoarse}}. Higher resolution boundaries are
#' provided in a companion package rworldxtra.
#' 
#' More generic functions allow the user to provide their own polygon map using
#' \code{\link{joinData2Map}} and \code{\link{mapPolys}}.
#' 
#' Bubble, bar and pie charts can be added to maps using
#' \code{\link{mapBubbles}}, \code{\link{mapBars}} and \code{\link{mapPies}}.
#' 
#' Try the new method \code{\link{barplotCountryData}} for producing a ranked
#' bar plot of country data with country names that can provide a useful
#' companion to maps.
#' 
#' Options are provided for categorising data, colouring maps and symbols, and
#' adding legends.
#' 
#' Gridded data can be mapped using \code{\link{mapGriddedData}}, but the
#' raster package is much more comprehensive.
#' 
#' Type vignette('rworldmap') to access a short document showing a few examples
#' of the main rworldmap functions to get you started.
#' 
#' @name rworldmap-package
#' @aliases rworldmap-package rworldmap
#' @docType package
#' @author Andy South
#' 
#' with contributions from Joe Scutt-Phillips, Barry Rowlingson, Roger Bivand
#' and Pru Foster
#' 
#' Maintainer: <southandy@@gmail.com>
#' @references Stable version :
#' http://cran.r-project.org/web/packages/rworldmap \cr Development version :
#' https://r-forge.r-project.org/projects/rworldmap/
#' 
#' Discussion group : http://groups.google.com/group/rworldmap
#' @keywords package
#' @examples
#' 
#' 
#' #mapping country level data, with no file specified it uses internal example data
#' mapCountryData()
#' #specifying region
#' mapCountryData(mapRegion="asia")
#' #mapping gridded data, with no file specified it uses internal example data
#' mapGriddedData()
#' #specifying region 
#' mapGriddedData(mapRegion="africa")  
#' #aggregating gridded data to country level 
#' #with no file specified it uses internal example data
#' mapHalfDegreeGridToCountries()              
#' 
#' 
#' 
NULL



