sub_dir_date  = 'strong\20030126-30\'

WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\others\'
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\CDF_wind\others\'
SetEnv,WIND_Data_Dir
SetEnv,WIND_Figure_Dir

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore= 'uy_1sec_vhm_20030126-30_v01.sav'
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


;===========================
;Step1:

;;--
i_BComp = 0
Read, 'i_BComp(1/2/3/4/5 for Bx/By/Bz/Btotal/Bvect): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'
If i_Bcomp eq 4 Then FileName_BComp='Btotal'
If i_Bcomp eq 5 Then FileName_BComp='Bvect'

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore = FileName_BComp+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr
;;;---
freq_vect = 1./period_vect
n_time = (size(BComp_wavlet_arr))[1]
n_freq = (size(BComp_wavlet_arr))[2]
BComp_wavlet_arr_ori = BComp_wavlet_arr;(2780:2859,*)
JulDay_vect = JulDay_2s_vect;(2780:2859)

iter_value_arr = fltarr(n_freq)






for i_freq = 0,n_freq-1 do begin ;0,n_freq-1  5,5
freq_index = i_freq
BComp_wavlet_arr_tmp = BComp_wavlet_arr
i_iter = 0

step2:
PSD_BComp_time_scale_arr = Abs(BComp_wavlet_arr)^2.
PSD_time_freq = reform(PSD_BComp_time_scale_arr(*,i_freq))
PSD_time_freq_v1 = PSD_time_freq(WHERE(FINITE(PSD_time_freq)))
PSD_time_freq_v2 = PSD_time_freq_v1(sort(PSD_time_freq_v1))
max_PSD = PSD_time_freq_v2(Long(0.95*N_Elements(PSD_time_freq_v2)))
;PSD_time_freq = PSD_time_freq(where(PSD_time_freq le max_PSD))
PSD_time_freq_F = mean(PSD_time_freq^2.)/(mean(PSD_time_freq))^2.
PSD_time_freq_I = PSD_time_freq/mean(PSD_time_freq)
if i_iter eq 0 then PSD_time_freq_I_ori = PSD_time_freq_I

xtitle  = 'Time'
ytitle  = 'LIM = w!U2!N/<w!U2!N>'
xrange  = [Min(JulDay_vect), max(JulDay_vect)]  ;[Min(JulDay_vect), Max(JulDay_vect)]
yrange  = [Min(PSD_time_freq_I_ori), Max(PSD_time_freq_I_ori)] ;[0,10];
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6

;;;---
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0/2
ysize = 750.0/2
Window,0,XSize=xsize,YSize=ysize
LoadCT,13,/silent
TVLCT,R,G,B,/Get
color_red = 255L
TVLCT,255L,0L,0L,color_red
color_green = 254L
TVLCT,0L,255L,0L,color_green
color_blue  = 253L
TVLCT,0L,0L,255L,color_blue
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
color_bg    = color_white
!p.background = color_bg
str_tau = TexToIDL('\tau')
Plot,JulDay_vect,PSD_time_freq_I_ori,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,color=color_black;,psym=-2
if i_iter ne 0 then oplot,JulDay_vect,PSD_time_freq_I,color=color_red;,psym=-2
if i_iter ne 0 then oplot,JulDay_vect,fltarr(n_time)+iter_value

xyouts,0.4,0.8,str_tau+' = '+string(freq_vect(freq_index),format='(f7.4)')+' Hz',$
  charsize=1.5,charthick=2,color=color_black,/normal
xyouts,0.4,0.7,'Flatness = <w!U4!N>/<w!U2!N>!U2!N = '+string(PSD_time_freq_F,format='(f4.2)'),$
  charsize=1.5, charthick=2,color=color_black,/normal
xyouts,0.4,0.6,'iter_times = '+string(i_iter,format='(I3)'),$
  charsize=1.5, charthick=2,color=color_black,/normal

