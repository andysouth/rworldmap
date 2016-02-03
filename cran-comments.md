## Test environments
* local x86_64-w64-mingw32, R Under development (unstable) (2016-01-30 r70052)
* travis-ci x86_64-pc-linux-gnu, R version 3.2.3 (2015-12-10)

3/2/16 Fixed invalid url : http://groups.google.com/group/ to https://groups.google.com/forum/#!forum/rworldmap

## R CMD check results
Local : no ERRORs or WARNINGs. 

Travis : 1 Warning, 1 Note
Warning : 
checking sizes of PDF files under ‘inst/doc’ ... WARNING
  ‘gs+qpdf’ made some significant size reductions:
     compacted ‘rworldmapFAQ.pdf’ from 1059Kb to 395Kb
     compacted ‘rworldmap.pdf’ from 1294Kb to 457Kb
  consider running tools::compactPDF(gs_quality = "ebook") on these files

The local version built using this to solve the pdf size issue :
devtools::build(args = c('--resave-data','--compact-vignettes="gs+qpdf"'))

Note :
checking CRAN incoming feasibility
Maintainer: ‘Andy South <southandy@gmail.com>’
Checking URLs requires 'libcurl' support in the R build

## Downstream dependencies
I ran devtools::revdep_check() to check reverse dependencies.
All packages that I could install passed.
Checking graticule
Checking mapr
Checking paleofire
Checking rworldxtra
Checking SensusR
Checking spoccutils
Checking virtualspecies
Checking wux
The following failed to install :
bayesPop
bayesTFR
birdring