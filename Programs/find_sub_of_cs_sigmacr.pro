;pro find_sub_of_CS_sigmacr


sub_dir_date  = 'wind\19950130-0203\'

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'sigmac_sigmar.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "calculate_sigma_cr.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  sigmac,sigmar(231,16)
;  period_vect

step2:
read,'select a period sub(0-15)', j
sigmac_yan = sigmac(*,j)
sigmar_yan = sigmar(*,j)
count = n_elements(sigmac_yan)

print,'-0.2<sigmac<0.2,sigmar>0.6'
for i_c = 1,count do begin
if abs(sigmac_yan(i_c-1)) le 0.2 and sigmar_yan(i_c-1) ge 0.6 then begin
   print,i_c,sigmac_yan(i_c-1),sigmar_yan(i_c-1)
endif
endfor


print,'sigmac>0.6,-0.2<sigmar<0.2'
for i_c = 1,count do begin
if abs(sigmar_yan(i_c-1)) le 0.2 and sigmac_yan(i_c-1) ge 0.6 then begin
   print,i_c,sigmac_yan(i_c-1),sigmar_yan(i_c-1)
endif
endfor


print,'-0.2<sigmac<0.2,sigmar<-0.6'
for i_c = 1,count do begin
if abs(sigmac_yan(i_c-1)) le 0.2 and sigmar_yan(i_c-1) le -0.6 then begin
   print,i_c,sigmac_yan(i_c-1),sigmar_yan(i_c-1)
endif
endfor


print,'sigmac<-0.6,-0.2<sigmar<0.2'
for i_c = 1,count do begin
if abs(sigmar_yan(i_c-1)) le 0.2 and sigmac_yan(i_c-1) le -0.6 then begin
   print,i_c,sigmac_yan(i_c-1),sigmar_yan(i_c-1)
endif
endfor

end_program:
end























