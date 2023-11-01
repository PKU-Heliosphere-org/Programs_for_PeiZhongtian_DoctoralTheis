;Pro get_PSD_of_Bperp_Bpara_Hm_arr_WIND_MFI_199502


sub_dir_date  = '2002/2002-06/';'2005-03/';'1995-12-25/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'Bx'+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_vect, $
;  BComp_wavlet_arr
;;;---
time_vect_wavlet  = time_vect_v2
period_vect_wavlet  = period_vect
Bx_wavlet_arr = BComp_wavlet_arr
;;;---
strpos_tmp  = StrPos(file_restore,'(time=')
TimeRange_str = StrMid(file_restore,strpos_tmp,20)

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'By'+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_vect, $
;  BComp_wavlet_arr
;;;---
time_vect_wavlet  = time_vect_v2
period_vect_wavlet  = period_vect
By_wavlet_arr = BComp_wavlet_arr

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'Bz'+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_vect, $
;  BComp_wavlet_arr
;;;---
time_vect_wavlet  = time_vect_v2
period_vect_wavlet  = period_vect
Bz_wavlet_arr = BComp_wavlet_arr

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'LocalBG_of_MagField(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; Bxyz_LBG_GSE_arr
;;;---
time_vect_LBG = time_vect_v2
period_vect_LBG = period_vect

;;--
diff_time   = time_vect_wavlet(0)-time_vect_LBG(0)
diff_num_times  = N_Elements(time_vect_wavlet)-N_Elements(time_vect_LBG)
diff_period   = period_vect_wavlet(0)-period_vect_LBG(0)
diff_num_periods= N_Elements(period_vect_wavlet)-N_Elements(period_vect_LBG)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  diff_period ne 0.0 or diff_num_periods ne 0L Then Begin
  Print, 'wavlet and LBG has different time_vect and period_vect!!!'
  Stop
EndIf


Step2:
;===========================
;Step2:

;;--
Bt_LBG_GSE_arr  = Reform(Sqrt(Total(Bxyz_LBG_GSE_arr^2,1)))
dbx_LBG_GSE_arr = Reform(Bxyz_LBG_GSE_arr(0,*,*)) / Bt_LBG_GSE_arr
dby_LBG_GSE_arr = Reform(Bxyz_LBG_GSE_arr(1,*,*)) / Bt_LBG_GSE_arr
dbz_LBG_GSE_arr = Reform(Bxyz_LBG_GSE_arr(2,*,*)) / Bt_LBG_GSE_arr

;;--direction along VxB
ex_perp2VB_arr  = 0.0 * dbz_LBG_GSE_arr
ey_perp2VB_arr  = -dbz_LBG_GSE_arr
ez_perp2VB_arr  = +dby_LBG_GSE_arr
tmp = Sqrt(ex_perp2VB_arr^2 + ey_perp2VB_arr^2 + ez_perp2VB_arr^2)
ex_perp2VB_arr  = ex_perp2VB_arr / tmp
ey_perp2VB_arr  = ey_perp2VB_arr / tmp
ez_perp2VB_arr  = ez_perp2VB_arr / tmp

;;--direction along Bx(VxB)
ex_perp2B_in_VB_arr = dby_LBG_GSE_arr^2 + dbz_LBG_GSE_arr^2
ey_perp2B_in_VB_arr = -dbx_LBG_GSE_arr * dby_LBG_GSE_arr
ez_perp2B_in_VB_arr = -dbx_LBG_GSE_arr * dbz_LBG_GSE_arr
tmp = Sqrt(ex_perp2B_in_VB_arr^2 + ey_perp2B_in_VB_arr^2 + ez_perp2B_in_VB_arr^2)
ex_perp2B_in_VB_arr = ex_perp2B_in_VB_arr / tmp
ey_perp2B_in_VB_arr = ey_perp2B_in_VB_arr / tmp
ez_perp2B_in_VB_arr = ez_perp2B_in_VB_arr / tmp

;;--
Bpara_wavlet_arr  = Bx_wavlet_arr*dbx_LBG_GSE_arr + $
            By_wavlet_arr*dby_LBG_GSE_arr + $
            Bz_wavlet_arr*dbz_LBG_GSE_arr

Bperp2VB_wavlet_arr = Bx_wavlet_arr*ex_perp2VB_arr + $
            By_wavlet_arr*ey_perp2VB_arr + $
            Bz_wavlet_arr*ez_perp2VB_arr

