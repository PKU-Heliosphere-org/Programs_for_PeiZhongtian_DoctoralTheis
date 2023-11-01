;pro get_crosscorrelation_of_V_B_select_5min






date = '20080406-08'
sub_dir_date  = 'wind\fast\'+date+'\'


Step1:
;===========================
;Step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_h0_mfi_'+date+'_v05.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR
;JulDay_b = JulDay_vect
BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR
Bx_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(0,*))
By_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(1,*))
Bz_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(2,*))
Bt_vect = sqrt(Bx_GSE_2S_vect^2+By_GSE_2S_vect^2+Bz_GSE_2S_vect^2)

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_inB.sav'
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

reso = (JulDay_2s_vect(1)-JulDay_2s_vect(0))*86400.0





step2:

read,'Vx&Bx(1) or Vy&By(2) or Vz&Bz(3)',select

if select eq 1 then begin
wave_vect1 = reform(P_VEL_3s_arr(0,*))
wave_vect2 = Bx_GSE_2S_vect
liang = 'Vx&Bx'
endif
if select eq 2 then begin
wave_vect1 = reform(P_VEL_3s_arr(1,*))
wave_vect2 = By_GSE_2S_vect
liang = 'Vy&By'
endif
if select eq 3 then begin
wave_vect1 = reform(P_VEL_3s_arr(2,*))
wave_vect2 = Bz_GSE_2S_vect
liang = 'Vz&Bz'
endif



sub_BadVal  = Where(Finite(wave_vect1) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse

sub_BadVal  = Where(Finite(wave_vect2) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
;;--
num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

time_vect_wavlet = time_vect
JulDay_min_v2 = Min(JulDay_2s_vect)
;;--
BComp_vect1  = wave_vect1
BComp_vect2  = wave_vect2
period_min  = 12.0;1.0;1.e0  ;unit: s
period_max  = 1200.0;1.e3
period_range= [period_min, period_max]
num_periods = 16

Diff_Bcomp_arr1  = Fltarr(num_times, num_periods)
Diff_Bcomp_arr2  = Fltarr(num_times, num_periods)
get_Wavelet_zidingyi_v2, $   ;可以改为Haar或者Morlet
    time_vect, BComp_vect1, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    BComp_wavlet_arr1, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_BComp_arr1
get_Wavelet_zidingyi_v2, $   ;可以改为Haar或者Morlet
    time_vect, BComp_vect2, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    BComp_wavlet_arr2, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_BComp_arr2    

period_vect_wavlet = period_vect

dtime     = time_vect(1)-time_vect(0)
PSD_BComp_time_scale_arr1  = Abs(BComp_wavlet_arr1)^2*dtime
PSD_BComp_time_scale_arr1 = alog10(PSD_BComp_time_scale_arr1)
PSD_BComp_time_scale_arr2  = Abs(BComp_wavlet_arr2)^2*dtime
PSD_BComp_time_scale_arr2 = alog10(PSD_BComp_time_scale_arr2)



 

wave_coherency, BComp_wavlet_arr1, time_vect, period_vect, BComp_wavlet_arr2 ,time_vect, period_vect, $
      WAVE_COHER=wave_coher,WAVE_PHASE=wave_phase


dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_save = 'Correlation_'+'_of_'+liang+$
        '.sav'
data_descrip= 'got from "get_crosscorrelation_of_v_b_select_5min.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  wave_coher, wave_phase,period_vect , time_vect_wavlet


step3:


PSD_BComp_time_scale_arr = wave_coher

time_min_TV = time_vect(0)
time_max_TV = time_min_TV+(24.*60.*60)*5
sub_time_min_TV = Where(time_vect ge time_min_TV)
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
image_TV  = PSD_BComp_time_scale_arr_TV
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 1.0;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
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
titleCB     = TexToIDL('correlation')
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
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_fig  = 'correlation_of_'+liang+'_time_scale_arr'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


step4:


PSD_BComp_time_scale_arr = abs(wave_phase)

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
image_TV  = PSD_BComp_time_scale_arr_TV
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
titleCB     = TexToIDL('wave_phase')
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
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_fig  = 'Phase_of_'+liang+'_time_scale_arr'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg



end

