;1. automatic
;2. calculate Flatness after excluding the intermittency intervals and before linear fit
;3. fit at the end of LIMed

;Prepare_WIND_BV_Wavelet_FFT,var,var_BG,dir_restore,dir_save,dir_fig,$
;  num_scales,file_version,n_hours,n_days,num_times,is_theta_1_or_2,$
;  JulDay_vect,B_RTN_3s_arr,$
;  time_vect,dtime,period_range,TimeRange_str,$
;  sub_dir_date

;===========================
;Step1:
sub_dir_date  = 'new\19950720-29-1\'

;WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\'
;WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\CDF_wind\'
;SetEnv,WIND_Data_Dir
;SetEnv,WIND_Figure_Dir

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01_v.sav'
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
JulDay_2s_vect = JulDay_1s_vect

;保存各个尺度被去掉的点sub_move
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'Bx'+'_Morlet_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr
n_time = (size(BComp_wavlet_arr))[1]
n_freq = (size(BComp_wavlet_arr))[2]
time_move = fltarr(3,n_time,n_freq)


for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3/4/5 for Bx/By/Bz/Btotal/Bvect): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = FileName_BComp+'_Morlet_wavlet_arr(time=*-*).sav'
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
BComp_wavlet_arr_nan = BComp_wavlet_arr+!values.F_nan
BComp_wavlet_arr_lim = BComp_wavlet_arr+!values.F_nan
iter_value_arr = fltarr(n_freq)
Int_percent_arr = fltarr(n_freq)

for i_freq = 0,n_freq-1 do begin ;0,n_freq-1  5,5
;goto,step3
freq_index = i_freq
i_iter = 0
iter_value = 12.
PSD_BComp_time_scale_arr = ABS(BComp_wavlet_arr);real_part(BComp_wavlet_arr)
Real_part_wavelet_arr = real_part(BComp_wavlet_arr)

PSD_time_freq = reform(PSD_BComp_time_scale_arr(*,i_freq))
Real_part_wavelet = reform(Real_part_wavelet_arr(*,i_freq))
PSD_time_freq_v1 = PSD_time_freq(WHERE(FINITE(PSD_time_freq)))
PSD_time_freq_v2 = PSD_time_freq_v1(sort(PSD_time_freq_v1))
max_PSD = PSD_time_freq_v2(Long(0.95*N_Elements(PSD_time_freq_v2)))
;PSD_time_freq = PSD_time_freq(where(PSD_time_freq le max_PSD))
PSD_time_freq_F = mean(PSD_time_freq^4.,/nan)/(mean(PSD_time_freq^2.,/nan))^2.
PSD_time_freq_I = PSD_time_freq^2./mean(PSD_time_freq^2.,/nan)
PSD_time_freq_I_ori = PSD_time_freq_I
xtitle  = 'Time '+sub_dir_date 
ytitle  = 'LIM = w!U2!N/<w!U2!N>'
xrange  = [Min(JulDay_2s_vect), max(JulDay_2s_vect)]  ;[Min(JulDay_vect), Max(JulDay_vect)]
yrange  = [Min(PSD_time_freq_I_ori), Max(PSD_time_freq_I_ori)] ;[0,10];
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
LoadCT,13,/silent
TVLCT,R,G,B,/Get
color_red = 251L
TVLCT,255L,0L,0L,color_red
color_green = 254L
TVLCT,0L,255L,0L,color_green
color_blue  = 253L
TVLCT,0L,0L,255L,color_blue
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 255L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
color_bg    = color_white

step2:
PSD_time_freq_F = mean(PSD_time_freq^4.,/nan)/(mean(PSD_time_freq^2.,/nan))^2.
PSD_time_freq_I = PSD_time_freq^2./mean(PSD_time_freq^2.,/nan)

;;;---
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0/2
ysize = 750.0/2
Window,0,XSize=xsize,YSize=ysize
!p.background = color_bg
str_tau = TexToIDL('\tau')
dummy = LABEL_DATE(DATE_FORMAT=['%H:%I','%M-%D'])
if i_iter eq 0 then begin
Plot,JulDay_2s_vect,PSD_time_freq_I_ori,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  XTICKFORMAT='LABEL_DATE', xtickunits = ['Time','Time'],$
  XTitle=xtitle,YTitle=ytitle,color=color_black;,psym=-2
endif else begin
Plot,JulDay_2s_vect,PSD_time_freq_I_ori,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,color=color_black;,psym=-2
endelse
if i_iter ne 0 then oplot,JulDay_2s_vect,PSD_time_freq_I,color=color_red;,psym=-2
if i_iter ne 0 then oplot,JulDay_2s_vect,fltarr(n_time)+iter_value,color=color_red

xyouts,0.4,0.8,str_tau+' = '+string(freq_vect(freq_index),format='(f7.4)')+' Hz',$
  charsize=1.5,charthick=2,color=color_black,/normal
xyouts,0.4,0.7,'Flatness = <w!U4!N>/<w!U2!N>!U2!N = '+string(PSD_time_freq_F,format='(f4.2)'),$
  charsize=1.5, charthick=2,color=color_black,/normal
xyouts,0.4,0.6,'iter_times = '+string(i_iter,format='(I3)'),$
  charsize=1.5, charthick=2,color=color_black,/normal
