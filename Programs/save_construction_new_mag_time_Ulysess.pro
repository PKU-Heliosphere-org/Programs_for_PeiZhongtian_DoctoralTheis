;pro save_construction_new_mag_time_Ulysess

sub_dir_date  = 'strong\20030126-30\'
file_read= 'uy_1sec_vhm_20030126-30_v01.sav'



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore= 'uy_1sec_vhm_20030126-30_v01.sav'
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


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = 'Bx'+'_wavlet_arr(time=*-*)_LIM_vect_ori.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_vect_arr

Bx_GSE_2s_vect = BComp_vect_arr



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = 'By'+'_wavlet_arr(time=*-*)_LIM_vect_ori.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_vect_arr

By_GSE_2s_vect = BComp_vect_arr



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = 'Bz'+'_wavlet_arr(time=*-*)_LIM_vect_ori.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_vect_arr

Bz_GSE_2s_vect = BComp_vect_arr

Bxyz_GSE_2s_arr(0,*) = Bx_GSE_2s_vect
Bxyz_GSE_2s_arr(1,*) = By_GSE_2s_vect
Bxyz_GSE_2s_arr(2,*) = Bz_GSE_2s_vect

;;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\others\'+sub_dir_date
file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'_con_ori'+'.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect
; JulDay_1min_vect, Bxyz_GSE_1min_arr, xyz_GSE_1min_arr

end



