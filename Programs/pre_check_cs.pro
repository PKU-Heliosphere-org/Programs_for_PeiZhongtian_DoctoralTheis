;pro pre_check_cs




device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


sub_dir_date  = 'wind\19950222-25\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_h0_mfi_19950222-25_v05.sav'
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
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_19950222-25_inB.sav'
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
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
;  P_TEMP_3s_vect

for i_Comp = 1,3 do begin
  if i_Comp eq 1 then begin
    BComp = 'Bx'
    VComp = 'Vx'
  endif
  if i_Comp eq 2 then begin
    BComp = 'By'
    VComp = 'Vy'
  endif
  if i_Comp eq 3 then begin
    BComp = 'Bz'
    VComp = 'Vz'
  endif
  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= BComp+'_wavlet_arr(time=*-*).sav'
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

if i_Comp eq 1 then Bx_diff = Diff_BComp_arr
if i_Comp eq 2 then By_diff = Diff_BComp_arr
if i_Comp eq 3 then Bz_diff = Diff_BComp_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= VComp+'_wavlet_arr(time=*-*).sav'
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

if i_Comp eq 1 then Vx_diff = Diff_BComp_arr
if i_Comp eq 2 then Vy_diff = Diff_BComp_arr
if i_Comp eq 3 then Vz_diff = Diff_BComp_arr

endfor

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_imformation.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "search_sheet.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
 ;  count_CS, width, ave_angle,scale_vect, $
 ;  JumpTimestamp, DropTimestamp, sub_mid
 
read,'check before(0) or after(1) cutting some CS:', select

if select eq 0 then begin

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
;data_descrip= 'got from "locate_sheet.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
 ;CS_location2 , count , CS_Jump2, CS_Drop2, $
  ;  width_real , time_mid
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
;data_descrip= 'got from "cut_some_CS.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    CS_location2 ,CS_Jump2, CS_Drop2, $
;    width_real ,theta_real, temp_real, Btcha, time_mid, cut
  
  count = n_elements(width_real)
endif


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'MagDeflectAng_zidingyiscale(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_MagDefectionAngle_time_scale_arr_WIND_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, scale_vect, $
; MagDeflectAng_arr

read,'select a period (0-15)',i_per


step2:

;read , 'resolution:' , reso
reso = 3.0


sub_loca = round(CS_location2)

loca_time = julDay_2s_vect(sub_loca)
print,'CS:',count