Bperp2B_in_VB_wavlet_arr = Bx_wavlet_arr*ex_perp2B_in_VB_arr + $
            By_wavlet_arr*ey_perp2B_in_VB_arr + $
            Bz_wavlet_arr*ez_perp2B_in_VB_arr
            

;;--
dtime     = time_vect_wavlet(1)-time_vect_wavlet(0)
PSD_Bx_time_scale_arr = Abs(Bx_wavlet_arr)^2*dtime
PSD_By_time_scale_arr = Abs(By_wavlet_arr)^2*dtime
PSD_Bz_time_scale_arr = Abs(Bz_wavlet_arr)^2*dtime
PSD_Bt_time_scale_arr = PSD_Bx_time_scale_arr + PSD_By_time_scale_arr + PSD_Bz_time_scale_arr
;;;---
PSD_Bpara_time_scale_arr  = Abs(Bpara_wavlet_arr)^2*dtime
PSD_Bperp_time_scale_arr  = (PSD_Bt_time_scale_arr - PSD_Bpara_time_scale_arr) / 2

PSD_Bperp2VB_time_scale_arr = Abs(Bperp2VB_wavlet_arr)^2*dtime
PSD_Bperp2B_in_VB_time_scale_arr  = Abs(Bperp2B_in_VB_wavlet_arr)^2*dtime
PSD_Bt_time_scale_arr_v2    = PSD_Bpara_time_scale_arr + PSD_Bperp2VB_time_scale_arr + PSD_Bperp2B_in_VB_time_scale_arr
PSD_Bperp_time_scale_arr_v2  = (PSD_Bt_time_scale_arr_v2 - PSD_Bpara_time_scale_arr) / 2


;;--
freq_vect_wavlet= 1./period_vect_wavlet
num_times = N_Elements(time_vect_wavlet)
freq_time_scale_arr = freq_vect_wavlet ## (Fltarr(num_times)+1.0)
kx_time_scale_arr = freq_time_scale_arr
;a Vsw_assumed     = 1.0 ;assume the solar wind velocity to be a constant 1.0
;a kx_time_scale_arr = freq_time_scale_arr / Vsw_assumed

;;;---
;a Syz_wavlet_arr  = By_wavlet_arr*Conj(Bz_wavlet_arr)
Syz_wavlet_arr  = (-By_wavlet_arr)*Conj(Bz_wavlet_arr) ;(-By_wavlet_arr) not (+By_wavlet_arr), since here y is GSE-y not RTN-T, while reduced magnetic helicity means rotation around R-direction

Syz_wavlet_arr  = Syz_wavlet_arr*dtime
ImSyz_wavlet_arr= Imaginary(Syz_wavlet_arr)
ImSyz_time_scale_arr  = ImSyz_wavlet_arr
Hm_yz_time_scale_arr  = 2*ImSyz_wavlet_arr / kx_time_scale_arr
;;--
NormHm_yz_time_scale_arr  = kx_time_scale_arr * Hm_yz_time_scale_arr / PSD_Bt_time_scale_arr


;;--
num_times = N_Elements(time_vect_wavlet)
num_periods = N_Elements(period_vect_wavlet)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_GSE_arr  = Reform(Bxyz_LBG_GSE_arr(0,*,*))
Bt_LBG_GSE_arr  = Reform(Sqrt(Bxyz_LBG_GSE_arr(0,*,*)^2+Bxyz_LBG_GSE_arr(1,*,*)^2+Bxyz_LBG_GSE_arr(2,*,*)^2))
;a theta_arr = ACos(Bx_LBG_GSE_arr/Bt_LBG_GSE_arr)*180/!pi
theta_arr = ACos(-Bx_LBG_GSE_arr/Bt_LBG_GSE_arr)*180/!pi


Step5:
;===========================
;Step5:

