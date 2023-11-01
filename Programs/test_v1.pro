;pro test_v1

 
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 500.0
ysize = 500.0
Window,1,XSize=xsize,YSize=ysize

LoadCT,13
TVLCT,R,G,B,/Get
color_num = fltarr(14)
color_num(0) = 255L
TVLCT,255L,0L,0L,color_num(0)
color_num(1) = 254L
TVLCT,0L,255L,0L,color_num(1)
color_num(2) = 253L
TVLCT,0L,0L,255L,color_num(2)
color_num(3) = 250L
TVLCT,255L,0L,255L,color_num(3)
color_num(4) = 249L
TVLCT,0L,255L,255L,color_num(4)
color_num(5) = 248L
TVLCT,255L,255L,0L,color_num(5)
color_num(6) = 247L
TVLCT,128L,128L,128L,color_num(6)
color_num(7) = 246L
TVLCT,200L,50L,0L,color_num(7)
color_num(8) = 245L
TVLCT,0L,128L,0L,color_num(8)
color_num(9) = 244L
TVLCT,0L,0L,128L,color_num(9)
color_num(10) = 243L
TVLCT,128L,128L,0L,color_num(10)
color_num(11) = 242L
TVLCT,128L,0L,128L,color_num(11)
color_num(12) = 241L
TVLCT,0L,128L,128L,color_num(12)
color_num(13) = 240L
TVLCT,250L,0L,64L,color_num(13)
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-16
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg1 = (position_img(3)-position_img(1))*0.65
dy_pos_SubImg2 = (position_img(3)-position_img(1))*0.35
  
x=[1,2,3]
y=[12,34,67]
plot,x,y,color=color_num(0),xrange=[0,15]
for i = 1,13 do begin
  oplot,x+i,y+i,color=color_num(i)
endfor


end

