;pro paper3_Bpara_Bperp_2_4_flatness


day = 'fast'
sub_dir_date  = 'wind\'+day+'\case2_v\'
day1 = 'slow'
sub_dir_date1  = 'wind\'+day1+'\case2_v\'

n_jie = 10
jie = (findgen(n_jie)+1)/2.0
;n_d = 15
;n_theta = 30;;;;;
;;--
step1:


position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


 Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=800.0 & ysize=800.0
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
    color_gray = 250L
    TVLCT,127L,127L,127L,color_gray
    num_CB_color= 256-6
    R=Congrid(R,num_CB_color)
    G=Congrid(G,num_CB_color)
    B=Congrid(B,num_CB_color)
    TVLCT,R,G,B
    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 

for i_s = 0,1 do begin

  if i_s eq 0  then begin
    i_x_SubImg  = 0
    i_y_SubImg  = 1
    i_y_SubImg1  = 0
    sub_dir_date = sub_dir_date
    day = day
    title = ' '+day+' stream'
  endif

  if i_s eq 1  then begin
    i_x_SubImg  = 1
    i_y_SubImg  = 1
    i_y_SubImg1  = 0    
    sub_dir_date = sub_dir_date1
    day = day1
    title = ' '+day+' stream'
  endif

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'SF_of_'+'quan'+'_second_Bperp_Bpara_period_or.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  period_vect,Btot_2_vect,Bpara_2_vect,Bperp_2_vect,Btot_4_vect,Bpara_4_vect,Bperp_4_vect,theta_bin_min_vect, $
;  StructFunct_Bpara_second_theta_scale_arr,StructFunct_Bperp_second_theta_scale_arr, $
;  num_DataNum_Bpara_second_theta_scale_arr,num_DataNum_Bperp_second_theta_scale_arr

;;--


position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)] 
xrange=[0.1,10000]
yrange=[0.001,100]
plot, period_vect,Bpara_2_vect,/noerase,color = color_black,position=position_subImg, $
  xrange = xrange,yrange=yrange,title=title,xtitle='period(s)',ytitle='SF2',/xlog,/ylog
oplot, period_vect,Bperp_2_vect,color = color_red
x1=[0.2,0.7]
y1=[40,40]
y2=[22,22]
oplot,x1,y1,color=color_black
oplot,x1,y2,color=color_red
xyouts,1,y1,'Bpara',color=color_black
xyouts,1,y2,'Bperp',color=color_red

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg1+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg1+0.9)] 
yrange=[1,100]           
plot, period_vect, Bpara_4_vect/Bpara_2_vect^2,/noerase,color = color_black,position=position_subImg, $
  xrange = xrange,yrange=yrange,title=title,xtitle='period(s)',ytitle='flatness',/xlog,/ylog
oplot, period_vect,Bperp_4_vect/Bperp_2_vect^2,color = color_red
x1=[0.2,0.7]
y1=[4,4]
y2=[2.2,2.2]
oplot,x1,y1,color=color_black
oplot,x1,y2,color=color_red
xyouts,1,y1,'Bpara',color=color_black
xyouts,1,y2,'Bperp',color=color_red

endfor


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Bpara_Bperp_Flatness_quan.png'
Write_PNG, dir_fig+file_fig, image_tvrd

step2:


day = 'fast'
sub_dir_date  = 'wind\'+day+'\case2_v\'
day1 = 'slow'
sub_dir_date1  = 'wind\'+day1+'\case2_v\'

n_jie = 10
jie = (findgen(n_jie)+1)/2.0
;n_d = 15
;n_theta = 30;;;;;



position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


 Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=800.0 & ysize=800.0
    Window,2,XSize=xsize,YSize=ysize,Retain=2
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
    color_gray = 250L
    TVLCT,127L,127L,127L,color_gray
    num_CB_color= 256-6
    R=Congrid(R,num_CB_color)
    G=Congrid(G,num_CB_color)
    B=Congrid(B,num_CB_color)
    TVLCT,R,G,B
    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 