int_percent = n_elements(where(~finite(PSD_time_freq)))/float(n_elements(PSD_time_Freq))
Int_percent_arr(i_freq) = Int_percent
xyouts,0.4,0.5,'Intmit percent = '+string(int_percent*100.,format='(f4.1)')+'%',$
  charsize=1.5, charthick=2,color=color_black,/normal

If PSD_time_freq_F gt 3.04 then begin
  If PSD_time_freq_F gt 3.1 then begin
    iter_value = iter_value-0.3
  endif else begin
    if PSD_time_freq_F gt 3.06 then begin
      iter_value = iter_value-0.01
    endif else begin
      iter_value = iter_value-0.005
    endelse
  endelse
  iter_value_arr(i_freq) = iter_value
  if (where(PSD_time_freq_I gt iter_value))(0) ne -1 then begin
    PSD_time_freq(where(PSD_time_freq_I gt iter_value)) = !values.F_nan
    Real_part_wavelet(where(PSD_time_freq_I gt iter_value)) = !values.F_nan
  endif else begin
    iter_value = max(PSD_time_freq_I)-0.0005
    PSD_time_freq(where(PSD_time_freq_I gt iter_value)) = !values.F_nan
    Real_part_wavelet(where(PSD_time_freq_I gt iter_value)) = !values.F_nan
  endelse
  i_iter = i_iter+1
  F_print = mean(PSD_time_freq^4.,/nan)/(mean(PSD_time_freq^2.,/nan))^2.
  if F_print le 2.95 then print,'F = '+string(F_print,format='(f4.2)')
  goto,step2
endif else begin
  goto,endofiteration
endelse
endofiteration:
if n_elements(where(~finite(PSD_time_freq))) ne 0 then begin
  BComp_wavlet_arr_nan(*,i_freq) = PSD_time_freq
  sub_nan = finite(PSD_time_freq)
  if sub_nan(0) ne 0 and sub_nan(n_elements(sub_nan)-1) ne 0 then begin
;    PSD_time_freq_nonan = PSD_time_freq(where(finite(PSD_time_freq)))
    Real_part_wavelet_nonan = Real_part_wavelet(where(finite(PSD_time_freq)))
    JulDay_2s_vect_nonan = JulDay_2s_vect(where(finite(PSD_time_freq)))
  endif else begin
    if sub_nan(0) eq 0 then begin
;      PSD_time_freq_nonan = [mean(PSD_time_freq,/nan),PSD_time_freq(where(finite(PSD_time_freq)))]
      Real_part_wavelet_nonan = [mean(Real_part_wavelet,/nan),Real_part_wavelet(where(finite(Real_part_wavelet)))]      
      JulDay_2s_vect_nonan = [JulDay_2s_vect(0),JulDay_2s_vect(where(finite(PSD_time_freq)))]
    endif
    if sub_nan(n_elements(sub_nan)-1) eq 0 then begin
;     PSD_time_freq_nonan = [PSD_time_freq(where(finite(PSD_time_freq))),mean(PSD_time_freq,/nan)]
      Real_part_wavelet_nonan = [Real_part_wavelet(where(finite(Real_part_wavelet))),mean(Real_part_wavelet,/nan)]
      JulDay_2s_vect_nonan = [JulDay_2s_vect(where(finite(PSD_time_freq))),JulDay_2s_vect(n_elements(JulDay_2s_vect)-1)]
    endif
  endelse
endif
BComp_wavlet_arr_lim(*,i_freq) = interpol(Real_part_wavelet_nonan,JulDay_2s_vect_nonan,JulDay_2s_vect)

image_tvrd  = TVRD(true=1)
file_version= '(v1)'
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = FileName_BComp+'LIM_Flat_'+string(i_freq,format='(I2)')+file_version+'_abs.png'
;if i_freq mod 5 eq 0 then Write_PNG, dir_fig+file_fig, image_tvrd
Write_PNG, dir_fig+file_fig, image_tvrd

sub_cut = where(PSD_time_freq_I_ori gt iter_value)
time_move(i_Bcomp-1,sub_cut,i_freq) = 1
;dir_save    = WIND_Data_Dir+sub_dir_date
;file_save   = StrMid(file_restore, 0, StrLen(file_restore)-4)+'_LIM_Freq'+string(i_freq,format='(I2)')+'.sav'
;data_descrip= 'got from "Plot_LIM_Flat.pro"'
;Save, FileName=file_save, $
;    data_descrip, $
;    JulDay_vect, period_vect, $
;    BComp_wavlet_time_v2, iter_value

print,'End of Iteration'

;wait,1
endfor

BComp_wavlet_arr = BComp_wavlet_arr_lim
file_save   = StrMid(file_restore, 0, StrLen(file_restore)-4)+'_LIMed.sav'
data_descrip= 'got from "Plot_LIMed_program.pro"'
Save, FileName=file_save, $
    data_descrip, $
    JulDay_2s_vect, period_vect, $
    BComp_wavlet_arr, iter_value_arr
 ;   BComp_wavlet_arr_nan,  Int_percent_arr
;goto,end_program




end_program:
endfor

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save   = 'time_remove_abs.sav'
data_descrip= 'got from "Plot_LIMed_program_v1.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    time_move





end