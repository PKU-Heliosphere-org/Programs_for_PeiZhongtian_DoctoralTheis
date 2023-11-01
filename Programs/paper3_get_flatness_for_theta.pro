;pro paper3_get_flatness_for_theta


sub_dir_date = 'wind\slow\case3\'
sub_dir_date1 = 'wind\fast\case3\'



;goto,step2
step1:

num_theta_bins = 90L
num_periods = 16L
flat_arr_slow = fltarr(num_periods)
secSF_arr_slow = fltarr(num_periods)
fourth_arr_slow = fltarr(num_periods)
flat_arr_slow_lit_theta = fltarr(num_periods)
flat_arr_slow_lar_theta = fltarr(num_periods)
secSF_arr_slow_lit_theta = fltarr(num_periods)
secSF_arr_slow_lar_theta = fltarr(num_periods)
fourth_arr_slow_lit_theta = fltarr(num_periods)
fourth_arr_slow_lar_theta = fltarr(num_periods)

flatness_mean = fltarr(num_theta_bins,num_periods)+!values.f_nan
datanum_bin = fltarr(num_theta_bins,num_periods)




;flat_arr_fast = fltarr(15,num_periods)




dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1-3.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;  JulDay_vect,  Bx_vect, By_vect, Bz_vect

JulDay_vect = JulDay_vect
Bx_GSE_vect = Bx_vect
By_GSE_vect = By_vect
Bz_GSE_vect = Bz_vect


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+'1-3'+'(time=*-*)(period=*-*).sav'
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


num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)

period_min = 3*time_lag
period_max = 1000*time_lag
period_range = [period_min,period_max]
is_log = 1



jieshu=1
Diff_BComp_arr = fltarr(num_times,num_periods)
diff_Bt_arr = fltarr(num_times,num_periods)
diff_Bx_arr = fltarr(num_times,num_periods)
diff_By_arr = fltarr(num_times,num_periods)
diff_Bz_arr = fltarr(num_times,num_periods)
get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, Bx_GSE_vect, By_GSE_vect, Bz_GSE_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    Bt_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_Bx_arr=Diff_Bx_arr,Diff_By_arr=Diff_By_arr,Diff_Bz_arr=Diff_Bz_arr, $  ;;
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr


sec_moment = Diff_Bt_arr^2
fourth_moment = Diff_Bt_arr^4


;;;;;;;;
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi

num_theta_bins = 90L

dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin
theta_vect = theta_bin_min_vect

