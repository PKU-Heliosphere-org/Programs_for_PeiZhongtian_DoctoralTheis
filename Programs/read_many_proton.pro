;pro read_many_proton
;


sub_dir_date1  = 'wind\fast\case2_v\'


step1:


dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_restore= 'wi_pm_3dp_20080310-13_v03.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr

JulDay_2s_vect24 = JulDay_vect
Vxyz_GSE_p_arr24 = Vxyz_GSE_p_arr
;Py_VEL_3s_vect24 = Py_VEL_3s_vect
;Pz_VEL_3s_vect24 = Pz_VEL_3s_vect
NumDens_p_vect24 = NumDens_p_vect
;P_VEL_3s_arr24 = P_VEL_3s_arr
Temper_p_vect24 = Temper_p_vect

sub_dir_date2  = sub_dir_date1

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date2
file_restore= 'wi_pm_3dp_20080314_v03.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
;  P_TEMP_3s_vect

JulDay_2s_vect25 = JulDay_vect
Vxyz_GSE_p_arr25 = Vxyz_GSE_p_arr
;Py_VEL_3s_vect25 = Py_VEL_3s_vect
;Pz_VEL_3s_vect25 = Pz_VEL_3s_vect
NumDens_p_vect25 = NumDens_p_vect
;P_VEL_3s_arr25 = P_VEL_3s_arr
Temper_p_vect25 = Temper_p_vect

a1=N_elements(JulDay_2s_vect24)
a2=N_elements(JulDay_2s_vect25)
JulDay_vect = dblarr(a1+a2)
JulDay_vect(0:a1-1)=JulDay_2s_vect24
JulDay_vect(a1:a1+a2-1)=JulDay_2s_vect25


;b1=N_elements(Px_VEL_3s_vect24)
;b2=N_elements(Px_VEL_3s_vect25)
;Px_VEL_3s_vect = dblarr(b1+b2)
;Px_VEL_3s_vect(0:b1-1)=Px_VEL_3s_vect24
;Px_VEL_3s_vect(b1:b1+b2-1)=Px_VEL_3s_vect25
;
;b1=N_elements(Py_VEL_3s_vect24)
;b2=N_elements(Py_VEL_3s_vect25)
;Py_VEL_3s_vect = dblarr(b1+b2)
;Py_VEL_3s_vect(0:b1-1)=Py_VEL_3s_vect24
;Py_VEL_3s_vect(b1:b1+b2-1)=Py_VEL_3s_vect25
;
;b1=N_elements(Pz_VEL_3s_vect24)
;b2=N_elements(Pz_VEL_3s_vect25)
;Pz_VEL_3s_vect = dblarr(b1+b2)
;Pz_VEL_3s_vect(0:b1-1)=Pz_VEL_3s_vect24
;Pz_VEL_3s_vect(b1:b1+b2-1)=Pz_VEL_3s_vect25

e1=N_elements(NumDens_p_vect24)
e2=N_elements(NumDens_p_vect25)
NumDens_p_vect = dblarr(e1+e2)
NumDens_p_vect(0:e1-1)=NumDens_p_vect24
NumDens_p_vect(e1:e1+e2-1)=NumDens_p_vect25

f1=N_elements(Vxyz_GSE_p_arr24(0,*))
f2=N_elements(Vxyz_GSE_p_arr25(0,*))
Vxyz_GSE_p_arr = dblarr(3,f1+f2)
Vxyz_GSE_p_arr(0,0:f1-1)=Vxyz_GSE_p_arr24(0,*)
Vxyz_GSE_p_arr(1,0:f1-1)=Vxyz_GSE_p_arr24(1,*)
Vxyz_GSE_p_arr(2,0:f1-1)=Vxyz_GSE_p_arr24(2,*)
Vxyz_GSE_p_arr(0,f1:f1+f2-1)=Vxyz_GSE_p_arr25(0,*)
Vxyz_GSE_p_arr(1,f1:f1+f2-1)=Vxyz_GSE_p_arr25(1,*)
Vxyz_GSE_p_arr(2,f1:f1+f2-1)=Vxyz_GSE_p_arr25(2,*)

g1=N_elements(Temper_p_vect24)
g2=N_elements(Temper_p_vect25)
Temper_p_vect = dblarr(g1+g2)
Temper_p_vect(0:g1-1)=Temper_p_vect24
Temper_p_vect(g1:g1+g2-1)=Temper_p_vect25

step2:
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_save = 'wi_pm_3dp_20080310-14_v03.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect, Vxyz_GSE_p_arr, $
  NumDens_p_vect,  Temper_p_vect


End_Program:
End