for i_s = 0,1 do begin

  if i_s eq 0  then begin
    i_x_SubImg  = 0
    i_y_SubImg  = 1
    i_y_SubImg1  = 0
    sub_dir_date = sub_dir_date
    day = day
    dstr = ' '+day+' stream'
  endif

  if i_s eq 1  then begin
    i_x_SubImg  = 1
    i_y_SubImg  = 1
    i_y_SubImg1  = 0    
    sub_dir_date = sub_dir_date1
    day = day1
    dstr = ' '+day+' stream'
  endif 

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'SF_of_'+'quan'+'_second_Bperp_Bpara_period_or.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  period_vect,Btot_SF_vect,Bpara_SF_vect,Bperp_SF_vect,theta_bin_min_vect, $
;  StructFunct_Bpara_second_theta_scale_arr,StructFunct_Bperp_second_theta_scale_arr, $
;  num_DataNum_Bpara_second_theta_scale_arr,num_DataNum_Bperp_second_theta_scale_arr
;;--

;--

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]
;;;---
SF_Bpara = StructFunct_Bpara_second_theta_scale_arr
image_0 = alog10(StructFunct_Bpara_second_theta_scale_arr)
SF_Bpara(45:89,*) = !values.f_nan
image_TV  = alog10(SF_Bpara)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = 'Bpara'+dstr
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
theta_vect = theta_bin_min_vect
xrange  = [Min(theta_vect), Max(theta_vect)]
yrange  = [Min(period_vect), Max(period_vect)]
xrange_time = xrange
;get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
 ; XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title,CharSize=1.2,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.06,position_SubImg(1),$
          position_SubImg(2)+0.07,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Bpara^2')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
  

;;;---

xaxis_vect_cont = theta_vect;xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
yaxis_vect_cont = period_vect;yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
levels  = [-3,-2.5,-2,-1.5,-1,0,0.5,1,2]
C_annotation = ['-3','-2.5','-2','-1.5','-1','0','0.5','1','2']
C_colors= [color_black,color_black,color_black,color_black,color_black,color_black,color_black,color_black,color_black]
C_LineStyle = [0,0,0,0,0,0,0,0,0]
C_labels = [0,0,0,0,0,0,0,0,0]
C_Thick   = [2,2,2,2,2,2,2,2,2]
;Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
;    /NoErase, /Fill, /Closed
Contour, image_0, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, C_annotation = C_annotation, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,C_labels=C_labels,C_charthick = 1.2, $
    /NoErase , ylog=1
;;;;

  

;;;;;;;;;;;;;;;;;;;;;;;;
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg1+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg1+0.85)]
;;;---
SF_Bperp = StructFunct_Bperp_second_theta_scale_arr
image_0 = alog10(StructFunct_Bperp_second_theta_scale_arr)
SF_Bperp(45:89,*) = !values.f_nan
image_TV  = alog10(SF_Bperp)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = 'Bperp'+dstr
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect), Max(theta_vect)]
yrange  = [Min(period_vect), Max(period_vect)]
xrange_time = xrange
;get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
 ; XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title,CharSize=1.2,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.06,position_SubImg(1),$
          position_SubImg(2)+0.07,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Bperp^2')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;;---

xaxis_vect_cont = theta_vect;xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
yaxis_vect_cont = period_vect;yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
levels  = [-3,-2.5,-2,-1.5,-1,0,0.5,1,1.5,2]
C_annotation = ['-3','-2.5','-2','-1.5','-1','0','0.5','1','1.5','2']
C_colors= [color_black,color_black,color_black,color_black,color_black,color_black,color_black,color_black,color_black,color_black]
C_LineStyle = [0,0,0,0,0,0,0,0,0,0]
C_labels = [0,0,0,0,0,0,0,0,0,0]
C_Thick   = [2,2,2,2,2,2,2,2,2,2]
;Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
;    /NoErase, /Fill, /Closed
Contour, image_0, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, C_annotation = C_annotation, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,C_labels=C_labels,C_charthick = 1.2, $
    /NoErase , ylog=1
;;;;

endfor

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Bpara_Bperp_SF2_theta_quan.png'
Write_PNG, dir_fig+file_fig, image_tvrd


END_PROGRAM:
END