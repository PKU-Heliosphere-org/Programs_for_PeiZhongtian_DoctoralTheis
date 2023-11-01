;pro calculate_Statistical_features


sub_dir_date  = 'new\19950720-29\'


Step1:
;===========================
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect, period_vect, $
; Bxyz_LBG_RTN_arr
;;;---
time_vect_LBG = time_vect
period_vect_LBG = period_vect

Bt_LBG_RTN_arr  = Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr  


step2:

num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

period_min  = 7.0
period_max  = 1.e3
period_range= [period_min, period_max]
num_periods = 32L
J_wavlet  = num_periods
dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)

Diff_BComp_arr = fltarr(3,num_times,num_periods)

for i = 0,2 do begin
  if i eq 0 then begin
    Bcomp_vect = Bxyz_GSE_2s_arr(0,*)
  ;  Sstr = 'Vx'
  endif
  if i eq 1 then begin
    Bcomp_vect = Bxyz_GSE_2s_arr(1,*)
  ;  Sstr = 'Vy'
  endif    
  if i eq 2 then begin
    Bcomp_vect = Bxyz_GSE_2s_arr(2,*)
  ;  Sstr = 'Vz'
  endif

dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = (Round(period_vect/dt_pix)/2)*2
period_vect_exact = PixLag_vect*dt_pix
For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf
  Diff_BComp_vect = (BComp_vect_backward-BComp_vect_forward)
  Diff_BComp_arr(i,*,i_period)  = Diff_BComp_vect
EndFor

endfor

;;--
num_times = N_Elements(time_vect_LBG)
num_periods = N_Elements(period_vect_LBG)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


;;--define 'theta_bin_min/max_vect'
num_theta_bins  = 90L
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin



Bx_vari = fltarr(num_theta_bins,num_periods)
Bx_av3 = fltarr(num_theta_bins,num_periods)
Bx_av4 = fltarr(num_theta_bins,num_periods)
Bx_sig = fltarr(num_theta_bins,num_periods)
Bx_piandu = fltarr(num_theta_bins,num_periods)
Bx_peak = fltarr(num_theta_bins,num_periods)
;;--get 'StructFunct_Bpara_theta_scale_arr'
;StructFunct_Bpara_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  dbx_tmp = diff_Bcomp_arr(0,sub_tmp,i_period)
  dBx_ave = mean(dbx_tmp,/nan)
  Bx_vari(i_theta,i_period) = variance(dbx_tmp,/nan)
  Bx_av3(i_theta,i_period) = mean((dbx_tmp-dBx_ave)^3.0,/nan)
  Bx_av4(i_theta,i_period) = mean((dbx_tmp-dBx_ave)^4.0,/nan)
  Bx_sig(i_theta,i_period) = stddev(dbx_tmp,/nan)
  Bx_piandu(i_theta,i_period) = Bx_av3(i_theta,i_period)/Bx_sig(i_theta,i_period)^3.0
  Bx_peak(i_theta,i_period) = Bx_av4(i_theta,i_period)/Bx_sig(i_theta,i_period)^4.0
EndFor
EndFor


By_vari = fltarr(num_theta_bins,num_periods)
By_av3 = fltarr(num_theta_bins,num_periods)
By_av4 = fltarr(num_theta_bins,num_periods)
By_sig = fltarr(num_theta_bins,num_periods)
By_piandu = fltarr(num_theta_bins,num_periods)
By_peak = fltarr(num_theta_bins,num_periods)
;;--get 'StructFunct_Bpara_theta_scale_arr'
;StructFunct_Bpara_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  dby_tmp = diff_Bcomp_arr(1,sub_tmp,i_period)
  dBy_ave = mean(dby_tmp,/nan)  
  By_vari(i_theta,i_period) = variance(dby_tmp,/nan)
  By_av3(i_theta,i_period) = mean((dby_tmp-dBy_ave)^3.0,/nan)
  By_av4(i_theta,i_period) = mean((dby_tmp-dBy_ave)^4.0,/nan)
  By_sig(i_theta,i_period) = stddev(dby_tmp,/nan)
  By_piandu(i_theta,i_period) = By_av3(i_theta,i_period)/By_sig(i_theta,i_period)^3.0
  By_peak(i_theta,i_period) = By_av4(i_theta,i_period)/By_sig(i_theta,i_period)^4.0
