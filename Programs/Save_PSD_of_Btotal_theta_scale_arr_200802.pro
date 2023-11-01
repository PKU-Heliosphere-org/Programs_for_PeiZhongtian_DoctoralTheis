;Pro Save_PSD_of_Btotal_theta_scale_arr_200802


sub_dir_date  = 'new\19951119-22\'


Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore= 'PSD_'+'Bx'+'_theta_period_arr'+$
        '(time=*-*)'+'_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose

pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)

PSD_Bx_theta_scale_arr = PSD_BComp_theta_scale_arr
;;---

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore= 'PSD_'+'By'+'_theta_period_arr'+$
        '(time=*-*)'+'_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose

pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)

PSD_By_theta_scale_arr = PSD_BComp_theta_scale_arr
;;---

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore= 'PSD_'+'Bz'+'_theta_period_arr'+$
        '(time=*-*)'+'_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose

pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)

PSD_Bz_theta_scale_arr = PSD_BComp_theta_scale_arr

data_descrip = data_descrip
theta_bin_min_vect = theta_bin_min_vect
theta_bin_max_vect = theta_bin_max_vect
period_vect = period_vect

;;---

PSD_Btotal_theta_scale_arr = PSD_Bx_theta_scale_arr + PSD_By_theta_scale_arr + PSD_Bz_theta_scale_arr

Step2:
;===========================
;Step2:

;;--
PSD_BComp_theta_scale_arr = PSD_Btotal_theta_scale_arr
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date

file_save = 'PSD_'+'Btotal'+'_theta_period_arr'+$
        '(time=19961104-19961104)'+'_recon.sav'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_bin_min_vect, theta_bin_max_vect, $
  period_vect, $
  PSD_BComp_theta_scale_arr
  



End_Program:
End


