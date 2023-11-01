;Pro get_LocalBG_of_MagField_at_Scales_WIND_MFI_199502

sub_dir_date  = '2002/2002-06/';'2005-03/';'1995-12-25/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date

 file_restore= 'Bxyz_GSE_arr(time=*-*).sav'
;a file_restore= 'wi_h2_mfi_20050311_v05.sav'

file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


Step2:
;===========================
;Step2:

;;--
JulDay_vect = JulDay_vect_interp
num_times = N_Elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

;;--
Bxyz_GSE_arr  = Fltarr(3, num_times)
Bxyz_GSE_arr(0,*) = Transpose(Bx_GSE_vect_interp)
Bxyz_GSE_arr(1,*) = Transpose(By_GSE_vect_interp)
Bxyz_GSE_arr(2,*) = Transpose(Bz_GSE_vect_interp)

;;--
period_min  = 0.4>(dtime*2);1.0;1.e0  ;unit: s
period_max  = 1.e2;1.e3
period_range= [period_min, period_max]
num_periods = 16L
;;--
get_LocalBG_of_MagField_at_Scales_WIND_MFI, $
		time_vect, Bxyz_GSE_arr, $	;input
		period_range=period_range, $	;input
    num_periods=num_periods, $ ;input
		Bxyz_LBG_GSE_arr, $		;output
		time_vect_v2=time_vect_v2, $	;output
		period_vect=period_vect			;output


;;--
dir_save	= GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_version= ''
file_save	= 'LocalBG_of_MagField'+$
				TimeRange_str+file_version+'.sav'
JulDay_min_v2	= Min(JulDay_vect)
data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_min_v2, time_vect_v2, period_vect, $
	Bxyz_LBG_GSE_arr


End_Program:
End

