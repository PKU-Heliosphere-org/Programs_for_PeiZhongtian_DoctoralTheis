;pro check_CS2




device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


sub_dir_date  = 'wind\fast\20071113-16\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_h0_mfi_20071113-16_v05.sav'
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
JulDay_b = JulDay_vect
BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR
Bx_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(0,*))
By_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(1,*))
Bz_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(2,*))
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_20071113-16_inB.sav'
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

JulDay_v = JulDay_2s_vect

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




step2:

;read , 'resolution:' , reso
reso = 3.0


sub_loca = round(CS_location2)

loca_time = julDay_2s_vect(sub_loca)
print,'CS:',count


for i = 1,count do begin
;read,'select one CS',i
;time=findgen(201)*reso-100.0*reso;+(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
ythe=(fltarr(201)+1)*45
;xthe=fltarr(201)+sub_mid(sub_loca(i-1));+(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
 

window,1,xsize=600,ysize=900





if sub_loca(i-1) lt 100 then begin
  continue
endif

ytitle='B & V(nT)'


JulDay_CS = JulDay_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
magdefl_a = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),0)
yla = max(magdefl_a)+10
xsm = min(JulDay_CS)
xla = max(JulDay_CS)

xrange  = [JulDay_2s_vect(sub_loca(i-1)-100), JulDay_2s_vect(sub_loca(i-1)+100)]
yrange  = [-10.0, 10.0]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.69,0.9,0.99],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  Font=-1,CharThick=1.0,Thick=1.0


Bx = Bx_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
Vx_B = Px_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
yB = 10.0
widtime=(findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0)/86400.+JulDay_2s_vect(sub_loca(i-1))
xbian=(fltarr(11)-width_real(i-1)/2.0)/86400.+JulDay_2s_vect(sub_loca(i-1))
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
Bx_mean = mean(Bx,/nan)
Vx_mean = mean(Vx_B,/nan)
plot,JulDay_CS,Bx-Bx_mean,position=[0.15,0.69,0.9,0.99],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/NoErase
plot,JulDay_CS,Vx_B-Vx_mean,position=[0.15,0.69,0.9,0.99],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1)/86400.,ybian,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,850,'Bx-Bx0',charsize=1.2,charthick=2,/DEvice
xyouts,300,850,'Vx-Vx0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice



Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.36,0.9,0.66],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /noerase,Font=-1,CharThick=1.0,Thick=1.0

By = By_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
Vy_B = Py_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
yB = 10.0
widtime=(findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0)/86400.+JulDay_2s_vect(sub_loca(i-1))
xbian=(fltarr(11)-width_real(i-1)/2.0)/86400.+JulDay_2s_vect(sub_loca(i-1))
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
By_mean = mean(By,/nan)
Vy_mean = mean(Vy_B,/nan)
plot,JulDay_CS,By-By_mean,position=[0.15,0.36,0.9,0.66],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/noerase
plot,JulDay_CS,Vy_B-Vy_mean,position=[0.15,0.36,0.9,0.66],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+width_real(i-1)/86400.,ybian,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,550,'By-By0',charsize=1.2,charthick=2,/DEvice
xyouts,300,550,'Vy-Vy0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice



Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.03,0.9,0.33],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /noerase,Font=-1,CharThick=1.0,Thick=1.0

Bz = Bz_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
Vz_B = Pz_VEL_3s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))*sqrt(P_DEN_3s_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100)))/22.0
yB = 10.0
widtime=(findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0)/86400.+JulDay_2s_vect(sub_loca(i-1))
xbian=(fltarr(11)-width_real(i-1)/2.0)/86400.+JulDay_2s_vect(sub_loca(i-1))
ybian=findgen(11)/10.0*yB-0.5*yB
widy=fltarr(11)
Bz_mean = mean(Bz,/nan)
Vz_mean = mean(Vz_B,/nan)
plot,JulDay_CS,Bz-Bz_mean,position=[0.15,0.03,0.9,0.33],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/noerase
plot,JulDay_CS,Vz_B-Vz_mean,position=[0.15,0.03,0.9,0.33],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian+(width_real(i-1))/86400.,ybian,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,250,'Bz-Bz0',charsize=1.2,charthick=2,/DEvice
xyouts,300,250,'Vz-Vz0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice





if select eq 0 then begin
  
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'currentsheet\'
;file_version= '(v1)'
file_fig  = 'currentsheet_B_V'+$
        string(i)+'th'+ $
 ;       file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endif

if select eq 1 then begin
  
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
file_fig  = 'currentsheet_B_V'+$
        string(i)+'th'+ $
 ;       file_version+$
        '_aftercut.png'
Write_PNG, dir_fig+file_fig, image_tvrd
  
  
endif

endfor

end

























