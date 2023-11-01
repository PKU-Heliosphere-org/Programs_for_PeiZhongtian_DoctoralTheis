;pro get_no_angle_sp_p


sub_dir_date  = 'new\19950720-29-1\'
n_jie = 14
jie = (findgen(n_jie)+1)/2.0
s = fltarr(n_jie)
sigma_notheta = fltarr(n_jie)
Btot_strctF = fltarr(n_jie,32);jie,scale尺度个数

for i_jie = 0,n_jie-1 do begin

jieshu = jie(i_jie)


Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)*.sav';7-100s.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
time_vect_StructFunct = time_vect
period_vect_StructFunct= period_vect
Bx_StructFunct_arr  = BComp_StructFunct_arr
Diff_Bx_arr = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)*.sav';7-100s.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
By_StructFunct_arr  = BComp_StructFunct_arr
Diff_By_arr = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)*.sav';7-100s.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
Bz_StructFunct_arr  = BComp_StructFunct_arr
Diff_Bz_arr = Diff_BComp_arr


step2:

Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
num_scales  = (Size(Btot_StructFunct_arr))[2]
i_per = 0
for i_per = 0,num_scales-1 do begin
  Btot_strctF(i_jie,i_per) = mean(Btot_StructFunct_arr(*,i_per),/nan)
endfor


period_low = 20;freq_min_plot;0.01
period_high = 200;freq_max_plot;1.0/7.0
sub_per_in_seg = Where(period_vect ge period_low and period_vect le period_high)

result = linfit(alog10(period_vect(sub_per_in_seg)),alog10(Btot_strctF(i_jie,sub_per_in_seg)),sigma = sigma)
sigma_notheta(i_jie) = sigma(1)
s(i_jie) = result(1)





endfor


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'slope_of_s(p).sav'
data_descrip= 'got from "get_no_angle_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  s, sigma_notheta



end_program:
end



