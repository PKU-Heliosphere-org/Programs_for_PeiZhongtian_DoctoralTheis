;pro calculate_sigma_cr
;

sub_dir_date  = 'wind\fast\20080406-08\'


step1:

read,'use wavlet(0) or delta(1):',select

if select eq 0 then begin

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location_do.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "locate_sheet.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
 ;CS_location2 , $
  ;  width_real , time_mid


  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Btotal'+'_time_scale_arr(time=*-*).sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Btotal_time_scale_arr  

PSD_BBtotal_time_scale_arr = PSD_Btotal_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Vtotal'+'_time_scale_arr(time=*-*).sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Btotal_time_scale_arr  
PSD_VVtotal_time_scale_arr = PSD_Btotal_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'V+Btotal'+'_time_scale_arr(time=*-*).sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Btotal_time_scale_arr  
PSD_VB1total_time_scale_arr = PSD_Btotal_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'V-Btotal'+'_time_scale_arr(time=*-*).sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Btotal_time_scale_arr , period_vect 

PSD_VB2total_time_scale_arr = PSD_Btotal_time_scale_arr


step2:

sizp = size(PSD_VB2total_time_scale_arr)
CS_location2 = round(CS_location2)
reso = 3.0

n_CS = n_elements(width_real)
eb = fltarr(n_CS,sizp(2))
ev = fltarr(n_CS,sizp(2))
ezheng = fltarr(n_CS,sizp(2))
efu = fltarr(n_CS,sizp(2))
sigmac = fltarr(n_CS,sizp(2))
sigmar = fltarr(n_CS,sizp(2))
sub_te = round(width_real/(reso*2.0))
for j = 0,sizp(2)-1 do begin  ;j是尺度个数
for i = 0,n_CS-1 do begin
  eb(i,j) = mean(PSD_BBtotal_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  ev(i,j) = mean(PSD_VVtotal_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  ezheng(i,j) = mean(PSD_VB1total_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  efu(i,j) = mean(PSD_VB2total_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  sigmac(i,j) = (ezheng(i,j)-efu(i,j))/(ezheng(i,j)+efu(i,j))
  sigmar(i,j) = (ev(i,j)-eb(i,j))/(ev(i,j)+eb(i,j))
endfor
endfor


dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'sigmac_sigmar.sav'
data_descrip= 'got from "calculate_sigma_cr.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sigmac, sigmar , $
  period_vect   


step3:


sigmac_arr = fltarr(sizp(1),sizp(2))
sigmar_arr = fltarr(sizp(1),sizp(2))

for j = 0,sizp(2)-1 do begin  
for i = 0,sizp(1)-1 do begin
  sigmac_arr(i,j) = (PSD_VB1total_time_scale_arr(i,j)-PSD_VB2total_time_scale_arr(i,j))/(PSD_VB1total_time_scale_arr(i,j)+PSD_VB2total_time_scale_arr(i,j))
  sigmar_arr(i,j) = (PSD_VVtotal_time_scale_arr(i,j)-PSD_BBtotal_time_scale_arr(i,j))/(PSD_VVtotal_time_scale_arr(i,j)+PSD_BBtotal_time_scale_arr(i,j))
endfor
endfor

dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'sigmac_sigmar_time_arr.sav'
data_descrip= 'got from "calculate_sigma_cr.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sigmac_arr,sigmar_arr, $
  period_vect

endif




if select eq 1 then begin
  

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location_do.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "locate_sheet.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
 ;CS_location2 , $
  ;  width_real , time_mid


  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_total_from_delta'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_B, PSD_V, PSD_VBz, PSD_VBf 



;step2:

sizp = size(PSD_VBf)
CS_location2 = round(CS_location2)
reso = 3.0

n_CS = n_elements(width_real)
eb = fltarr(n_CS,sizp(2))
ev = fltarr(n_CS,sizp(2))
ezheng = fltarr(n_CS,sizp(2))
efu = fltarr(n_CS,sizp(2))
sigmac = fltarr(n_CS,sizp(2))
sigmar = fltarr(n_CS,sizp(2))
sub_te = round(width_real/(reso*2.0))
for j = 0,sizp(2)-1 do begin  ;j是尺度个数
for i = 0,n_CS-1 do begin
  eb(i,j) = mean(PSD_B((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  ev(i,j) = mean(PSD_V((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  ezheng(i,j) = mean(PSD_VBz((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  efu(i,j) = mean(PSD_VBf((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
  sigmac(i,j) = (ezheng(i,j)-efu(i,j))/(ezheng(i,j)+efu(i,j))
  sigmar(i,j) = (ev(i,j)-eb(i,j))/(ev(i,j)+eb(i,j))
endfor
endfor


dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'sigmac_sigmar_from_delta.sav'
data_descrip= 'got from "calculate_sigma_cr.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sigmac,sigmar, $
  period_vect  


;step3:


sigmac_arr = fltarr(sizp(1),sizp(2))
sigmar_arr = fltarr(sizp(1),sizp(2))

for j = 0,sizp(2)-1 do begin  
for i = 0,sizp(1)-1 do begin
  sigmac_arr(i,j) = (PSD_VBz(i,j)-PSD_VBf(i,j))/(PSD_VBz(i,j)+PSD_VBf(i,j))
  sigmar_arr(i,j) = (PSD_V(i,j)-PSD_B(i,j))/(PSD_V(i,j)+PSD_B(i,j))
endfor
endfor

dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'sigmac_sigmar_time_arr_from_delta.sav'
data_descrip= 'got from "calculate_sigma_cr.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sigmac_arr,sigmar_arr, $
  period_vect  


endif


END_program:
end


  