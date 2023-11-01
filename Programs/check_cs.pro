;pro check_CS

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
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR


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

read , 'resolution:' , reso

sub_loca = round(CS_location2)

loca_time = julDay_2s_vect(sub_loca)
print,'CS:',count
read,'select one CS',i
time=findgen(201)*reso-100.0*reso;+(loca_time(i-1)-JulDay_2s_vect(0))*86400.0
ythe=(fltarr(201)+1)*45
xthe=fltarr(201);+(loca_time(i-1)-JulDay_2s_vect(0))*86400.0


window,1,xsize=800,ysize=2000


;position_SubImg = [0.1,0.7,0.7,0.96]

magdefl_a = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),0)
yla = max(magdefl_a)+10
xsm = min(time)
xla = max(time)
plot,time,magdefl_a,position=[0.1,0.76,0.96,0.94],yrange=[0,yla],xtitle='time',ytitle='theta'
plot,time,ythe,color='0000ff'XL,position=[0.1,0.76,0.96,0.94],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
plot,xthe,magdefl_a,color='00ff00'XL,position=[0.1,0.76,0.96,0.94],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase

magdefl_b = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),1)
plot,time,magdefl_b,position=[0.1,0.54,0.96,0.72],xtitle='time',ytitle='theta',/noerase
plot,time,ythe,color='0000ff'XL,position=[0.1,0.54,0.96,0.72],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
plot,xthe,magdefl_a,color='00ff00'XL,position=[0.1,0.54,0.96,0.72],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase

magdefl_c = MagDeflectAng_arr((sub_loca(i-1)-100):(sub_loca(i-1)+100),3)
plot,time,magdefl_c,position=[0.1,0.32,0.96,0.5],xtitle='time',ytitle='theta',/noerase
plot,time,ythe,color='0000ff'XL,position=[0.1,0.32,0.96,0.5],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase
plot,xthe,magdefl_a,color='00ff00'XL,position=[0.1,0.32,0.96,0.5],xrange=[xsm,xla],yrange=[0,yla],xstyle=4,ystyle=4,/noerase

Bx = Bx_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
By = By_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
Bz = Bz_GSE_2s_vect((sub_loca(i-1)-100):(sub_loca(i-1)+100))
widtime=findgen(11)*width_real(i-1)/10.0-width_real(i-1)/2.0
widy=fltarr(11)
plot,time,Bx,position=[0.1,0.1,0.96,0.28],xtitle='time',ytitle='Bx',yrange=[-1.0,1.0],color='ff0000'XL,/noerase
plot,time,By,position=[0.1,0.1,0.96,0.28],xtitle='time',ytitle='By',yrange=[-1.0,1.0],color='00ff00'XL,/noerase
plot,time,Bz,position=[0.1,0.1,0.96,0.28],xtitle='time',ytitle='Bz',yrange=[-1.0,1.0],color='0000ff'XL,/noerase
plot,widtime,widy,position=[0.1,0.1,0.96,0.28],color='f0f000'XL,xrange=[xsm,xla],yrange=[-1.0,1.0],xstyle=4,ystyle=4,/noerase

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
file_fig  = 'currentsheet_threescale_'+$
        string(i)+'th'+ $
 ;       file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd



end










  








