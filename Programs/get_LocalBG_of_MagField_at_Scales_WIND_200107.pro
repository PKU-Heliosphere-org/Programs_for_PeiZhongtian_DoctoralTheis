;Pro get_LocalBG_of_MagField_at_Scales_WIND_200107

;


sub_dir_date  = 'wind\Alfven1\'


Step1:
;===========================
;Step1:

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_20020524_v05.sav'
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
;  JulDay_vect, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


Step2:
;===========================
;Step2:

;;--
num_times	= N_Elements(JulDay_vect)
time_vect	= (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
dtime	= Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime	= num_times
;;--zuhe
Bxyz_GSE_arr = fltarr(3,num_times)
Bxyz_GSE_arr(0,*) = Bx_GSE_vect_interp
Bxyz_GSE_arr(1,*) = By_GSE_vect_interp
Bxyz_GSE_arr(2,*) = Bz_GSE_vect_interp
;;--
period_min	= 3*dtime;1.0;0.3;1.0	;unit: s
period_max	= 1.e3*dtime;1.e3
period_range= [period_min, period_max]
nscale=24L
;;--
get_LocalBG_of_MagField_at_Scales_WIND_v2, $
		time_vect, Bxyz_GSE_arr, $	;input
		period_range=period_range, $	;input
		  num_scales=nscale, $         ;input
		Bxyz_LBG_RTN_arr, $		;output
	;	time_vect_v2=time_vect_v2, $	;output
		period_vect=period_vect			;output

;;--
dir_save	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min	= Min(JulDay_vect)
JulDay_max	= Max(JulDay_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str	= '(time='+$
		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save	= 'LocalBG_of_MagField'+$
				TimeRange_str+'.sav'
JulDay_min_v2	= Min(JulDay_vect)
data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_WIND_200107.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_min_v2, time_vect, period_vect, $
	Bxyz_LBG_RTN_arr    


End_Program:
End

