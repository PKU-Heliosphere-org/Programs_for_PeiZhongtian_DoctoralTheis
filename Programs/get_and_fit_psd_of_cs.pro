;pro get_and_fit_PSD_of_CS


date = '20060430-0503'

sub_dir_date  = 'wind\slow\'+date+'\'

zf = ''
B_yrange = [1.e-3,1.e3]
V_yrange = [1,1.e6]



Step1:
;===========================
;Step1:

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
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
file_restore= 'PSD_'+'Bx'+'_time_scale_arr(time=0-0)'+zf+'.sav'
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
;  data_descrip, $
;  PSD_BComp_time_scale_arr, period_vect
;;;---
PSD_Bx_t  = PSD_BComp_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
file_restore= 'PSD_'+'By'+'_time_scale_arr(time=0-0)'+zf+'.sav'
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
;  data_descrip, $
;  PSD_BComp_time_scale_arr, period_vect
;;;---
PSD_By_t  = PSD_BComp_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
file_restore= 'PSD_'+'Bz'+'_time_scale_arr(time=0-0)'+zf+'.sav'
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
;  data_descrip, $
;  PSD_BComp_time_scale_arr, period_vect
;;;---
PSD_Bz_t  = PSD_BComp_time_scale_arr

read,'V(1) or V*sqrt(n)(2)',select_v
if select_v eq 1 then begin
strv = 'V'
  
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_inB.sav'
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



i_BComp = 0

for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Vx/Vy/Vz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Vx'
If i_BComp eq 2 Then FileName_BComp='Vy'
If i_Bcomp eq 3 Then FileName_BComp='Vz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(0,*))
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(1,*))
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(2,*))
EndIf
wave_vect = BComp_RTN_vect




;;--
num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

;;--
is_StepIn = 0 ;There will be out of memory for a direct wavelet transform of a long time sequence
If is_StepIn eq 1 Then Begin
WaveLetCoeff_arr  = WAVELET(wave_vect,dtime,PERIOD=period_vect,COI=coi_vect,/PAD,SIGNIF=signif_arr)
nscale  = N_ELEMENTS(period_vect)
WaveLetPSD_arr    = Abs(WaveLetCoeff_arr)^2           ;unit: nT^2
WaveLetPSD_arr    = WaveLetPSD_arr*dtime              ;unit: nT^2/Hz
PSD_vect_wavlet   = 1*Total(WaveLetPSD_arr,1)/ntime       ;unit: nT^2/Hz
freq_vect_wavlet  = 1./period_vect
EndIf ;If is_StepIn eq 1 Then Begin

;;--
BComp_vect  = wave_vect
period_min  = 12.0;1.0;1.e0  ;unit: s
period_max  = 1200.0;1.e3
period_range= [period_min, period_max]
num_periods = 16

Diff_Bcomp_arr  = Fltarr(num_times, num_periods)
get_Wavelet_zidingyi_v2, $   ;可以改为Haar或者Morlet
    time_vect, BComp_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    BComp_wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_BComp_arr



PSD_BComp_time_scale_arr  = Abs(BComp_wavlet_arr)^2*dtime
;;--
if i_BComp eq 1 then PSD_Vx_t=PSD_BComp_time_scale_arr
if i_BComp eq 2 then PSD_Vy_t=PSD_BComp_time_scale_arr
if i_BComp eq 3 then PSD_Vz_t=PSD_BComp_time_scale_arr

endfor

PSD_Vtot = PSD_Vx_t+PSD_Vy_t+PSD_Vz_t


endif


if select_v eq 2 then begin
  strv = 'v_n'

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
file_restore= 'PSD_'+'Vx'+'_time_scale_arr(time=0-0)'+'.sav'
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
;  data_descrip, $
;  PSD_BComp_time_scale_arr
;;;---
PSD_Vx_t  = PSD_BComp_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
file_restore= 'PSD_'+'Vy'+'_time_scale_arr(time=0-0)'+'.sav'
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
;  data_descrip, $
;  PSD_BComp_time_scale_arr
;;;---
PSD_Vy_t  = PSD_BComp_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
file_restore= 'PSD_'+'Vz'+'_time_scale_arr(time=0-0)'+'.sav'
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
;  data_descrip, $
;  PSD_BComp_time_scale_arr
;;;---
PSD_Vz_t  = PSD_BComp_time_scale_arr
PSD_Vtot = PSD_Vx_t+PSD_Vy_t+PSD_Vz_t

endif

num_periods = n_elements(period_vect)
sizp = size(PSD_BComp_time_scale_arr)
num_times = sizp(1)
;;;--



step2:


Set_Plot, 'Win'
Device,DeComposed=0
xsize = 800.0
ysize = 800.0
Window,0,XSize=xsize,YSize=ysize
;;--
LoadCT,13
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

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background


