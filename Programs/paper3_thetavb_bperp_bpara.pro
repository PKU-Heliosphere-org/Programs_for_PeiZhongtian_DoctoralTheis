;pro paper3_thetaVB_Bperp_Bpara

sub_dir_date  = 'wind\slow\case1\'
sub_dir_date1  = 'wind\fast\case1\'

num_days = 15
n_jie = 5L;;;
jie = findgen(n_jie)+1

step1:

num_periods = 6

period_guan = fltarr(num_periods)
period_hao = fltarr(num_periods)
m1_slow_30_theta_hao = fltarr(15,num_periods)
m2_slow_30_theta_hao = fltarr(15,num_periods)
m3_slow_30_theta_hao = fltarr(15,num_periods)
m4_slow_30_theta_hao = fltarr(15,num_periods)
m5_slow_30_theta_hao = fltarr(15,num_periods)

m1_slow_60_theta_hao = fltarr(15,num_periods)
m2_slow_60_theta_hao = fltarr(15,num_periods)
m3_slow_60_theta_hao = fltarr(15,num_periods)
m4_slow_60_theta_hao = fltarr(15,num_periods)
m5_slow_60_theta_hao = fltarr(15,num_periods)

m1_slow_90_theta_hao = fltarr(15,num_periods)
m2_slow_90_theta_hao = fltarr(15,num_periods)
m3_slow_90_theta_hao = fltarr(15,num_periods)
m4_slow_90_theta_hao = fltarr(15,num_periods)
m5_slow_90_theta_hao = fltarr(15,num_periods)
;;;
m1_slow_30_theta_hao_perp = fltarr(15,num_periods)
m2_slow_30_theta_hao_perp = fltarr(15,num_periods)
m3_slow_30_theta_hao_perp = fltarr(15,num_periods)
m4_slow_30_theta_hao_perp = fltarr(15,num_periods)
m5_slow_30_theta_hao_perp = fltarr(15,num_periods)

m1_slow_60_theta_hao_perp = fltarr(15,num_periods)
m2_slow_60_theta_hao_perp = fltarr(15,num_periods)
m3_slow_60_theta_hao_perp = fltarr(15,num_periods)
m4_slow_60_theta_hao_perp = fltarr(15,num_periods)
m5_slow_60_theta_hao_perp = fltarr(15,num_periods)

m1_slow_90_theta_hao_perp = fltarr(15,num_periods)
m2_slow_90_theta_hao_perp = fltarr(15,num_periods)
m3_slow_90_theta_hao_perp = fltarr(15,num_periods)
m4_slow_90_theta_hao_perp = fltarr(15,num_periods)
m5_slow_90_theta_hao_perp = fltarr(15,num_periods)

m1_slow_30_theta_hao_para = fltarr(15,num_periods)
m2_slow_30_theta_hao_para = fltarr(15,num_periods)
m3_slow_30_theta_hao_para = fltarr(15,num_periods)
m4_slow_30_theta_hao_para = fltarr(15,num_periods)
m5_slow_30_theta_hao_para = fltarr(15,num_periods)

m1_slow_60_theta_hao_para = fltarr(15,num_periods)
m2_slow_60_theta_hao_para = fltarr(15,num_periods)
m3_slow_60_theta_hao_para = fltarr(15,num_periods)
m4_slow_60_theta_hao_para = fltarr(15,num_periods)
m5_slow_60_theta_hao_para = fltarr(15,num_periods)

m1_slow_90_theta_hao_para = fltarr(15,num_periods)
m2_slow_90_theta_hao_para = fltarr(15,num_periods)
m3_slow_90_theta_hao_para = fltarr(15,num_periods)
m4_slow_90_theta_hao_para = fltarr(15,num_periods)
m5_slow_90_theta_hao_para = fltarr(15,num_periods)
;;;

for i_d = 1,num_days do begin
  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i_d),/remove_all)+'_v.sav'
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
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_d),/remove_all)+'_hao'+'_(time=*-*)(period=*-*).sav'
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
period_max = 20*time_lag
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
    
period_hao = period_vect

