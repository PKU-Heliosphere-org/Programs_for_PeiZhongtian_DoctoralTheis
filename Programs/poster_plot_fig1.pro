;pro poster_plot_fig1



sub_dir_date  = 'wind\slow\case1\'
sub_dir_date1  = 'wind\fast\case1\'



step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'N_sigma_deltaB_v.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "poster_get_deltaB_sigma_15day_v.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;  period_vect,min_vect,max_vect,theta_vect, $
;  datanum_bin, second_moment,fourth_moment,sigma_Bt_vect,theta_arr

datanum_bin_s = datanum_bin
second_moment_s = second_moment
fourth_moment_s = fourth_moment
sigma_Bt_vect_s = sigma_Bt_vect
theta_arr_s = theta_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= 'N_sigma_deltaB_v.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "poster_get_deltaB_sigma_15day_v.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;  period_vect,min_vect,max_vect,theta_vect, $
;  datanum_bin, second_moment,fourth_moment,sigma_Bt_vect,theta_arr

datanum_bin_f = datanum_bin
second_moment_f = second_moment
fourth_moment_f = fourth_moment
sigma_Bt_vect_f = sigma_Bt_vect
theta_arr_f = theta_arr

step2:

n_period = n_elements(period_vect)
n_theta = n_elements(theta_vect)

second_moment_theta_s = fltarr(3,n_period)
fourth_moment_theta_s = fltarr(3,n_period)
flatness_theta_s = fltarr(3,n_period)

for i_period = 0,n_period-1 do begin
  second_moment_theta_s(0,i_period) = total(datanum_bin_s(*,i_period)*second_moment_s(*,i_period)*sigma_Bt_vect_s(i_period)^2,/nan)/total(datanum_bin_s(*,i_period),/nan)
  fourth_moment_theta_s(0,i_period) = total(datanum_bin_s(*,i_period)*fourth_moment_s(*,i_period)*sigma_Bt_vect_s(i_period)^4,/nan)/total(datanum_bin_s(*,i_period),/nan)
  flatness_theta_s(0,i_period) = fourth_moment_theta_s(0,i_period)/second_moment_theta_s(0,i_period)^2
  
;  sub_small = where((theta_arr_s(*,i_period) ge 0 and theta_arr_s(*,i_period) le 30) or $
;    (theta_arr_s(*,i_period) ge 150 and theta_arr_s(*,i_period) le 180))
;  sub_big = where(theta_arr_s(*,i_period) ge 60 and theta_arr_s(*,i_period) le 120)  

      second_moment_theta_s(1,i_period) = (total(datanum_bin_s(0:14,i_period)*second_moment_s(0:14,i_period)*sigma_Bt_vect_s(i_period)^2,/nan) $
                +total(datanum_bin_s(75:89,i_period)*second_moment_s(75:89,i_period)*sigma_Bt_vect_s(i_period)^2,/nan))/(total(datanum_bin_s(0:14,i_period),/nan)+total(datanum_bin_s(75:89,i_period),/nan))
      fourth_moment_theta_s(1,i_period) = (total(datanum_bin_s(0:14,i_period)*fourth_moment_s(0:14,i_period)*sigma_Bt_vect_s(i_period)^4,/nan) $
                +total(datanum_bin_s(75:89,i_period)*fourth_moment_s(75:89,i_period)*sigma_Bt_vect_s(i_period)^4,/nan))/(total(datanum_bin_s(0:14,i_period),/nan)+total(datanum_bin_s(75:89,i_period),/nan))
      flatness_theta_s(1,i_period) = fourth_moment_theta_s(1,i_period)/second_moment_theta_s(1,i_period)^2

      second_moment_theta_s(2,i_period) = total(datanum_bin_s(29:59,i_period)*second_moment_s(29:59,i_period)*sigma_Bt_vect_s(i_period)^2,/nan)/total(datanum_bin_s(29:59,i_period),/nan)
      fourth_moment_theta_s(2,i_period) = total(datanum_bin_s(29:59,i_period)*fourth_moment_s(29:59,i_period)*sigma_Bt_vect_s(i_period)^4,/nan)/total(datanum_bin_s(29:59,i_period),/nan)
      flatness_theta_s(2,i_period) = fourth_moment_theta_s(2,i_period)/second_moment_theta_s(2,i_period)^2
endfor


second_moment_theta_f = fltarr(3,n_period)
fourth_moment_theta_f = fltarr(3,n_period)
flatness_theta_f = fltarr(3,n_period)

