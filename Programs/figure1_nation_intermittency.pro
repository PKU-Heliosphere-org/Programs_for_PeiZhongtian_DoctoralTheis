;pro Figure1_nation_intermittency


sub_dir_date = 'wind\slow\case1\'
sub_dir_date1 = 'wind\fast\case1\'



;goto,step2
step1:

num_periods = 32
flat_arr_slow = fltarr(15,num_periods)
secSF_arr_slow = fltarr(15,num_periods)
fourth_arr_slow = fltarr(15,num_periods)
flat_arr_slow_lit_theta = fltarr(15,num_periods)
flat_arr_slow_lar_theta = fltarr(15,num_periods)
secSF_arr_slow_lit_theta = fltarr(15,num_periods)
secSF_arr_slow_lar_theta = fltarr(15,num_periods)
fourth_arr_slow_lit_theta = fltarr(15,num_periods)
fourth_arr_slow_lar_theta = fltarr(15,num_periods)

;flat_arr_fast = fltarr(15,num_periods)




for i_slow = 1,15 do begin

;step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i_slow),/remove_all)+'_v.sav'
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

JulDay_vect = JulDay_vect_interp
Bx_GSE_vect = Bx_GSE_vect_interp
By_GSE_vect = By_GSE_vect_interp
Bz_GSE_vect = Bz_GSE_vect_interp


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_slow),/remove_all)+'_(time=*-*)(period=*-*).sav'
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
period_max = 2000*time_lag
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
     secSF_arr_slow_lit_theta(i_slow-1,i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_slow_lit_theta(i_slow-1,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
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
     secSF_arr_slow_lar_theta(i_slow-1,i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_slow_lar_theta(i_slow-1,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
  EndIf
EndFor
;;;;;;;;

flat = fltarr(num_periods)
secSF = fltarr(num_periods)
fourthSF = fltarr(num_periods)
for i_period = 0,num_periods-1 do begin
flat(i_period) = mean(Diff_Bt_arr(*,i_period)^4,/nan)/mean(Diff_Bt_arr(*,i_period)^2,/nan)^2
secSF(i_period) = mean(sec_moment(*,i_period),/nan)
fourthSF(i_period) = mean(fourth_moment(*,i_period),/nan)
endfor


flat_arr_slow(i_slow-1,*) = flat
secSF_arr_slow(i_slow-1,*) = secSF
fourth_arr_slow(i_slow-1,*) = fourthSF
flat_arr_slow_lit_theta(i_slow-1,*) = mean(fourth_arr_slow_lit_theta(i_slow-1,*),/nan)/mean(secSF_arr_slow_lit_theta(i_slow-1,*),/nan)^2
flat_arr_slow_lar_theta(i_slow-1,*) = mean(fourth_arr_slow_lar_theta(i_slow-1,*),/nan)/mean(secSF_arr_slow_lar_theta(i_slow-1,*),/nan)^2
;step2:
;;--

endfor

step2:

num_periods = 32
flat_arr_fast = fltarr(15,num_periods)
secSF_arr_fast = fltarr(15,num_periods)
fourth_arr_fast = fltarr(15,num_periods)
flat_arr_fast_lit_theta = fltarr(15,num_periods)
flat_arr_fast_lar_theta = fltarr(15,num_periods)
secSF_arr_fast_lit_theta = fltarr(15,num_periods)
secSF_arr_fast_lar_theta = fltarr(15,num_periods)
fourth_arr_fast_lit_theta = fltarr(15,num_periods)
fourth_arr_fast_lar_theta = fltarr(15,num_periods)

for i_fast = 1,15 do begin

;step1:



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= strcompress(string(i_fast),/remove_all)+'_v.sav'
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

JulDay_vect = JulDay_vect_interp
Bx_GSE_vect = Bx_GSE_vect_interp
By_GSE_vect = By_GSE_vect_interp
Bz_GSE_vect = Bz_GSE_vect_interp

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_fast),/remove_all)+'_(time=*-*)(period=*-*).sav'
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
period_max = 2000*time_lag
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
     secSF_arr_fast_lit_theta(i_fast-1,i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_fast_lit_theta(i_fast-1,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
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
     secSF_arr_fast_lar_theta(i_fast-1,i_period) = mean(sec_moment(sub_tmp,i_period),/nan)
     fourth_arr_fast_lar_theta(i_fast-1,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)
 ;    flat_arr_fast_lar_theta(i_fast-1,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)/mean(sec_moment(sub_tmp,i_period),/nan)^2
  EndIf
EndFor
;;;;;;;;

flat = fltarr(num_periods)
secSF = fltarr(num_periods)
fourthSF = fltarr(num_periods)
for i_period = 0,num_periods-1 do begin
flat(i_period) = mean(Diff_Bt_arr(*,i_period)^4,/nan)/mean(Diff_Bt_arr(*,i_period)^2,/nan)^2
secSF(i_period) = mean(sec_moment(*,i_period),/nan)
fourthSF(i_period) = mean(fourth_moment(*,i_period),/nan)
endfor


flat_arr_fast(i_fast-1,*) = flat
secSF_arr_fast(i_fast-1,*) = secSF
fourth_arr_fast(i_fast-1,*) = fourthSF
flat_arr_fast_lit_theta(i_fast-1,*) = fourth_arr_fast_lit_theta(i_fast-1,*)/secSF_arr_fast_lit_theta(i_fast-1,*)^2
flat_arr_fast_lar_theta(i_fast-1,*) = fourth_arr_fast_lar_theta(i_fast-1,*)/secSF_arr_fast_lar_theta(i_fast-1,*)^2

;step2:
;;--

endfor





file_save = 'flatness_fast_slow'+$
        '_v.sav'
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
file_restore= 'flatness_fast_slow'+'_v.sav'
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
xsize = 1000.0
ysize = 1500.0
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
flat_mid_fast = fltarr(n_period)
flat_mid_slow = fltarr(n_period)
secSf_mid_fast = fltarr(n_period)
secSF_mid_slow = fltarr(n_period)
fourth_mid_fast = fltarr(n_period)
fourth_mid_slow = fltarr(n_period)

flat_mid_fast_lit_theta = fltarr(n_period)
flat_mid_slow_lit_theta = fltarr(n_period)
secSf_mid_fast_lit_theta = fltarr(n_period)
secSF_mid_slow_lit_theta = fltarr(n_period)
fourth_mid_fast_lit_theta = fltarr(n_period)
fourth_mid_slow_lit_theta = fltarr(n_period)

flat_mid_fast_lar_theta = fltarr(n_period)
flat_mid_slow_lar_theta = fltarr(n_period)
secSf_mid_fast_lar_theta = fltarr(n_period)
secSF_mid_slow_lar_theta = fltarr(n_period)
fourth_mid_fast_lar_theta = fltarr(n_period)
fourth_mid_slow_lar_theta = fltarr(n_period)


for i_period=0,n_period-1 do begin
  a1 = sort(flat_arr_fast(*,i_period))
  a2 = sort(flat_arr_slow(*,i_period))
  flat_mid_fast(i_period) = flat_arr_fast(a1(7),i_period)
  flat_mid_slow(i_period) = flat_arr_slow(a2(7),i_period)
  b1 = sort(secSF_arr_fast(*,i_period))
  b2 = sort(secSF_arr_slow(*,i_period))
  secSF_mid_fast(i_period) = secSF_arr_fast(b1(7),i_period)
  secSF_mid_slow(i_period) = secSF_arr_slow(b2(7),i_period)
  c1 = sort(fourth_arr_fast(*,i_period))
  c2 = sort(fourth_arr_slow(*,i_period))
  fourth_mid_fast(i_period) = fourth_arr_fast(c1(7),i_period)
  fourth_mid_slow(i_period) = fourth_arr_slow(c2(7),i_period) 
    
  a1 = sort(flat_arr_fast_lit_theta(*,i_period))
  a2 = sort(flat_arr_slow_lit_theta(*,i_period))
  flat_mid_fast_lit_theta(i_period) = flat_arr_fast_lit_theta(a1(7),i_period)
  flat_mid_slow_lit_theta(i_period) = flat_arr_slow_lit_theta(a2(7),i_period)
  b1 = sort(secSF_arr_fast_lit_theta(*,i_period))
  b2 = sort(secSF_arr_slow_lit_theta(*,i_period))
  secSF_mid_fast_lit_theta(i_period) = secSF_arr_fast_lit_theta(b1(7),i_period)
  secSF_mid_slow_lit_theta(i_period) = secSF_arr_slow_lit_theta(b2(7),i_period)
  c1 = sort(fourth_arr_fast_lit_theta(*,i_period))
  c2 = sort(fourth_arr_slow_lit_theta(*,i_period))
  fourth_mid_fast_lit_theta(i_period) = fourth_arr_fast_lit_theta(c1(7),i_period)
  fourth_mid_slow_lit_theta(i_period) = fourth_arr_slow_lit_theta(c2(7),i_period) 
  
  a1 = sort(flat_arr_fast_lar_theta(*,i_period))
  a2 = sort(flat_arr_slow_lar_theta(*,i_period))
  flat_mid_fast_lar_theta(i_period) = flat_arr_fast_lar_theta(a1(7),i_period)
  flat_mid_slow_lar_theta(i_period) = flat_arr_slow_lar_theta(a2(7),i_period)
  b1 = sort(secSF_arr_fast_lar_theta(*,i_period))
  b2 = sort(secSF_arr_slow_lar_theta(*,i_period))
  secSF_mid_fast_lar_theta(i_period) = secSF_arr_fast_lar_theta(b1(7),i_period)
  secSF_mid_slow_lar_theta(i_period) = secSF_arr_slow_lar_theta(b2(7),i_period)
  c1 = sort(fourth_arr_fast_lar_theta(*,i_period))
  c2 = sort(fourth_arr_slow_lar_theta(*,i_period))
  fourth_mid_fast_lar_theta(i_period) = fourth_arr_fast_lar_theta(c1(7),i_period)
  fourth_mid_slow_lar_theta(i_period) = fourth_arr_slow_lar_theta(c2(7),i_period)   
      
   
 
endfor

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

plot,1./period_vect,flat_mid_fast,color = color_black, thick = 2, charsize = 1.2,xtitle = 'f(Hz)',ytitle = 'flatness', $
  position = position_SubImg,yrange = [1,60],/xlog,/ylog,/noerase
oplot,1./period_vect,flat_mid_fast_lit_theta,color = color_blue, thick = 2
oplot,1./period_vect,flat_mid_fast_lar_theta,color = color_red, thick = 2
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

plot,1./period_vect,flat_mid_slow,color = color_black, thick = 2, charsize = 1.2,xtitle = 'f(Hz)',ytitle = 'flatness', $
  position = position_SubImg,yrange = [1,60],/xlog,/ylog,/noerase
oplot,1./period_vect,flat_mid_slow_lit_theta,color = color_blue, thick = 2
oplot,1./period_vect,flat_mid_slow_lar_theta,color = color_red, thick = 2

;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,secSF_mid_fast,color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF2', $
  position = position_SubImg,yrange = [0.001,10],/xlog,/ylog,/noerase
oplot,1./period_vect,secSf_mid_fast_lit_theta,color = color_blue, thick = 2
oplot,1./period_vect,secSF_mid_fast_lar_theta,color = color_red, thick = 2

;;--
i_x_SubImg  = 1
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,secSF_mid_slow,color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF2', $
  position = position_SubImg,yrange = [0.001,10],/xlog,/ylog,/noerase
oplot,1./period_vect,secSf_mid_slow_lit_theta,color = color_blue, thick = 2
oplot,1./period_vect,secSF_mid_slow_lar_theta,color = color_red, thick = 2

;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,fourth_mid_fast,color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF4', $
  position = position_SubImg,yrange = [0.0005,50],/xlog,/ylog,/noerase
oplot,1./period_vect,fourth_mid_fast_lit_theta,color = color_blue, thick = 2
oplot,1./period_vect,fourth_mid_fast_lar_theta,color = color_red, thick = 2


;;--
i_x_SubImg  = 1
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,fourth_mid_slow,color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF4', $
  position = position_SubImg,yrange = [0.0005,50],/xlog,/ylog,/noerase
oplot,1./period_vect,fourth_mid_slow_lit_theta,color = color_blue, thick = 2
oplot,1./period_vect,fourth_mid_slow_lar_theta,color = color_red, thick = 2




image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure1_v'+'_v1.png'
Write_PNG, dir_fig+file_fig, image_tvrd


step4:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'flatness_fast_slow'+'_v.sav'
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


xsize = 1000.0
ysize = 1500.0
Window,2,XSize=xsize,YSize=ysize
;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

for i = 0,14 do begin
  
xsize = 1000.0
ysize = 1500.0
Window,2,XSize=xsize,YSize=ysize
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

plot,1./period_vect,flat_arr_fast(i,*),color = color_black, thick = 2, charsize = 1.2,xtitle = 'f(Hz)',ytitle = 'flatness', $
  position = position_SubImg,yrange = [1,60],/xlog,/ylog,/noerase
oplot,1./period_vect,flat_arr_fast_lit_theta(i,*),color = color_blue, thick = 2
oplot,1./period_vect,flat_arr_fast_lar_theta(i,*),color = color_red, thick = 2
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

plot,1./period_vect,flat_arr_slow(i,*),color = color_black, thick = 2, charsize = 1.2,xtitle = 'f(Hz)',ytitle = 'flatness', $
  position = position_SubImg,yrange = [1,60],/xlog,/ylog,/noerase
oplot,1./period_vect,flat_arr_slow_lit_theta(i,*),color = color_blue, thick = 2
oplot,1./period_vect,flat_arr_slow_lar_theta(i,*),color = color_red, thick = 2

;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,secSF_arr_fast(i,*),color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF2', $
  position = position_SubImg,yrange = [0.001,10],/xlog,/ylog,/noerase
oplot,1./period_vect,secSf_arr_fast_lit_theta(i,*),color = color_blue, thick = 2
oplot,1./period_vect,secSF_arr_fast_lar_theta(i,*),color = color_red, thick = 2

;;--
i_x_SubImg  = 1
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,secSF_arr_slow(i,*),color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF2', $
  position = position_SubImg,yrange = [0.001,10],/xlog,/ylog,/noerase
oplot,1./period_vect,secSf_arr_slow_lit_theta(i,*),color = color_blue, thick = 2
oplot,1./period_vect,secSF_arr_slow_lar_theta(i,*),color = color_red, thick = 2

;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,fourth_arr_fast(i,*),color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF4', $
  position = position_SubImg,yrange = [0.0005,50],/xlog,/ylog,/noerase
oplot,1./period_vect,fourth_arr_fast_lit_theta(i,*),color = color_blue, thick = 2
oplot,1./period_vect,fourth_arr_fast_lar_theta(i,*),color = color_red, thick = 2


;;--
i_x_SubImg  = 1
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.90),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.90)]

plot,1./period_vect,fourth_arr_slow(i,*),color = color_black, thick = 2, charsize = 1.2, xtitle = 'f(Hz)',ytitle = 'SF4', $
  position = position_SubImg,yrange = [0.0005,50],/xlog,/ylog,/noerase
oplot,1./period_vect,fourth_arr_slow_lit_theta(i,*),color = color_blue, thick = 2
oplot,1./period_vect,fourth_arr_slow_lar_theta(i,*),color = color_red, thick = 2

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure1_for_'+strcompress(string(i+1),/remove_all)+'day'+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endfor


end
