;pro get_SF_of_mag_pm_wind

sub_dir_date  = 'wind\fast\case2_v\'


num_theta_bins  = 90L
num_periods = 32



step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_20080310-14_v05.sav'
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
;  JulDay_vect, Bxyz_GSE_arr

;JulDay_vect = JulDay_vect_interp
Bx_GSE_vect = Bxyz_GSE_arr(0,*)
By_GSE_vect = Bxyz_GSE_arr(1,*)
Bz_GSE_vect = Bxyz_GSE_arr(2,*)


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_20080310-14_inB.sav'
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
;  JulDay_vect, Vxyz_GSE_p_arr, $
;  NumDens_p_vect,  Temper_p_vect

;JulDay_vect = JulDay_vect_interp
Vx_GSE_vect = Vxyz_GSE_p_arr(0,*)
Vy_GSE_vect = Vxyz_GSE_p_arr(1,*)
Vz_GSE_vect = Vxyz_GSE_p_arr(2,*)


num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)



num_periods = 24L
period_min = 3*time_lag;耗散3，惯性100
period_max = 1000*time_lag;耗散20，惯性1000
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

for i_com = 0,2 do begin
  if i_com eq 0 then Bcomp_vect = Vx_GSE_vect
  if i_com eq 1 then Bcomp_vect = vy_GSE_vect
  if i_com eq 2 then Bcomp_vect = vz_GSE_vect

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

if i_com eq 0 then diff_Vx_arr = diff_Bcomp_arr
if i_com eq 1 then diff_Vy_arr = diff_Bcomp_arr
if i_com eq 2 then diff_Vz_arr = diff_Bcomp_arr
endfor

file_save = 'deltaBxyz_of'+'.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "get_SF_of_mag_pm_wind.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect,diff_Bx_arr,diff_By_arr,diff_Bz_arr

file_save = 'deltaVxyz_of'+'.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "get_SF_of_mag_pm_wind.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect,diff_Vx_arr,diff_Vy_arr,diff_Vz_arr



step2:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=   'deltaBxyz_of'+'.sav'
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
file_restore=  'LocalBG_of_MagField(time=*-*).sav'
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








end