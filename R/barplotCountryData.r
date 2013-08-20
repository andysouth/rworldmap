#barplotCountryData1
#andy south 16/11/09

#to develop a function to plot country data as a series of barplots in columns or rows
#one bar per country and to be able to read country names
#ranking countries
#to fit all countries on a single page
#to be able to assess whether catMethod and numCats are sensible for the data

#initial needs :
#same inputs as rworldmap functions
#ability apply same categorisation & colouration
#option for scale to be the same between columns

#later
#vertical
#offer portrait & landscape options with pre-defined settings
#option whether to add rank
#option for different ordering, e.g. by continent



barplotCountryData <- function( dF=""
                         , nameColumnToPlot = ""
                         , nameCountryColumn = "NAME"                          
                         , numPanels = 4  #the number of layout panels in the plot
                         , scaleSameInPanels = FALSE
                         , main=nameColumnToPlot
                         , numCats = 5  
                         #, catMethod="categorical" #categorical gives continuous colours ? may be useful
                         , catMethod="quantiles" #categorical gives continuous colours ? may be useful                            
                         , colourPalette= "heat"
                         , addLegend=TRUE
                         , toPDF = FALSE
                         , outFile = ""
                         , decreasing = TRUE
                         , na.last = TRUE    
                         , cex = 0.7        
                         , ... #allow extra params to barplot
                        )
{


if (outFile == "") outFile <- "barplotCountryDataOut"

#toPDF <- F
if (toPDF) pdf(paste(outFile,".pdf",sep=''),paper='a4r',width=11,height=8)

#for testing & example
if (length(dF)==1 && dF=="") dF <- getMap()@data

if (nameColumnToPlot=="") nameColumnToPlot <- 'POP_EST'
#if (nameColumnToPlot=="") nameColumnToPlot <- 'AREA'

############################
#rank data by column to plot
#! problem that this puts NAs at the top
#dF <- dF[ rev(order(dF[[nameColumnToPlot]])), ]
dF <- dF[ order(dF[[nameColumnToPlot]],decreasing=decreasing,na.last=na.last), ]

#! classification and colouring bit
#! copied from mapCountryData
#! only changes that mapToPlot@data replaced with dF
#! i think this is same common bit used in mapBubbles, so I should put into its own function

#! I should also add something to deal with NAs

dataCategorised <- dF[[nameColumnToPlot]]

#checking whether method is categorical, length(catMethod)==1 needed to avoid warning if a vector of breaks is passed
if( length(catMethod)==1 && catMethod=="categorical" ) #if categorical, just copy the data, add an as.factor() to convert any data that aren't yet as a factor
  {
    dataCategorised <- as.factor( dataCategorised )
    cutVector <- levels(dataCategorised) #doesn't do cutting but is passed for use in legend
  }else
  {
    if(is.character(catMethod)==TRUE)
  	{
  		cutVector <- rwmGetClassBreaks( dataCategorised, catMethod=catMethod, numCats=numCats, verbose=TRUE )
  	} else if(is.numeric(catMethod)==TRUE)
  	#if catMethod is numeric it is already a vector of breaks
  	{
  		cutVector <- catMethod
  	}
	#Categorising the data, using a vector of breaks.
	dataCategorised <- cut( dataCategorised, cutVector, include.lowest=TRUE)
  } #end of if data are not categorical


## add extra column to map attribute data
colNameRaw <- nameColumnToPlot
colNameCat <- paste(colNameRaw,"categorised",sep='')
dF[[colNameCat]] <- dataCategorised

## how many colours : numCats may be overriden (e.g. for 'pretty')
numColours <- length(levels(dataCategorised))

## get vector of the colours to be used in map (length=num categories)
colourVector <- rwmGetColours(colourPalette,numColours)

## get numeric index of which category each datapoint is in (length = num points)
dataCatNums <- as.numeric(dataCategorised)
  
#!end of bit copied from mapCountryData

#external figure properties
op <- par(fin=c(7,10),mai=c(0.05,0.3,0.05,0),xaxs="i",yaxs="i", oma=c(0,1,5,2)) #c(bottom, left, top, right)
#internal figure subdivisions
interval <- ceiling(nrow(dF)/numPanels)
seq(from=1,to=1+4*interval,by=interval)
#create x columns
#nF <- layout(rbind(c(1:numPanels)),heights=rep(1,numPanels),respect=F)
#adding a space at bottom for legend
nF <- layout(rbind(c(1:numPanels),numPanels+1),heights=c(1,0.1),respect=F)
#heights=c(1,0.1) looks nicer in my R but generates error on R CMD CHECK
#seems like it may be poor interaction between layout & par 
#nF <- layout(rbind(c(1:numPanels),numPanels+1),heights=c(1,0.15),respect=F)

#layout.show(nF)
for( i in 1:numPanels )
   {
    #define which data to go in this panel
    limits <- (i*interval):(1+(i-1)*interval)

    #if scale the same between panels set max X to max of whole data, otherwise just to this panel 
    if ( scaleSameInPanels ) xlim <- c(0,max(pretty(dF[[nameColumnToPlot]])))
    else                     xlim <- c(0,max(pretty(dF[[nameColumnToPlot]][limits])))

    ### to create the barplot ###
    axisPoints <- barplot(dF[[nameColumnToPlot]][limits],names.arg=limits,horiz=TRUE,axisnames=TRUE,cex.names=0.7,las=1,space=0,xlim=xlim,axes=FALSE,col=colourVector[dataCatNums][limits] )#,xaxp=c(0,max(pretty(dF[[nameColumnToPlot]][limits])),1)) #xaxp=c(from,to,numIntervals)

    #to put axis label just at maximum (a 0 value would overlap)
    #axis(side=1,at=max(pretty(dF[[nameColumnToPlot]][limits]))) #bottom
    axis(side=3,at=xlim[2]) #top
    
    #could try to add tick marks in the higher plots at each of the lower maximums
    
    #adds country name labels
    text( x=0,y=axisPoints[,1], labels=dF[[nameCountryColumn]][limits], cex=cex, pos=4) #pos=4 puts label to right
    
    #previous attempt to add ranks using text didn't work, now done in barplot instead
    #text( x=axisPoints, labels=limits, cex=0.7, pos=4, offset=-5 ) #pos=2 puts label to left
   }

#add a title
mtext(main,outer=T, line=3)

#I could potentially add the colour bar legend underneath - (although it's not that necessary)
#if (addLegend) addMapLegend(cutVector=cutVector,colourVector=colourVector,legendMar=20,legendWidth=10,legendLabels='all') #to make legend thicker & further up, because its a narrow panel on it's own
#10/4/12 trying to fix glitch on testing
#because par & layout are not compatible
#later try to put this back in
if (addLegend) 
   {
#    plot.new()#to move to lower panel
#    addMapLegend(cutVector=cutVector,colourVector=colourVector,legendMar=20,legendWidth=5,legendLabels='all') #to make legend thicker & further up, because its a narrow panel on it's own
   }

if (toPDF) dev.off()

#resetting old layout
par(op)


} # end of barplotCountryData

#testing
#barplotCountryData()
#barplotCountryData(toPDF=TRUE,outFile="C:\\rWorldMapNotes\\functionsInDevelopment\\barplotCountryData\\barplot1")