EndFor
EndFor

;;--get 'StructFunct_Bt_theta_scale_arr'
Bz_vari = fltarr(num_theta_bins,num_periods)
Bz_av3 = fltarr(num_theta_bins,num_periods)
Bz_av4 = fltarr(num_theta_bins,num_periods)
Bz_sig = fltarr(num_theta_bins,num_periods)
Bz_piandu = fltarr(num_theta_bins,num_periods)
Bz_peak = fltarr(num_theta_bins,num_periods)
;;--get 'StructFunct_Bpara_theta_scale_arr'
;StructFunct_Bpara_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  dbz_tmp = diff_Bcomp_arr(2,sub_tmp,i_period)
  dBz_ave = mean(dbz_tmp,/nan)  
  Bz_vari(i_theta,i_period) = variance(dbz_tmp,/nan)
  Bz_av3(i_theta,i_period) = mean((dbz_tmp-dBz_ave)^3.0,/nan)
  Bz_av4(i_theta,i_period) = mean((dbz_tmp-dBz_ave)^4.0,/nan)
  Bz_sig(i_theta,i_period) = stddev(dbz_tmp,/nan)
  Bz_piandu(i_theta,i_period) = Bz_av3(i_theta,i_period)/Bz_sig(i_theta,i_period)^3.0
  Bz_peak(i_theta,i_period) = Bz_av4(i_theta,i_period)/Bz_sig(i_theta,i_period)^4.0
EndFor
EndFor

;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min  = JulDay_min
JulDay_max  = JulDay_min+(Max(time_vect_LBG)-Min(time_vect_LBG))/(24.*60.*60)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
period_min_str  = String(Min(period_vect),'(F3.1)')
period_max_str  = String(Max(period_vect),'(I4.4)')
PeriodRange_str = '(period='+period_min_str+'-'+period_max_str+')'
file_save = 'Ulysess_vari_piandu_peak_arr'+$
        TimeRange_str+$
        PeriodRange_str+$
        '.sav'
period_vect = period_vect_LBG
data_descrip= 'got from "get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_bin_min_vect, theta_bin_max_vect, $
  period_vect, $
  Bx_vari, $
  Bx_piandu, $
  Bx_peak, $
  By_vari, $
  By_piandu, $
  By_peak, $
  Bz_vari, $
  Bz_piandu, $
  Bz_peak



;;画图

;===========================

step3:

period_vect_TV  = period_vect_LBG

theta_vect_TV = theta_bin_min_vect





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


step3_1:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = Bx_vari
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
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.2)');the tick-names of colorbar 15
titleCB     = TexToIDL('Bx_Variance')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

step3_2:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = Bx_piandu
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = -3.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 3.5 ;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Vx_Skewness')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_tickn,max_tickn],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


step3_3:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = Bx_peak
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 30.0;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Vx_kurtosis')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_tickn,max_tickn],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Bx_vari_pd_fd'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd


;;--
step4:

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

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


step4_1:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = By_vari
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
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.2)');the tick-names of colorbar 15
titleCB     = TexToIDL('By_Variance')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

step4_2:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = By_piandu
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = -3.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 3.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('By_Skewness')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


step4_3:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = By_peak
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 30.0;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('By_kurtosis')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'By_vari_pd_fd'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd



step5:
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

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


step5_1:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = Bz_vari
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
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.2)');the tick-names of colorbar 15
titleCB     = TexToIDL('Bz_Variance')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

step5_2:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = Bz_piandu
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = -3.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 3.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Bz_Skewness')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


step5_3:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = Bz_peak
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 30.0;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('Bz_kurtosis')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Bz_vari_pd_fd'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd


!p.background = color_bg

End_Program:
End











