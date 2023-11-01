;pro poster_get_deltaB_sigma_Bpara_Bperp



sub_dir_date  = 'wind\fast\case3\'


num_theta_bins  = 90L
num_periods = 32




goto,step2
step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
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
; JulDay_vect,  Bx_vect, By_vect, Bz_vect

;JulDay_vect = JulDay_vect_interp
Bx_GSE_vect = Bx_vect
By_GSE_vect = By_vect
Bz_GSE_vect = Bz_vect





num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)



num_periods = 32L
period_min = 4*time_lag;耗散3，惯性100
period_max = 100000*time_lag;耗散20，惯性1000
period_range = [period_min,period_max]

is_log = 1


;;;---
J_wavlet  = num_periods
If (is_log eq 1) Then Begin
  dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
  period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
EndIf Else Begin
  dperiod   = (period_max-period_min)/(num_periods-1)
  period_vect = period_min + Findgen(num_periods)*dperiod
EndElse

dt_pix    = time_lag
PixLag_vect = Round((period_vect/dt_pix)/2)*2
period_vect = PixLag_vect*dt_pix
;;--

num_periods = J_wavlet
num_times = N_Elements(time_vect)



for i_com = 0,2 do begin
  if i_com eq 0 then Bcomp_vect = Bx_GSE_vect
  if i_com eq 1 then Bcomp_vect = By_GSE_vect
  if i_com eq 2 then Bcomp_vect = Bz_GSE_vect

;jieshu=1
Diff_BComp_arr  = Fltarr(num_times, num_periods)
For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf

  ;;;---get 'diff_BComp_vect/arr' and transfer to the uppper level for calculating 'SF_para/perp_vect'
  Diff_BComp_vect = (BComp_vect_backward-BComp_vect_forward)
  Diff_BComp_arr(*,i_period)  = Diff_BComp_vect
EndFor

if i_com eq 0 then diff_Bx_arr = diff_Bcomp_arr
if i_com eq 1 then diff_By_arr = diff_Bcomp_arr
if i_com eq 2 then diff_Bz_arr = diff_Bcomp_arr
endfor

;diff_Bt_arr = Fltarr(num_times, num_periods)
;delta_Bt_arr = Fltarr(num_times, num_periods)
;sigma_Bt_vect = Fltarr(num_periods)
;For i_period=0,num_periods-1 Do Begin
;  diff_Bt_arr(*,i_period) = sqrt(diff_Bx_arr(*,i_period)^2.0+diff_By_arr(*,i_period)^2.0+diff_Bz_arr(*,i_period)^2.0)
;;  StructFunct_Bt_arr(*,i_period) = (abs(diff_Bt_arr(*,i_period)))^jieshu
;  sigma_Bt_vect(i_period) = stddev(diff_Bt_arr(*,i_period),/nan)
;  delta_Bt_arr(*,i_period) = diff_Bt_arr(*,i_period)/sigma_Bt_vect(i_period)
;endfor

file_save = 'deltaBxyz_of_'+'quan'+'.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "paper3_caculate_spy.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect,diff_Bx_arr,diff_By_arr,diff_Bz_arr



step2:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=   'deltaBxyz_of_'+'quan'+'.sav'
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
;  period_vect,diff_Bx_arr,diff_By_arr,diff_Bz_arr
;  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+'1-4'+'(time=*-*)(period=  0.4-10001).sav'
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
;;;;;;;;;分角度

;;--
num_times = N_Elements(time_vect_LBG)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi




;;--define 'theta_bin_min/max_vect'
dBx_or = diff_Bx_arr
dBy_or = diff_By_arr
dBz_or = diff_Bz_arr

;;--get 'StructFunct_Bt_theta_scale_arr'
;Btot_StructFunct_arr  = Fltarr(n_jie,num_times, num_periods)
;Bpara_StructFunct_arr  = Fltarr(n_jie,num_times, num_periods)
;Bperp_StructFunct_arr  = Fltarr(n_jie,num_times, num_periods)
Btot_2_vect = Fltarr(num_periods)
Bpara_2_vect = Fltarr(num_periods)
Bperp_2_vect = Fltarr(num_periods)
Btot_4_vect = Fltarr(num_periods)
Bpara_4_vect = Fltarr(num_periods)
Bperp_4_vect = Fltarr(num_periods)