;Flatness_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
;  theta_min_bin = theta_bin_min_vect(i_theta)
;  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
 ;   flatness_vect_tmp  = flat(*,i_period)
 ;   flatness_tmp = mean(flatness_vect_tmp(sub_tmp),/nan)
 ;   flatness_mean_15(i_slow-1,i_theta,i_period) = flatness_tmp
     secSF_arr_slow_lit_theta(i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_slow_lit_theta(i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
  EndIf
EndFor

For i_period=0,num_periods-1 Do Begin
;  theta_min_bin = theta_bin_min_vect(i_theta)
;  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
 ;   flatness_vect_tmp  = flat(*,i_period)
 ;   flatness_tmp = mean(flatness_vect_tmp(sub_tmp),/nan)
 ;   flatness_mean_15(i_slow-1,i_theta,i_period) = flatness_tmp
     secSF_arr_slow_lar_theta(i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_slow_lar_theta(i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
  EndIf
EndFor
;;;;;;;;
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
     datanum_bin(i_theta,i_period) = n_elements(sub_tmp)
     flatness_mean(i_theta,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)/mean(sec_moment(sub_tmp,i_period),/nan)^2
  EndIf
EndFor
EndFor
;;;
flat = fltarr(num_periods)
secSF = fltarr(num_periods)
fourthSF = fltarr(num_periods)
for i_period = 0,num_periods-1 do begin
flat(i_period) = mean(Diff_Bt_arr(*,i_period)^4,/nan)/mean(Diff_Bt_arr(*,i_period)^2,/nan)^2
secSF(i_period) = mean(sec_moment(*,i_period),/nan)
fourthSF(i_period) = mean(fourth_moment(*,i_period),/nan)
endfor


flat_arr_slow = flat
secSF_arr_slow = secSF
fourth_arr_slow = fourthSF
flat_arr_slow_lit_theta = mean(fourth_arr_slow_lit_theta,/nan)/mean(secSF_arr_slow_lit_theta,/nan)^2
flat_arr_slow_lar_theta = mean(fourth_arr_slow_lar_theta,/nan)/mean(secSF_arr_slow_lar_theta,/nan)^2
;step2:
;;--



step2:


flat_arr_fast = fltarr(num_periods)
secSF_arr_fast = fltarr(num_periods)
fourth_arr_fast = fltarr(num_periods)
flat_arr_fast_lit_theta = fltarr(num_periods)
flat_arr_fast_lar_theta = fltarr(num_periods)
secSF_arr_fast_lit_theta = fltarr(num_periods)
secSF_arr_fast_lar_theta = fltarr(num_periods)
fourth_arr_fast_lit_theta = fltarr(num_periods)
fourth_arr_fast_lar_theta = fltarr(num_periods)

flatness_meanf = fltarr(num_theta_bins,num_periods)+!values.f_nan
datanum_binf = fltarr(num_theta_bins,num_periods)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= '1-4.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

JulDay_vect = JulDay_vect
Bx_GSE_vect = Bx_vect
By_GSE_vect = By_vect
Bz_GSE_vect = Bz_vect

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+'1-4'+'(time=*-*)(period=*-*).sav'
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


num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)

period_min = 3*time_lag
period_max = 1000*time_lag
period_range = [period_min,period_max]
is_log = 1



jieshu=1
Diff_BComp_arr = fltarr(num_times,num_periods)
diff_Bt_arr = fltarr(num_times,num_periods)
diff_Bx_arr = fltarr(num_times,num_periods)
diff_By_arr = fltarr(num_times,num_periods)
diff_Bz_arr = fltarr(num_times,num_periods)
get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, Bx_GSE_vect, By_GSE_vect, Bz_GSE_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    Bt_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_Bx_arr=Diff_Bx_arr,Diff_By_arr=Diff_By_arr,Diff_Bz_arr=Diff_Bz_arr, $  ;;
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr


sec_moment = Diff_Bt_arr^2
fourth_moment = Diff_Bt_arr^4


;;;;;;;;
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


num_theta_bins = 90L
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin
theta_vect = theta_bin_min_vect

;Flatness_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
;  theta_min_bin = theta_bin_min_vect(i_theta)
;  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
 ;   flatness_vect_tmp  = flat(*,i_period)
 ;   flatness_tmp = mean(flatness_vect_tmp(sub_tmp),/nan)
 ;   flatness_mean_15(i_slow-1,i_theta,i_period) = flatness_tmp
     secSF_arr_fast_lit_theta(i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_fast_lit_theta(i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
  EndIf
EndFor

For i_period=0,num_periods-1 Do Begin
;  theta_min_bin = theta_bin_min_vect(i_theta)
;  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
 ;   flatness_vect_tmp  = flat(*,i_period)
 ;   flatness_tmp = mean(flatness_vect_tmp(sub_tmp),/nan)
 ;   flatness_mean_15(i_slow-1,i_theta,i_period) = flatness_tmp
     secSF_arr_fast_lar_theta(i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_fast_lar_theta(i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
 ;    flat_arr_fast_lar_theta(i_fast-1,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)/mean(sec_moment(sub_tmp,i_period),/nan)^2
  EndIf
EndFor
;;;;;;;;
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
     datanum_binf(i_theta,i_period) = n_elements(sub_tmp)
     flatness_meanf(i_theta,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)/mean(sec_moment(sub_tmp,i_period),/nan)^2
  EndIf
EndFor
EndFor




dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'flatness_theta_arr_fewdays'+'.sav'
data_descrip= 'got from "Figure2_flatness_theta_period.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_vect, period_vect, datanum_binf, flatness_meanf, datanum_bin, flatness_mean


;;;;;

flat = fltarr(num_periods)
secSF = fltarr(num_periods)
fourthSF = fltarr(num_periods)
for i_period = 0,num_periods-1 do begin
flat(i_period) = mean(Diff_Bt_arr(*,i_period)^4,/nan)/mean(Diff_Bt_arr(*,i_period)^2,/nan)^2
secSF(i_period) = mean(sec_moment(*,i_period),/nan)
fourthSF(i_period) = mean(fourth_moment(*,i_period),/nan)
endfor


flat_arr_fast = flat
secSF_arr_fast = secSF
fourth_arr_fast = fourthSF
flat_arr_fast_lit_theta = fourth_arr_fast_lit_theta/secSF_arr_fast_lit_theta^2
flat_arr_fast_lar_theta = fourth_arr_fast_lar_theta/secSF_arr_fast_lar_theta^2

;step2:
;;--







file_save = 'flatness_fast_slow'+$
        '_fewdays.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
data_descrip= 'got from "Figure1_nation_intermittency.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect, $
  flat_arr_fast, $
  flat_arr_slow,secSF_arr_fast,fourth_arr_fast,secSF_arr_slow,fourth_arr_slow, $
  secSF_arr_fast_lit_theta, secSF_arr_slow_lit_theta, secSF_arr_fast_lar_theta, secSF_arr_slow_lar_theta, $
  fourth_arr_fast_lit_theta, fourth_arr_slow_lit_theta, fourth_arr_fast_lar_theta, fourth_arr_slow_lar_theta, $
  flat_arr_fast_lit_theta, flat_arr_slow_lit_theta, flat_arr_fast_lar_theta, flat_arr_slow_lar_theta
  
step3:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'flatness_fast_slow'+'_fewdays.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Figure1_nation_intermittency.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect, $
;  flat_arr_fast, $
;  flat_arr_slow,secSF_arr_fast,fourth_arr_fast,secSF_arr_slow,fourth_arr_slow, $
;  secSF_arr_fast_lit_theta, secSF_arr_slow_lit_theta, secSF_arr_fast_lar_theta, secSF_arr_slow_lar_theta, $
;  fourth_arr_fast_lit_theta, fourth_arr_slow_lit_theta, fourth_arr_fast_lar_theta, fourth_arr_slow_lar_theta, $
;  flat_arr_fast_lit_theta, flat_arr_slow_lit_theta, flat_arr_fast_lar_theta, flat_arr_slow_lar_theta

flat_arr_fast_lit_theta = fourth_arr_fast_lit_theta/secSF_arr_fast_lit_theta^2
flat_arr_fast_lar_theta = fourth_arr_fast_lar_theta/secSF_arr_fast_lar_theta^2
flat_arr_slow_lit_theta = fourth_arr_slow_lit_theta/secSF_arr_slow_lit_theta^2
flat_arr_slow_lar_theta = fourth_arr_slow_lar_theta/secSF_arr_slow_lar_theta^2

;Set_Plot, 'Win'
;for i = 0,14 do begin
;  plot,1./period_vect,flat_arr_fast(i,*), xtitle = 'f(Hz)',ytitle = 'flatness',/xlog
;  image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_fig  = 'Figure1_'+strcompress(string(i))+'f_v.png'
;Write_PNG, dir_fig+file_fig, image_tvrd
;endfor
;for i = 0,14 do begin
;  plot,1./period_vect,flat_arr_slow(i,*), xtitle = 'f(Hz)',ytitle = 'flatness',/xlog
;  image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_fig  = 'Figure1_'+strcompress(string(i))+'s_v.png'
;Write_PNG, dir_fig+file_fig, image_tvrd
;endfor


Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1500.0
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




n_period = n_elements(period_vect)



position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs



;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,flat_arr_fast,period_vect,color = color_black, thick = 2, charsize = 1.2,xtitle = 'flatness',ytitle = 'period(s)', $
  position = position_SubImg,xrange = [1,60],/xlog,/ylog,/noerase
oplot,flat_arr_fast_lit_theta,period_vect,color = color_blue, thick = 2
oplot,flat_arr_fast_lar_theta,period_vect,color = color_red, thick = 2
;for i_fast = 1,15 do begin
;oplot,1./period_vect,flat_arr_fast(i_fast-1,*),color = color_gray
;endfor
;print,size(flat_arr_fast),size(flat_arr_slow)

;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,flat_arr_slow,period_vect,color = color_black, thick = 2, charsize = 1.2,xtitle = 'flatness',ytitle = 'period(s)', $
  position = position_SubImg,xrange = [1,60],/xlog,/ylog,/noerase
oplot,flat_arr_slow_lit_theta,period_vect,color = color_blue, thick = 2
oplot,flat_arr_slow_lar_theta,period_vect,color = color_red, thick = 2



;Step3_1:
;;--
i_x_SubImg  = 1
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = flatness_mean
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
  XTitle=xtitle,YTitle=ytitle,CharSize=1.5,$
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
i_x_SubImg  = 1
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = flatness_meanf
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
  XTitle=xtitle,YTitle=ytitle,CharSize=1.5,$
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
titleCB     = TexToIDL('flatness')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3





image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure1'+'_fewdays.png'
Write_PNG, dir_fig+file_fig, image_tvrd






end



