CS_location2 = round(CS_location2)
reso = 3.0
n_CS = n_elements(width_real)
sub_te = round(width_real/(reso*2.0))
slope = fltarr(6,n_CS)

read,'plot CS(0) or not CS(1) or total(2)',select

if select eq 0 then begin
;  i=0
for i = 0,n_CS-1 do begin

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

i_x_SubImg  = 0
i_y_SubImg  = 1
position_B = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]

i_x_SubImg  = 0
i_y_SubImg  = 0
position_V = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
           
           
PSD_Bx = fltarr(num_periods)
PSD_By = fltarr(num_periods)
PSD_Bz = fltarr(num_periods)
PSD_Vx = fltarr(num_periods)
PSD_Vy = fltarr(num_periods)
PSD_Vz = fltarr(num_periods)
for i_p = 0,num_periods-1 do begin
PSD_Bx(i_p) = mean(PSD_Bx_t((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),i_p),/nan)
PSD_By(i_p) = mean(PSD_By_t((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),i_p),/nan)
PSD_Bz(i_p) = mean(PSD_Bz_t((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),i_p),/nan)
PSD_Vx(i_p) = mean(PSD_Vx_t((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),i_p),/nan)
PSD_Vy(i_p) = mean(PSD_Vy_t((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),i_p),/nan)
PSD_Vz(i_p) = mean(PSD_Vz_t((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),i_p),/nan)
endfor

result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Bx))
slope(0,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_By))
slope(1,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Bz))
slope(2,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vx))
slope(3,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vy))
slope(4,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vz))
slope(5,i) = result(1)

plot,1.0/period_vect,PSD_Bx,color=color_black,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xtitle='frequency(Hz)',ytitle='PSD(nT^2)',position=position_B, thick=2,/xlog,/ylog
plot,1.0/period_vect,PSD_By,color=color_blue,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_B,/noerase
plot,1.0/period_vect,PSD_Bz,color=color_red,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_B,/noerase
 xyouts,0.0002,0.1,'Bx',color=color_black,charthick=1.5     
 xyouts,0.0003,0.1,'By',color=color_blue,charthick=1.5  
 xyouts,0.00042,0.1,'Bz',color=color_red,charthick=1.5  
   
plot,1.0/period_vect,PSD_Vx,color=color_black,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xtitle='frequency(Hz)',ytitle='PSD((km/s)^2)',position=position_V, thick=2,/xlog,/ylog,/noerase
plot,1.0/period_vect,PSD_Vy,color=color_blue,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_V,/noerase
plot,1.0/period_vect,PSD_Vz,color=color_red,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_V,/noerase
 xyouts,0.0002,0.1,'Vx',color=color_black,charthick=1.5     
 xyouts,0.0003,0.1,'Vy',color=color_blue,charthick=1.5  
 xyouts,0.00042,0.1,'Vz',color=color_red,charthick=1.5  
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
file_fig  = 'PSD_of_'+'B_and_V_'+string(i+1)+'th_CS'+zf+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd



endfor

dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
file_save = 'slope_of_PSD_of_BVCS'+zf+'.sav'
data_descrip= 'got from "get_and_fit_PSD_of_CS.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  slope
  
;step3:拟合画直方图
Compname = ['Bx','By','Bz','Vx','Vy','Vz']
for i_comp = 0,5 do begin
  
  s_range = [-2.5,-0.5]
  s_gap = 10.
  s_min = indgen(s_gap)*((s_range(1)-s_range(0))/s_gap)+s_range(0)
  s_max = s_min+(s_range(1)-s_range(0))/s_gap
  value = fltarr(s_gap)
  barname = strarr(s_gap)  
  for i_gap=0,s_gap-1 do begin
    sub = where(slope(i_comp,*) ge s_min(i_gap) and slope(i_comp,*) lt s_max(i_gap))
    value(i_gap) = n_elements(sub)
    barname(i_gap) = string(s_min(i_gap))
    barname(i_gap) = strmid(barname(i_gap),4,5)
  endfor
xsize = 600.0
ysize = 500.0
Window,3,XSize=xsize,YSize=ysize

  bar_plot,value, barnames = barname, background=color_white,xtitle='slope',ytitle='' ;, /overplot
 ; xyouts,1.0,60,'Gap='+string((s_range(1)-s_range(0))/s_gap)
  image_tvrd  = TVRD(true=1)
  dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
  file_fig  = 'Bar_of_'+'slope_of_'+compname(i_comp)+zf+ $
           '.png'
  Write_PNG, dir_fig+file_fig, image_tvrd
  
endfor

endif


;非电流片

if select eq 1 then begin
;  i=0
for i = 0,n_CS-2 do begin

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

i_x_SubImg  = 0
i_y_SubImg  = 1
position_B = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]

