;pro poster_get_deltaB_sigma_15day



sub_dir_date  = 'wind\fast\case1\'


num_theta_bins  = 90L
num_periods = 32
n_cell = 60.    
  min_vect = (findgen(n_cell)/n_cell-0.5)*60
  max_vect = ((findgen(n_cell)+1)/n_cell-0.5)*60;;[-30,30]1

datanum_bin_15 = fltarr(15,num_theta_bins,num_periods,n_cell)+!values.f_nan
mean_Bt_15 = fltarr(15,num_theta_bins,num_periods,n_cell)+!values.f_nan
datanum_bin = fltarr(num_theta_bins,num_periods,n_cell)+!values.f_nan
mean_Bt = fltarr(num_theta_bins,num_periods,n_cell)+!values.f_nan
second_moment = fltarr(num_theta_bins,num_periods,n_cell)+!values.f_nan
fourth_moment = fltarr(num_theta_bins,num_periods,n_cell)+!values.f_nan
flatness_theta_arr = fltarr(num_theta_bins,num_periods,n_cell)+!values.f_nan

for i = 1,15 do begin

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i),/remove_all)+'_v.sav'
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
;   JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp

JulDay_vect = JulDay_vect_interp
Bx_GSE_vect = Bx_GSE_vect_interp
By_GSE_vect = By_GSE_vect_interp
Bz_GSE_vect = Bz_GSE_vect_interp

i_slow = i

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_slow),/remove_all)+'(time=*-*)(period=*-*).sav'
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

jieshu=1
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

diff_Bt_arr = Fltarr(num_times, num_periods)
delta_Bt_arr = Fltarr(num_times, num_periods)
sigma_Bt_vect = Fltarr(num_periods)
For i_period=0,num_periods-1 Do Begin
  diff_Bt_arr(*,i_period) = sqrt(diff_Bx_arr(*,i_period)^2.0+diff_By_arr(*,i_period)^2.0+diff_Bz_arr(*,i_period)^2.0)
;  StructFunct_Bt_arr(*,i_period) = (abs(diff_Bt_arr(*,i_period)))^jieshu
  sigma_Bt_vect(i_period) = stddev(diff_Bt_arr(*,i_period),/nan)
  delta_Bt_arr(*,i_period) = diff_Bt_arr(*,i_period)/sigma_Bt_vect(i_period)
endfor

;;;;;;;;;分角度
num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi



dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin
theta_vect = theta_bin_min_vect

;Flatness_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
for i_cell=0,n_cell-1 do begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)

  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  sub_cell = where(delta_Bt_arr(*,i_period) ge min_vect(i_cell) and $
          delta_Bt_arr(*,i_period) lt max_vect(i_cell))  
  sub_jiao = setintersection(sub_tmp,sub_cell)     ;;;;求交集   
  If sub_jiao(0) ne -1 Then Begin
 ;   flatness_vect_tmp  = flat(*,i_period)
 ;   flatness_tmp = mean(flatness_vect_tmp(sub_tmp),/nan)
 ;   flatness_mean_15(i_slow-1,i_theta,i_period) = flatness_tmp
     datanum_bin_15(i-1,i_theta,i_period,i_cell) = n_elements(sub_jiao)
     mean_Bt_15(i-1,i_theta,i_period,i_cell) = mean(delta_Bt_arr(sub_jiao,i_period),/nan)
 ;    flatness_mean_15(i-1,i_theta,i_period) = mean(fourth_moment(sub_tmp,i_period),/nan)/mean(sec_moment(sub_tmp,i_period),/nan)^2
  EndIf
EndFor
EndFor
endfor

endfor

For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
for i_cell=0,n_cell-1 do begin
  datanum_bin(i_theta,i_period,i_cell) = total(datanum_bin_15(*,i_theta,i_period,i_cell),/nan)
  mean_Bt(i_theta,i_period,i_cell) = total(datanum_bin_15(*,i_theta,i_period,i_cell)*mean_Bt_15(*,i_theta,i_period,i_cell),/nan)/datanum_bin(i_theta,i_period,i_cell)
EndFor
EndFor
endfor


file_save ='N_sigma_deltaB.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
data_descrip= 'got from "Figure1_nation_intermittency.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect,min_vect,max_vect,theta_vect, $
  datanum_bin, mean_Bt,sigma_Bt_vect







;endfor





end











