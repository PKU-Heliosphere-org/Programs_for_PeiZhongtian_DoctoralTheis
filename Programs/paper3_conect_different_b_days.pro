;pro paper3_conect_different_B_days



sub_dir_date = 'wind\fast\case7\';;;
;sub_dir_date1 = 'wind\fast\case1\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1'+'_v.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

JulDay_vect1 = JulDay_vect_interp
Bx_vect1 = Bx_GSE_vect_interp
By_vect1 = By_GSE_vect_interp
Bz_vect1 = Bz_GSE_vect_interp
num_times1 = n_elements(JulDay_vect1)
time_vect1 = (JulDay_vect1(0:num_times1-1)-JulDay_vect1(0))*(24.*60.*60.)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '2'+'_v.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

JulDay_vect2 = JulDay_vect_interp
Bx_vect2 = Bx_GSE_vect_interp
By_vect2 = By_GSE_vect_interp
Bz_vect2 = Bz_GSE_vect_interp
num_times2 = n_elements(JulDay_vect2)
time_vect2 = (JulDay_vect2(0:num_times2-1)-JulDay_vect2(0))*(24.*60.*60.)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '3'+'_v.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

JulDay_vect3 = JulDay_vect_interp
Bx_vect3 = Bx_GSE_vect_interp
By_vect3 = By_GSE_vect_interp
Bz_vect3 = Bz_GSE_vect_interp
num_times3 = n_elements(JulDay_vect3)
time_vect3 = (JulDay_vect3(0:num_times3-1)-JulDay_vect3(0))*(24.*60.*60.)

;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= '4'+'_v.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;;Save, FileName=dir_save+file_save, $
;;    data_descrip, $
;;    TimeRange_str, $
;;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect
;
;JulDay_vect4 = JulDay_vect_interp
;Bx_vect4 = Bx_GSE_vect_interp
;By_vect4 = By_GSE_vect_interp
;Bz_vect4 = Bz_GSE_vect_interp
;num_times4 = n_elements(JulDay_vect4)
;time_vect4 = (JulDay_vect4(0:num_times4-1)-JulDay_vect4(0))*(24.*60.*60.)
;
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= '5'+'_v.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;;Save, FileName=dir_save+file_save, $
;;    data_descrip, $
;;    TimeRange_str, $
;;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect
;
;JulDay_vect5 = JulDay_vect_interp
;Bx_vect5 = Bx_GSE_vect_interp
;By_vect5 = By_GSE_vect_interp
;Bz_vect5 = Bz_GSE_vect_interp
;num_times5 = n_elements(JulDay_vect5)
;time_vect5 = (JulDay_vect5(0:num_times5-1)-JulDay_vect5(0))*(24.*60.*60.)

;;;接数据
n1 = n_elements(time_vect1)
n2 = n_elements(time_vect2)
n3 = n_elements(time_vect3)
;n4 = n_elements(time_vect4)
;n5 = n_elements(time_vect5)




JulDay_vect = dblarr(n1+n2+n3);+n4+n5)
JulDay_vect(0:(n1-1)) = JulDay_vect1
JulDay_vect(n1:(n1+n2-1)) = JulDay_vect2
JulDay_vect((n1+n2):(n1+n2+n3-1)) = JulDay_vect3
;JulDay_vect((n1+n2+n3):(n1+n2+n3+n4-1)) = JulDay_vect4
;JulDay_vect((n1+n2+n3+n4):(n1+n2+n3+n4+n5-1)) = JulDay_vect5

Bx_vect = fltarr(n1+n2+n3);+n4+n5)
Bx_vect(0:(n1-1)) = Bx_vect1
Bx_vect(n1:(n1+n2-1)) = Bx_vect2
Bx_vect((n1+n2):(n1+n2+n3-1)) = Bx_vect3
;Bx_vect((n1+n2+n3):(n1+n2+n3+n4-1)) = Bx_vect4
;Bx_vect((n1+n2+n3+n4):(n1+n2+n3+n4+n5-1)) = Bx_vect5

By_vect = fltarr(n1+n2+n3);+n4+n5)
By_vect(0:(n1-1)) = By_vect1
By_vect(n1:(n1+n2-1)) = By_vect2
By_vect((n1+n2):(n1+n2+n3-1)) = By_vect3
;By_vect((n1+n2+n3):(n1+n2+n3+n4-1)) = By_vect4
;By_vect((n1+n2+n3+n4):(n1+n2+n3+n4+n5-1)) = By_vect5

Bz_vect = fltarr(n1+n2+n3);+n4+n5)
Bz_vect(0:(n1-1)) = Bz_vect1
Bz_vect(n1:(n1+n2-1)) = Bz_vect2
Bz_vect((n1+n2):(n1+n2+n3-1)) = Bz_vect3
;Bz_vect((n1+n2+n3):(n1+n2+n3+n4-1)) = Bz_vect4
;Bz_vect((n1+n2+n3+n4):(n1+n2+n3+n4+n5-1)) = Bz_vect5

file_save = '1-3.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
data_descrip= 'got from "figure4_PVI_diffrerent_scale_vs.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect,  Bx_vect, By_vect, Bz_vect
;;;




end









