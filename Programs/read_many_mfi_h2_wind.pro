;pro read_many_MFI_h2_wind




sub_dir_date  = ''


step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven_v\'+sub_dir_date
file_restore= 'wi_h2_mfi_20020524_v05_17301800p5.sav'
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
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp

JulDay_vect_a = JulDay_vect_interp
Bx_GSE_vect_a = Bx_GSE_vect_interp
By_GSE_vect_a = By_GSE_vect_interp
Bz_GSE_vect_a = Bz_GSE_vect_interp



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\wind\fast\'+sub_dir_date
file_restore= 'wi_h2_mfi_20020525_v05_17301800p5.sav'
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
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp

JulDay_vect_b = JulDay_vect_interp
Bx_GSE_vect_b = Bx_GSE_vect_interp
By_GSE_vect_b = By_GSE_vect_interp
Bz_GSE_vect_b = Bz_GSE_vect_interp


a1=N_elements(JulDay_vect_a)
a2=N_elements(JulDay_vect_b)
JulDay_vect = dblarr(a1+a2)
JulDay_vect(0:a1-1)=JulDay_vect_a
JulDay_vect(a1:a1+a2-1)=JulDay_vect_b


b1=N_elements(Bx_GSE_vect_a)
b2=N_elements(Bx_GSE_vect_b)
Bx_GSE_vect = dblarr(b1+b2)
Bx_GSE_vect(0:b1-1)=Bx_GSE_vect_a
Bx_GSE_vect(b1:b1+b2-1)=Bx_GSE_vect_b


c1=N_elements(By_GSE_vect_a)
c2=N_elements(By_GSE_vect_b)
By_GSE_vect = dblarr(c1+c2)
By_GSE_vect(0:c1-1)=By_GSE_vect_a
By_GSE_vect(c1:c1+c2-1)=By_GSE_vect_b


d1=N_elements(Bz_GSE_vect_a)
d2=N_elements(Bz_GSE_vect_b)
Bz_GSE_vect = dblarr(d1+d2)
Bz_GSE_vect(0:d1-1)=Bz_GSE_vect_a
Bz_GSE_vect(d1:d1+d2-1)=Bz_GSE_vect_b


JulDay_vect_interp = JulDay_vect
Bx_GSE_vect_interp = Bx_GSE_vect
By_GSE_vect_interp = By_GSE_vect
Bz_GSE_vect_interp = Bz_GSE_vect


step2:
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven_v\'+sub_dir_date
file_save = 'wi_h2_mfi_2002052425_v05_17301800p5.sav'
data_descrip= 'got from "read_many_MFI_h2_wind.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


End_Program:
End

;接下来进行差值，运行Read_many_MFI_h2_wind_interpol


