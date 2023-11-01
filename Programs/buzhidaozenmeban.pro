;pro buzhidaozenmeban






sub_dir_date  = 'wind\19950130-0203\'


Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_19950130-0203_v03.sav'
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
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect

time_v = JulDay_2s_vect
n_v = n_elements(time_v)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_19950130-0203_v05.sav'
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
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect

time_b = JulDay_2s_vect
n_b = n_elements(time_b)
sub = indgen(n_b)
time_v = time_v(sub)
P_VEL_3s_arr = P_VEL_3s_arr(*,sub)
P_DEN_3s_arr = P_DEN_3s_arr(sub)

step2:
;;--
i_BComp = 1
;Read, 'i_BComp(1/2/3 for Vx/Vy/Vz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Vx-Bx'
If i_BComp eq 2 Then FileName_BComp='Vy-By'
If i_Bcomp eq 3 Then FileName_BComp='Vz-Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0-reform(Bxyz_GSE_2s_arr(0,*))
  Bcompfan = reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0+reform(Bxyz_GSE_2s_arr(0,*))
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(1,*))*sqrt(P_DEN_3s_arr)/22.0-reform(Bxyz_GSE_2s_arr(1,*))
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(2,*))*sqrt(P_DEN_3s_arr)/22.0-reform(Bxyz_GSE_2s_arr(2,*))
EndIf
wave_vect = BComp_RTN_vect

;print,reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0
plot,JulDay_2s_vect,P_DEN_3s_arr

end

