pro gass

;pro PLot_PDF
device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL
;Pro fanwavelet
sub_dir_date  = 'strong\20050127\'
;;--
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = FileName_BComp+'_wavlet_arr(time=*-*)_LIM_vect.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_vect_arr