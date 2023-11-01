;pro Read_some_data

;dater = '20071113-16'
date = '19950906'
sub_dir_date  = 'wind\another\199509\fast\'

read,'select mag(0) or vel(1):', sele

if sele eq 0 then begin
  
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
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR
JulDay_2s_vect = JulDay_vect
BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR
step2:

i=size(JulDay_2s_vect,/dimensions)
time = fltarr(i)
second=fltarr(i)
hour=fltarr(i)
time = JulDay_2s_vect-long(JulDay_2s_vect(0))-0.5
second = time*86400.0
hour= time*24
read,'begin hour(0-24):',hour_beg
read,'end hour(0-24):',hour_end
index = where(hour LT hour_end and hour GT hour_beg);;

Bx_GSE_2s_vect = reform(BXYZ_GSE_2S_ARR(0,*))
By_GSE_2s_vect = reform(BXYZ_GSE_2S_ARR(1,*))
Bz_GSE_2s_vect = reform(BXYZ_GSE_2S_ARR(2,*))
JulDay_2s_vect = JulDay_2s_vect(index)
Bx_GSE_2s_vect = Bx_GSE_2s_vect(index)
By_GSE_2s_vect = By_GSE_2s_vect(index)
Bz_GSE_2s_vect = Bz_GSE_2s_vect(index)
;BMAG_GSE_2S_ARR = BMAG_GSE_2S_ARR(index)
j = size(Bx_GSE_2s_vect,/dimensions)
Bxyz_GSE_2s_arr = fltarr(3,j(0))
BXYZ_GSE_2S_ARR(0,*) = Bx_GSE_2s_vect
BXYZ_GSE_2S_ARR(1,*) = By_GSE_2s_vect
BXYZ_GSE_2S_ARR(2,*) = BZ_GSE_2s_vect
;Btotal_GSE_2s_vect = Btotal_GSE_2s_vect(index)


JulDay_vect = JulDay_2s_vect
BXYZ_GSE_ARR = BXYZ_GSE_2s_ARR
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'wi_h0_mfi_'+date+'_v05.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect, Bxyz_GSE_arr
  


endif


if sele eq 1 then begin
  
Step3:
;===========================
;Step1:


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_v03.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect
;  P_TEMP_3s_vect

step4:

i=size(JulDay_2s_vect,/dimensions)
time = fltarr(i)
second=fltarr(i)
hour=fltarr(i)
time = JulDay_2s_vect-long(JulDay_2s_vect(0))-0.5
second = time*86400.0
hour= time*24.0

read,'begin hour(0-24):',hour_beg
read,'end hour(0-24):',hour_end
index = where(hour LT hour_end and hour GT hour_beg);;

JulDay_2s_vect = JulDay_2s_vect(index)
Px_VEL_3s_vect = Px_VEL_3s_vect(index)
Py_VEL_3s_vect = Py_VEL_3s_vect(index)
Pz_VEL_3s_vect = Pz_VEL_3s_vect(index)
P_TEMP_3s_vect = P_TEMP_3s_vect(index)
P_DEN_3s_arr = P_DEN_3s_arr(index)
j = size(Pz_VEL_3s_vect,/dimensions)
P_VEL_3s_arr = fltarr(3,j(0))
P_VEL_3s_arr(0,*) = Px_VEL_3s_vect
P_VEL_3s_arr(1,*) = Py_VEL_3s_vect
P_VEL_3s_arr(2,*) = Pz_VEL_3s_vect
P_DEN_3s_vect = P_DEN_3s_vect(index)

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'wi_pm_3dp_'+date+'_v03.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
  P_TEMP_3s_vect



endif


  
End_Program:
End











