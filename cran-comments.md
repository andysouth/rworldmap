## Test environments
* local x86_64-w64-mingw32, R Under development (unstable) (2016-01-30 r70052)
* ubuntu (on travis-ci)


## R CMD check results
There were no ERRORs or WARNINGs. 

There were 2 NOTEs on travis :
* checking package dependencies ... NOTE
  No repository set, so cyclic dependency check skipped
  

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