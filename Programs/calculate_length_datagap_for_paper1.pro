;pro calculate_length_datagap_for_paper1


sub_dir_date1  = 'new\19950720-29-1\'


step1:


dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_restore= '1-9_datagap.sav'
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
;  JulDay_1s_vect, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, $
;  JulDay_length_dataGap_vect, num_gappoints, num_gapData, beg_gap, end_gap

print,JulDay_length_dataGap_vect*86400.,beg_gap*86400.,end_gap*86400.
JulDay_length_dataGap_vect1 = JulDay_length_dataGap_vect
beg_gap1 = beg_gap
end_gap1 = end_gap


sub_dir_date2  = sub_dir_date1

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date2
file_restore= '10_datagap.sav'
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
;  JulDay_1s_vect, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, $
;  JulDay_length_dataGap_vect, num_gappoints, num_gapData, beg_gap, end_gap

print,JulDay_length_dataGap_vect*86400.,beg_gap*86400.,end_gap*86400.
JulDay_length_dataGap_vect2 = JulDay_length_dataGap_vect
beg_gap2 = beg_gap
end_gap2 = end_gap


a1=N_elements(JulDay_length_dataGap_vect1)
a2=N_elements(JulDay_length_dataGap_vect2)
JulDay_length_dataGap_vect = dblarr(a1+a2+1)
JulDay_length_dataGap_vect(0:a1-1)=JulDay_length_dataGap_vect1
JulDay_length_dataGap_vect(a1+1:a1+a2)=JulDay_length_dataGap_vect2
beg_gap = beg_gap1
JulDay_length_dataGap_vect(a1) = end_gap1+beg_gap2
end_gap = end_gap2



step2:
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date1
file_save = '1-10_datagap.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_length_dataGap_vect, beg_gap, end_gap

print,JulDay_length_dataGap_vect*86400.,beg_gap*86400.,end_gap*86400.

End_Program:
End










