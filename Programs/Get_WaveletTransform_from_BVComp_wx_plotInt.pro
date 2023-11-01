Prepare_WIND_BV_Wavelet_FFT,var,var_BG,dir_restore,dir_save,dir_fig,$
  num_scales,file_version,n_hours,n_days,num_times,is_theta_1_or_2,$
  JulDay_vect,B_RTN_3s_arr,$
  time_vect,dtime,period_range,TimeRange_str,$
  sub_dir_date, NUMDENS_VECT

suffix = '_nan_gt1';
file_restore = var+'_PSD_arr'+TimeRange_str+file_version+suffix+'.sav'
restore,dir_save+file_restore
;data_descrip= 'got from "get_WaveletTransform_from_BComp_wx.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  time_vect, period_vect, $
;  PSD_Bx_time_scale_arr, PSD_By_time_scale_arr, PSD_Bz_time_scale_arr, $
;  PSD_Bt_time_scale_arr, PSD_Bpara_time_scale_arr, PSD_Bperp_time_scale_arr
xtitle_char = 'Date'
charsize = 1.2

Step5:
;===========================
;Step5: plot the wavelet 2D figures for magnetic field trace & para & perp
;;--
;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 1300.0
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
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


Step5_1:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
image_TV  = ALog10(PSD_Bt_time_scale_arr)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 1;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 6.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = xtitle_char
ytitle  = 'period (s)'
title = var+' Wavelet Power Spectra Density'
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect), Max(JulDay_vect)]
yrange  = [Min(period_vect), Max(period_vect)]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
if max(JulDay_vect)-min(JulDay_vect) ge 2.5 then begin
xtitle_char = 'Date'
dummy = LABEL_DATE(DATE_FORMAT=['%M-%D'])
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTICKFORMAT='LABEL_DATE', xtickunits = 'Time', $
  XTitle=xtitle,YTitle=ytitle,title=title,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,charsize=charsize,/YLog
endif else begin
xtitle_char = 'Time'+' '+sub_dir_date
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,charsize=charsize,/YLog
endelse
;;;---
position_CB   = [position_SubImg(2)+0.1,position_SubImg(1),$
          position_SubImg(2)+0.12,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = 'lg(PSD of '+var+'t) ((km/s)!U2!N/Hz)'
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.2, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

image_tvrd  = TVRD(true=1)
file_fig  = var+'Trac_time_scale_arr'+TimeRange_str+file_version+suffix+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd
end