i_x_SubImg  = 0
i_y_SubImg  = 0
position_V = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
           
           
PSD_Bx = fltarr(num_periods)
PSD_By = fltarr(num_periods)
PSD_Bz = fltarr(num_periods)
PSD_Vx = fltarr(num_periods)
PSD_Vy = fltarr(num_periods)
PSD_Vz = fltarr(num_periods)
for i_p = 0,num_periods-1 do begin
if CS_location2(i)+sub_te(i) ge CS_location2(i+1)-sub_te(i+1) then begin        
endif
if CS_location2(i)+sub_te(i) lt CS_location2(i+1)-sub_te(i+1) then begin
PSD_Bx(i_p) = mean(PSD_Bx_t((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),i_p),/nan)
PSD_By(i_p) = mean(PSD_By_t((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),i_p),/nan)
PSD_Bz(i_p) = mean(PSD_Bz_t((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),i_p),/nan)
PSD_Vx(i_p) = mean(PSD_Vx_t((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),i_p),/nan)
PSD_Vy(i_p) = mean(PSD_Vy_t((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),i_p),/nan)
PSD_Vz(i_p) = mean(PSD_Vz_t((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),i_p),/nan)
endif
endfor

if PSD_Bx(0) ne 0 then begin
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Bx))
slope(0,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_By))
slope(1,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Bz))
slope(2,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vx))
slope(3,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vy))
slope(4,i) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vz))
slope(5,i) = result(1)


plot,1.0/period_vect,PSD_Bx,color=color_black,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xtitle='frequency(Hz)',ytitle='PSD(nT^2/Hz)',position=position_B, thick=2,/xlog,/ylog
plot,1.0/period_vect,PSD_By,color=color_blue,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_B,/noerase
plot,1.0/period_vect,PSD_Bz,color=color_red,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_B,/noerase
 xyouts,0.0002,0.1,'Bx',color=color_black,charthick=1.5     
 xyouts,0.0003,0.1,'By',color=color_blue,charthick=1.5  
 xyouts,0.00042,0.1,'Bz',color=color_red,charthick=1.5  
   
plot,1.0/period_vect,PSD_Vx,color=color_black,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xtitle='frequency(Hz)',ytitle='PSD((km/s)^2/Hz)',position=position_V, thick=2,/xlog,/ylog,/noerase
plot,1.0/period_vect,PSD_Vy,color=color_blue,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_V,/noerase
plot,1.0/period_vect,PSD_Vz,color=color_red,xrange=[0.0005,0.1],yrange=[0.001,1000.0],   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_V,/noerase
 xyouts,0.0002,0.1,'Vx',color=color_black,charthick=1.5     
 xyouts,0.0003,0.1,'Vy',color=color_blue,charthick=1.5  
 xyouts,0.00042,0.1,'Vz',color=color_red,charthick=1.5  
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
file_fig  = 'PSD_of_'+'B_and_V_'+string(i+1)+'th_noCS'+zf+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endif

endfor

dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
file_save = 'slope_of_PSD_of_BVnoCS'+zf+'.sav'
data_descrip= 'got from "get_and_fit_PSD_of_CS.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  slope
  
;step3:拟合画直方图
Compname = ['Bx','By','Bz','Vx','Vy','Vz']
for i_comp = 0,5 do begin
  
  s_range = [-2.5,-0.5]
  s_gap = 10.
  s_min = indgen(s_gap)*((s_range(1)-s_range(0))/s_gap)+s_range(0)
  s_max = s_min+(s_range(1)-s_range(0))/s_gap
  value = fltarr(s_gap)
  barname = strarr(s_gap)  
  for i_gap=0,s_gap-1 do begin
    sub = where(slope(i_comp,*) ge s_min(i_gap) and slope(i_comp,*) lt s_max(i_gap))
    value(i_gap) = n_elements(sub)
    barname(i_gap) = string(s_min(i_gap))
    barname(i_gap) = strmid(barname(i_gap),4,5)
  endfor
xsize = 600.0
ysize = 500.0
Window,3,XSize=xsize,YSize=ysize

  bar_plot,value, barnames = barname, background=color_white,xtitle='slope',ytitle='' ;, /overplot
 ; xyouts,1.0,60,'Gap='+string((s_range(1)-s_range(0))/s_gap)
  image_tvrd  = TVRD(true=1)
  dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
  file_fig  = 'Bar_of_'+'slope_of_no_'+compname(i_comp)+zf+ $
           '.png'
  Write_PNG, dir_fig+file_fig, image_tvrd
  
endfor

endif


;step3:
if select eq 2 then begin

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

i_x_SubImg  = 0
i_y_SubImg  = 2
position_B = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]

i_x_SubImg  = 0
i_y_SubImg  = 1
position_V = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

i_x_SubImg  = 0
i_y_SubImg  = 0
position_Vt = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]           
           