for i_period = 0,n_period-1 do begin
  second_moment_theta_f(0,i_period) = total(datanum_bin_f(*,i_period)*second_moment_f(*,i_period)*sigma_Bt_vect_f(i_period)^2,/nan)/total(datanum_bin_f(*,i_period),/nan)
  fourth_moment_theta_f(0,i_period) = total(datanum_bin_f(*,i_period)*fourth_moment_f(*,i_period)*sigma_Bt_vect_f(i_period)^4,/nan)/total(datanum_bin_f(*,i_period),/nan)
  flatness_theta_f(0,i_period) = fourth_moment_theta_f(0,i_period)/second_moment_theta_f(0,i_period)^2
  
      second_moment_theta_f(1,i_period) = (total(datanum_bin_f(0:14,i_period)*second_moment_f(0:14,i_period)*sigma_Bt_vect_f(i_period)^2,/nan) $
                +total(datanum_bin_f(75:89,i_period)*second_moment_f(75:89,i_period)*sigma_Bt_vect_f(i_period)^2,/nan))/(total(datanum_bin_f(0:14,i_period),/nan)+total(datanum_bin_f(75:89,i_period),/nan))
      fourth_moment_theta_f(1,i_period) = (total(datanum_bin_f(0:14,i_period)*fourth_moment_f(0:14,i_period)*sigma_Bt_vect_f(i_period)^4,/nan) $
                +total(datanum_bin_f(75:89,i_period)*fourth_moment_f(75:89,i_period)*sigma_Bt_vect_f(i_period)^4,/nan))/(total(datanum_bin_f(0:14,i_period),/nan)+total(datanum_bin_f(75:89,i_period),/nan))
      flatness_theta_f(1,i_period) = fourth_moment_theta_f(1,i_period)/second_moment_theta_f(1,i_period)^2

      second_moment_theta_f(2,i_period) = total(datanum_bin_f(29:59,i_period)*second_moment_f(29:59,i_period)*sigma_Bt_vect_f(i_period)^2,/nan)/total(datanum_bin_f(29:59,i_period),/nan)
      fourth_moment_theta_f(2,i_period) = total(datanum_bin_f(29:59,i_period)*fourth_moment_f(29:59,i_period)*sigma_Bt_vect_f(i_period)^4,/nan)/total(datanum_bin_f(29:59,i_period),/nan)
      flatness_theta_f(2,i_period) = fourth_moment_theta_f(2,i_period)/second_moment_theta_f(2,i_period)^2
endfor

step3:

Set_Plot, 'Win'
Device,DeComposed=0
xsize = 900.0
ysize = 1200.0
Window,1,XSize=xsize,YSize=ysize

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
TVLCT,175L,175L,175L,color_gray
num_CB_color= 256-6
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background



position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs



;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

yrange = [1,100]
plot,alog10(1./period_vect),flatness_theta_f(0,*),color = color_black, thick = 2, charsize = 1.2,xtitle = 'log(f(Hz))',ytitle = 'flatness', $
  position = position_SubImg,yrange = yrange,/ylog,/noerase
oplot,alog10(1./period_vect(0:19)),flatness_theta_f(1,0:19),color = color_blue, thick = 2
oplot,alog10(1./period_vect(0:19)),flatness_theta_f(2,0:19),color = color_red, thick = 2
oplot,[-3,-3],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,-4.5,70,'(e)',color=color_black,charthick = 1.5,charsize = 1.5
;for i_fast = 1,15 do begin
;oplot,1./period_vect,flat_arr_fast(i_fast-1,*),color = color_gray
;endfor
;print,size(flat_arr_fast),size(flat_arr_slow)

;;--
i_x_SubImg  = 1
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

yrange = [1,100]
plot,alog10(1./period_vect),flatness_theta_s(0,*),color = color_black, thick = 2, charsize = 1.2,xtitle = 'log(f(Hz))',ytitle = 'flatness', $
  position = position_SubImg,yrange = yrange,/ylog,/noerase
oplot,alog10(1./period_vect(0:19)),flatness_theta_s(1,0:19),color = color_blue, thick = 2
oplot,alog10(1./period_vect(0:19)),flatness_theta_s(2,0:19),color = color_red, thick = 2
oplot,[-3.5,-3.5],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,-4.5,70,'(f)',color=color_black,charthick = 1.5,charsize = 1.5

;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]
yrange = [-3,2]
plot,alog10(1./period_vect),alog10(second_moment_theta_f(0,*)),color = color_black, thick = 2, charsize = 1.2, xtitle = 'log(f(Hz))',ytitle = 'log(SF2(nT^2))', $
  position = position_SubImg,yrange = yrange,/noerase;,/xlog,/ylog
oplot,alog10(1./period_vect(0:19)),alog10(second_moment_theta_f(1,0:19)),color = color_blue, thick = 2
oplot,alog10(1./period_vect(0:19)),alog10(second_moment_theta_f(2,0:19)),color = color_red, thick = 2
oplot,[-3,-3],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,-4.5,1.6,'(a)',color=color_black,charthick = 1.5,charsize = 1.5
;;--
i_x_SubImg  = 1
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

yrange = [-3,2]
plot,alog10(1./period_vect),alog10(second_moment_theta_s(0,*)),color = color_black, thick = 2, charsize = 1.2, xtitle = 'log(f(Hz))',ytitle = 'log(SF2(nT^2))', $
  position = position_SubImg,yrange = yrange,/noerase
oplot,alog10(1./period_vect(0:19)),alog10(second_moment_theta_s(1,0:19)),color = color_blue, thick = 2
oplot,alog10(1./period_vect(0:19)),alog10(second_moment_theta_s(2,0:19)),color = color_red, thick = 2
oplot,[-3.5,-3.5],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,-4.5,1.6,'(b)',color=color_black,charthick = 1.5,charsize = 1.5
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

