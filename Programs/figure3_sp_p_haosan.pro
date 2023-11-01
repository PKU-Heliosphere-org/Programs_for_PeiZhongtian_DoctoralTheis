;pro figure3_sp_p_haosan




sub_dir_date = 'wind\slow\case2\'
sub_dir_date1 = 'wind\fast\case2\'



;goto,step2
Step1:;耗散区
;===========================
;Step1:

;for i_slow = 1,15 do begin


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1-5.sav'
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

;Bxyz_GSE_2s_arr = B_RTN_1s_arr
;JulDay_vect = JulDay_vect_interp



n_jie = 10
jie = (findgen(n_jie)+1)/2.0

for i_jie = 0,n_jie-1 do begin



;===========================
;Step2:

;;--
i_BComp = 0
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
for i_BComp = 1,3 do begin
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'



;;--

If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = Bx_vect
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = By_vect;By_GSE_vect_interp
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = Bz_vect;Bz_GSE_vect_interp
EndIf
wave_vect = BComp_RTN_vect


;;--
num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)

print,'time lag',time_lag
period_min = 3*time_lag;0.3
period_max = 20*time_lag;2


;;--
BComp_vect  = wave_vect ;-Mean(wave_vect,/NaN)

period_range= [period_min, period_max]

num_periods = 6L

is_log    = 1
Diff_BComp_arr  = Fltarr(num_times, num_periods)
jieshu = jie(i_jie)
get_StructFunct_of_BComp_time_scale_arr_Helios, $
    time_vect, BComp_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    BComp_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_BComp_arr=Diff_BComp_arr

;;--
num_periods = N_Elements(period_vect)
BComp_StructFunct_vect  = Fltarr(num_periods)
num_times_vect      = Lonarr(num_periods)
For i_period=0,num_periods-1 Do Begin
  BComp_StructFunct_tmp = Mean(Reform(BComp_StructFunct_arr(*,i_period)), /NaN)
  BComp_StructFunct_vect(i_period)  = BComp_StructFunct_tmp
  sub_tmp = Where(Finite(Reform(BComp_StructFunct_arr(*,i_period))) ne 0)
  num_times_tmp = N_ELements(sub_tmp)
  num_times_vect(i_period)  = num_times_tmp
EndFor


;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+FileName_BComp+'_hao_'+'_SF'+'.sav'

data_descrip= 'got from "figure3_sp_p_haosan.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  time_vect, period_vect, $
  BComp_StructFunct_arr, $
  BComp_StructFunct_vect, $
  Diff_BComp_arr, $
  num_times_vect


endfor
endfor
;endfor

step2:;惯性区

;for i_slow = 1,15 do begin


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1-5.sav'
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

;Bxyz_GSE_2s_arr = B_RTN_1s_arr
;JulDay_vect = JulDay_vect_interp



n_jie = 10
jie = (findgen(n_jie)+1)/2.0

for i_jie = 0,n_jie-1 do begin



;===========================
;Step2:

;;--
i_BComp = 0
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
for i_BComp = 1,3 do begin
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'



;;--

If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = Bx_vect;Bx_GSE_vect_interp
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = By_vect;By_GSE_vect_interp
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = Bz_vect;Bz_GSE_vect_interp
EndIf
wave_vect = BComp_RTN_vect


;;--
num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)

print,'time lag',time_lag
period_min = 50*time_lag;3
period_max = 1000*time_lag;50


;;--
BComp_vect  = wave_vect ;-Mean(wave_vect,/NaN)

period_range= [period_min, period_max]

num_periods = 6L

is_log    = 1
Diff_BComp_arr  = Fltarr(num_times, num_periods)
jieshu = jie(i_jie)
get_StructFunct_of_BComp_time_scale_arr_Helios, $
    time_vect, BComp_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    BComp_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_BComp_arr=Diff_BComp_arr

;;--
num_periods = N_Elements(period_vect)
BComp_StructFunct_vect  = Fltarr(num_periods)
num_times_vect      = Lonarr(num_periods)
For i_period=0,num_periods-1 Do Begin
  BComp_StructFunct_tmp = Mean(Reform(BComp_StructFunct_arr(*,i_period)), /NaN)
  BComp_StructFunct_vect(i_period)  = BComp_StructFunct_tmp
  sub_tmp = Where(Finite(Reform(BComp_StructFunct_arr(*,i_period))) ne 0)
  num_times_tmp = N_ELements(sub_tmp)
  num_times_vect(i_period)  = num_times_tmp
EndFor


;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+FileName_BComp+'_guan_'+'_SF'+'.sav';strcompress(string(i_slow),/remove_all)

data_descrip= 'got from "figure3_sp_p_haosan.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  time_vect, period_vect, $
  BComp_StructFunct_arr, $
  BComp_StructFunct_vect, $
  Diff_BComp_arr, $
  num_times_vect


endfor
endfor
;endfor


End_Program:
End







