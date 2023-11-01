;pro Read_many_MFI_h2_wind_inter




sub_dir_date  = ''


step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven_v\'+sub_dir_date
file_restore= 'wi_h2_mfi_2002052425_v05_17301800p5.sav'
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
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, Bt, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, num_gapData, perce_gapData



step2:

reso = (JulDay_vect_interp(1)-JulDay_vect_interp(0))*86400.
num_times = Floor((Max(JulDay_vect_interp)-Min(JulDay_vect_interp))/(reso/(24.*60*60))) 
JulDay_beg = min(JulDay_vect_interp)
JulDay_end = max(JulDay_vect_interp)
JulDay_vect_v3 = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)


Bx_GSE_vect_v3 = Interpol(Bx_GSE_vect_interp, JulDay_vect_interp, JulDay_vect_v3)
By_GSE_vect_v3 = Interpol(By_GSE_vect_interp, JulDay_vect_interp, JulDay_vect_v3)
Bz_GSE_vect_v3 = Interpol(Bz_GSE_vect_interp, JulDay_vect_interp, JulDay_vect_v3)


Bx_GSE_vect_interp = Bx_GSE_vect_v3
By_GSE_vect_interp = By_GSE_vect_v3
Bz_GSE_vect_interp = Bz_GSE_vect_v3
JulDay_vect_interp = JulDay_vect_v3


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven_v\'+sub_dir_date
file_save = 'wi_h2_mfi_2002052425_v05_17301800p5.sav'
data_descrip= 'got from "read_many_MFI_h2_wind.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp




end





