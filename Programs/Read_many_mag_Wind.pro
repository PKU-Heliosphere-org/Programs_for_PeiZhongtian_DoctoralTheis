;pro Read_many_mag_Wind


sub_dir_date1  = 'wind\fast\case2_v\'


step1:


dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_restore= 'wi_h0_mfi_20080310-13_v05.sav'
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
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr

JulDay_vect24 = JulDay_vect
BXYZ_GSE_ARR24 = BXYZ_GSE_ARR


sub_dir_date2  = sub_dir_date1

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date2
file_restore= 'wi_h0_mfi_20080314_v05.sav'
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
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr

JulDay_vect25 = JulDay_vect
BXYZ_GSE_ARR25 = BXYZ_GSE_ARR


a1=N_elements(JulDay_vect24)
a2=N_elements(JulDay_vect25)
JulDay_vect = dblarr(a1+a2)
JulDay_vect(0:a1-1)=JulDay_vect24
JulDay_vect(a1:a1+a2-1)=JulDay_vect25



f1=N_elements(BXYZ_GSE_ARR24(0,*))
f2=N_elements(BXYZ_GSE_ARR25(0,*))
BXYZ_GSE_ARR = dblarr(3,f1+f2)
BXYZ_GSE_ARR(0,0:f1-1)=BXYZ_GSE_ARR24(0,*)
BXYZ_GSE_ARR(1,0:f1-1)=BXYZ_GSE_ARR24(1,*)
BXYZ_GSE_ARR(2,0:f1-1)=BXYZ_GSE_ARR24(2,*)
BXYZ_GSE_ARR(0,f1:f1+f2-1)=BXYZ_GSE_ARR25(0,*)
BXYZ_GSE_ARR(1,f1:f1+f2-1)=BXYZ_GSE_ARR25(1,*)
BXYZ_GSE_ARR(2,f1:f1+f2-1)=BXYZ_GSE_ARR25(2,*)

step2:
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_save = 'wi_h0_mfi_20080310-14_v05.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect, Bxyz_GSE_arr



End_Program:
End




