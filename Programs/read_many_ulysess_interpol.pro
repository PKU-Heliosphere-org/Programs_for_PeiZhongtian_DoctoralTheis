;pro Read_many_ulysess_interpol


sub_dir_date  = 'new\19950720-29-1\'


step1:


dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01.sav'
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



Step2:
;===========================
;Step3:

;;--
;a num_times  = Round(24.*3600./3.1)
num_times = Floor((Max(JulDay_1s_vect)-Min(JulDay_1s_vect))/(1.0/(24.*60*60)))   ;2s是分辨率
;a CalDat, JulDay_3s_vect(0), mon_beg, day_beg, year_beg, hour_beg, min_beg, sec_beg
;a JulDay_beg = JulDay(mon_beg, day_beg, year_beg, 0.0, 0.0, 0.0)
;a JulDay_end = JulDay(mon_beg, day_beg, year_beg, 23.0, 59.0, 59.0)
JulDay_beg  = Min(JulDay_1s_vect)
JulDay_end  = Max(JulDay_1s_vect)
JulDay_1s_vect_v3 = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)
;;;---
Bx_RTN_1s_vect_v3 = Interpol(Reform(B_RTN_1s_arr(0,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
By_RTN_1s_vect_v3 = Interpol(Reform(B_RTN_1s_arr(1,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
Bz_RTN_1s_vect_v3 = Interpol(Reform(B_RTN_1s_arr(2,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
Bmag_RTN_1s_vect_v3 = Interpol(Reform(Bmag_RTN_1s_arr(*,0)), JulDay_1s_vect, JulDay_1s_vect_v3)
B_RTN_1s_arr_v3 = Fltarr(3,num_times)
Bmag_RTN_1s_arr_v3  = Fltarr(1,num_times)
B_RTN_1s_arr_v3(0,*)  = Transpose(Bx_RTN_1s_vect_v3)
B_RTN_1s_arr_v3(1,*)  = Transpose(By_RTN_1s_vect_v3)
B_RTN_1s_arr_v3(2,*)  = Transpose(Bz_RTN_1s_vect_v3)
Bmag_RTN_1s_arr_v3(0,*) = Transpose(Bmag_RTN_1s_vect_v3)

Bx_RTN_1s_vect = Reform(B_RTN_1s_arr_v3(0,*))
By_RTN_1s_vect = Reform(B_RTN_1s_arr_v3(1,*))
Bz_RTN_1s_vect = Reform(B_RTN_1s_arr_v3(2,*))
Bmag_RTN_1s_vect = Reform(Bmag_RTN_1s_arr_v3(0,*))
;;;---
JulDay_1s_vect  = JulDay_1s_vect_v3
B_RTN_1s_arr  = B_RTN_1s_arr_v3
Bmag_RTN_1s_arr = Bmag_RTN_1s_vect_v3

;;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'uy_1sec_vhm_19950720-29_v01'+'_v'+'.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect
; JulDay_1min_vect, Bxyz_GSE_1min_arr, xyz_GSE_1min_arr


end



;接下来做小波分析，然后除去间歇Plot_LIMed_program_v1