;;--
time_min_TV = Min(time_vect_wavlet)
time_max_TV = Max(time_vect_wavlet)
sub_time_min_TV = Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV = sub_time_min_TV(0)
sub_time_max_TV = Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV = sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV  = time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
          (time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
          JulDay_min_v2
;;;---
year_beg_plot=1995 & mon_beg_plot=2 & day_beg_plot=4
hour_beg_plot=7 & min_beg_plot=33 & sec_beg_plot=0
year_end_plot=1995 & mon_end_plot=2 & day_end_plot=4
hour_end_plot=7 & min_end_plot=42 & sec_end_plot=0

;;--
year_beg_plot=2002 & mon_beg_plot=6 & day_beg_plot=26
hour_beg_plot=16 & min_beg_plot=0 & sec_beg_plot=0
year_end_plot=2002 & mon_end_plot=6 & day_end_plot=26
hour_end_plot=19 & min_end_plot=0 & sec_end_plot=0

JulDay_beg_plot = JulDay(mon_beg_plot,day_beg_plot,year_beg_plot, hour_beg_plot,min_beg_plot,sec_beg_plot)
JulDay_end_plot = JulDay(mon_end_plot,day_end_plot,year_end_plot, hour_end_plot,min_end_plot,sec_end_plot)

;;;---
TimeRange_plot_str  = '(time='+$
                      String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')+'-'+$
                      String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')+')'

;;--
sub_beg_plot  = Where(JulDay_vect_TV ge JulDay_beg_plot)
sub_end_plot  = Where(JulDay_vect_TV le JulDay_end_plot)
sub_beg_plot  = sub_beg_plot(0)
sub_end_plot  = sub_end_plot(N_Elements(sub_end_plot)-1)
sub_time_min_TV = sub_beg_plot
sub_time_max_TV = sub_end_plot          
JulDay_vect_TV  = JulDay_vect_TV(sub_time_min_TV:sub_time_max_TV)
          
;;;---
period_vect_TV  = period_vect_wavlet
theta_arr_TV  = theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bpara_time_scale_arr_TV = PSD_Bpara_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bperp_time_scale_arr_TV = PSD_Bperp_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bt_time_scale_arr_TV  = PSD_Bt_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bperp2VB_time_scale_arr_TV  = PSD_Bperp2VB_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bperp2B_in_VB_time_scale_arr_TV = PSD_Bperp2B_in_VB_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bt_time_scale_arr_TV_v2 = PSD_Bt_time_scale_arr_v2(sub_time_min_TV:sub_time_max_TV,*)
NormHm_yz_time_scale_arr_TV = NormHm_yz_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)


;;--
is_save_TV_data = 0
Print, 'is_save_TV_data (0 or 1): ', is_save_TV_data
is_continue = ' '
Read, 'is_continue: ', is_continue
dir_save = '/Work/Data Analysis/WIND data process/Data/Data_for_Paper/1995-12-25/1020-1026/'
file_save = 'theta_RB_NormHm_yz_time_scale_arr_TV.sav'
data_descrip  = 'got from "get_PSD_of_Bperp_Bpara_Hm_arr_WIND_MFI_199502.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect_TV, period_vect_TV, $
  theta_arr_TV, PSD_Bpara_time_scale_arr_TV, PSD_Bperp_time_scale_arr_TV, PSD_Bt_time_scale_arr_TV, $
  NormHm_yz_time_scale_arr_TV
  

