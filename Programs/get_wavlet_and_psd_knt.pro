;pro get_wavlet_and_PSD_knT




date='19950906'
sub_dir_date  = 'wind\another\199509\fast\'


Step1_1:
;===========================
;Step1:

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
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, P_TEMP_3s_vect, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect




dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_'+date+'_v05.sav'
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
;  JulDay_2s_vect, Bxyz_GSE_2s_arr
JulDay_2s_vect = JulDay_vect
Bxyz_GSE_2s_arr = Bxyz_GSE_arr


Bx = reform(Bxyz_GSE_2s_arr(0,*))
By = reform(Bxyz_GSE_2s_arr(1,*))
Bz = reform(Bxyz_GSE_2s_arr(2,*))
Bt = sqrt(Bx^2.0+By^2.0+Bz^2.0)


Step1_2:
;===========================
;Step2:

reya = 2.76*1.16*1.e-2*P_DEN_3s_arr*P_TEMP_3s_vect;k=1.38*1.e-16 or k=1 
ciya = Bt^2.0/(4.0*!pi);/(8.0*!pi)
;;--
select = 0
;read,'select a value(0 for pressure and 1 for magnetic pressure):',select
for select = 0,3 do begin

;;--
if select eq 0 then begin

BComp_RTN_vect  = reya
wave_vect = BComp_RTN_vect
liang = 'Pressure'
endif
if select eq 1 then begin
BComp_RTN_vect  = ciya
wave_vect = BComp_RTN_vect
liang = 'MagPressure'
endif
if select eq 2 then begin
BComp_RTN_vect  = reya+ciya
wave_vect = BComp_RTN_vect
liang = 'Pre+Mag'
endif
if select eq 3 then begin
BComp_RTN_vect  = reya-ciya
wave_vect = BComp_RTN_vect
liang = 'Pre-Mag'
endif


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

;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min  = Min(JulDay_2s_vect)
JulDay_max  = Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save = liang+'_wavlet_arr'+$
        TimeRange_str+'.sav'
JulDay_min_v2 = Min(JulDay_2s_vect)
data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_200107.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min_v2, time_vect_v2, period_vect, $
  BComp_wavlet_arr, Diff_BComp_arr




step2:



time_vect_wavlet  = time_vect_v2
period_vect_wavlet  = period_vect



;;--
num_times = N_Elements(time_vect_wavlet)
num_periods = N_Elements(period_vect_wavlet)



;;--
dtime     = time_vect_wavlet(1)-time_vect_wavlet(0)
PSD_BComp_time_scale_arr  = Abs(BComp_wavlet_arr)^2*dtime


;TimeRange_str = '(time='+$
;    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
;    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
    
dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'PSD_'+liang+'_time_scale_arr(time=0-0)'+ $
;        TimeRange_str+$
        '.sav'
data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  PSD_BComp_time_scale_arr, period_vect 





;;--
time_min_TV = time_vect_wavlet(0)
time_max_TV = time_min_TV+(24.*60.*60)*5
sub_time_min_TV = Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV = sub_time_min_TV(0)
sub_time_max_TV = Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV = sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV  = time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
          (time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
          JulDay_min_v2
;;;---
period_vect_TV  = period_vect_wavlet
;theta_arr_TV  = theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_BComp_time_scale_arr_TV = PSD_BComp_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
;theta_vect_TV = theta_bin_min_vect
;PSD_BComp_theta_scale_arr_TV= PSD_BComp_theta_scale_arr(*,*)

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 1300.0
Window,1,XSize=xsize,YSize=ysize

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

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs





Step4_2:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = ALog10(PSD_BComp_time_scale_arr_TV)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+liang+')')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB   = [position_SubImg(2)+0.08,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('lg(PSD_'+liang+')')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'PSD_of_'+liang+'_time_scale_arr'+$
        file_version+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg

endfor


end