yrange = [-4,4]
plot,alog10(1./period_vect),alog10(fourth_moment_theta_f(0,*)),color = color_black, thick = 2, charsize = 1.2, xtitle = 'log(f(Hz))',ytitle = 'log(SF4(nT^4))', $
  position = position_SubImg,yrange = yrange,/noerase
oplot,alog10(1./period_vect(0:19)),alog10(fourth_moment_theta_f(1,0:19)),color = color_blue, thick = 2
oplot,alog10(1./period_vect(0:19)),alog10(fourth_moment_theta_f(2,0:19)),color = color_red, thick = 2
oplot,[-3,-3],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,-4.5,3.3,'(c)',color=color_black,charthick = 1.5,charsize = 1.5
;;--
i_x_SubImg  = 1
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]
yrange = [-4,4]
plot,alog10(1./period_vect),alog10(fourth_moment_theta_s(0,*)),color = color_black, thick = 2, charsize = 1.2, xtitle = 'log(f(Hz))',ytitle = 'log(SF4(nT^4))', $
  position = position_SubImg,yrange = yrange,/noerase
oplot,alog10(1./period_vect(0:19)),alog10(fourth_moment_theta_s(1,0:19)),color = color_blue, thick = 2
oplot,alog10(1./period_vect(0:19)),alog10(fourth_moment_theta_s(2,0:19)),color = color_red, thick = 2
oplot,[-3.5,-3.5],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,-4.5,3.3,'(d)',color=color_black,charthick = 1.5,charsize = 1.5


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure1_poster'+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

step4:

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0
ysize = 600.0
Window,2,XSize=xsize,YSize=ysize
;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background


;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


;Step3_1:
;;--
i_x_SubImg  = 1
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
flatness_theta_arr_s = fourth_moment_s/second_moment_s^2
image_TV  = flatness_theta_arr_s
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 20;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = ''
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
  XTitle=xtitle,YTitle=ytitle,CharSize=1.5,title='(b) slow wind',$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.5,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.05,position_SubImg(1),$
          position_SubImg(2)+0.07,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('flatness')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


;Step3_2:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
flatness_theta_arr_f = fourth_moment_f/second_moment_f^2
image_TV  = flatness_theta_arr_f
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 20;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = ''
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
  XTitle=xtitle,YTitle=ytitle,CharSize=1.5,title='(a) fast wind',$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.5,Thick=1.0,/YLog
;;;---
;position_CB   = [position_SubImg(2)+0.05,position_SubImg(1),$
;          position_SubImg(2)+0.07,position_SubImg(3)]
;num_ticks   = 3
;num_divisions = num_ticks-1
;max_tickn   = max_image
;min_tickn   = min_image
;interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
;tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
;titleCB     = TexToIDL('flatness')
;bottom_color  = 0B
;img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
;TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;;----draw the outline of the color-bar
;Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
;  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
;  /NoData,/NoErase,Color=color_black,$
;  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3



image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure2_flatness_theta'+'_poster.png'
Write_PNG, dir_fig+file_fig, image_tvrd


step5:


;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 600.0
ysize = 900.0
Window,3,XSize=xsize,YSize=ysize
;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background


;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


;Step3_1:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
yrange = [-3,2]
plot,alog10(1./period_vect),alog10(second_moment_theta_f(0,*)),color = color_black, thick = 2, charsize = 1.5, xtitle = 'log(f(Hz))',ytitle = 'log(SF2(nT^2))', $
  position = position_SubImg,yrange = yrange,/noerase;,/xlog,/ylog
oplot,[-3,-3],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
;;--
oplot,alog10(1./period_vect),alog10(second_moment_theta_s(0,*)),color = color_red, thick = 2
oplot,[-3.5,-3.5],yrange,linestyle=1,color=color_red, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,0,1.5,'fast',color=color_black,charsize=2,charthick = 2
xyouts,0,1,'slow',color=color_red,charsize=2,charthick = 2
;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
           

yrange = [1,100]
plot,alog10(1./period_vect),flatness_theta_f(0,*),color = color_black, thick = 2, charsize = 1.5,xtitle = 'log(f(Hz))',ytitle = 'flatness', $
  position = position_SubImg,yrange = yrange,/ylog,/noerase
oplot,[-3,-3],yrange,linestyle=1,color=color_black, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
;for i_fast = 1,15 do begin
;oplot,1./period_vect,flat_arr_fast(i_fast-1,*),color = color_gray
;endfor
;print,size(flat_arr_fast),size(flat_arr_slow)
oplot,alog10(1./period_vect),flatness_theta_s(0,*),color = color_red, thick = 2
oplot,[-3.5,-3.5],yrange,linestyle=1,color=color_red, thick=2
oplot,[-0.4,-0.4],yrange,linestyle=1,color=color_black, thick=2
xyouts,0,50,'fast',color=color_black,charsize=2,charthick = 2
xyouts,0,30,'slow',color=color_red,charsize=2,charthick = 2
           
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure7_difference'+'_poster.png'
Write_PNG, dir_fig+file_fig, image_tvrd

END









