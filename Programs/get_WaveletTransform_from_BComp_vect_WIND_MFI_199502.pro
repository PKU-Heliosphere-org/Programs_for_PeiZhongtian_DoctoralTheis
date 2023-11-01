;Pro get_WaveletTransform_from_BComp_vect_WIND_MFI_199502

;Not Wrong!!
;Not unable to allocate memory for the array in wavelet subroutine due to the large data-set

sub_dir_date  = '2002/2002-06/';'2005-03/';'1995-12-25/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore	= GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date

 file_restore= 'Bxyz_GSE_arr(time=*-*).sav'
;a file_restore= 'wi_h2_mfi_20050311_v05.sav'

file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


Step2:
;===========================
;Step2:

;;--
i_BComp	= 0
Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
	BComp_GSE_vect	= Bx_GSE_vect_interp
EndIf
If i_BComp eq 2 Then Begin
	BComp_GSE_vect	= By_GSE_vect_interp
EndIf
If i_BComp eq 3 Then Begin
	BComp_GSE_vect	= Bz_GSE_vect_interp
EndIf
wave_vect	= BComp_GSE_vect

;;--
JulDay_vect = JulDay_vect_interp
num_times	= N_Elements(JulDay_vect)
time_vect	= (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
dtime	= Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime	= num_times


;;--
BComp_vect	= wave_vect
period_min	= 0.4>(dtime*2);1.0;1.e0	;unit: s
period_max	= 1.e2;1.e3
period_range= [period_min, period_max]
num_periods = 16L
get_Wavelet_Transform_of_BComp_vect_STEREO_v3, $
		time_vect, BComp_vect, $		;input
		period_range=period_range, $	;input
		num_periods=num_periods, $
		BComp_wavlet_arr, $				;output
		time_vect_v2=time_vect_v2, $
		period_vect=period_vect


;;--
dir_save	= GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_save	= FileName_BComp+'_wavlet_arr'+$
				TimeRange_str+'.sav'
JulDay_min_v2 = Min(JulDay_vect)				
data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_MFI_199502.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_min_v2, time_vect_v2, period_vect, $
	BComp_wavlet_arr


End_Program:
End