;pro locate_sheet



sub_dir_date  = 'wind\slow\20060430-0503\'



step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_imformation.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "search_sheet.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
 ;  count_CS, width, ave_angle,scale_vect, $
 ;  JumpTimestamp, DropTimestamp, sub_mid



Read, 'select one scale(24,48,72,96,120 for 0,1,2,3,4): ' , a
Read, 'select other scale(24,48,72,96,120 for 0,1,2,3,4): ' , b
read, 'resolution:' , reso

sub_mid_eff_a = sub_mid(where(sub_mid(*,a) ne 0.0),a)
sub_mid_eff_b = sub_mid(where(sub_mid(*,b) ne 0.0),b)
width_eff_a = width(where(width(*,a) ne 0.0),a)
width_eff_b = width(where(width(*,b) ne 0.0),b)
JumpTimestamp_a = JumpTimestamp(where(JumpTimestamp(*,a) ne 0.0),a)
JumpTimestamp_b = JumpTimestamp(where(JumpTimestamp(*,b) ne 0.0),b)
DropTimestamp_a = DropTimestamp(where(DropTimestamp(*,a) ne 0.0),a)
DropTimestamp_b = DropTimestamp(where(DropTimestamp(*,b) ne 0.0),b)

na = n_elements(sub_mid_eff_a)
nb = n_elements(sub_mid_eff_b)
CS_location = fltarr(na)
CS_Jump = dblarr(na)
CS_Drop = dblarr(na)
width_a = fltarr(na)
count=0

  for i_na = 0,na-1 do begin
    for ii_nb = 0,nb-1 do begin
      temp1 = abs(sub_mid_eff_a(i_na)-sub_mid_eff_b(ii_nb))*reso  ;数据时间分辨率3s
      temp2 = min([width_eff_b(ii_nb),width_eff_a(i_na)])
      ;temp2 = min([24.0*(a+1),24.0*(b+1)])
      if temp1 le temp2 then begin 
        count=count+1
        CS_location(i_na) = sub_mid_eff_a(i_na)
        width_a(i_na) = width_eff_a(i_na)
        CS_Jump(i_na) = JumpTimestamp_a(i_na)
        CS_Drop(i_na) = DropTimestamp_a(i_na)
      endif
    endfor
  endfor
  
  print,count
  
  step2:
  read,'continue?0/1 for no/Yes',con
  if con eq 1 then begin
    Read, 'select the third scale(24,48,72,96,120 for 0,1,2,3,4): ', c
    sub_mid_eff_a = CS_location(where(CS_location ne 0.0))
    sub_mid_eff_c = sub_mid(where(sub_mid(*,c) ne 0.0),c)
    width_eff_a = width_a(where(width_a ne 0.0))
    width_eff_c = width(where(width(*,c) ne 0.0),c)
    JumpTimestamp_a = CS_Jump(where(CS_Jump ne 0.0))
    JumpTimestamp_c = JumpTimestamp(where(JumpTimestamp(*,c) ne 0.0),c)
    DropTimestamp_a = CS_Drop(where(CS_Drop ne 0.0))
    DropTimestamp_c = DropTimestamp(where(DropTimestamp(*,c) ne 0.0),c)
    na = n_elements(sub_mid_eff_a)
nc = n_elements(sub_mid_eff_c)
CS_location2 = fltarr(na)
CS_Jump2 = dblarr(na)
CS_Drop2 = dblarr(na)
;count=0

  for i_na = 0,na-1 do begin
    for ii_nc = 0,nc-1 do begin
      temp1 = abs(sub_mid_eff_a(i_na)-sub_mid_eff_c(ii_nc))*reso  ;数据时间分辨率3s
      temp2 = min([width_eff_a(i_na),width_eff_c(ii_nc)])
      ;temp2 = min([24.0*(a+1),24.0*(c+1)])
      if (temp1 le temp2) and (temp2 ge 10.0) then begin        ;持续时间长于10秒
 ;       count=count+1
        CS_location2(i_na) = sub_mid_eff_a(i_na)
        CS_Jump2(i_na) = JumpTimestamp_a(i_na)
        CS_Drop2(i_na) = DropTimestamp_a(i_na)
      endif
    endfor
  endfor
  
 CS_location2 =  CS_location2(where(CS_location2 ne 0.0))
 CS_Jump2 = CS_Jump2(where(CS_Jump2 ne 0.0))
 CS_Drop2 = CS_Drop2(where(CS_Drop2 ne 0.0))

 
 
 count = n_elements(CS_location2)
 
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save   = 'Current_sheet_location'+'.sav'
data_descrip= 'got from "locate_sheet.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    CS_location2 , CS_Jump2, CS_Drop2,  $
    count
  
  print,count
  endif
  
  if con eq 0 then begin
  endif
    
    
  
  end




