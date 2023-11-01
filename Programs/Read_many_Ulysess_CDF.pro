;pro Read_many_Ulysess_CDF


sub_dir_date1  = 'new\19950720-29-1\'


step1:


dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_restore= 'uy_1sec_vhm_19950720-28_v01.sav'
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
;  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
;  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect

JulDay_1s_vect24 = JulDay_1s_vect
Bx_RTN_1s_vect24 = Bx_RTN_1s_vect
By_RTN_1s_vect24 = By_RTN_1s_vect
Bz_RTN_1s_vect24 = Bz_RTN_1s_vect
BMAG_RTN_1s_ARR24 = BMAG_RTN_1s_ARR
B_RTN_1s_ARR24 = B_RTN_1s_ARR


sub_dir_date2  = sub_dir_date1

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date2
file_restore= 'uy_1sec_vhm_19950729_v01.sav'
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

JulDay_1s_vect25 = JulDay_1s_vect
Bx_RTN_1s_vect25 = Bx_RTN_1s_vect
By_RTN_1s_vect25 = By_RTN_1s_vect
Bz_RTN_1s_vect25 = Bz_RTN_1s_vect
BMAG_RTN_1s_ARR25 = BMAG_RTN_1s_ARR
B_RTN_1s_ARR25 = B_RTN_1s_ARR


a1=N_elements(JulDay_1s_vect24)
a2=N_elements(JulDay_1s_vect25)
JulDay_1s_vect = dblarr(a1+a2)
JulDay_1s_vect(0:a1-1)=JulDay_1s_vect24
JulDay_1s_vect(a1:a1+a2-1)=JulDay_1s_vect25


b1=N_elements(Bx_RTN_1s_vect24)
b2=N_elements(Bx_RTN_1s_vect25)
Bx_RTN_1s_vect = dblarr(b1+b2)
Bx_RTN_1s_vect(0:b1-1)=Bx_RTN_1s_vect24
Bx_RTN_1s_vect(b1:b1+b2-1)=Bx_RTN_1s_vect25

c1=N_elements(By_RTN_1s_vect24)
c2=N_elements(By_RTN_1s_vect25)
By_RTN_1s_vect = dblarr(c1+c2)
By_RTN_1s_vect(0:c1-1)=By_RTN_1s_vect24
By_RTN_1s_vect(c1:c1+c2-1)=By_RTN_1s_vect25

d1=N_elements(Bz_RTN_1s_vect24)
d2=N_elements(Bz_RTN_1s_vect25)
Bz_RTN_1s_vect = dblarr(d1+d2)
Bz_RTN_1s_vect(0:d1-1)=Bz_RTN_1s_vect24
Bz_RTN_1s_vect(d1:d1+d2-1)=Bz_RTN_1s_vect25

e1=N_elements(BMAG_RTN_1s_ARR24)
e2=N_elements(BMAG_RTN_1s_ARR25)
BMAG_RTN_1s_ARR = dblarr(e1+e2)
BMAG_RTN_1s_ARR(0:e1-1)=BMAG_RTN_1s_ARR24
BMAG_RTN_1s_ARR(e1:e1+e2-1)=BMAG_RTN_1s_ARR25

f1=N_elements(B_RTN_1s_ARR24(0,*))
f2=N_elements(B_RTN_1s_ARR25(0,*))
B_RTN_1s_ARR = dblarr(3,f1+f2)
B_RTN_1s_ARR(0,0:f1-1)=B_RTN_1s_ARR24(0,*)
B_RTN_1s_ARR(1,0:f1-1)=B_RTN_1s_ARR24(1,*)
B_RTN_1s_ARR(2,0:f1-1)=B_RTN_1s_ARR24(2,*)
B_RTN_1s_ARR(0,f1:f1+f2-1)=B_RTN_1s_ARR25(0,*)
B_RTN_1s_ARR(1,f1:f1+f2-1)=B_RTN_1s_ARR25(1,*)
B_RTN_1s_ARR(2,f1:f1+f2-1)=B_RTN_1s_ARR25(2,*)

step2:
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_save = 'uy_1sec_vhm_19950720-29_v01.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect


End_Program:
End

;接下来进行差值，运行Read_many_ulysess_interpol