PSD_Bx = fltarr(num_periods)
PSD_By = fltarr(num_periods)
PSD_Bz = fltarr(num_periods)
PSD_Vx = fltarr(num_periods)
PSD_Vy = fltarr(num_periods)
PSD_Vz = fltarr(num_periods)
for i_p = 0,num_periods-1 do begin
PSD_Bx(i_p) = mean(PSD_Bx_t(*,i_p),/nan)
PSD_By(i_p) = mean(PSD_By_t(*,i_p),/nan)
PSD_Bz(i_p) = mean(PSD_Bz_t(*,i_p),/nan)
PSD_Vx(i_p) = mean(PSD_Vx_t(*,i_p),/nan)
PSD_Vy(i_p) = mean(PSD_Vy_t(*,i_p),/nan)
PSD_Vz(i_p) = mean(PSD_Vz_t(*,i_p),/nan)
endfor

slope_total=fltarr(6)
sigma_total=fltarr(6)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Bx),sigma=sigma)
sigma_total(0) = sigma(1)
slope_total(0) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_By),sigma=sigma)
sigma_total(1) = sigma(1)
slope_total(1) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Bz),sigma=sigma)
sigma_total(2) = sigma(1)
slope_total(2) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vx),sigma=sigma)
sigma_total(3) = sigma(1)
slope_total(3) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vy),sigma=sigma)
sigma_total(4) = sigma(1)
slope_total(4) = result(1)
result = linfit(Alog10(1.0/period_vect),Alog10(PSD_Vz),sigma=sigma)
sigma_total(5) = sigma(1)
slope_total(5) = result(1)

plot,1.0/period_vect,PSD_Bx,color=color_black,xrange=[0.0005,0.1],yrange=B_yrange,   $
  xtitle='frequency(Hz)',ytitle='PSD(nT^2/Hz)',position=position_B, thick=2,/xlog,/ylog
plot,1.0/period_vect,PSD_By,color=color_blue,xrange=[0.0005,0.1],yrange=B_yrange,   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_B,/noerase
plot,1.0/period_vect,PSD_Bz,color=color_red,xrange=[0.0005,0.1],yrange=B_yrange,   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_B,/noerase
 xyouts,0.0002,B_yrange(0)*1000.,'Bx_n:k='+string(slope_total(0))+textoidl('\pm')+string(sigma_total(0)),color=color_black,charthick=1.5     
 xyouts,0.0002,B_yrange(0)*100.,'By_n:k='+string(slope_total(1))+textoidl('\pm')+string(sigma_total(1)),color=color_blue,charthick=1.5  
 xyouts,0.0002,B_yrange(0)*10.,'Bz_n:k='+string(slope_total(2))+textoidl('\pm')+string(sigma_total(2)),color=color_red,charthick=1.5  
   
plot,1.0/period_vect,PSD_Vx,color=color_black,xrange=[0.0005,0.1],yrange=V_yrange,   $
  xtitle='frequency(Hz)',ytitle='PSD((km/s)^2/Hz)',position=position_V, thick=2,/xlog,/ylog,/noerase
plot,1.0/period_vect,PSD_Vy,color=color_blue,xrange=[0.0005,0.1],yrange=V_yrange,   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_V,/noerase
plot,1.0/period_vect,PSD_Vz,color=color_red,xrange=[0.0005,0.1],yrange=V_yrange,   $
  xstyle=4,ystyle=4,/xlog,/ylog,thick=2,position=position_V,/noerase
 xyouts,0.0002,V_yrange(0)*1000.,strv+'x:k='+string(slope_total(3))+textoidl('\pm')+string(sigma_total(3)),color=color_black,charthick=1.5     
 xyouts,0.0002,V_yrange(0)*100.,strv+'y:k='+string(slope_total(4))+textoidl('\pm')+string(sigma_total(4)),color=color_blue,charthick=1.5  
 xyouts,0.0002,V_yrange(0)*10.,strv+'z:k='+string(slope_total(5))+textoidl('\pm')+string(sigma_total(5)),color=color_red,charthick=1.5  


PSD_Vt = fltarr(num_periods)
for i_p = 0,num_periods-1 do begin
  PSD_Vt(i_p) = mean(PSD_Vtot(*,i_p),/nan)
endfor
result = linfit(alog10(1.0/period_vect),alog10(PSD_Vt),sigma=sigma)
plot, 1.0/period_vect, PSD_Vt,color = color_black,position=position_Vt,xtitle='frequency(Hz)',ytitle='PSD((km/s)^2/Hz)', $
  /xlog,/ylog,/noerase
xyouts,0.0002,100,strv+'trace:  k='+string(result(1))+textoidl('\pm')+string(sigma(1)),color=color_black

;;--


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\BVPSD\'
file_fig  = 'PSD_of_'+'B_and_'+strV+zf+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif

end
