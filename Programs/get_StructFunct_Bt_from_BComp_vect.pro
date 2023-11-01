;Pro get_StructFunct_Bt_from_BComp_vect


sub_dir_date  = 'wind\Alfven1\'



Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_20020524_v05.sav'
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
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, Bt, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, num_gapData, perce_gapData

JulDay_2s_vect = JulDay_vect;_interp

n_jie = 10
jie = findgen(n_jie)+1

i_jie = 1
;for i_jie = 0,n_jie-1 do begin

Step2:
;===========================
;Step2:

;;--
;i_BComp = 0
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
;for i_BComp = 1,3 do begin
;If i_BComp eq 1 Then FileName_BComp='Bx'
;If i_BComp eq 2 Then FileName_BComp='By'
;If i_Bcomp eq 3 Then FileName_BComp='Bz'



;;--

;If i_BComp eq 1 Then Begin
  Bx_RTN_vect  = Bx_GSE_vect_interp
;EndIf
;If i_BComp eq 2 Then Begin
  By_RTN_vect  = By_GSE_vect_interp
;EndIf
;If i_BComp eq 3 Then Begin
  Bz_RTN_vect  = Bz_GSE_vect_interp
;EndIf
;wave_vect = BComp_RTN_vect


;;--
num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times


;;--
Bx_vect  = Bx_RTN_vect
By_vect  = By_RTN_vect
Bz_vect  = Bz_RTN_vect
;a period_min = 0.8;1.0;1.e0  ;unit: s
;a period_max = 5.e3
period_min  = 6.0;0.4;6.0
period_max  = 1000;1000;1.e3;1.e3
;a period_max = 5.e3  ;for average profile
period_range= [period_min, period_max]
;a num_periods  = 48L ;for average profile
num_periods = 32L
;;;---

;;;---
is_log    = 1
Diff_Bx_arr  = Fltarr(num_times, num_periods)
Diff_By_arr  = Fltarr(num_times, num_periods)
Diff_Bz_arr  = Fltarr(num_times, num_periods)
Diff_Bt_arr  = Fltarr(num_times, num_periods)
Diff_Bcomp_arr  = Fltarr(num_times, num_periods)
jieshu = jie(i_jie)
get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, Bx_vect, By_vect, Bz_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    Bt_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_Bx_arr=Diff_Bx_arr,Diff_By_arr=Diff_By_arr,Diff_Bz_arr=Diff_Bz_arr, $
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr

;;--
num_periods = N_Elements(period_vect)
Bt_StructFunct_vect  = Fltarr(num_periods)
num_times_vect      = Lonarr(num_periods)
For i_period=0,num_periods-1 Do Begin
  Bt_StructFunct_tmp = Mean(Reform(Bt_StructFunct_arr(*,i_period)), /NaN)
  Bt_StructFunct_vect(i_period)  = Bt_StructFunct_tmp
  sub_tmp = Where(Finite(Reform(Bt_StructFunct_arr(*,i_period))) ne 0)
  num_times_tmp = N_ELements(sub_tmp)
  num_times_vect(i_period)  = num_times_tmp
EndFor


;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min  = Min(JulDay_2s_vect)
JulDay_max  = Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_version= '(v3)'
period_min_str  = String(period_min,'(F3.1)')
period_max_str  = String(period_max,'(I4.4)')
PeriodRange_str = '(period='+period_min_str+'-'+period_max_str+')'

;;;---
;a If period_max le 2.e3 Then Begin
If period_max le 5.e3 Then Begin
file_save = 'Bt'+'_StructFunct'+string(jieshu)+'_arr'+$
        TimeRange_str+$
        PeriodRange_str+$
        file_version+$
        '_h0.sav'
JulDay_min  = Min(JulDay_2s_vect)
data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min, time_vect, period_vect, $
  Bt_StructFunct_arr, $
  Bt_StructFunct_vect, $
  Diff_Bt_arr, $
  num_times_vect
EndIf



;endfor

;endfor
End_Program:
End