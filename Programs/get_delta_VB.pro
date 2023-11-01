;pro get_delta_VB



sub_dir_date  = 'wind\19950130-0203\'


Step1:
;===========================
;Step1:

;;--
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
;  JulDay_2s_vect, Bxyz_GSE_2s_arr,  $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_19950130-0203_inB.sav'
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





Step2:
;===========================
;Step2:

;;--
i_BComp = 0

for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_vect  = reform(Bxyz_GSE_2s_arr(0,*))
  VComp_vect  = reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0  
  VBComp_z_vect  = reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0+reform(Bxyz_GSE_2s_arr(0,*))  
  VBComp_f_vect  = reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0-reform(Bxyz_GSE_2s_arr(0,*))   
EndIf
If i_BComp eq 2 Then Begin
  BComp_vect  = reform(Bxyz_GSE_2s_arr(1,*))
  VComp_vect  = reform(P_VEL_3s_arr(1,*))*sqrt(P_DEN_3s_arr)/22.0  
  VBComp_z_vect  = reform(P_VEL_3s_arr(1,*))*sqrt(P_DEN_3s_arr)/22.0+reform(Bxyz_GSE_2s_arr(1,*))  
  VBComp_f_vect  = reform(P_VEL_3s_arr(1,*))*sqrt(P_DEN_3s_arr)/22.0-reform(Bxyz_GSE_2s_arr(1,*))
EndIf
If i_BComp eq 3 Then Begin
  BComp_vect  = reform(Bxyz_GSE_2s_arr(2,*))
  VComp_vect  = reform(P_VEL_3s_arr(2,*))*sqrt(P_DEN_3s_arr)/22.0  
  VBComp_z_vect  = reform(P_VEL_3s_arr(2,*))*sqrt(P_DEN_3s_arr)/22.0+reform(Bxyz_GSE_2s_arr(2,*))  
  VBComp_f_vect  = reform(P_VEL_3s_arr(2,*))*sqrt(P_DEN_3s_arr)/22.0-reform(Bxyz_GSE_2s_arr(2,*))
EndIf
;wave_vect = BComp_RTN_vect

;;--
num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times



;;--

period_min  = 12.0;1.0;1.e0  ;unit: s
period_max  = 1200.0;1.e3
period_range= [period_min, period_max]
num_periods = 16


;for B

Diff_Bcomp_arr  = Fltarr(num_times, num_periods)

get_diff_from_time_series, $   ;
    time_vect, BComp_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_BComp_arr
    
    

Diff_Vcomp_arr  = Fltarr(num_times, num_periods)

get_diff_from_time_series, $   ;
    time_vect, VComp_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_VComp_arr
    
    
Diff_VBcomp_z_arr  = Fltarr(num_times, num_periods)

get_diff_from_time_series, $   ;
    time_vect, VBComp_z_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_VBComp_z_arr
    
    
Diff_VBcomp_f_arr  = Fltarr(num_times, num_periods)

get_diff_from_time_series, $   ;
    time_vect, VBComp_f_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_VBComp_f_arr


;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min  = Min(JulDay_2s_vect)
JulDay_max  = Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save = FileName_BComp+'_diff_arr'+$
        TimeRange_str+'.sav'
JulDay_min_v2 = Min(JulDay_2s_vect)
data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_200107.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min_v2, time_vect_v2, period_vect, $
  Diff_BComp_arr,  Diff_VComp_arr, Diff_VBComp_z_arr, Diff_VBComp_f_arr


If i_BComp eq 1 Then Begin
  X_Diff_BComp_arr  = Diff_BComp_arr
  X_Diff_VComp_arr  = Diff_VComp_arr  
  X_Diff_VBComp_z_arr  = Diff_VBComp_z_arr 
  X_Diff_VBComp_f_arr  = Diff_VBComp_f_arr   
EndIf
If i_BComp eq 2 Then Begin
  Y_Diff_BComp_arr  = Diff_BComp_arr
  Y_Diff_VComp_arr  = Diff_VComp_arr  
  Y_Diff_VBComp_z_arr  = Diff_VBComp_z_arr 
  Y_Diff_VBComp_f_arr  = Diff_VBComp_f_arr 
EndIf
If i_BComp eq 3 Then Begin
  Z_Diff_BComp_arr  = Diff_BComp_arr
  Z_Diff_VComp_arr  = Diff_VComp_arr  
  Z_Diff_VBComp_z_arr  = Diff_VBComp_z_arr 
  Z_Diff_VBComp_f_arr  = Diff_VBComp_f_arr 
EndIf



endfor


step3:
;计算平方

PSD_Bx = X_Diff_BComp_arr^2.0
PSD_By = Y_Diff_BComp_arr^2.0
PSD_Bz = Z_Diff_BComp_arr^2.0
PSD_B = PSD_Bx + PSD_By + PSD_Bz

PSD_Vx = X_Diff_VComp_arr^2.0
PSD_Vy = Y_Diff_VComp_arr^2.0
PSD_Vz = Z_Diff_VComp_arr^2.0
PSD_V = PSD_Vx + PSD_Vy + PSD_Vz

PSD_VBzx = X_Diff_VBComp_z_arr^2.0
PSD_VBzy = Y_Diff_VBComp_z_arr^2.0
PSD_VBzz = Z_Diff_VBComp_z_arr^2.0
PSD_VBz = PSD_VBzx + PSD_VBzy + PSD_VBzz

PSD_VBfx = X_Diff_VBComp_f_arr^2.0
PSD_VBfy = Y_Diff_VBComp_f_arr^2.0
PSD_VBfz = Z_Diff_VBComp_f_arr^2.0
PSD_VBf = PSD_VBfx + PSD_VBfy + PSD_VBfz


dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'PSD_'+'total'+'_from_delta'+$
        '.sav'
data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  PSD_B, PSD_V, PSD_VBz, PSD_VBf


step4:

;;--
step4_1:

PSD_BComp_time_scale_arr = PSD_B
time_vect_wavlet  = time_vect_v2


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
period_vect_TV  = period_vect
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





;Step4_2:
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
min_image = -2.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 2.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'Btotal'+')')
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
titleCB     = TexToIDL('lg(PSD_'+'Btotal'+')')
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
file_fig  = 'PSD_of_'+'Btotal'+'_from_delta'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


step4_2:

PSD_BComp_time_scale_arr = PSD_V

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
period_vect_TV  = period_vect
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
min_image = -2.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 2.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'vtotal'+')')
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
titleCB     = TexToIDL('lg(PSD_'+'Vtotal'+')')
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
file_fig  = 'PSD_of_'+'Vtotal'+'_from_delta'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


step4_3:

PSD_BComp_time_scale_arr = PSD_VBz

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
period_vect_TV  = period_vect
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





;Step4_2:
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
min_image = -2.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 2.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'v+btotal'+')')
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
titleCB     = TexToIDL('lg(PSD_'+'V+Btotal'+')')
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
file_fig  = 'PSD_of_'+'V+Btotal'+'_from_delta'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


step4_4:

PSD_BComp_time_scale_arr = PSD_VBf

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
period_vect_TV  = period_vect
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





;Step4_2:
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
min_image = -2.5;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 2.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_'+'v-btotal'+')')
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
titleCB     = TexToIDL('lg(PSD_'+'V-Btotal'+')')
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
file_fig  = 'PSD_of_'+'V-Btotal'+'_from_delta'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


End_Program:
End