;If PSD_time_freq_F gt 3 then begin
;  iter_value_arr = [15,13,10,8,7.8,7.5,7.2,7,6,5,4,3,2,1,0.5,0.2,0.1]
;  iter_value = iter_value_arr(i_iter)
  read,'iter_value: ',iter_value
  if iter_value gt 0 then begin
    iter_value_arr(i_freq) = iter_value
    sub_posi = where(PSD_time_freq_I le iter_value)
    BComp_wavlet_time_v1 = reform(BComp_wavlet_arr(sub_posi,i_freq))
    JulDay_vect_v1 = JulDay_vect(sub_posi)
    if sub_posi(0) ne 0 then begin
      BComp_wavlet_time_v1 = [BComp_wavlet_time_v1(0),BComp_wavlet_time_v1]
      JulDay_vect_v1 = [JulDay_vect(0),JulDay_vect_v1]
    endif
    if sub_posi(n_elements(sub_posi)-1) ne n_time-1 then begin
      BComp_wavlet_time_v1 = [BComp_wavlet_time_v1,BComp_wavlet_time_v1(n_elements(sub_posi)-1)]
      JulDay_vect_v1 = [JulDay_vect_v1,JulDay_vect(n_time-1)]
    endif
;    BComp_wavlet_time_v2_real = interpol(real_part(BComp_wavlet_time_v1),JulDay_vect_v1,JulDay_vect)
;    BComp_wavlet_time_v2_imag = interpol(imaginary(BComp_wavlet_time_v1),JulDay_vect_v1,JulDay_vect)
;    BComp_wavlet_time_v2 = complex(BComp_wavlet_time_v2_real,BComp_wavlet_time_v2_imag)
    BComp_wavlet_time_v2 = interpol(BComp_wavlet_time_v1,JulDay_vect_v1,JulDay_vect)
    BComp_wavlet_arr(*,i_freq) = BComp_wavlet_time_v2
    i_iter = i_iter+1
    goto,step2
  endif else begin
    goto,endofiteration
  endelse
endofiteration:

;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
;file_fig  = FileName_BComp+'LIM_Flat_'+string(i_freq,format='(I2)')+'.png'
;Write_PNG, dir_fig+file_fig, image_tvrd

window,1,xs=1200,ysize = 750.0/2
plot,JulDay_vect,real_part(BComp_wavlet_arr_ori(*,i_freq)),XRange=xrange,XStyle=1,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle='Wavelet Coefficient (km/s)',color=color_black
oplot,JulDay_vect,real_part(BComp_wavlet_arr(*,i_freq)),color=color_red
oplot,JulDay_vect,real_part(BComp_wavlet_arr(*,i_freq))-real_part(BComp_wavlet_arr_ori(*,i_freq)),color=color_green

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_fig  = FileName_BComp+'LIMed_Wavelet_'+string(i_freq,format='(I2)')+'.png'
;Write_PNG, dir_fig+file_fig, image_tvrd

dir_save    = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_save   = StrMid(file_restore, 0, StrLen(file_restore)-4)+'_LIM_Freq'+string(i_freq,format='(I2)')+'.sav'
data_descrip= 'got from "Plot_LIM_Flat.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, period_vect, $
;    BComp_wavlet_time_v2, iter_value

print,'End of Iteration'
;endif

wait,1
endfor












;
;dir_save    = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
;file_save   = StrMid(file_restore, 0, StrLen(file_restore)-4)+'_LIM.sav'
;data_descrip= 'got from "Plot_LIM_Flat.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_wavlet_arr, iter_value_arr
    
    
dt=2
dj=0.125
Cdelta=1
psi0=1
;IF (Cdelta EQ -1) THEN BEGIN
;         y1 = -1
;         MESSAGE,/INFO, $
;          'Cdelta undefined, cannot reconstruct with this wavelet'
;       ENDIF ELSE BEGIN
;重构
         y1=dj*SQRT(dt)/(Cdelta*psi0)*(FLOAT(BComp_wavlet_arr_ori) # (1./SQRT(period_vect)))
         n = N_ELEMENTS(y1)
         y1 = y1[0:n-1]
;       ENDELSE

BComp_vect_arr = y1

dir_save    = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_save   = StrMid(file_restore, 0, StrLen(file_restore)-4)+'_LIM_vect_ori.sav'
data_descrip= 'got from "Plot_LIM_Flat.pro"'
Save, FileName=file_save, $
    data_descrip, $
    JulDay_vect, time_vect_v2, period_vect, $
    BComp_vect_arr
end


