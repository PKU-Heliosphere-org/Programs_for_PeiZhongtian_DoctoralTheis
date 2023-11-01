;pro B_change_inV



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
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_vect, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp



;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_20020524_inB.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_vect, Vxyz_GSE_p_arr, $
;  NumDens_p_vect,  Temper_p_vect

mass_proton = 1.0
;B_G = sqrt(Bxyz_GSE_arr(0,*)^2+Bxyz_GSE_arr(1,*)^2+Bxyz_GSE_arr(2,*)^2)*10^(-5)

VAx  = 2.18e11 * mass_proton^(-1./2) * NumDens_p_vect^(-1./2) * Bx_GSE_vect_interp*1.e-5
Vba_x  = VAx/1.e5 ;unit: km/s
VAy  = 2.18e11 * mass_proton^(-1./2) * NumDens_p_vect^(-1./2) * By_GSE_vect_interp*1.e-5
Vba_y  = VAy/1.e5 ;unit: km/s
VAz  = 2.18e11 * mass_proton^(-1./2) * NumDens_p_vect^(-1./2) * Bz_GSE_vect_interp*1.e-5
Vba_z  = VAz/1.e5 ;unit: km/s


dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'wi_h0_mfi_20020524_inV.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect,  Vba_x, Vba_y, Vba_z






end













