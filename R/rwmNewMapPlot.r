`rwmNewMapPlot`<-
function(mapToPlot=getMap(),
         oceanCol=NA,
         mapRegion="world",
         xlim=NA,                  
         ylim=NA,
         aspect=1){

  #browser()

  ## setting map extents if a mapRegion has been specified
  if (mapRegion != "world"){
    dFwesn <- setMapExtents(mapRegion)
    xlim <- c(dFwesn$we, dFwesn$ea)
    ylim <- c(dFwesn$so, dFwesn$no)
  }

  #2/10/12 getting xlim & ylim from bbox of the map
  if (length(xlim)<2) xlim <- bbox(mapToPlot)['x',]  
  if (length(ylim)<2) ylim <- bbox(mapToPlot)['y',]
  
  
  plot.new()

  #replicate behaviour of plot.Spatial in the sp package regarding aspect
  #if the map is unprojected the aspect is set based upon the mean y coord
  #only if region not 'world'
  if (aspect == 'variable' & mapRegion != "world")
        aspect <- ifelse(is.na(proj4string(mapToPlot)) || is.projected(mapToPlot),
            1, 1/cos((mean(ylim) * pi)/180))

  plot.window(xlim=xlim,ylim=ylim,asp=aspect)#,xaxs='i',yaxs='i')#,bg=oceanCol,xpd=NA)
  
  #rect(xlim[1],ylim[1],xlim[2],ylim[2],col=oceanCol,border=oceanCol)
  #making the rectangle as big as the whole map should ensure it fills
  rect(mapToPlot@bbox[1],mapToPlot@bbox[2],mapToPlot@bbox[3],mapToPlot@bbox[4],col=oceanCol,border=oceanCol)
}
