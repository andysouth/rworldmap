`mapBars` <- function( dF = ""
                        ,nameX="longitude", nameY="latitude" 
                        ,nameZs=c(names(dF)[3],names(dF)[4])
                        ,zColours=c(1:length(nameZs))

                        ,barWidth = 1
                        ,barOrient = 'vert' ## orientation of bars 'vert' as default or 'horiz'
                        ,barRelative = TRUE

                        ,ratio = 1
                        #,we=0, ea=0, so=0, no=0
                        ,addCatLegend = TRUE
                        ,addSizeLegend = TRUE
                        
                        ,symbolSize = 1 #multiplier relative to the default
                        ,maxZVal=NA

                       , xlim=NA
                       , ylim=NA   
                       
                         , mapRegion = "world"   #sets map extents, overrides we,ea etc.                                                    
                         , borderCol = "grey"
                         , oceanCol=NA
                         , landCol=NA
                         ,add=FALSE                        

                        ,main=''
                        ,lwd=0.5
                        ,lwdSymbols=1
                        ,... )
   {                        
    functionName <- as.character(sys.call()[[1]])

    #for example data need to put in here before example dF loaded
    if (length(dF)==1 && dF == "")
    {
      nameZs <- c('POP_EST','GDP_MD_EST')
    }
    
    
    #1/7/2013 refactoring
    #this returns either a dF or sPDF
    dF <- rwmCheckAndLoadInput( dF, inputNeeded = "sPDF or dF", callingFunction=functionName ) 
    
    #if sPDF
    #  sPDF <- dF
    #  dF[nameX & nameY] <- coordinates(SPDF)
    #  dF <- dF@data
    
    #else if dF
    #  xlimylim <- max dF[nameX & nameY]
    #  sPDF <- getMap()



    
    # *shared*
    # plot map using sPDF
    # do bars using dF
    
    
    #if rwmCheckAndLoadInput returns a sPDF get the dF bit add columns for centroid coords & set nameX & nameY
    if ( class(dF)=="SpatialPolygonsDataFrame" ) #################################
    {
      #copying map to sPDF to use later
      sPDF <- dF
      
      nameX <- "rwmX"
      nameY <- "rwmY"
      coords <- coordinates(dF)
      #fill columns in dF with centroid coords
      dF[[nameX]] <- coords[,1]
      dF[[nameY]] <- coords[,2]
      #dF bit to be used for bars
      dF <- dF@data
      
    } else if( class(dF)=="data.frame"  ) #######################################
    {   
      #to be used for background map if !add
      sPDF <- getMap()
      
    } else
    {
      stop(functionName," requires a dataFrame or spatialPolygonsDataFrame for the first argument or dF=\n")
      return(FALSE)       
    }
    
    
    #debugging
    #browser()
    

    #background map
    #if user wants finer control they can call rwmNewMapPlot, and then this with add=TRUE 
    if (!add) 
    {
      #option for region to be set from data
      if ( mapRegion == 'data' ) #( (we==0 && so==0) ) # || (we==NA && so==NA)) #caused error with some data not other
      {
        xlim <- c( min(dF[,nameX], na.rm=TRUE),max(dF[,nameX], na.rm=TRUE) )
        ylim <- c( min(dF[,nameY], na.rm=TRUE),max(dF[,nameY], na.rm=TRUE) )
      } else
      {
        xlim <- ylim <- NA #then they are set from bbox of map in rwmNewMapPlot
      }    
      
      lims <- rwmNewMapPlot(sPDF, oceanCol=oceanCol, mapRegion=mapRegion, xlim=xlim, ylim=ylim)
      xlim <- lims$xlim #!!! these lims are used later to set symbol sizes
      ylim <- lims$ylim
      plot( sPDF, add=TRUE, border=borderCol, col=landCol, lwd=lwd )
    }    

    
    #**BEWARE what happens with symbolMaxSize if add=TRUE ???
    
    #Warning message:
    #  In max(xlim[2] - xlim[1], (ylim[2] - ylim[1]) * ratio) :
    #  no non-missing arguments to max; returning -Inf
    
    #browser()
    
    #1/7/13 adding a relative option so that all bars can be scaled 0-1
    #partly to make it easier to produce an example plot
    if (barRelative)
    {
      for( numZ in 1:length(nameZs))
      {
        #TEMPORARY FIX TO REPLACE -99 with NA for pop & gdp
        #if ( length(which(dF[nameZs][numZ]=="-99") ))
        #  dF[nameZs][numZ][ which(dF[nameZs][numZ]=="-99"),1 ] <- NA  
        
        dF[nameZs][numZ] <- dF[nameZs][numZ] / max(dF[nameZs][numZ],na.rm=TRUE)
        
      }
    }
    
    #browser()
    
    maxSumValues <- 0
    #go through each circle to plot to find maximum value for scaling
    for (locationNum in 1:length(dF[,nameZs[1]]))
      {  
       sumValues <- sum( dF[ locationNum, nameZs ], na.rm=TRUE )
       if ( sumValues > maxSumValues ) maxSumValues <- sumValues
      }
      
    
    #browser()    
    
    #should set radius to 5% of max extent (diam will be 10%)  
    #symbolMaxSize <- 0.05*max( ea-we, (no-so)*ratio )
    #but seemed to big ? set to 2% instead  
    #symbolMaxSize <- 0.02*max( ea-we, (no-so)*ratio )
    symbolMaxSize <- 0.02*max( xlim[2]-xlim[1], (ylim[2]-ylim[1])*ratio, na.rm=TRUE )    
        
    #symbol size
    #maxZVal & symbolSize can be set by user
    #if ( is.na(maxZVal) ) maxZVal <- max( dF[,nameZSize], na.rm=TRUE )
    #4 in here is just a good sizing default found by trial & error
    #fMult = symbolSize * 4 / sqrt(maxZVal)
    #cex= fMult*sqrt(dF[,nameZSize])
    
    #so want maxSumValues to equate to maxSize (and remember they scale by square root)
    #symbolScale <- symbolMaxSize / sqrt( maxSumValues )
    #tried removing sqrt for bars
    #1/7/2013 re-enabled this
    symbolScale <- symbolMaxSize / maxSumValues 
    
    cat("symbolMaxSize=",symbolMaxSize," maxSumValues=",maxSumValues," symbolScale=",symbolScale,"\n")
    
    #for each circle to plot (row, got from num rows for first z value)
    for (locationNum in 1:length(dF[,nameZs[1]]))
      {    
       #to get an array of the values for each slice
       sliceValues <- as.numeric( dF[ locationNum, nameZs ] )
       
       #if the total of all values is 0 then skip this circle
       if (sum(sliceValues, na.rm=TRUE)==0) next
       
       #x is a cumulative list of proportions starting at 0 (i.e. 1 greater than num slices)
       cumulatProps <- c(0,cumsum(sliceValues)/sum(sliceValues, na.rm=TRUE))
       #cat("cumulative proportions", cumulatProps,"\n")
    
       #radius <- sqrt(sum(sliceValues, na.rm=TRUE))*symbolScale
       #1/7/2013 removing sqrt
       radius <- sum(sliceValues, na.rm=TRUE)*symbolScale       
       
       radius <- radius*symbolSize
       
       #for each slice
       for ( sliceNum in 1:length(sliceValues) ) {
       
            #rect(xleft, ybottom, xright, ytop, density = NULL, angle = 45,col = NA, border = NULL, lty = par("lty"), lwd = par("lwd")
            
            if ( barOrient == 'horiz' )
               {
                #cat('horiz')
                xleft <- dF[ locationNum, nameX ] + ( radius * cumulatProps[sliceNum] )
                ybottom <- dF[ locationNum, nameY ]  
                xright <- dF[ locationNum, nameX ] + ( radius * cumulatProps[sliceNum+1] ) 
                ytop <- dF[ locationNum, nameY ] + barWidth  
               } else
               {
                #cat('vert')
                xleft <- dF[ locationNum, nameX ] 
                ybottom <- dF[ locationNum, nameY ] + ( radius * cumulatProps[sliceNum] ) 
                xright <- dF[ locationNum, nameX ] + barWidth 
                ytop <- dF[ locationNum, nameY ] + ( radius * cumulatProps[sliceNum+1] )  
               }                         
            
            rect( xleft, ybottom, xright, ytop, col=zColours[sliceNum],lwd=lwdSymbols )
            #number of points on the circumference, minimum of 2
            #difference between next cumulative prop & this
 
            #cat("slice coords", P,"\n")
    
            #plot each slice
            #polygon(c(P$x,dF[ locationNum, nameX ]),c(P$y,dF[ locationNum, nameY ]),col=zColours[sliceNum]) #,col=colours()[tc[i]])
           } #end of each slice in a circle
        } #end of each circle
    
    #legend("bottomleft", select, fill=colours()[tc], cex=0.7, bg="white")
    if (addCatLegend)
        legend("bottomleft", legend=nameZs, fill=zColours, cex=0.7, bg="white")#fill=c(1:length(nameZs))
    
    #do I also want to add option for a legend showing the scaling of the symbols
    #legend(x='bottomright', legend=legendVals, pt.cex = legendSymbolSizes, pch=1, col="black", bg="white")
    #trying just a single symbol for a start
    #legendVals = maxSumValues
    #getting the size of the max symbol in terms of pt.cex, could be very tricky
    #might need to just draw a circle & text on the map, but getting that right will also be tricky
    #legendSymbolSizes = 
    #legend(x='bottomright', legend=legendVals, pt.cex = legendSymbolSizes, pch=1, col="black", bg="white")    
    #P <- list( x= ratio * radius * cos(2*pi*seq(cumulatProps[sliceNum],cumulatProps[sliceNum+1],length=n))+ dF[ locationNum, nameX ],
    #           y=         radius * sin(2*pi*seq(cumulatProps[sliceNum],cumulatProps[sliceNum+1],length=n))+ dF[ locationNum, nameY ] )
    
    #ratio <- 2
    #radius <- 1
    #to create a whole circle equivalent to the max symbol size
    radius <- symbolMaxSize*symbolSize
    
    #par('usr'), returns extents of plot, so can use to put components in specific places relative to it
    #[1] -7.161063 -1.689103 48.424150 50.899516
    
    #plotExtents <- par('usr')
    #plotS <- plotExtents[3]  
    #plotW <- plotExtents[1] 
    #plotN <- plotExtents[4]  
    #plotE <- plotExtents[2] 
    #top left
    #centreE <- plotW + radius*2*ratio
    #centreN <- plotN - radius*2
    ##bottom right
    ##centreE <- plotE - radius*2*ratio
    ##centreN <- plotS + radius*2
    #t <- seq(0,2*pi,length=100)
    #P <- list( x= ratio * radius * cos(t)+ centreE,
    #           y=         radius * sin(t)+ centreN )
    
    #str(P)
    
    # LEGEND FOR THE SIZE OF CIRCLES
    
    #could also try to create a box to include the circle & text
    #if (addSizeLegend)           
    #    polygon(P$x,P$y,border="red");#,col="red")  without the col it wouldn't be filled
                                            #for some reason didn't fill properly anyway ?
    #to put text in centre of circle ...
    #text(centreE,centreN,labels=maxSumValues) 
    # could try to put below circle                                                  
    #text(centreE,centreN-radius*1.5,labels=maxSumValues) 
    #text(centreE,centreN-radius*1.5,labels=signif(maxSumValues,digits=4)) 
    
    } # end of mapBars



#######################
#testing the function
    
#dF <- getMap()@data    
#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('POP_EST','AREA') )
#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA') )
#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA'),mapRegion='africa' )
#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA','AREA','AREA'),mapRegion='africa' )
#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA','AREA','AREA'),mapRegion='africa',symbolSize=2 )
#mapBars( dF,nameX="LON", nameY="LAT",nameZs=c('AREA','AREA','AREA','AREA'),mapRegion='africa',symbolSize=2, barOrient = 'horiz' )

  