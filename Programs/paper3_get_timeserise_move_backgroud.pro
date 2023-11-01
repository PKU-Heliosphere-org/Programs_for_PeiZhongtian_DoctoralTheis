;pro paper3_get_timeserise_move_backgroud


sub_dir_date  = 'wind\Alfven_v\'


;for i_slow = 1,15 do begin

;step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h2_mfi_2002052425_v05_17301800p5.sav'
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

JulDay_vect = JulDay_vect_interp;JulDay_vect
Bx_GSE_vect = Bx_GSE_vect_interp;Bx_vect
By_GSE_vect = By_GSE_vect_interp;By_vect
Bz_GSE_vect = Bz_GSE_vect_interp;Bz_vect

num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)

for i_qu = 3,3 do begin
  if i_qu eq 0 then begin
   quyu = 'haosan'

num_periods = 7
period_min = 4*time_lag;耗散4，惯性100
period_max = 16*time_lag;耗散20，惯性1000
period_range = [period_min,period_max]
is_log = 0
endif
  if i_qu eq 2 then begin
   quyu = 'guanxing'

num_periods = 10
period_min = 100*time_lag;耗散3，惯性100
period_max = 1000*time_lag;耗散20，惯性1000
period_range = [period_min,period_max]
is_log = 0
endif
  if i_qu eq 1 then begin
   quyu = 'guodu'

num_periods = 7
period_min = 16*time_lag;耗散4，惯性100
period_max = 100*time_lag;耗散20，惯性1000
period_range = [period_min,period_max]
is_log = 0
endif
  if i_qu eq 3 then begin
   quyu = 'quan'
num_periods = 12
period_min = 4*time_lag;耗散4，惯性100
period_max = 1000*time_lag;耗散20，惯性1000
period_range = [period_min,period_max]
is_log = 1
endif

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
window_vect = 5.*period_vect


Bx_new_arr = Fltarr(num_times, num_periods)
By_new_arr = Fltarr(num_times, num_periods)
Bz_new_arr = Fltarr(num_times, num_periods)

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




BComp_new_arr = Fltarr(num_times, num_periods)+!values.f_nan
BComp_bg_arr  = Fltarr(num_times, num_periods)+!values.f_nan
dBComp_or  = Fltarr(num_times, num_periods)+!values.f_nan
dBComp_bg  = Fltarr(num_times, num_periods)+!values.f_nan
dBComp_new  = Fltarr(num_times, num_periods)+!values.f_nan

For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
;  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
;  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)

  If (pix_shift ge 1) Then Begin
;    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
;    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan  
  for i_time = 5*pix_shift,num_times-5*pix_shift-1 do begin
    BComp_bg_arr(i_time,i_period) = mean(BComp_vect(i_time-5*pix_shift:i_time+5*pix_shift),/nan)
    BComp_new_arr(i_time,i_period) = BComp_vect(i_time)-BComp_bg_arr(i_time,i_period)  
  EndFor
  for i_time = 6*pix_shift,num_times-6*pix_shift-1 do begin
    dBComp_bg(i_time,i_period) = (BComp_bg_arr(i_time-pix_shift,i_period) - BComp_bg_arr(i_time+pix_shift,i_period))
    dBComp_new(i_time,i_period) = (BComp_new_arr(i_time-pix_shift,i_period) - BComp_new_arr(i_time+pix_shift,i_period))
  endfor
  endif
;  dBComp_or(*,i_period) = abs(BComp_vect_backward-BComp_vect_forward)
endfor
if i_com eq 0 then begin
Diff_Bx_arr = Diff_BComp_arr
Bx_new_arr = BComp_new_arr
Bx_bg_arr = BComp_bg_arr
;dBx_or = dBComp_or
dBx_new = dBComp_new
dBx_bg = dBComp_bg
endif
if i_com eq 1 then begin
Diff_By_arr = Diff_BComp_arr
By_new_arr = BComp_new_arr
By_bg_arr = BComp_bg_arr
;dBy_or = dBComp_or
dBy_new = dBComp_new
dBy_bg = dBComp_bg
endif
if i_com eq 2 then begin
Diff_Bz_arr = Diff_BComp_arr
Bz_new_arr = BComp_new_arr
Bz_bg_arr = BComp_bg_arr
;dBz_or = dBComp_or
dBz_new = dBComp_new
dBz_bg = dBComp_bg
endif
endfor

;StructFunct_Bt_arr = Fltarr(num_times, num_periods)
;For i_period=0,num_periods-1 Do Begin
;  diff_Bt_arr(*,i_period) = sqrt(diff_Bx_arr(*,i_period)^2.0+diff_By_arr(*,i_period)^2.0+diff_Bz_arr(*,i_period)^2.0)
;  StructFunct_Bt_arr(*,i_period) = (abs(diff_Bt_arr(*,i_period)))^jieshu
;endfor

n_jie = 10;;;
jie = (findgen(n_jie)+1)/2.0

Bx_o = fltarr(n_jie,num_periods)
By_o = fltarr(n_jie,num_periods)
Bz_o = fltarr(n_jie,num_periods)
Bt_o = fltarr(n_jie,num_periods)
Bx_SF = fltarr(n_jie,num_periods)
By_SF = fltarr(n_jie,num_periods)
Bz_SF = fltarr(n_jie,num_periods)
Bt_SF = fltarr(n_jie,num_periods)
Bx_SF_bg = fltarr(n_jie,num_periods)
By_SF_bg = fltarr(n_jie,num_periods)
Bz_SF_bg = fltarr(n_jie,num_periods)
Bt_SF_bg = fltarr(n_jie,num_periods)

for i_period = 0,num_periods-1 do begin
for i_jie = 0,n_jie-1 do begin
  Bx_o(i_jie,i_period) = mean(abs(Diff_Bx_arr(*,i_period))^jie(i_jie),/nan)
  By_o(i_jie,i_period) = mean(abs(Diff_By_arr(*,i_period))^jie(i_jie),/nan)
  Bz_o(i_jie,i_period) = mean(abs(Diff_Bz_arr(*,i_period))^jie(i_jie),/nan)   
  
  
  Bx_sF(i_jie,i_period) = mean(abs(dBx_new(*,i_period))^jie(i_jie),/nan)
  By_sF(i_jie,i_period) = mean(abs(dBy_new(*,i_period))^jie(i_jie),/nan)
  Bz_sF(i_jie,i_period) = mean(abs(dBz_new(*,i_period))^jie(i_jie),/nan)  
   
  Bx_sF_bg(i_jie,i_period) = mean(abs(dBx_bg(*,i_period))^jie(i_jie),/nan)
  By_sF_bg(i_jie,i_period) = mean(abs(dBy_bg(*,i_period))^jie(i_jie),/nan)
  Bz_sF_bg(i_jie,i_period) = mean(abs(dBz_bg(*,i_period))^jie(i_jie),/nan)
endfor
endfor  
Bt_o = Bx_o+By_o+Bz_o
Bt_SF = Bx_SF+By_SF+Bz_SF
Bt_SF_bg = Bx_SF_bg+By_SF_bg+Bz_SF_bg


file_save ='p5_'+quyu+'_SF.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
data_descrip= 'got from "Figure1_nation_intermittency.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect, $
  Bt_o,Bt_SF,Bt_SF_bg, dBx_new, dBy_new, dBz_new, Diff_Bx_arr, Diff_By_arr, Diff_Bz_arr


endfor




;endfor





end





