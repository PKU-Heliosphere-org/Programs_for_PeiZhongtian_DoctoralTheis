;Pro get_StructFunct_from_BComp_vect_Helios_19760307

;Not Wrong!!
;Not unable to allocate memory for the array in wavelet subroutine due to the large data-set


sub_dir_date  = 'new\19950720-29-1\'



Step1:
;===========================
;Step1:




;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01_recon.sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
;  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect

Bxyz_GSE_2s_arr = B_RTN_1s_arr
JulDay_2s_vect = JulDay_1s_vect




n_jie = 14
jie = (findgen(n_jie)+1)/2.0

for i_jie = 0,n_jie-1 do begin

Step2:
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
  BComp_RTN_vect  = reform(Bxyz_GSE_2s_arr(0,*))
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(Bxyz_GSE_2s_arr(1,*))
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(Bxyz_GSE_2s_arr(2,*))
EndIf
wave_vect = BComp_RTN_vect


;;--
num_times	= N_Elements(JulDay_2s_vect)
time_vect	= (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime	= Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime	= num_times


;;--
BComp_vect	= wave_vect	;-Mean(wave_vect,/NaN)
;a period_min	= 0.8;1.0;1.e0	;unit: s
;a period_max	= 5.e3
period_min	= 6.0;
period_max	= 2.e3;1.e3
;a period_max	= 5.e3	;for average profile
period_range= [period_min, period_max]
;a num_periods	= 48L	;for average profile
num_periods	= 32L
;;;---
;Print, 'For curve-fitting with merged data: '
;Print, 'period_max=5.e3, num_periods=48L'
;Print, 'For distribution-fitting with single data: '
;Print, 'period_max=1.e3, num_periods=32L'
;Print, 'Current period_max, num_periods: ', period_max, num_periods
;is_continue	= ' '
;Read, 'is_continue: ', is_continue
;;;---
is_log		= 1
Diff_BComp_arr	= Fltarr(num_times, num_periods)
jieshu = jie(i_jie)
get_StructFunct_of_BComp_time_scale_arr_Helios, $
		time_vect, BComp_vect, $		;input
		jieshu,                   $       ;input
		period_range=period_range, $	;input
		num_periods=num_periods, is_log=is_log, $	;input
		BComp_StructFunct_arr, $			;output
		period_vect=period_vect, $
		Diff_BComp_arr=Diff_BComp_arr

;;--
num_periods	= N_Elements(period_vect)
BComp_StructFunct_vect	= Fltarr(num_periods)
num_times_vect			= Lonarr(num_periods)
For i_period=0,num_periods-1 Do Begin
	BComp_StructFunct_tmp	= Mean(Reform(BComp_StructFunct_arr(*,i_period)), /NaN)
	BComp_StructFunct_vect(i_period)	= BComp_StructFunct_tmp
	sub_tmp	= Where(Finite(Reform(BComp_StructFunct_arr(*,i_period))) ne 0)
	num_times_tmp	= N_ELements(sub_tmp)
	num_times_vect(i_period)	= num_times_tmp
EndFor


;;--
dir_save	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min	= Min(JulDay_2s_vect)
JulDay_max	= Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str	= '(time='+$
		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_version= '(v3)'
period_min_str	= String(period_min,'(F3.1)')
period_max_str	= String(period_max,'(I4.4)')
PeriodRange_str	= '(period='+period_min_str+'-'+period_max_str+')'

;;;---
;a If period_max le 2.e3 Then Begin
If period_max le 5.e3 Then Begin
file_save	= FileName_BComp+'_StructFunct'+string(jieshu)+'_arr'+$
				TimeRange_str+$
				PeriodRange_str+$
				file_version+$
				'_recon.sav'
JulDay_min	= Min(JulDay_2s_vect)
data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_min, time_vect, period_vect, $
	BComp_StructFunct_arr, $
	BComp_StructFunct_vect, $
	Diff_BComp_arr, $
	num_times_vect
EndIf

;;;;---
;file_save	= FileName_BComp+'_StructFunct'+string(jieshu)+'_scale_vect'+$
;				TimeRange_str+$
;				PeriodRange_str+$
;				file_version+$
;				'.sav'
;JulDay_min	= Min(JulDay_2s_vect)
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min, time_vect, period_vect, $
;	BComp_StructFunct_vect, $
;	num_times_vect

endfor
endfor
End_Program:
End