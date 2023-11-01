;pro check_sigmacr


device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

sub_dir_date  = 'wind\19950130-0203\'


step1:

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

  

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_19950130-0203_v03.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect
JulDay_min_v2 = JulDay_2s_vect(0)

time_v = JulDay_2s_vect
n_v = n_elements(time_v)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_19950130-0203_v05.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect

time_b = JulDay_2s_vect
n_b = n_elements(time_b)
sub = indgen(n_b)
time_v = time_v(sub)
P_VEL_3s_arr = P_VEL_3s_arr(*,sub)
P_DEN_3s_arr = P_DEN_3s_arr(sub)  
  
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr
;;;---
time_vect_wavlet  = time_vect_v2
period_vect_wavlet  = period_vect  
  
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
;  PSD_Btotal_time_scale_arr  

PSD_VB2total_time_scale_arr = PSD_Btotal_time_scale_arr


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
;  sigmac,sigmar


  
step2:
n_CS = n_elements(CS_location2)
sub = fltarr(401,n_CS)
for i=0,n_CS-1 do begin
sub(*,i) = findgen(401)-200.0+round(CS_location2(i))

endfor  

step3:


;read , 'resolution:' , reso
reso=3.0
time=findgen(401)*reso-200.0*reso
i=3
;for i= 1,n_CS-1 do begin
  
window,1,xsize=1200,ysize=500
;fig1 磁场
Bx = Bx_GSE_2s_vect(sub(*,i))
By = By_GSE_2s_vect(sub(*,i))
Bz = Bz_GSE_2s_vect(sub(*,i))
yB = 10.0
plot,time,Bx,position=[0.05,0.1,0.46,0.98],thick=2,yrange=[-yB,yB],color='ff0000'XL
plot,time,By,position=[0.05,0.1,0.46,0.98],thick=2,yrange=[-yB,yB],color='00ff00'XL,/noerase
plot,time,Bz,position=[0.05,0.1,0.46,0.98],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,/noerase
xyouts,200,450,'Bx',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
xyouts,250,450,'By',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
xyouts,300,450,'Bz',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice
;图2，速度
Px = Px_VEL_3s_vect(sub(*,i))
Py = Py_VEL_3s_vect(sub(*,i))
Pz = Pz_VEL_3s_vect(sub(*,i))
yB = 800.0
plot,time,Px,position=[0.55,0.1,0.96,0.98],thick=2,yrange=[-yB,yB],color='ff0000'XL,/noerase
plot,time,Py,position=[0.55,0.1,0.96,0.98],thick=2,yrange=[-yB,yB],color='00ff00'XL,/noerase
plot,time,Pz,position=[0.55,0.1,0.96,0.98],xtitle='time(s)',ytitle='V(km/s)',thick=2,yrange=[-yB,yB],color='0000ff'XL,/noerase
xyouts,800,450,'Px',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
xyouts,850,450,'Py',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
xyouts,900,450,'Pz',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'check\'
file_version= '(v1)'
file_fig  = 'B_and_V'+string(i)+'_time_arr'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;图3-6，功率谱
time_up = 600.0 ;查看时间的半段，秒

stringbz = 'BB'
get_sometime_PSD_from_total, $
  sub_dir_date, stringbz, time_up,0,$
PSD_BBtotal_time_scale_arr, time_vect_wavlet, period_vect_wavlet, sub(*,i),i,JulDay_min_v2

stringbz = 'VV'
get_sometime_PSD_from_total, $
  sub_dir_date, stringbz, time_up,0,$
PSD_VVtotal_time_scale_arr, time_vect_wavlet, period_vect_wavlet, sub(*,i),i,JulDay_min_v2

stringbz = 'V+B'
get_sometime_PSD_from_total, $
  sub_dir_date, stringbz, time_up,0,$
PSD_VB1total_time_scale_arr, time_vect_wavlet, period_vect_wavlet, sub(*,i),i,JulDay_min_v2

stringbz = 'V-B'
get_sometime_PSD_from_total, $
  sub_dir_date, stringbz, time_up,0,$
PSD_VB2total_time_scale_arr, time_vect_wavlet, period_vect_wavlet, sub(*,i),i,JulDay_min_v2

;图7,8，实时sigmacr
stringbz = 'sigmac'
sigmac_t = (PSD_VB1total_time_scale_arr-PSD_VB2total_time_scale_arr)/(PSD_VB1total_time_scale_arr+PSD_VB2total_time_scale_arr)
get_sometime_PSD_from_total, $
  sub_dir_date, stringbz, time_up,1,$
sigmac_t, time_vect_wavlet, period_vect_wavlet, sub(*,i),i,JulDay_min_v2,sigmac,sigmar

stringbz = 'sigmar'
sigmar_t = (PSD_VVtotal_time_scale_arr-PSD_BBtotal_time_scale_arr)/(PSD_VVtotal_time_scale_arr+PSD_BBtotal_time_scale_arr)
get_sometime_PSD_from_total, $
  sub_dir_date, stringbz, time_up,1,$
sigmar_t, time_vect_wavlet, period_vect_wavlet, sub(*,i),i,JulDay_min_v2,sigmac,sigmar

;endfor  


end  
  
  
  
