;pro V_chazhi_in_B   把B按V插值

date='19950906'
sub_dir_date  = 'wind\another\199509\fast\'

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
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect

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
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect

Julday_V = JulDay_2s_vect


step2:

select = 1
;read,'select B in V(0) or V in B(1):',select
;
;if select eq 0 then begin
;
;B_size = size(P_VEL_3s_arr)
;Bxyz_GSE_2s_arr_v1 = fltarr(B_size(1),B_size(2))
;
;
;Bx_GSE_v1 = Interpol(Reform(Bxyz_GSE_2s_arr(0,*)), JulDay_B, JulDay_V)
;By_GSE_v1 = Interpol(Reform(Bxyz_GSE_2s_arr(1,*)), JulDay_B, JulDay_V)
;Bz_GSE_v1 = Interpol(Reform(Bxyz_GSE_2s_arr(2,*)), JulDay_B, JulDay_V)
;
;;Btotal_GSE_2s_vect_v1 = Interpol(Reform(Bmag_GSE_2s_arr(0,*)), JulDay_B, JulDay_V)
;
;;Bmag_GSE_2s_arr_v1  = Fltarr(1,B_size(2))
;Bxyz_GSE_2s_arr_v1(0,*) = Transpose(Bx_GSE_v1)
;Bxyz_GSE_2s_arr_v1(1,*) = Transpose(By_GSE_v1)
;Bxyz_GSE_2s_arr_v1(2,*) = Transpose(Bz_GSE_v1)
;;Bmag_GSE_2s_arr_v1(0,*) = Transpose(Btotal_GSE_2s_vect_v1)
;
;Bx_GSE_2s_vect = Reform(Bxyz_GSE_2s_arr_v1(0,*))
;By_GSE_2s_vect = Reform(Bxyz_GSE_2s_arr_v1(1,*))
;Bz_GSE_2s_vect = Reform(Bxyz_GSE_2s_arr_v1(2,*))
;;Btotal_GSE_2s_vect = Reform(Bmag_GSE_2s_arr_v1(0,*))
;;;;---
;JulDay_2s_vect  = JulDay_V
;Bxyz_GSE_2s_arr = Bxyz_GSE_2s_arr_v1
;
;
;;;--
;dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
;file_save = 'wi_h0_mfi_20071113-16_inV.sav'
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr,  $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect
;
;
;endif

if select eq 1 then begin

V_size = size(Bxyz_GSE_arr)
P_VEL_3s_arr_v1 = fltarr(V_size(1),V_size(2))
;P_DEN_3s_arr_v1  = Fltarr(B_size(2))

Px_VEL_v1 = Interpol(Reform(P_VEL_3s_arr(0,*)), JulDay_V, JulDay_B)
Py_VEL_v1 = Interpol(Reform(P_VEL_3s_arr(1,*)), JulDay_V, JulDay_B)
Pz_VEL_v1 = Interpol(Reform(P_VEL_3s_arr(2,*)), JulDay_V, JulDay_B)
P_DEN_3s_arr_v1  = Interpol(P_DEN_3s_arr, JulDay_V, JulDay_B)
P_TEMP_3s_arr_v1  = Interpol(P_TEMP_3s_vect, JulDay_V, JulDay_B)
;Btotal_GSE_2s_vect_v1 = Interpol(Reform(Bmag_GSE_2s_arr(0,*)), JulDay_B, JulDay_V)


P_VEL_3s_arr_v1(0,*) = Transpose(Px_VEL_v1)
P_VEL_3s_arr_v1(1,*) = Transpose(Py_VEL_v1)
P_VEL_3s_arr_v1(2,*) = Transpose(Pz_VEL_v1)
;Bmag_GSE_2s_arr_v1(0,*) = Transpose(Btotal_GSE_2s_vect_v1)

Px_VEL_3s_vect = Reform(P_VEL_3s_arr_v1(0,*))
Py_VEL_3s_vect = Reform(P_VEL_3s_arr_v1(1,*))
Pz_VEL_3s_vect = Reform(P_VEL_3s_arr_v1(2,*))
P_DEN_3s_arr = P_DEN_3s_arr_v1
P_TEMP_3s_vect = P_TEMP_3s_arr_v1
;Btotal_GSE_2s_vect = Reform(Bmag_GSE_2s_arr_v1(0,*))
;;;---
JulDay_2s_vect  = JulDay_B
P_VEL_3s_arr = P_VEL_3s_arr_v1


;;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'wi_pm_3dp_'+date+'_inB.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr,  P_TEMP_3s_vect, $
  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect


endif




end_program:
end












