;pro get_Vx_para_perp_PSD


sub_dir_date  = 'wind\fast\19950130-0203\'


Step1:
;===========================
;Step1:

;;;--
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= 'LocalBG_of_MagField_vv(time=*-*).sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
;;Save, FileName=dir_save+file_save, $
;; data_descrip, $
;; JulDay_min_v2, time_vect, period_vect, $
;; P_VEL_LBG_arr
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_19950130-0203_inB.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect
Vx_vect = reform(P_VEL_3s_arr(0,*))
;;;---

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'LocalBG_of_MagField(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect, period_vect, $
; Bxyz_LBG_RTN_arr
time_vect_wavlet = time_vect
period_vect_wavlet = period_vect
num_times = n_elements(time_vect)
num_periods = n_elements(period_vect)
;;---
period_min  = 12.0;1.0;1.e0  ;unit: s
period_max  = 1200.0;1.e3
period_range= [period_min, period_max]
Diff_Vx_arr  = Fltarr(num_times, num_periods)


;;;---
J_wavlet  = num_periods
  dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
  period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)


;;;---
dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = round((period_vect/dt_pix)/2)*2
period_vect_exact = PixLag_vect*dt_pix

;;;---
If (period_min le dt_pix*2) Then Begin
  Stop, 'period_min < 2*dt_pix'
EndIf
num_times = N_Elements(time_vect)
If (period_max ge num_times*dt_pix) Then Begin
  Stop, 'period_max > num_times*dt_pix'
EndIf

;;--
For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
  Vx_vect_backward = Shift(Vx_vect, +pix_shift)
  Vx_vect_forward  = Shift(Vx_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    Vx_vect_backward(0:pix_shift-1)  = !values.f_nan
    Vx_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf
  Diff_Vx_vect = (Vx_vect_backward-Vx_vect_forward)
  Diff_Vx_arr(*,i_period)  = Diff_Vx_vect
EndFor


step2:


Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi

;Px_VEL_LBG_arr  = Reform(P_VEL_LBG_arr(0,*,*))
Px_para_arr = Diff_Vx_arr*cos(theta_arr)
Px_perp_arr = Diff_Vx_arr*sin(theta_arr)

PSD_Px_para = Px_para_arr^2
PSD_Px_perp = Px_perp_arr^2


step3:



;;--

PSD_BComp_time_scale_arr = PSD_Px_para

time_min_TV = time_vect_wavlet(0)
time_max_TV = time_min_TV+(24.*60.*60)*5
sub_time_min_TV = Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV = sub_time_min_TV(0)
sub_time_max_TV = Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV = sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV  = time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
          (time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
          JulDay_min_v2
;;;---
period_vect_TV  = period_vect_wavlet
;theta_arr_TV  = theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_BComp_time_scale_arr_TV = PSD_BComp_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
;theta_vect_TV = theta_bin_min_vect
;PSD_BComp_theta_scale_arr_TV= PSD_BComp_theta_scale_arr(*,*)

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

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs





;Step4_2:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = ALog10(PSD_BComp_time_scale_arr_TV)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
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
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'Vtotal'+')')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.08,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Vxpara')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'PSD_of_'+'Vxpara'+'_time_scale_arr'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg



step4:

;;--

PSD_BComp_time_scale_arr = PSD_Px_perp

time_min_TV = time_vect_wavlet(0)
time_max_TV = time_min_TV+(24.*60.*60)*5
sub_time_min_TV = Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV = sub_time_min_TV(0)
sub_time_max_TV = Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV = sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV  = time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
          (time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
          JulDay_min_v2
;;;---
period_vect_TV  = period_vect_wavlet
;theta_arr_TV  = theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_BComp_time_scale_arr_TV = PSD_BComp_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
;theta_vect_TV = theta_bin_min_vect
;PSD_BComp_theta_scale_arr_TV= PSD_BComp_theta_scale_arr(*,*)

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

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs





;Step4_2:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = ALog10(PSD_BComp_time_scale_arr_TV)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
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
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'Vtotal'+')')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.08,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Vxperp')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'PSD_of_'+'Vxperp'+'_time_scale_arr'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg

step5:

;;--

PSD_BComp_time_scale_arr = PSD_Px_para/PSD_Px_perp

time_min_TV = time_vect_wavlet(0)
time_max_TV = time_min_TV+(24.*60.*60)*5
sub_time_min_TV = Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV = sub_time_min_TV(0)
sub_time_max_TV = Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV = sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV  = time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
          (time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
          JulDay_min_v2
;;;---
period_vect_TV  = period_vect_wavlet
;theta_arr_TV  = theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_BComp_time_scale_arr_TV = PSD_BComp_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
;theta_vect_TV = theta_bin_min_vect
;PSD_BComp_theta_scale_arr_TV= PSD_BComp_theta_scale_arr(*,*)

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

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs





;Step4_2:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = ALog10(PSD_BComp_time_scale_arr_TV)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
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
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'Vtotal'+')')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.08,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Vxpara/Vxperp')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'PSD_of_'+'Vxpara_Vxperp'+'_time_scale_arr'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


end

