;pro get_MagDeflectionAngle_zidingyiscale


sub_dir_date  = 'wind\slow\20060430-0503\'

WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\research\CDF_wind\'
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\research\CDF_wind\'
SetEnv,WIND_Data_Dir
SetEnv,WIND_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore = GetEnv('WIND_Data_Dir')+sub_dir_date;+'MFI\'
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
;  JulDay_vect, Bxyz_GSE_arr

JulDay_2s_vect = JulDay_vect
BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR


Step2:
;===========================
;Step2:

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
scale_min = 24.0;4,1.0;1.e0  ;unit: s
scale_max = 120.0;1.e3,1.e5
scale_range = [scale_min, scale_max]
num_scales  = 5 ;16;16 ;number of scales
;dlg2scale = ALog10(scale_max/scale_min)/ALog10(2)/(num_scales-1)
scale_vect  = [24.0,48.0,72.0,96.0,120.0]

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
;;--
dir_save  = GetEnv('WIND_Data_Dir')+sub_dir_date+''
JulDay_min  = Min(JulDay_2s_vect)
JulDay_max  = Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save = 'MagDeflectAng_zidingyiscale'+$
        TimeRange_str+'.sav'
JulDay_min_v2 = Min(JulDay_2s_vect)
data_descrip= 'got from "get_MagDeflectionAngle_time_scale_arr_WIND_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, scale_vect, $
  MagDeflectAng_arr


Step3:
;===========================
;Step3:

;;--
dir_restore = GetEnv('WIND_Data_Dir')+sub_dir_date;+'MFI\'
file_restore= 'MagDeflectAng_zidingyiscale(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_MagDefectionAngle_time_scale_arr_WIND_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, scale_vect, $
; MagDeflectAng_arr

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0
ysize = 600.0
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
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


Step3_1:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = MagDeflectAng_arr
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
byt_image_TV= BytSCL(image_TV,min=min_image,max=90, Top=num_CB_color-1);30,60,max_image  gaiguo
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'time'
ytitle  = 'period (s)'
title = TexToIDL('MagDeflectAng')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_2s_vect), Max(JulDay_2s_vect)]
yrange  = [Min(scale_vect), Max(scale_vect)]
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
max_tickn   = 90  ;30,60,max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('MagDeflectAng')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,90],Position=position_CB,XStyle=1,YStyle=1,$  ;30,60,max_image
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "get_MagDeflectionAngle_time_scale_arr_WIND_19950131.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd  = TVRD(true=1)
dir_fig   = GetEnv('WIND_Figure_Dir')+sub_dir_date
file_version= '(v1)'
file_fig  = 'MagDeflectionAngle_zidingyi'+$
        TimeRange_str+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


End_Program:
end