moment1 = (abs(Diff_Bt_arr))^1
moment2 = (abs(Diff_Bt_arr))^2
moment3 = (abs(Diff_Bt_arr))^3
moment4 = (abs(Diff_Bt_arr))^4
moment5 = (abs(Diff_Bt_arr))^5

;;;;;计算Bpara,Bperp
;Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
Bpara_SF1 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^1
Bperp_SF1 = (moment1 - Bpara_SF1) / 2
Bpara_SF2 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^2
Bperp_SF2 = (moment2 - Bpara_SF2) / 2
Bpara_SF3 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^3
Bperp_SF3 = (moment3 - Bpara_SF3) / 2
Bpara_SF4 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^4
Bperp_SF4 = (moment4 - Bpara_SF4) / 2
Bpara_SF5 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^5
Bperp_SF5 = (moment5 - Bpara_SF5) / 2
;;;---

;;;;;;;;
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi




For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180))
  If sub_tmp(0) ne -1 Then Begin
     m1_slow_30_theta_hao(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_slow_30_theta_hao(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_slow_30_theta_hao(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_slow_30_theta_hao(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_slow_30_theta_hao(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_slow_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_slow_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_slow_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_slow_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_slow_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_slow_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_slow_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_slow_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_slow_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_slow_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;        
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 30 and $
          theta_arr(*,i_period) lt 60) or (theta_arr(*,i_period) ge 120 and $
          theta_arr(*,i_period) lt 150))
  If sub_tmp(0) ne -1 Then Begin
     m1_slow_60_theta_hao(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_slow_60_theta_hao(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_slow_60_theta_hao(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_slow_60_theta_hao(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_slow_60_theta_hao(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_slow_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_slow_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_slow_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_slow_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_slow_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_slow_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_slow_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_slow_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_slow_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_slow_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;         
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120))
  If sub_tmp(0) ne -1 Then Begin
     m1_slow_90_theta_hao(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_slow_90_theta_hao(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_slow_90_theta_hao(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_slow_90_theta_hao(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_slow_90_theta_hao(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_slow_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_slow_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_slow_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_slow_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_slow_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_slow_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_slow_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_slow_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_slow_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_slow_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;         
  EndIf
EndFor

endfor


step2:

m1_fast_30_theta_hao = fltarr(15,num_periods)
m2_fast_30_theta_hao = fltarr(15,num_periods)
m3_fast_30_theta_hao = fltarr(15,num_periods)
m4_fast_30_theta_hao = fltarr(15,num_periods)
m5_fast_30_theta_hao = fltarr(15,num_periods)

m1_fast_60_theta_hao = fltarr(15,num_periods)
m2_fast_60_theta_hao = fltarr(15,num_periods)
m3_fast_60_theta_hao = fltarr(15,num_periods)
m4_fast_60_theta_hao = fltarr(15,num_periods)
m5_fast_60_theta_hao = fltarr(15,num_periods)

m1_fast_90_theta_hao = fltarr(15,num_periods)
m2_fast_90_theta_hao = fltarr(15,num_periods)
m3_fast_90_theta_hao = fltarr(15,num_periods)
m4_fast_90_theta_hao = fltarr(15,num_periods)
m5_fast_90_theta_hao = fltarr(15,num_periods)
;;;
m1_fast_30_theta_hao_perp = fltarr(15,num_periods)
m2_fast_30_theta_hao_perp = fltarr(15,num_periods)
m3_fast_30_theta_hao_perp = fltarr(15,num_periods)
m4_fast_30_theta_hao_perp = fltarr(15,num_periods)
m5_fast_30_theta_hao_perp = fltarr(15,num_periods)

m1_fast_60_theta_hao_perp = fltarr(15,num_periods)
m2_fast_60_theta_hao_perp = fltarr(15,num_periods)
m3_fast_60_theta_hao_perp = fltarr(15,num_periods)
m4_fast_60_theta_hao_perp = fltarr(15,num_periods)
m5_fast_60_theta_hao_perp = fltarr(15,num_periods)

m1_fast_90_theta_hao_perp = fltarr(15,num_periods)
m2_fast_90_theta_hao_perp = fltarr(15,num_periods)
m3_fast_90_theta_hao_perp = fltarr(15,num_periods)
m4_fast_90_theta_hao_perp = fltarr(15,num_periods)
m5_fast_90_theta_hao_perp = fltarr(15,num_periods)

m1_fast_30_theta_hao_para = fltarr(15,num_periods)
m2_fast_30_theta_hao_para = fltarr(15,num_periods)
m3_fast_30_theta_hao_para = fltarr(15,num_periods)
m4_fast_30_theta_hao_para = fltarr(15,num_periods)
m5_fast_30_theta_hao_para = fltarr(15,num_periods)

m1_fast_60_theta_hao_para = fltarr(15,num_periods)
m2_fast_60_theta_hao_para = fltarr(15,num_periods)
m3_fast_60_theta_hao_para = fltarr(15,num_periods)
m4_fast_60_theta_hao_para = fltarr(15,num_periods)
m5_fast_60_theta_hao_para = fltarr(15,num_periods)

m1_fast_90_theta_hao_para = fltarr(15,num_periods)
m2_fast_90_theta_hao_para = fltarr(15,num_periods)
m3_fast_90_theta_hao_para = fltarr(15,num_periods)
m4_fast_90_theta_hao_para = fltarr(15,num_periods)
m5_fast_90_theta_hao_para = fltarr(15,num_periods)
;;;


for i_d = 1,num_days do begin
  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= strcompress(string(i_d),/remove_all)+'_v.sav'
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
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_d),/remove_all)+'_hao'+'_(time=*-*)(period=*-*).sav'
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
period_max = 20*time_lag
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

moment1 = (abs(Diff_Bt_arr))^1
moment2 = (abs(Diff_Bt_arr))^2
moment3 = (abs(Diff_Bt_arr))^3
moment4 = (abs(Diff_Bt_arr))^4
moment5 = (abs(Diff_Bt_arr))^5

;;;;;计算Bpara,Bperp
;Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
Bpara_SF1 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^1
Bperp_SF1 = (moment1 - Bpara_SF1) / 2
Bpara_SF2 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^2
Bperp_SF2 = (moment2 - Bpara_SF2) / 2
Bpara_SF3 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^3
Bperp_SF3 = (moment3 - Bpara_SF3) / 2
Bpara_SF4 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^4
Bperp_SF4 = (moment4 - Bpara_SF4) / 2
Bpara_SF5 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^5
Bperp_SF5 = (moment5 - Bpara_SF5) / 2
;;;---

;;;;;;;;
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi




For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180))
  If sub_tmp(0) ne -1 Then Begin
     m1_fast_30_theta_hao(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_fast_30_theta_hao(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_fast_30_theta_hao(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_fast_30_theta_hao(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_fast_30_theta_hao(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_fast_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_fast_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_fast_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_fast_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_fast_30_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_fast_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_fast_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_fast_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_fast_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_fast_30_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;       
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 30 and $
          theta_arr(*,i_period) lt 60) or (theta_arr(*,i_period) ge 120 and $
          theta_arr(*,i_period) lt 150))
  If sub_tmp(0) ne -1 Then Begin
     m1_fast_60_theta_hao(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_fast_60_theta_hao(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_fast_60_theta_hao(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_fast_60_theta_hao(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_fast_60_theta_hao(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_fast_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_fast_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_fast_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_fast_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_fast_60_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_fast_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_fast_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_fast_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_fast_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_fast_60_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;  
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120))
  If sub_tmp(0) ne -1 Then Begin
     m1_fast_90_theta_hao(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_fast_90_theta_hao(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_fast_90_theta_hao(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_fast_90_theta_hao(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_fast_90_theta_hao(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_fast_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_fast_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_fast_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_fast_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_fast_90_theta_hao_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_fast_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_fast_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_fast_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_fast_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_fast_90_theta_hao_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;           
  EndIf
EndFor

endfor


step3:

num_periods = 6
m1_slow_30_theta_guan = fltarr(15,num_periods)
m2_slow_30_theta_guan = fltarr(15,num_periods)
m3_slow_30_theta_guan = fltarr(15,num_periods)
m4_slow_30_theta_guan = fltarr(15,num_periods)
m5_slow_30_theta_guan = fltarr(15,num_periods)

m1_slow_60_theta_guan = fltarr(15,num_periods)
m2_slow_60_theta_guan = fltarr(15,num_periods)
m3_slow_60_theta_guan = fltarr(15,num_periods)
m4_slow_60_theta_guan = fltarr(15,num_periods)
m5_slow_60_theta_guan = fltarr(15,num_periods)

m1_slow_90_theta_guan = fltarr(15,num_periods)
m2_slow_90_theta_guan = fltarr(15,num_periods)
m3_slow_90_theta_guan = fltarr(15,num_periods)
m4_slow_90_theta_guan = fltarr(15,num_periods)
m5_slow_90_theta_guan = fltarr(15,num_periods)
;;;
m1_slow_30_theta_guan_perp = fltarr(15,num_periods)
m2_slow_30_theta_guan_perp = fltarr(15,num_periods)
m3_slow_30_theta_guan_perp = fltarr(15,num_periods)
m4_slow_30_theta_guan_perp = fltarr(15,num_periods)
m5_slow_30_theta_guan_perp = fltarr(15,num_periods)

m1_slow_60_theta_guan_perp = fltarr(15,num_periods)
m2_slow_60_theta_guan_perp = fltarr(15,num_periods)
m3_slow_60_theta_guan_perp = fltarr(15,num_periods)
m4_slow_60_theta_guan_perp = fltarr(15,num_periods)
m5_slow_60_theta_guan_perp = fltarr(15,num_periods)

m1_slow_90_theta_guan_perp = fltarr(15,num_periods)
m2_slow_90_theta_guan_perp = fltarr(15,num_periods)
m3_slow_90_theta_guan_perp = fltarr(15,num_periods)
m4_slow_90_theta_guan_perp = fltarr(15,num_periods)
m5_slow_90_theta_guan_perp = fltarr(15,num_periods)

m1_slow_30_theta_guan_para = fltarr(15,num_periods)
m2_slow_30_theta_guan_para = fltarr(15,num_periods)
m3_slow_30_theta_guan_para = fltarr(15,num_periods)
m4_slow_30_theta_guan_para = fltarr(15,num_periods)
m5_slow_30_theta_guan_para = fltarr(15,num_periods)

m1_slow_60_theta_guan_para = fltarr(15,num_periods)
m2_slow_60_theta_guan_para = fltarr(15,num_periods)
m3_slow_60_theta_guan_para = fltarr(15,num_periods)
m4_slow_60_theta_guan_para = fltarr(15,num_periods)
m5_slow_60_theta_guan_para = fltarr(15,num_periods)

m1_slow_90_theta_guan_para = fltarr(15,num_periods)
m2_slow_90_theta_guan_para = fltarr(15,num_periods)
m3_slow_90_theta_guan_para = fltarr(15,num_periods)
m4_slow_90_theta_guan_para = fltarr(15,num_periods)
m5_slow_90_theta_guan_para = fltarr(15,num_periods)
;;;


for i_d = 1,num_days do begin
  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i_d),/remove_all)+'_v.sav'
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
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_d),/remove_all)+'_guan'+'_(time=*-*)(period=*-*).sav'
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

period_min = 100*time_lag
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
    
period_guan = period_vect

moment1 = (abs(Diff_Bt_arr))^1
moment2 = (abs(Diff_Bt_arr))^2
moment3 = (abs(Diff_Bt_arr))^3
moment4 = (abs(Diff_Bt_arr))^4
moment5 = (abs(Diff_Bt_arr))^5

;;;;;计算Bpara,Bperp
;Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
Bpara_SF1 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^1
Bperp_SF1 = (moment1 - Bpara_SF1) / 2
Bpara_SF2 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^2
Bperp_SF2 = (moment2 - Bpara_SF2) / 2
Bpara_SF3 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^3
Bperp_SF3 = (moment3 - Bpara_SF3) / 2
Bpara_SF4 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^4
Bperp_SF4 = (moment4 - Bpara_SF4) / 2
Bpara_SF5 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^5
Bperp_SF5 = (moment5 - Bpara_SF5) / 2
;;;---

;;;;;;;;
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi




For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180))
  If sub_tmp(0) ne -1 Then Begin
     m1_slow_30_theta_guan(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_slow_30_theta_guan(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_slow_30_theta_guan(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_slow_30_theta_guan(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_slow_30_theta_guan(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_slow_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_slow_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_slow_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_slow_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_slow_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_slow_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_slow_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_slow_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_slow_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_slow_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;       
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 30 and $
          theta_arr(*,i_period) lt 60) or (theta_arr(*,i_period) ge 120 and $
          theta_arr(*,i_period) lt 150))
  If sub_tmp(0) ne -1 Then Begin
     m1_slow_60_theta_guan(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_slow_60_theta_guan(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_slow_60_theta_guan(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_slow_60_theta_guan(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_slow_60_theta_guan(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_slow_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_slow_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_slow_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_slow_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_slow_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_slow_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_slow_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_slow_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_slow_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_slow_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;       
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120))
  If sub_tmp(0) ne -1 Then Begin
     m1_slow_90_theta_guan(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_slow_90_theta_guan(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_slow_90_theta_guan(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_slow_90_theta_guan(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_slow_90_theta_guan(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_slow_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_slow_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_slow_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_slow_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_slow_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_slow_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_slow_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_slow_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_slow_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_slow_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;         
  EndIf
EndFor

endfor


step4:

m1_fast_30_theta_guan = fltarr(15,num_periods)
m2_fast_30_theta_guan = fltarr(15,num_periods)
m3_fast_30_theta_guan = fltarr(15,num_periods)
m4_fast_30_theta_guan = fltarr(15,num_periods)
m5_fast_30_theta_guan = fltarr(15,num_periods)

m1_fast_60_theta_guan = fltarr(15,num_periods)
m2_fast_60_theta_guan = fltarr(15,num_periods)
m3_fast_60_theta_guan = fltarr(15,num_periods)
m4_fast_60_theta_guan = fltarr(15,num_periods)
m5_fast_60_theta_guan = fltarr(15,num_periods)

m1_fast_90_theta_guan = fltarr(15,num_periods)
m2_fast_90_theta_guan = fltarr(15,num_periods)
m3_fast_90_theta_guan = fltarr(15,num_periods)
m4_fast_90_theta_guan = fltarr(15,num_periods)
m5_fast_90_theta_guan = fltarr(15,num_periods)
;;;
m1_fast_30_theta_guan_perp = fltarr(15,num_periods)
m2_fast_30_theta_guan_perp = fltarr(15,num_periods)
m3_fast_30_theta_guan_perp = fltarr(15,num_periods)
m4_fast_30_theta_guan_perp = fltarr(15,num_periods)
m5_fast_30_theta_guan_perp = fltarr(15,num_periods)

m1_fast_60_theta_guan_perp = fltarr(15,num_periods)
m2_fast_60_theta_guan_perp = fltarr(15,num_periods)
m3_fast_60_theta_guan_perp = fltarr(15,num_periods)
m4_fast_60_theta_guan_perp = fltarr(15,num_periods)
m5_fast_60_theta_guan_perp = fltarr(15,num_periods)

m1_fast_90_theta_guan_perp = fltarr(15,num_periods)
m2_fast_90_theta_guan_perp = fltarr(15,num_periods)
m3_fast_90_theta_guan_perp = fltarr(15,num_periods)
m4_fast_90_theta_guan_perp = fltarr(15,num_periods)
m5_fast_90_theta_guan_perp = fltarr(15,num_periods)

m1_fast_30_theta_guan_para = fltarr(15,num_periods)
m2_fast_30_theta_guan_para = fltarr(15,num_periods)
m3_fast_30_theta_guan_para = fltarr(15,num_periods)
m4_fast_30_theta_guan_para = fltarr(15,num_periods)
m5_fast_30_theta_guan_para = fltarr(15,num_periods)

m1_fast_60_theta_guan_para = fltarr(15,num_periods)
m2_fast_60_theta_guan_para = fltarr(15,num_periods)
m3_fast_60_theta_guan_para = fltarr(15,num_periods)
m4_fast_60_theta_guan_para = fltarr(15,num_periods)
m5_fast_60_theta_guan_para = fltarr(15,num_periods)

m1_fast_90_theta_guan_para = fltarr(15,num_periods)
m2_fast_90_theta_guan_para = fltarr(15,num_periods)
m3_fast_90_theta_guan_para = fltarr(15,num_periods)
m4_fast_90_theta_guan_para = fltarr(15,num_periods)
m5_fast_90_theta_guan_para = fltarr(15,num_periods)
;;;




for i_d = 1,num_days do begin
  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= strcompress(string(i_d),/remove_all)+'_v.sav'
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
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_d),/remove_all)+'_guan'+'_(time=*-*)(period=*-*).sav'
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

period_min = 100*time_lag
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

moment1 = (abs(Diff_Bt_arr))^1
moment2 = (abs(Diff_Bt_arr))^2
moment3 = (abs(Diff_Bt_arr))^3
moment4 = (abs(Diff_Bt_arr))^4
moment5 = (abs(Diff_Bt_arr))^5


    
;;;;;计算Bpara,Bperp
;Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
Bpara_SF1 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^1
Bperp_SF1 = (moment1 - Bpara_SF1) / 2
Bpara_SF2 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^2
Bperp_SF2 = (moment2 - Bpara_SF2) / 2
Bpara_SF3 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^3
Bperp_SF3 = (moment3 - Bpara_SF3) / 2
Bpara_SF4 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^4
Bperp_SF4 = (moment4 - Bpara_SF4) / 2
Bpara_SF5 = abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^5
Bperp_SF5 = (moment5 - Bpara_SF5) / 2
;;;---

    




;;;;;;;;
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi




For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180))
  If sub_tmp(0) ne -1 Then Begin
     m1_fast_30_theta_guan(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_fast_30_theta_guan(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_fast_30_theta_guan(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_fast_30_theta_guan(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_fast_30_theta_guan(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_fast_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_fast_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_fast_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_fast_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_fast_30_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_fast_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_fast_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_fast_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_fast_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_fast_30_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;  
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 30 and $
          theta_arr(*,i_period) lt 60) or (theta_arr(*,i_period) ge 120 and $
          theta_arr(*,i_period) lt 150))
  If sub_tmp(0) ne -1 Then Begin
     m1_fast_60_theta_guan(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_fast_60_theta_guan(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_fast_60_theta_guan(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_fast_60_theta_guan(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_fast_60_theta_guan(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_fast_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_fast_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_fast_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_fast_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_fast_60_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_fast_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_fast_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_fast_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_fast_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_fast_60_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;      
  EndIf
EndFor


For i_period=0,num_periods-1 Do Begin
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120))
  If sub_tmp(0) ne -1 Then Begin
     m1_fast_90_theta_guan(i_d-1,i_period) = mean(moment1(sub_tmp,i_period),/nan)
     m2_fast_90_theta_guan(i_d-1,i_period) = mean(moment2(sub_tmp,i_period),/nan)
     m3_fast_90_theta_guan(i_d-1,i_period) = mean(moment3(sub_tmp,i_period),/nan)
     m4_fast_90_theta_guan(i_d-1,i_period) = mean(moment4(sub_tmp,i_period),/nan)
     m5_fast_90_theta_guan(i_d-1,i_period) = mean(moment5(sub_tmp,i_period),/nan)
  ;;;   
     m1_fast_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF1(sub_tmp,i_period),/nan)
     m2_fast_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF2(sub_tmp,i_period),/nan)
     m3_fast_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF3(sub_tmp,i_period),/nan)
     m4_fast_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF4(sub_tmp,i_period),/nan)
     m5_fast_90_theta_guan_perp(i_d-1,i_period) = mean(Bperp_SF5(sub_tmp,i_period),/nan)     
     m1_fast_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF1(sub_tmp,i_period),/nan)
     m2_fast_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF2(sub_tmp,i_period),/nan)
     m3_fast_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF3(sub_tmp,i_period),/nan)
     m4_fast_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF4(sub_tmp,i_period),/nan)
     m5_fast_90_theta_guan_para(i_d-1,i_period) = mean(Bpara_SF5(sub_tmp,i_period),/nan)                     
   ;;;      
  EndIf
EndFor

endfor


file_save = 'paper3_thetavb_Bperp_Bpara_slowfast_haoguan.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "paper3_caculate_spy.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_guan,period_hao, $
  m1_fast_90_theta_guan, m2_fast_90_theta_guan, m3_fast_90_theta_guan, m4_fast_90_theta_guan, m5_fast_90_theta_guan, $
  m1_fast_60_theta_guan, m2_fast_60_theta_guan, m3_fast_60_theta_guan, m4_fast_60_theta_guan, m5_fast_60_theta_guan, $  
  m1_fast_30_theta_guan, m2_fast_30_theta_guan, m3_fast_30_theta_guan, m4_fast_30_theta_guan, m5_fast_30_theta_guan, $  
  m1_slow_90_theta_guan, m2_slow_90_theta_guan, m3_slow_90_theta_guan, m4_slow_90_theta_guan, m5_slow_90_theta_guan, $
  m1_slow_60_theta_guan, m2_slow_60_theta_guan, m3_slow_60_theta_guan, m4_slow_60_theta_guan, m5_slow_60_theta_guan, $    
  m1_slow_30_theta_guan, m2_slow_30_theta_guan, m3_slow_30_theta_guan, m4_slow_30_theta_guan, m5_slow_30_theta_guan, $
  m1_fast_90_theta_hao, m2_fast_90_theta_hao, m3_fast_90_theta_hao, m4_fast_90_theta_hao, m5_fast_90_theta_hao, $
  m1_fast_60_theta_hao, m2_fast_60_theta_hao, m3_fast_60_theta_hao, m4_fast_60_theta_hao, m5_fast_60_theta_hao, $  
  m1_fast_30_theta_hao, m2_fast_30_theta_hao, m3_fast_30_theta_hao, m4_fast_30_theta_hao, m5_fast_30_theta_hao, $  
  m1_slow_90_theta_hao, m2_slow_90_theta_hao, m3_slow_90_theta_hao, m4_slow_90_theta_hao, m5_slow_90_theta_hao, $
  m1_slow_60_theta_hao, m2_slow_60_theta_hao, m3_slow_60_theta_hao, m4_slow_60_theta_hao, m5_slow_60_theta_hao, $    
  m1_slow_30_theta_hao, m2_slow_30_theta_hao, m3_slow_30_theta_hao, m4_slow_30_theta_hao, m5_slow_30_theta_hao, $

  m1_fast_90_theta_guan_perp, m2_fast_90_theta_guan_perp, m3_fast_90_theta_guan_perp, m4_fast_90_theta_guan_perp, m5_fast_90_theta_guan_perp, $
  m1_fast_60_theta_guan_perp, m2_fast_60_theta_guan_perp, m3_fast_60_theta_guan_perp, m4_fast_60_theta_guan_perp, m5_fast_60_theta_guan_perp, $  
  m1_fast_30_theta_guan_perp, m2_fast_30_theta_guan_perp, m3_fast_30_theta_guan_perp, m4_fast_30_theta_guan_perp, m5_fast_30_theta_guan_perp, $  
  m1_slow_90_theta_guan_perp, m2_slow_90_theta_guan_perp, m3_slow_90_theta_guan_perp, m4_slow_90_theta_guan_perp, m5_slow_90_theta_guan_perp, $
  m1_slow_60_theta_guan_perp, m2_slow_60_theta_guan_perp, m3_slow_60_theta_guan_perp, m4_slow_60_theta_guan_perp, m5_slow_60_theta_guan_perp, $    
  m1_slow_30_theta_guan_perp, m2_slow_30_theta_guan_perp, m3_slow_30_theta_guan_perp, m4_slow_30_theta_guan_perp, m5_slow_30_theta_guan_perp, $
  m1_fast_90_theta_hao_perp, m2_fast_90_theta_hao_perp, m3_fast_90_theta_hao_perp, m4_fast_90_theta_hao_perp, m5_fast_90_theta_hao_perp, $
  m1_fast_60_theta_hao_perp, m2_fast_60_theta_hao_perp, m3_fast_60_theta_hao_perp, m4_fast_60_theta_hao_perp, m5_fast_60_theta_hao_perp, $  
  m1_fast_30_theta_hao_perp, m2_fast_30_theta_hao_perp, m3_fast_30_theta_hao_perp, m4_fast_30_theta_hao_perp, m5_fast_30_theta_hao_perp, $  
  m1_slow_90_theta_hao_perp, m2_slow_90_theta_hao_perp, m3_slow_90_theta_hao_perp, m4_slow_90_theta_hao_perp, m5_slow_90_theta_hao_perp, $
  m1_slow_60_theta_hao_perp, m2_slow_60_theta_hao_perp, m3_slow_60_theta_hao_perp, m4_slow_60_theta_hao_perp, m5_slow_60_theta_hao_perp, $    
  m1_slow_30_theta_hao_perp, m2_slow_30_theta_hao_perp, m3_slow_30_theta_hao_perp, m4_slow_30_theta_hao_perp, m5_slow_30_theta_hao_perp, $
  
  m1_fast_90_theta_guan_para, m2_fast_90_theta_guan_para, m3_fast_90_theta_guan_para, m4_fast_90_theta_guan_para, m5_fast_90_theta_guan_para, $
  m1_fast_60_theta_guan_para, m2_fast_60_theta_guan_para, m3_fast_60_theta_guan_para, m4_fast_60_theta_guan_para, m5_fast_60_theta_guan_para, $  
  m1_fast_30_theta_guan_para, m2_fast_30_theta_guan_para, m3_fast_30_theta_guan_para, m4_fast_30_theta_guan_para, m5_fast_30_theta_guan_para, $  
  m1_slow_90_theta_guan_para, m2_slow_90_theta_guan_para, m3_slow_90_theta_guan_para, m4_slow_90_theta_guan_para, m5_slow_90_theta_guan_para, $
  m1_slow_60_theta_guan_para, m2_slow_60_theta_guan_para, m3_slow_60_theta_guan_para, m4_slow_60_theta_guan_para, m5_slow_60_theta_guan_para, $    
  m1_slow_30_theta_guan_para, m2_slow_30_theta_guan_para, m3_slow_30_theta_guan_para, m4_slow_30_theta_guan_para, m5_slow_30_theta_guan_para, $
  m1_fast_90_theta_hao_para, m2_fast_90_theta_hao_para, m3_fast_90_theta_hao_para, m4_fast_90_theta_hao_para, m5_fast_90_theta_hao_para, $
  m1_fast_60_theta_hao_para, m2_fast_60_theta_hao_para, m3_fast_60_theta_hao_para, m4_fast_60_theta_hao_para, m5_fast_60_theta_hao_para, $  
  m1_fast_30_theta_hao_para, m2_fast_30_theta_hao_para, m3_fast_30_theta_hao_para, m4_fast_30_theta_hao_para, m5_fast_30_theta_hao_para, $  
  m1_slow_90_theta_hao_para, m2_slow_90_theta_hao_para, m3_slow_90_theta_hao_para, m4_slow_90_theta_hao_para, m5_slow_90_theta_hao_para, $
  m1_slow_60_theta_hao_para, m2_slow_60_theta_hao_para, m3_slow_60_theta_hao_para, m4_slow_60_theta_hao_para, m5_slow_60_theta_hao_para, $    
  m1_slow_30_theta_hao_para, m2_slow_30_theta_hao_para, m3_slow_30_theta_hao_para, m4_slow_30_theta_hao_para, m5_slow_30_theta_hao_para    
  

end_program:
end






