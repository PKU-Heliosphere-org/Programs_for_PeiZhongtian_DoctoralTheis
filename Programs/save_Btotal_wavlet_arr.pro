;pro save_Btotal_vect_arr保存总的磁场，目的来看PDF
sub_dir_date  = 'strong\20030126-30\'

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

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = 'Bx'+'_wavlet_arr(time=*-*)_LIM_vect_ori.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_vect_arr
Bx_vect_arr = BComp_vect_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = 'By'+'_wavlet_arr(time=*-*)_LIM_vect_ori.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_vect_arr
By_vect_arr = BComp_vect_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = 'Bz'+'_wavlet_arr(time=*-*)_LIM_vect_ori.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_vect_arr
Bz_vect_arr = BComp_vect_arr

n = size(Bz_vect_arr)

;Btotal_vect_arr = fltarr(n)
;for i=0,n-1 do begin
  Btotal_vect_arr = sqrt(Bx_vect_arr^2+By_vect_arr^2+Bz_vect_arr^2)
;endfor

Bcomp_vect_arr = Btotal_vect_arr

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_save = 'Btotal'+'_wavlet_arr'+$
        '(time=0-0)_LIM_vect_ori'+'.sav'
data_descrip= 'got from "save_Btotal_vect_arr.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  time_vect_v2, period_vect, $
  Bcomp_vect_arr
  
  
end











