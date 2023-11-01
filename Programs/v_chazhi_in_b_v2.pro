;pro V_chazhi_in_B_v2   ;把B按V插值

date='20020524'
sub_dir_date  = 'wind\Alfven1\'

Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_'+date+'_v05.sav'
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

Julday_B = JulDay_vect


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_v03.sav'
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
;  JulDay_vect, Vx_GSE_vect, Vy_GSE_vect, Vz_GSE_vect, NumDens_p_vect, Temper_p_vect

Julday_V = JulDay_vect


step2:

select = 1


if select eq 1 then begin

V_size = size(Bx_GSE_vect_interp)
Vxyz_GSE_p_arr_v1 = fltarr(3,V_size(1))
;P_DEN_3s_arr_v1  = Fltarr(B_size(2))

Px_VEL_v1 = Interpol(Vx_GSE_vect, JulDay_V, JulDay_B)
Py_VEL_v1 = Interpol(Vy_GSE_vect, JulDay_V, JulDay_B)
Pz_VEL_v1 = Interpol(Vz_GSE_vect, JulDay_V, JulDay_B)
NumDens_p_vect_v1  = Interpol(NumDens_p_vect, JulDay_V, JulDay_B)
Temper_p_vect_v1 = Interpol(Temper_p_vect, JulDay_V, JulDay_B)
;Temper_p_vect_v1  = Interpol(Temper_p_vect, JulDay_V, JulDay_B)
;Btotal_GSE_2s_vect_v1 = Interpol(Reform(Bmag_GSE_2s_arr(0,*)), JulDay_B, JulDay_V)


Vxyz_GSE_p_arr_v1(0,*) = Transpose(Px_VEL_v1)
Vxyz_GSE_p_arr_v1(1,*) = Transpose(Py_VEL_v1)
Vxyz_GSE_p_arr_v1(2,*) = Transpose(Pz_VEL_v1)
;Bmag_GSE_2s_arr_v1(0,*) = Transpose(Btotal_GSE_2s_vect_v1)

;Px_VEL_3s_vect = Reform(Vxyz_GSE_p_arr_v1(0,*))
;Py_VEL_3s_vect = Reform(Vxyz_GSE_p_arr_v1(1,*))
;Pz_VEL_3s_vect = Reform(Vxyz_GSE_p_arr_v1(2,*))
NumDens_p_vect = NumDens_p_vect_v1
Temper_p_vect = Temper_p_vect_v1
;Btotal_GSE_2s_vect = Reform(Bmag_GSE_2s_arr_v1(0,*))
;;;---
JulDay_vect  = JulDay_B
Vxyz_GSE_p_arr = Vxyz_GSE_p_arr_v1


;;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'wi_pm_3dp_'+date+'_inB.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect, Vxyz_GSE_p_arr, $
  NumDens_p_vect, Temper_p_vect


endif




end_program:
end












