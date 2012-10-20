`mapDevice`<-
function(device="dev.new"
                   ,rows=1
                   ,columns=1
                   ,plotOrder="rows"
                   ,width=NULL
                   ,height=NULL
                   ,titleSpace=NULL
                   ,mai=c(0,0,0.2,0)
                   ,mgp=c(0,0,0)
                   ,xaxs="i"
                   ,yaxs="i"
                   ,...)
{
  #aspectRatio = width/height. Unless you specify both width and height,
  #mapDevice will choose an aspect ratio for you, depending on the projection.
  #aspectRatio<-switch(projection,EqualArea=1.7,none=2)
  aspectRatio<-2

  #The margin with the title is only margin you would reguarly adjust,
  #so a shortcut is provided
  if(!is.null(titleSpace)){
   mai[3]<-titleSpace
  }
  
  #If at least one of height and width is NULL, they are set to sensible values
  if(is.null(height) && is.null(width)){
   if (device=='png') width=720 #default width in pixels
   else width=9 #this width works well for powerpoint for a single plot & gets reduced for word    
  }
  if(is.null(width)){
   width=(height-mai[1]-mai[3])*aspectRatio+mai[2]+mai[4]
  }
  if(is.null(height)){
   height=(width-mai[2]-mai[4])/aspectRatio+mai[3]+mai[1]
  }

  #Increase the device size for multiple plots.
  width=width*columns
  height=height*rows
  
  #Create a device  and set parameters.
  do.call(device,c(list(width=width,height=height),list(...)))
  par(mai=mai,mgp=mgp,xaxs=xaxs,yaxs=yaxs)
  
  #2/10/09 allow setting of whether, mfrow or mfcol
  if (plotOrder=='rows') 
     {par(mfrow=c(rows,columns))
     } else 
     {par(mfcol=c(rows,columns))
      print('####columns#####')
     }   
}


#To Do:
#A mapRegion argument would be helpful
#change the order of plotting on plots with both rows and columns over 2.

