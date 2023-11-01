;pro Save_PSD_Bmag_time_scale_arr



sub_dir_date  = 'new\19950509-13\'


Step1:
;===========================
;Step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Bx'+'_time_scale_arr(time=*-*)'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr,$
;  theta_arr

PSD_Bx_time_scale_arr = PSD_BComp_time_scale_arr



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'By'+'_time_scale_arr(time=*-*)'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr,$
;  theta_arr

PSD_By_time_scale_arr = PSD_BComp_time_scale_arr



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Bz'+'_time_scale_arr(time=*-*)'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr,$
;  theta_arr

PSD_Bz_time_scale_arr = PSD_BComp_time_scale_arr



PSD_Bmag_time_scale_arr = PSD_Bx_time_scale_arr+PSD_By_time_scale_arr+PSD_Bz_time_scale_arr


PSD_BComp_time_scale_arr = PSD_Bmag_time_scale_arr
dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'PSD_'+'Bmag'+'_time_scale_arr(time=0-0)'+$
        '.sav'
data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  PSD_BComp_time_scale_arr,$
  theta_arr


end












