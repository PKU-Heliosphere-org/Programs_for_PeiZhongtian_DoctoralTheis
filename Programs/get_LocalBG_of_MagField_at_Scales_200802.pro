;Pro get_LocalBG_of_MagField_at_Scales_200802

IMPACT_Data_Dir = 'IMPACT_Data_Dir=/Work/Data Analysis/IMPACT data process/Data/'
IMPACT_Figure_Dir = 'IMPACT_Figure_Dir=/Work/Data Analysis/IMPACT data process/Figures/'
SetEnv, IMPACT_Data_Dir
SetEnv, IMPACT_Figure_Dir

sub_dir_date  = '2008-02/'


Step1:
;===========================
;Step1:

;;--
dir_restore	= GetEnv('IMPACT_Data_Dir')+''+sub_dir_date
file_restore= 'STA_L1_MAG_RTN_????????_V03.sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_IMPACT_MAG_RNT_CDF_200802.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_vect, Bxyzt_RTN_arr


Step2:
;===========================
;Step2:

;;--
num_times	= N_Elements(JulDay_vect)
time_vect	= (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
dtime	= Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime	= num_times

;;--
period_min	= 0.3;1.0;0.3;1.0	;unit: s
period_max	= 1.e2;1.e3
period_range= [period_min, period_max]
num_periods = 16L

;;--
is_wavelet_1_or_2	= 1
Print, 'is_wavelet_1_or_2(no-segmentation/segmentation): ', is_wavelet_1_or_2
is_continue	= ' '
Read, 'is_continue: ', is_continue
If is_wavelet_1_or_2 eq 2 Then Begin
	get_LocalBG_of_MagField_at_Scales, $
		time_vect, Bxyzt_RTN_arr, $	;input
		period_range=period_range, $	;input
		num_periods=num_periods, $
		Bxyz_LBG_RTN_arr, $		;output
		time_vect_v2=time_vect_v2, $	;output
		period_vect=period_vect			;output
EndIf Else Begin
If is_wavelet_1_or_2 eq 1 Then Begin
	get_LocalBG_of_MagField_at_Scales_STEREO_v2, $
		time_vect, Bxyzt_RTN_arr, $	;input
		period_range=period_range, $	;input
    num_periods=num_periods, $ ;input
		Bxyz_LBG_RTN_arr, $		;output
		time_vect_v2=time_vect_v2, $	;output
		period_vect=period_vect			;output
EndIf
EndElse

;;--
dir_save	= GetEnv('IMPACT_Data_Dir')+''+sub_dir_date
JulDay_min	= Min(JulDay_vect)
JulDay_max	= Max(JulDay_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str	= '(time='+$
		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_version= '(v2)'
file_save	= 'LocalBG_of_MagField'+$
				TimeRange_str+file_version+'.sav'
JulDay_min_v2	= Min(JulDay_vect)
data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_min_v2, time_vect_v2, period_vect, $
	Bxyz_LBG_RTN_arr


End_Program:
End