;Btot_StructFunct_arr(i_jie,*,*) = abs(dBx_or)^jie(i_jie)+abs(dBy_or)^jie(i_jie)+abs(dBz_or)^jie(i_jie);;;;;;original or new
;Bpara_StructFunct_arr(i_jie,*,*) = abs(dBx_or*dbx_LBG_RTN_arr + dBy_or*dby_LBG_RTN_arr + dBz_or*dbz_LBG_RTN_arr)^jie(i_jie)
;Bperp_StructFunct_arr(i_jie,*,*) = (Btot_StructFunct_arr(i_jie,*,*) - Bpara_StructFunct_arr(i_jie,*,*)) / 2
for i_period = 0,num_periods-1 do begin
Btot_2_vect(i_period) = mean(abs(dBx_or(*,i_period))^2+abs(dBy_or(*,i_period))^2+abs(dBz_or(*,i_period))^2,/nan)
Bpara_2_vect(i_period) = mean(abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2,/nan)
Bperp_2_vect(i_period) = mean(((dBx_or(*,i_period)-dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period))^2+(dBy_or(*,i_period)-dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period))^2+(dBz_or(*,i_period)-dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2),/nan)
Btot_4_vect(i_period) = mean((dBx_or(*,i_period)^2+dBy_or(*,i_period)^2+dBz_or(*,i_period)^2)^2.0,/nan);mean(abs(dBx_or(*,i_period))^jie(i_jie)+abs(dBy_or(*,i_period))^jie(i_jie)+abs(dBz_or(*,i_period))^jie(i_jie),/nan)
Bpara_4_vect(i_period) = mean(abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^4,/nan)
Bperp_4_vect(i_period) = mean(((dBx_or(*,i_period)-dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period))^2+(dBy_or(*,i_period)-dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period))^2+(dBz_or(*,i_period)-dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2)^2.0,/nan)
endfor


num_theta_bins  = 90L
dtheta_bin    = 180./num_theta_bins
 
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin

StructFunct_Bpara_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
StructFunct_Bperp_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
num_DataNum_Bpara_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
num_DataNum_Bperp_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) or ((theta_arr(*,i_period) ge (180-theta_max_bin) and $
          theta_arr(*,i_period) lt (180-theta_min_bin))))      ;;;对折
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2;Btot_StructFunct_arr(*,i_period)
;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_tmp = Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
    StructFunct_Bpara_second_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
    num_DataNum_tmp = N_Elements(sub_tmp_v2)
    num_DataNum_Bpara_second_theta_scale_arr(i_theta,i_period) = num_DataNum_tmp
  EndIf
EndFor
EndFor

For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) or ((theta_arr(*,i_period) ge (180-theta_max_bin) and $
          theta_arr(*,i_period) lt (180-theta_min_bin))))      ;;;对折
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = ((dBx_or(*,i_period)-dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period))^2+(dBy_or(*,i_period)-dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period))^2+(dBz_or(*,i_period)-dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2);Btot_StructFunct_arr(*,i_period)
;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_tmp = Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
    StructFunct_Bperp_second_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
    num_DataNum_tmp = N_Elements(sub_tmp_v2)
    num_DataNum_Bperp_second_theta_scale_arr(i_theta,i_period) = num_DataNum_tmp
  EndIf
EndFor
EndFor
;;save:jie,theta,period
;Btot_StructFunct_arr = Reverse(Btot_StructFunct_arr,3)
;Bpara_StructFunct_arr = Reverse(Bpara_StructFunct_arr,3)
;Bperp_StructFunct_arr = Reverse(Bperp_StructFunct_arr,3)
;Btot_SF_vect = Reverse(Btot_SF_vect)
;Btot_SF_vect = Reverse(Btot_SF_vect)
;Btot_SF_vect = Reverse(Btot_SF_vect)
file_save = 'SF_of_'+'quan'+'_second_Bperp_Bpara_period_or_v2.sav';;orginal or new
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "paper3_caculate_spy.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect,Btot_2_vect,Bpara_2_vect,Bperp_2_vect,Btot_4_vect,Bpara_4_vect,Bperp_4_vect,theta_bin_min_vect, $
  StructFunct_Bpara_second_theta_scale_arr,StructFunct_Bperp_second_theta_scale_arr, $
  num_DataNum_Bpara_second_theta_scale_arr,num_DataNum_Bperp_second_theta_scale_arr




end