for i = 1,count do begin
;read,'select one CS',i
time=findgen(201)*reso-100.0*reso;+(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
ythe=(fltarr(201)+1)*45
;xthe=fltarr(201)+sub_mid(sub_loca(i-1));+(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
 

window,1,xsize=1600,ysize=750



if sub_loca(i-1) lt 100 then begin
  continue
endif

magdefl_a = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),0)
yla = max(magdefl_a)+10
xsm = min(time)
xla = max(time)
a=sub_mid(where(sub_mid((sub_loca(i-1)-100):(sub_loca(i-1)+100),0) ne 0.0)+sub_loca(i-1)-100,0)*reso
plot,time,magdefl_a,position=[0.03,0.69,0.33,0.99],yrange=[0,yla],xtitle='time(s)',ytitle='theta'
plot,time,ythe,color='0000ff'XL,position=[0.03,0.69,0.33,0.99],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
n_a = n_elements(a)
for i_a = 0,n_a-1 do begin
  xthe=fltarr(201)+a(i_a)-(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
plot,xthe,magdefl_a,color='00ff00'XL,position=[0.03,0.69,0.33,0.99],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
endfor



magdefl_b = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),1)
a=sub_mid(where(sub_mid((sub_loca(i-1)-100):(sub_loca(i-1)+100),1) ne 0.0)+sub_loca(i-1)-100,1)*reso
plot,time,magdefl_b,position=[0.03,0.36,0.33,0.66],yrange=[0,yla],xtitle='time(s)',ytitle='theta',/noerase
plot,time,ythe,color='0000ff'XL,position=[0.03,0.36,0.33,0.66],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
n_a = n_elements(a)
for i_a = 0,n_a-1 do begin
  xthe=fltarr(201)+a(i_a)-(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
plot,xthe,magdefl_a,color='00ff00'XL,position=[0.03,0.36,0.33,0.66],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
endfor



magdefl_c = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),3)
a=sub_mid(where(sub_mid((sub_loca(i-1)-100):(sub_loca(i-1)+100),3) ne 0.0)+sub_loca(i-1)-100,3)*reso
plot,time,magdefl_c,position=[0.03,0.03,0.33,0.33],yrange=[0,yla],xtitle='time(s)',ytitle='theta',/noerase
plot,time,ythe,color='0000ff'XL,position=[0.03,0.03,0.33,0.33],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
n_a = n_elements(a)
for i_a = 0,n_a-1 do begin
  xthe=fltarr(201)+a(i_a)-(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
plot,xthe,magdefl_a,color='00ff00'XL,position=[0.03,0.03,0.33,0.33],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
endfor



Bx = Bx_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
By = By_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
Bz = Bz_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
yB = 10.0
widtime=findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0
xbian=fltarr(11)-width_real(i-1)/2.0
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
plot,time,Bx,position=[0.36,0.69,0.66,0.99],thick=2,yrange=[-yB,yB],color='ff0000'XL,/noerase
plot,time,By,position=[0.36,0.69,0.66,0.99],thick=2,yrange=[-yB,yB],color='00ff00'XL,/noerase
plot,time,Bz,position=[0.36,0.69,0.66,0.99],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,/noerase
plot,widtime,widy-0.5*yB,position=[0.36,0.69,0.66,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.36,0.69,0.66,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.36,0.69,0.66,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1),ybian,position=[0.36,0.69,0.66,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,750,700,'Bx',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
xyouts,800,700,'By',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
xyouts,850,700,'Bz',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice


Vx_B = Px_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
Vy_B = Py_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
Vz_B = Pz_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
;Vx = Px_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
;Vy = Py_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
;Vz = Pz_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
yB = 10.0
widtime=findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0
xbian=fltarr(11)-width_real(i-1)/2.0
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
Vx_mean = mean(Vx_B,/nan)
Vy_mean = mean(Vy_B,/nan)
Vz_mean = mean(Vz_B,/nan)
plot,time,Vx_B-Vx_mean,position=[0.36,0.36,0.66,0.66],thick=2,yrange=[-yB,yB],color='ff0000'XL,/noerase
plot,time,Vy_B-Vy_mean,position=[0.36,0.36,0.66,0.66],thick=2,yrange=[-yB,yB],color='00ff00'XL,/noerase
plot,time,Vz_B-Vz_mean,position=[0.36,0.36,0.66,0.66],xtitle='time(s)',ytitle='V(in B)',thick=2,yrange=[-yB,yB],color='0000ff'XL,/noerase
plot,widtime,widy-0.5*yB,position=[0.36,0.36,0.66,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.36,0.36,0.66,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.36,0.36,0.66,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1),ybian,position=[0.36,0.36,0.66,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,750,450,'Vx-Vx0',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
xyouts,850,450,'Vy-Vy0',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
xyouts,950,450,'Vz-Vz0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice



temp = P_TEMP_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
tr = 15.0
widtime=findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0
xbian=fltarr(11)-width_real(i-1)/2.0
ybian=findgen(11)/10.0*tr-0.5*tr+25.0
widy=fltarr(11)
plot,time,temp,position=[0.36,0.03,0.66,0.33],xtitle='time(s)',ytitle='Temperature(eV)',thick=2,yrange=[10.0,40.0],color='0000ff'XL,/noerase
plot,widtime,widy-0.5*tr+25.0,position=[0.36,0.03,0.66,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[10.0,40.0],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*tr+25.0,position=[0.36,0.03,0.66,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[10.0,40.0],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.36,0.03,0.66,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[10.0,40.0],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1),ybian,position=[0.36,0.03,0.66,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[10.0,40.0],xstyle=4,ystyle=4,/noerase
;xyouts,750,200,'Temperature',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice



;deltaB

Bx_d = Bx_diff((sub_loca(i-1)-100):(sub_loca(i-1)+100),i_per)
By_d = By_diff((sub_loca(i-1)-100):(sub_loca(i-1)+100),i_per)
Bz_d = Bz_diff((sub_loca(i-1)-100):(sub_loca(i-1)+100),i_per)
yB = 10.0
widtime=findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0
xbian=fltarr(11)-width_real(i-1)/2.0
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
plot,time,Bx_d,position=[0.69,0.69,0.99,0.99],thick=2,yrange=[-yB,yB],color='ff0000'XL,/noerase
plot,time,By_d,position=[0.69,0.69,0.99,0.99],thick=2,yrange=[-yB,yB],color='00ff00'XL,/noerase
plot,time,Bz_d,position=[0.69,0.69,0.99,0.99],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,/noerase
plot,widtime,widy-0.5*yB,position=[0.69,0.69,0.99,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.69,0.69,0.99,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.69,0.69,0.99,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1),ybian,position=[0.69,0.69,0.99,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,1250,700,textoIDL('\delta')+'Bx',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
xyouts,1300,700,textoIDL('\delta')+'By',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
xyouts,1350,700,textoIDL('\delta')+'Bz',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice

;delta V
Vx_d = Vx_diff((sub_loca(i-1)-100):(sub_loca(i-1)+100),i_per);*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
Vy_d = Vy_diff((sub_loca(i-1)-100):(sub_loca(i-1)+100),i_per);*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
Vz_d = Vz_diff((sub_loca(i-1)-100):(sub_loca(i-1)+100),i_per);*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
;Vx = Px_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
;Vy = Py_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
;Vz = Pz_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
yB = 10.0
widtime=findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0
xbian=fltarr(11)-width_real(i-1)/2.0
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
Vx_mean = mean(Vx_B,/nan)
Vy_mean = mean(Vy_B,/nan)
Vz_mean = mean(Vz_B,/nan)
plot,time,Vx_d,position=[0.69,0.36,0.99,0.66],thick=2,yrange=[-yB,yB],color='ff0000'XL,/noerase
plot,time,Vy_d,position=[0.69,0.36,0.99,0.66],thick=2,yrange=[-yB,yB],color='00ff00'XL,/noerase
plot,time,Vz_d,position=[0.69,0.36,0.99,0.66],xtitle='time(s)',ytitle='V(km/s)',thick=2,yrange=[-yB,yB],color='0000ff'XL,/noerase
plot,widtime,widy-0.5*yB,position=[0.69,0.36,0.99,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.69,0.36,0.99,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.69,0.36,0.99,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1),ybian,position=[0.69,0.36,0.99,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,1250,450,textoIDL('\delta')+'Vx',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
xyouts,1300,450,textoIDL('\delta')+'Vy',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
xyouts,1350,450,textoIDL('\delta')+'Vz',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice


if select eq 0 then begin
  
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
file_fig  = 'currentsheet_threescale_pre'+$
        string(i)+'th'+ $
 ;       file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endif

if select eq 1 then begin
  
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
file_fig  = 'currentsheet_threescale_pre'+$
        string(i)+'th'+ $
 ;       file_version+$
        '_aftercut.png'
Write_PNG, dir_fig+file_fig, image_tvrd
  
  
endif

endfor

end







  









