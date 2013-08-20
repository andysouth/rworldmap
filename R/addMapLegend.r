`addMapLegend`<-
function(            
                     colourVector=""
                    ,cutVector=""
                    
                    ,legendLabels="limits"              #style of bar labels 'all','none','limits'
                    ,labelFontSize=1                    #cex.axis by another name
                    ,legendWidth=1.2                    #Width in characters of the legend
                    ,legendShrink=0.9                   #Shrinks the legend, lengthwise
                    ,legendMar=3                       #shifts the legend upwards when horiz, measured in characters.
                    ,horizontal=TRUE                    #orientation
                    ,legendArgs=NULL                   #allows a title above legend
                    ,tcl=-.5                            #as per par(tcl=) tick length par default = -.5
                    ,mgp=c(3,1,0)                       #as per par(mgp=) margin position par default= c(3,1,0)
                    ,sigFigs=4                    #controls how numbers get rounded
                    ,digits=3                           #controls how numbers get formatted into neater numbers.
                    ,legendIntervals='page'       #page" or "data"."page"=intervals equal on page, "data"= equal in data units
                    
                    ,plottedData=""               #not used yet but maybe in future
                    ,catMethod="pretty"           #not used yet but maybe in future
                    ,colourPalette="heat"         #not used yet but maybe in future
                    #,missingCountryCol="white"    #not used yet but maybe in future                    
                                        
                    ){
#require(fields)

#BEWARE image.plot from fields package at end modifies the par settings
#seemingly not possible to stop this, e.g. can't query whether mfrow or mfcol
#oldPar <- par(no.readonly = TRUE)

#i could allow a version of this for categorical data
#where it just creates equal page breaks & puts the cat names in the middle

#this checks that length of colour vector is one less than length of cutVector
#if it isn't could be because a missingCountryCol has been added by mapCountryData
#for now remove the last colour, later may want to try to deal with missingCountryCol
if ( length(colourVector)  == length(cutVector) ) colourVector <- colourVector[-length(colourVector)]


#Simplify the plotBreaks. By rounding the numbers, it becomes easier to read.
colourBarBreaks = as.numeric(cutVector)
tidyPlotBreaks <- signif(colourBarBreaks,sigFigs) #

#The image.plot zlim argument only requires the min and max
zlim <- range(colourBarBreaks,na.rm=TRUE)

#27/10/09 andy, adding in equal scale intervals options
if ( legendIntervals == 'page' )
   {
    colourBarBreaks <- colourBarBreaks[1] + (colourBarBreaks[length(colourBarBreaks)]-colourBarBreaks[1])* seq(from=0,to=1,length.out=length(colourBarBreaks))
   }

#axis.args at = positioning, labels = text displayed.
if(legendLabels=="limits"){
  limitsIndex=c(1,length(colourBarBreaks))
  axis.args=list(at=colourBarBreaks[limitsIndex],cex.axis=labelFontSize,mgp=mgp,tcl=tcl,labels=prettyNum(tidyPlotBreaks[limitsIndex],digits=digits,format="G"))

} else if(legendLabels=="none"){
  #to get no labels need to change ac to whether horizontal
  if ( horizontal ) axis.args=list(xaxt="n")
  else axis.args=list(yaxt="n")
  
} else if(legendLabels=="all"){
  axis.args=list(at=colourBarBreaks,cex.axis=labelFontSize,mgp=mgp,tcl=tcl,labels=prettyNum(tidyPlotBreaks,digits=digits,format="G"))
}

#The actual legend plotting command
#**BEWARE this can cause mfcol to be set back to mfrow and seems to be no way to fix
image.plot(zlim=zlim,legend.only=TRUE,horizontal=horizontal,legend.args=legendArgs,legend.mar=legendMar,col=colourVector,breaks=colourBarBreaks,axis.args=axis.args,legend.width=legendWidth,legend.shrink=legendShrink)

#image.plot(zlim=zlim,legend.only=TRUE,graphics.reset=TRUE,horizontal=horizontal,legend.args=legendArgs,legend.mar=legendMar,col=coloursUsed,breaks=colourBarBreaks,axis.args=axis.args,legend.width=legendWidth,legend.shrink=legendShrink)

#par(oldPar)
#print('test')

}


