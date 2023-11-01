;pro search_sheet


sub_dir_date  = 'wind\slow\20060430-0503\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'MagDeflectAng_zidingyiscale(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_MagDefectionAngle_time_scale_arr_WIND_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, scale_vect, $
; MagDeflectAng_arr

step2:

nscale = size(scale_vect)
nscale = nscale(1)
nAng = size(MagDeflectAng_arr)
nAng = nAng(1)
width = fltarr(nAng,nscale)
element = fltarr(nAng,nscale)
ave_angle = fltarr(nAng,nscale)
JumpTimestamp = dblarr(nAng,nscale)
DropTimestamp = dblarr(nAng,nscale)
sub_mid = fltarr(nAng,nscale)
count_CS = fltarr(nscale)

 for j =0, nscale-1   do begin                 ;尺度

       
            level_deg = 45

            
;-----Filters the Current Sheets by 30 Degrees ------

          

          
            con = 1; %for flagging an event
              for i=0,nAng-1 do begin

    
               


;Degrees is still above 30 degrees. 
;Searchs for One Peak Current Sheets and finds the Mid. Timestamp
;Finds the Deflection Angl
                 if  con eq 1  then begin   ;true statement 
                    
                    if MagDeflectAng_arr(i,j) GT level_deg   then begin
                        jump = i; %saves "jump" location
                        con = 0;  %stops from returning to this if statement
                    endif
                 endif
                    
                if con eq 0 then begin
                     if MagDeflectAng_arr(i,j) LE level_deg  then begin;waits for the "drop"
            
                        drop = i;           %saves "drop" location
                        drop = drop - 1;    %end of current sheet
                        width(i,j) = (JulDay_2s_vect(i) - JulDay_2s_vect(jump))*86400.0; %in seconds
                        element(i,j)=(drop-jump)+1; %adds one, #elements
                        ave_angle(i,j) = mean(MagDeflectAng_arr(jump:drop,j));
                ;        ave_ang = sum_angle/element;
                        JumpTimestamp(i,j) = JulDay_2s_vect(jump);
                        DropTimestamp(i,j) = JulDay_2s_vect(drop);
       
                        sub_mid(i,j) = element(i,j)/2.+jump;
            ; %print对每个尺度上发现的每个电流片记录尺度、电流片开始、结束的时间点、宽度等信息
                        
                        count_CS(j) = count_CS(j)+1
                        con = 1; %Looks for more jumps 

                    endif
                 endif
            endfor ; end for 


        
    endfor ;end for lag

;;检查脉冲型磁场
; ;去掉0元素
;read,'resolution', reso
;impu = fltarr(nscale);计算脉冲数量
;
;for j = 0,nscale-1 do begin
;a=where(width(*,j) ne 0.0)
;temp=size(a)
;n_ele=temp(1)
;
;  for i = 0,n_ele-2 do begin
;    if abs(JumpTimestamp(a(i+1),j)-DropTimestamp(a(i),j))*86400.0 le min([width(a(i),j),width(a(i+1),j)]) then begin
;      width(a(i+1),j) = (JumpTimestamp(a(i+1),j)-DropTimestamp(a(i),j))*86400.0+width(a(i),j)+width(a(i+1),j)
;      width(a(i),j) = 0
;      
;      JumpTimestamp(a(i+1),j) = JumpTimestamp(a(i),j)
;      JumpTimestamp(a(i),j) = 0
;      DropTimestamp(a(i),j) = 0
;      jump = round((jumpTimestamp(a(i+1),j)-JulDay_2s_vect(0))*86400.0/reso)
;      drop = round((DropTimestamp(a(i+1),j)-JulDay_2s_vect(0))*86400.0/reso)
;      ave_angle(a(i+1),j) = mean(MagDeflectAng_arr(jump:drop,j))
;      ave_angle(a(i),j) = 0
;      sub_mid(a(i+1),j) = ((drop-jump)+1)/2.+jump
;      sub_mid(a(i),j) = 0
;      count_CS(j) = count_CS(j)-2
;      impu(j) = impu(j)+1
;    endif
;  endfor
; endfor
  



print,count_cs,scale_vect

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save   = 'Current_sheet_imformation'+'.sav'
data_descrip= 'got from "search_sheet.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    count_CS, width, ave_angle,scale_vect, $
    JumpTimestamp, DropTimestamp, sub_mid










end_program:
end











