;pro define_CS_width
device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


sub_dir_date  = 'wind\slow\20060430-0503\'

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location.sav'
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
;    CS_location2 , CS_Jump2, CS_Drop2, $
;    count
;    

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_h0_mfi_20060430-0503_v05.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_vect, BXYZ_GSE_ARR
JulDay_2s_vect_y = JulDay_vect
BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_pm_3dp_20060430-0503_inB.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect,P_VEL_3s_arr,P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, $
;  P_TEMP_3s_vect  

JulDay_2s_vect = JulDay_2s_vect_y

step2:

read , 'resolution:' , reso
sub_loca = round(CS_location2)
n_loca = n_elements(sub_loca)
width_real = fltarr(n_loca)
theta_real = fltarr(n_loca)
time_mid = fltarr(n_loca)
temp_real = fltarr(n_loca)

;;--
num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

;;--
Bx_vect = Reform(BXYZ_GSE_2S_ARR(0,*))
By_vect = Reform(BXYZ_GSE_2S_ARR(1,*))
Bz_vect = Reform(BXYZ_GSE_2S_ARR(2,*))

;;--

;;--
scale_min = 5.0;4,1.0;1.e0  ;unit: s
scale_max = 99.0*reso+5.0;1.e3,1.e5
scale_range = [scale_min, scale_max]
num_scales  = 100 ;16;16 ;number of scales
;dlg2scale = ALog10(scale_max/scale_min)/ALog10(2)/(num_scales-1)
scale_vect = findgen(100)*reso+5.0

;;--
MagDeflectAng_arr = Fltarr(num_times, num_scales)


For i_scale=0,num_scales-1 Do Begin
  scale_tmp = scale_vect(i_scale)
  pixel_tmp = Round(scale_tmp/dtime)
  pixel_tmp = pixel_tmp/2*2+1
  Bx_vect_v1  = Shift(Bx_vect,+pixel_tmp/2)
  By_vect_v1  = Shift(By_vect,+pixel_tmp/2)
  Bz_vect_v1  = Shift(Bz_vect,+pixel_tmp/2)
  Bx_vect_v2  = Shift(Bx_vect,-pixel_tmp/2)
  By_vect_v2  = Shift(By_vect,-pixel_tmp/2)
  Bz_vect_v2  = Shift(Bz_vect,-pixel_tmp/2)
  MagDeflectAng_vect  = ACos((Bx_vect_v1*Bx_vect_v2+By_vect_v1*By_vect_v2+Bz_vect_v1*Bz_vect_v2)/$
                (Sqrt(Bx_vect_v1^2+By_vect_v1^2+Bz_vect_v1^2)*Sqrt(Bx_vect_v2^2+By_vect_v2^2+Bz_vect_v2^2)))
  MagDeflectAng_vect  = MagDeflectAng_vect*180/!pi
  MagDeflectAng_vect(0:(pixel_tmp/2-1)) = !values.f_nan
  MagDeflectAng_vect(num_times-1-(pixel_tmp/2-1):num_times-1) = !values.f_nan
  MagDeflectAng_arr(*,i_scale)  = MagDeflectAng_vect
EndFor


jump = round((CS_Jump2-JulDay_2s_vect(0))*86400.0/reso)
drop = round((CS_Drop2-JulDay_2s_vect(0))*86400.0/reso)
Bxcha = fltarr(n_loca)
Bycha = fltarr(n_loca)
Bzcha = fltarr(n_loca)
Btcha = fltarr(n_loca)
for i_loca = 0,n_loca-1 do begin
  x=scale_vect
  y=fltarr(num_scales)
  Bxcha(i_loca) = Bx_vect(jump(i_loca))-Bx_vect(drop(i_loca))
  Bycha(i_loca) = By_vect(jump(i_loca))-By_vect(drop(i_loca))  
  Bzcha(i_loca) = Bz_vect(jump(i_loca))-Bz_vect(drop(i_loca)) 
  Btcha(i_loca) = sqrt(Bxcha(i_loca)^2+Bycha(i_loca)^2+Bzcha(i_loca)^2) 
  for i_scale = 0,num_scales-1 do begin
  y(i_scale)=mean(MagDeflectAng_arr(jump(i_loca):drop(i_loca),i_scale),/nan)
  endfor
  ;z=mean(P_TEMP_3s_vect(jump(i_loca):drop(i_loca)),/nan)
  
  for i = 0,num_scales-2 do begin
    if (y(i+1) lt y(i)) and (y(i) gt 45) then begin          ;大于45°作为电流片
      sub_max = i
      break
    endif
  endfor
;  for i_scale = 0,num_scales-3 do begin
;    if (y(i_scale+1) gt y(i_scale)) and (y(i_scale+1) ge y(i_scale+2)) then begin
;      width_real(i_loca) = x(i_scale+1)
;      break
;    endif
;  endfor
  width_real(i_loca) = x(sub_max)
  theta_real(i_loca) = y(sub_max)
  ;temp_real(i_loca) = z
  time_mid(i_loca) = JulDay_2s_vect(sub_loca(i_loca))
  temp_s = round(width_real(i_loca)/(2.0*reso))
  temp_real(i_loca) = mean(P_TEMP_3s_vect((sub_loca(i_loca)-temp_s):(sub_loca(i_loca)+temp_s)),/nan)
  
  plot,x,y,xtitle='scale(s)',ytitle='theta'
  xyouts,280,200,'width='+string(width_real(i_loca))+'s',charsize=1.2,charthick=2,/DEvice
 ;wait,0.3
 image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'CS_wide_identify_'+$
        string(i_loca+1)+'th'+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd
  
endfor

;print,time_mid
print,width_real,theta_real,Btcha


;sub_mid =  sub_mid(where(sub_mid ne 0.0))


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save   = 'Current_sheet_location_new'+'.sav'
data_descrip= 'got from "define_cs_width.pro"'
Save, FileName=dir_save+file_save, $ 
    data_descrip, $
    CS_location2 , count , CS_Jump2, CS_Drop2, $
    width_real , theta_real, temp_real, Btcha, time_mid

end










