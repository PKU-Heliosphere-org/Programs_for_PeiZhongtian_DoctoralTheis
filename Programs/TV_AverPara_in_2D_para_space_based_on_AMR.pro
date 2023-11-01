Pro TV_AverPara_in_2D_para_space_based_on_AMR, x_vect, y_vect, para_vect, $
    num_x_pix_l1=num_x_pix_l1, num_y_pix_l1=num_y_pix_l1, $
    position_panel=position_panel, num_CB_color=num_CB_color, $
    xtitle=xtitle, ytitle=ytitle, title=title, $
    remark_vect=remark_vect
    
  Common dataList, x, y, data
  Common paraPlot, data_min,data_max, color_min,color_max, $
                    x_min,x_max,y_min,y_max, position_img

;;--
x = x_vect
y = y_vect
data  = para_vect
    

;;--
image_TV  = x_vect
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 1.e10
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.005*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.995*(N_Elements(image_TV)))-num_BadVal)
x_min = min_image
x_max = max_image
;a x_min = 0.0
;a x_max = 6.0

;;--
image_TV  = y_vect
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 1.e10
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.005*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.995*(N_Elements(image_TV)))-num_BadVal)
y_min = min_image
y_max = max_image
;a y_min = -1.0
;a y_max = +1.0

;;--
dx_pix_l1 = (x_max-x_min)/num_x_pix_l1
x_bin_cent_vect = x_min+(Findgen(num_x_pix_l1)+0.5)*dx_pix_l1
dy_pix_l1 = (y_max-y_min)/num_y_pix_l1
y_bin_cent_vect = y_min+(Findgen(num_y_pix_l1)+0.5)*dy_pix_l1



;;--
image_TV  = para_vect
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.1*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.9*(N_Elements(image_TV)))-num_BadVal)
;;;---
data_min  = min_image
data_max  = max_image


;;--
Set_Plot,'x'
Device,DeComposed=0;, /Retain
xsize=900.0 & ysize=900.0
Window,1,XSize=xsize,YSize=ysize,Retain=2

;;--
LoadCT,13
TVLCT,R,G,B,/Get
color_red = 255L
TVLCT,255L,0L,0L,color_red
color_green = 254L
TVLCT,0L,255L,0L,color_green
color_blue  = 253L
TVLCT,0L,0L,255L,color_blue
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

;;--
position_img  = [0.05,0.10,0.95,0.95]
position_panel= position_img

;;--
num_subimgs_x = 1
num_subimgs_y = 1
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
i_subimg_x  = 0
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_SubImg = win_position
position_img    = position_SubImg

;;--
xrange  = [x_min, x_max]
yrange  = [y_min, y_max]
;a xtitle  = 'x'
;a ytitel  = 'y'
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
    Color=color_black, $
    XTitle=xtitle, YTitle=ytitle, Title=title, Position=position_img, NoData=1, $
    Thick=2.0, XThick=2.0, YThick=2.0,CharThick=1.5, CharSize=1.5
    

color_min = 0L
color_max = num_CB_color-1L

;;--
For i_x=0,num_x_pix_l1-1 Do Begin
For i_y=0,num_y_pix_l1-1 Do Begin
  x_min_tmp = x_bin_cent_vect(i_x)-0.5*dx_pix_l1
  x_max_tmp = x_min_tmp + dx_pix_l1
  y_min_tmp = y_bin_cent_vect(i_y)-0.5*dy_pix_l1
  y_max_tmp = y_min_tmp + dy_pix_l1
  sub_tmp = Where(x_vect ge x_min_tmp and x_vect lt x_max_tmp and y_vect ge y_min_tmp and y_vect lt y_max_tmp)
  If (sub_tmp(0) eq -1) Then Goto, next_pix_l1
  xLeft   = x_min_tmp
  xRight  = x_max_tmp
  yBottom = y_min_tmp
  yTop    = y_max_tmp
  plot_squares, xLeft, xRight, yBottom, yTop  ;recursive subroutine
;  Recusive_TV_AverPara_in_2D_AMR_space x_vect_pix_MotherLevel, y_vect_pix_MotherLevel, para_vect_pix_MotherLevel, $
;        x_min_MotherLevel, x_max_MotherLevel, y_min_MotherLevel, y_max_MotherLevel, $
;        position_panel=position_panel, x_min_pos=x_min,x_max_pos=x_max, y_min_pos=y_min,y_max_pos=y_max, $
;        min_image=min_image, max_image=max_image, num_CB_color=num_CB_color
  

next_pix_l1:  
EndFor
EndFor

;;;---
position_CB   = [position_img(0),position_img(3)+0.05,$
                  position_img(2),position_img(3)+0.07]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = data_max
min_tickn   = data_min
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = ' '
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)##(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
Plot,[min_image,max_image],[1,2],Position=position_CB,XStyle=1,YStyle=1,$
  YTicks=1,YTickName=[' ',' '],XTicks=2,XTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3  

;;--
AnnotStr_arr  = [remark_vect(0)+', '+remark_vect(1)+', '+remark_vect(2)+', ', remark_vect(3), remark_vect(4)]
num_strings   = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

End