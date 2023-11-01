;pro figure3_get_no_angle_sp_p


sub_dir_date = 'wind\slow\case2\'
sub_dir_date1 = 'wind\fast\case2\'


for i_qu = 0,1 do begin
;i_qu = 0
if i_qu eq 0 then begin
qu = '_guan_'
endif
if i_qu eq 1 then begin
qu = '_hao_'
endif

n_jie = 10
n_periods = 12
slope_fast = fltarr(n_jie)
slope_slow = fltarr(n_jie)
sigma_fast = fltarr(n_jie)
sigma_slow = fltarr(n_jie)
jie = (findgen(n_jie)+1)/2.0

;;;;;;
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= 'slope_of_s(p)_'+qu+'dissipation.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;;;;;;;;


;goto,step2
step1:

;for i_slow = 1,15 do begin
  
Btot_strctF = fltarr(n_jie,n_periods);jie,scale尺度个数

for i_jie = 0,n_jie-1 do begin

jieshu = jie(i_jie)


;Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+'Bx'+qu+'_SF'+'.sav';strcompress(string(i_slow),/remove_all)
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
file_restore= '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+'By'+qu+'_SF'+'.sav'
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
file_restore= '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+'Bz'+qu+'_SF'+'.sav'
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


;step2:

Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
num_scales  = (Size(Btot_StructFunct_arr))[2]
i_per = 0
for i_per = 0,num_scales-1 do begin
  Btot_strctF(i_jie,i_per) = mean(Btot_StructFunct_arr(*,i_per),/nan)
endfor

freq_max_plot = max(period_vect)
freq_min_plot = min(period_vect)
period_low = freq_min_plot;0.01
period_high = freq_max_plot;1.0/7.0
sub_per_in_seg = Where(period_vect ge period_low and period_vect le period_high)

result = linfit(alog10(period_vect(sub_per_in_seg)),alog10(Btot_strctF(i_jie,sub_per_in_seg)),sigma = sigma)
sigma_slow(i_jie) = sigma(1)
slope_slow(i_jie) = result(1)

endfor
;endfor


;goto,step3
step2:


;for i_slow = 1,15 do begin
  
Btot_strctF = fltarr(n_jie,n_periods);jie,scale尺度个数

for i_jie = 0,n_jie-1 do begin

jieshu = jie(i_jie)


;Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+'Bx'+qu+'_SF'+'.sav'
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
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+'By'+qu+'_SF'+'.sav'
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
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= '1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_'+'Bz'+qu+'_SF'+'.sav'
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


;step2:

Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
num_scales  = (Size(Btot_StructFunct_arr))[2]
i_per = 0
for i_per = 0,num_scales-1 do begin
  Btot_strctF(i_jie,i_per) = mean(Btot_StructFunct_arr(*,i_per),/nan)
endfor

freq_max_plot = max(period_vect)
freq_min_plot = min(period_vect)
period_low = freq_min_plot;0.01
period_high = freq_max_plot;1.0/7.0
sub_per_in_seg = Where(period_vect ge period_low and period_vect le period_high)

result = linfit(alog10(period_vect(sub_per_in_seg)),alog10(Btot_strctF(i_jie,sub_per_in_seg)),sigma = sigma)
sigma_fast(i_jie) = sigma(1)
slope_fast(i_jie) = result(1)

endfor
;endfor

step3:

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'slope_of_s(p)_'+qu+'.sav'
data_descrip= 'got from "get_no_angle_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  slope_fast, sigma_fast, slope_slow, sigma_slow

endfor

end_program:
end