;;--
Set_Plot, 'X'
Device,DeComposed=0
xsize = 800.0
ysize = 800.0
Window,1,XSize=xsize,YSize=ysize,Retain=2

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
position_img  = [0.10,0.10,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 5
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


Step5_1:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
position_subimg_v1  = position_SubImg           
;;;---
image_TV  = theta_arr_TV
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
title = TexToIDL('\theta_{B^R}')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
xminor    = xminor_time
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
titleCB     = TexToIDL('\theta')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


Step5_2:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
position_subimg_v2  = position_SubImg               
;;;---
image_TV  = NormHm_yz_time_scale_arr_TV
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
xtitle  = ' '
ytitle  = 'period (s)'
title = TexToIDL('NormHm')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ',xticks+1)
xminor    = 6
xminor    = xminor_time
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
titleCB     = TexToIDL('NormHm')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

Step5_3:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
position_subimg_v3  = position_SubImg               
;;;---
;a image_TV  = PSD_Bperp_time_scale_arr_TV / PSD_Bt_time_scale_arr_TV
;a image_TV  = ALog10(PSD_Bperp_time_scale_arr_TV)
image_TV  = PSD_Bperp2VB_time_scale_arr_TV / $
              (PSD_Bperp2VB_time_scale_arr_TV + PSD_Bperp2B_in_VB_time_scale_arr_TV)
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
min_image = 0.0
max_image = 1.0
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL(' ')
ytitle  = 'period (s)'
title = TexToIDL('PSD_Bperp1/(Bperp1+Bperp2)')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ',xticks+1)
xminor    = 6
xminor    = xminor_time
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
titleCB     = TexToIDL('PSD_Bperp1/Bperp2')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


Step5_4:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 3
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
position_subimg_v4  = position_SubImg               
;;;---
image_TV  = PSD_Bpara_time_scale_arr_TV/PSD_Bt_time_scale_arr_TV
;image_TV = ALog10(PSD_Bpara_time_scale_arr_TV)
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
xtitle  = TexToIDL(' ')
ytitle  = 'period (s)'
title = TexToIDL('PSD_Bpara/Bt')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ',xticks+1)
;xminor    = 6
xminor  = xminor_time
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
titleCB     = TexToIDL('PSD_Bpara/Bt')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


Step5_5:
;;--
i_x_SubImg  = 0
i_y_SubImg  = 4
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
position_subimg_v5  = position_SubImg               
;;;---
num_times_TV  = (Size(PSD_Bt_time_scale_arr_TV))[1]
AverPSD_Bt_time_scale_arr  = (Total(PSD_Bt_time_scale_arr_TV,1)/num_times_TV) ## (Fltarr(num_times_TV)+1.)
image_TV  = ALog10(PSD_Bt_time_scale_arr_TV)
image_TV  = ALog10(PSD_Bt_time_scale_arr_TV / AverPSD_Bt_time_scale_arr)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.05*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.95*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL(' ')
ytitle  = 'period (s)'
title = TexToIDL('lg(PSD_Bt)')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ',xticks+1)
;xminor    = 6
xminor  = xminor_time
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
titleCB     = TexToIDL('lg(PSD_Bt)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

Goto,AnnotStr
;;--
Print, 'cursor to select JulDay_min & period_min'
Cursor, x_cursor_norm, y_cursor_norm, Wait=1, /Normal
i_subimg  = Floor((y_cursor_norm-position_img(1))/dy_pos_SubImg-0.05)
x_cursor_data = xrange(0) + (xrange(1)-xrange(0))*(x_cursor_norm-position_SubImg(0))/(position_SubImg(2)-position_SubImg(0))
y_cursor_data = yrange(0) + (xrange(1)-xrange(0))*(x_cursor_norm-position_SubImg(0))/(position_SubImg(2)-position_SubImg(0))
JulDay_min_cursor = x_cursor_data
period_min_cursor = y_cursor_data
;;;---
Print, 'cursor to select JulDay_max & period_max'
Cursor, x_cursor_norm, y_cursor_norm, Wait=1, /Normal
i_subimg  = Floor((y_cursor_norm-position_img(1))/dy_pos_SubImg-0.05)
x_cursor_data = xrange(0) + (xrange(1)-xrange(0))*(x_cursor_norm-position_SubImg(0))/(position_SubImg(2)-position_SubImg(0))
y_cursor_data = yrange(0) + (xrange(1)-xrange(0))*(x_cursor_norm-position_SubImg(0))/(position_SubImg(2)-position_SubImg(0))
JulDay_max_cursor = x_cursor_data
period_max_cursor = y_cursor_data
;;;---
CalDat, JulDay_min_cursor, mon_min_cursor,day_min_cursor,year_min_cursor,hour_min_cursor,min_min_cursor,sec_min_cursor
CalDat, JulDay_max_cursor, mon_max_cursor,day_max_cursor,year_max_cursor,hour_max_cursor,min_max_cursor,sec_max_cursor
time_min_cursor_str = String(hour_min_cursor,format='(I2.2)')+':'+String(min_min_cursor,format='(I2.2)')+':'+String(sec_min_cursor,format='(I2.2)')
time_max_cursor_str = String(hour_max_cursor,format='(I2.2)')+':'+String(min_max_cursor,format='(I2.2)')+':'+String(sec_max_cursor,format='(I2.2)')
Print, 'time_min_cursor_str: ', time_min_cursor_str
Print, 'time_max_cursor_str: ', time_max_cursor_str
Print, 'period_min_cursor_str: ', period_min_cursor
Print, 'period_max_cursor_str: ', period_max_cursor

AnnotStr:
;;--
AnnotStr_tmp  = 'got from "get_PSD_of_Bpara_Bperp_Hm_arr_WIND_MFI_199502.pro"'
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
dir_fig   = GetEnv('WIND_MFI_Figure_Dir')+''+sub_dir_date
file_version= ''
file_fig  = 'PSD&Hm_time_scale_arr'+$
        TimeRange_plot_str+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd



End_Program:
End