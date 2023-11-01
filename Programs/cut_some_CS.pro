;pro cut_some_CS
;


sub_dir_date  = 'wind\slow\20060430-0503\'

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location_new.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "define_cs_width.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
;    CS_location2 , count , CS_Jump2, CS_Drop2, $
;    width_real , theta_real, temp_real, Btcha, time_mid
  ;  
  ;  

  
  
step2:

cut = [2,15,16,17,19,22,23]
cut = cut-1



n_cs =  n_elements(CS_location2)
n_cut =  n_elements(cut)
sub = findgen(n_cs)

sub_eff = where(sub ne cut)

for i=0,n_cut-1 do begin
  for j=0,n_cs-1 do begin
    if cut(i) eq j then begin
      CS_location2(j) = 0
      CS_Jump2(j) = 0
      CS_Drop2(j) = 0
      width_real(j) = 0
      theta_real(j) = 0
      temp_real(j) = 0      
      Btcha(j) = 0
      time_mid(j) = 0
    endif
  endfor
endfor

CS_location2 =  CS_location2(where(CS_location2 ne 0))
CS_Jump2 =  CS_Jump2(where(CS_Jump2 ne 0))
CS_Drop2 =  CS_Drop2(where(CS_Drop2 ne 0))
width_real = width_real(where(width_real ne 0))
theta_real = theta_real(where(theta_real ne 0))
temp_real = temp_real(where(temp_real ne 0))
Btcha = Btcha(where(Btcha ne 0))
time_mid = time_mid(where(time_mid ne 0))




dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save   = 'Current_sheet_location_do'+'.sav'
data_descrip= 'got from "cut_some_CS.pro"'
Save, FileName=dir_save+file_save, $ 
    data_descrip, $
    CS_location2 ,CS_Jump2, CS_Drop2, $
    width_real ,theta_real, temp_real, Btcha, time_mid  , cut










end








