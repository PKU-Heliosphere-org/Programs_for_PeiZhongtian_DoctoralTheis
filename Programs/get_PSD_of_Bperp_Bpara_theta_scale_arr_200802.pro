;Pro get_PSD_of_Bperp_Bpara_theta_scale_arr_200802


sub_dir_date  = 'new\19950720-29pvi\'


Step1:
;===========================
;Step1:

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_wavlet_arr(time=*-*).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min_v2, time_vect_v2, period_vect, $
;	BComp_wavlet_arr
;;;---
time_vect_wavlet	= time_vect_v2
period_vect_wavlet	= period_vect
Bx_wavlet_arr	= BComp_wavlet_arr

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_wavlet_arr(time=*-*).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min_v2, time_vect_v2, period_vect, $
;	BComp_wavlet_arr
;;;---
time_vect_wavlet	= time_vect_v2
period_vect_wavlet	= period_vect
By_wavlet_arr	= BComp_wavlet_arr

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_wavlet_arr(time=*-*).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min_v2, time_vect_v2, period_vect, $
;	BComp_wavlet_arr
;;;---
time_vect_wavlet	= time_vect_v2
period_vect_wavlet	= period_vect
Bz_wavlet_arr	= BComp_wavlet_arr

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'LocalBG_of_MagField(time=*-*).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min_v2, time_vect_v2, period_vect, $
;	Bxyz_LBG_RTN_arr
;;;---
time_vect_LBG	= time_vect_v2
period_vect_LBG	= period_vect

;;--
diff_time		= time_vect_wavlet(0)-time_vect_LBG(0)
diff_num_times	= N_Elements(time_vect_wavlet)-N_Elements(time_vect_LBG)
diff_period		= period_vect_wavlet(0)-period_vect_LBG(0)
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
Bt_LBG_RTN_arr	= Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr	= Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr	= Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr	= Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr

;;--
Bpara_wavlet_arr	= Bx_wavlet_arr*dbx_LBG_RTN_arr + $
						By_wavlet_arr*dby_LBG_RTN_arr + $
						Bz_wavlet_arr*dbz_LBG_RTN_arr

;;--
dtime			= time_vect_wavlet(1)-time_vect_wavlet(0)
PSD_Bx_time_scale_arr	= Abs(Bx_wavlet_arr)^2*dtime
PSD_By_time_scale_arr	= Abs(By_wavlet_arr)^2*dtime
PSD_Bz_time_scale_arr	= Abs(Bz_wavlet_arr)^2*dtime
PSD_Bt_time_scale_arr	= PSD_Bx_time_scale_arr + PSD_By_time_scale_arr + PSD_Bz_time_scale_arr
;;;---
PSD_Bpara_time_scale_arr	= Abs(Bpara_wavlet_arr)^2*dtime
PSD_Bperp_time_scale_arr	= (PSD_Bt_time_scale_arr - PSD_Bpara_time_scale_arr) / 2

;;--
num_times	= N_Elements(time_vect_wavlet)
num_periods	= N_Elements(period_vect_wavlet)
theta_arr	= Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr	= Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr	= Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr	= ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'B'+'_PSD_xyzt_time_scale_arr'+$
        '.sav'
data_descrip= 'got from "get_PSD_of_Bperp_Bpara_theta_scale_arr_200802.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  time_vect_v2, period_vect, $
  PSD_Bx_time_scale_arr,  PSD_By_time_scale_arr,  PSD_Bz_time_scale_arr,  PSD_Bt_time_scale_arr, $
  PSD_Bpara_time_scale_arr,  PSD_Bperp_time_scale_arr
  
  
  


Step4:
;===========================
;Step4:

;;--define 'theta_bin_min/max_vect'
num_theta_bins	= 90L
dtheta_bin		= 180./num_theta_bins
theta_bin_min_vect	= Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect	= (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'PSD_Bpara_theta_scale_arr'
PSD_Bpara_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
	theta_min_bin	= theta_bin_min_vect(i_theta)
	theta_max_bin	= theta_bin_max_vect(i_theta)
	sub_tmp	= Where(theta_arr(*,i_period) ge theta_min_bin and $
					theta_arr(*,i_period) lt theta_max_bin)
	If sub_tmp(0) ne -1 Then Begin
		PSD_vect_tmp	= PSD_Bpara_time_scale_arr(*,i_period)
		PSD_tmp	= Mean(PSD_vect_tmp(sub_tmp))
		PSD_Bpara_theta_scale_arr(i_theta,i_period)	= PSD_tmp
	EndIf
EndFor
EndFor

;;--get 'PSD_Bperp_theta_scale_arr'
PSD_Bperp_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
	theta_min_bin	= theta_bin_min_vect(i_theta)
	theta_max_bin	= theta_bin_max_vect(i_theta)
	sub_tmp	= Where(theta_arr(*,i_period) ge theta_min_bin and $
					theta_arr(*,i_period) lt theta_max_bin)
	If sub_tmp(0) ne -1 Then Begin
		PSD_vect_tmp	= PSD_Bperp_time_scale_arr(*,i_period)
		PSD_tmp	= Mean(PSD_vect_tmp(sub_tmp))
		PSD_Bperp_theta_scale_arr(i_theta,i_period)	= PSD_tmp
	EndIf
EndFor
EndFor

;;--get 'PSD_Bt_theta_scale_arr'
PSD_Bt_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)
PSD_Bt_theta_scale_arr	= PSD_Bperp_theta_scale_arr*2+PSD_Bpara_theta_scale_arr


;;--
dir_save	= 'C:\course\research\CDF\'+sub_dir_date
JulDay_min	= JulDay_min_v2
JulDay_max	= JulDay_min_v2+(Max(time_vect_wavlet)-Min(time_vect_wavlet))/(24.*60.*60)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str	= '(time='+$
		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save	= 'PSD_Bperp_Bpara_total_theta_period_arr'+$
				TimeRange_str+'.sav'
period_vect	= period_vect_wavlet
data_descrip= 'got from "get_PSD_of_Bperp_Bpara_theta_scale_arr_200802.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	theta_bin_min_vect, theta_bin_max_vect, $
	period_vect, $
	PSD_Bperp_theta_scale_arr, $
	PSD_Bpara_theta_scale_arr, $
	PSD_Bt_thet_scale_arr


Step5:
;===========================
;Step5:

;;--
time_min_TV	= time_vect_wavlet(0)
time_max_TV	= time_min_TV+24.*60.*60
sub_time_min_TV	= Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV	= sub_time_min_TV(0)
sub_time_max_TV	= Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV	= sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV	= time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
					(time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
					JulDay_min_v2
;;;---
period_vect_TV	= period_vect_wavlet
theta_arr_TV	= theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bpara_time_scale_arr_TV	= PSD_Bpara_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
theta_vect_TV	= theta_bin_min_vect
PSD_Bpara_theta_scale_arr_TV= PSD_Bpara_theta_scale_arr(*,*)

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize	= 750.0
ysize	= 1300.0
Window,1,XSize=xsize,YSize=ysize

;;--
LoadCT,13
TVLCT,R,G,B,/Get
color_red	= 255L
TVLCT,255L,0L,0L,color_red
color_green	= 254L
TVLCT,0L,255L,0L,color_green
color_blue	= 253L
TVLCT,0L,0L,255L,color_blue
color_white	= 252L
TVLCT,255L,255L,255L,color_white
color_black	= 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--
color_bg		= color_white
!p.background	= color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData	;change the background

;;--
position_img	= [0.10,0.15,0.90,0.98]
num_x_SubImgs	= 1
num_y_SubImgs	= 3
dx_pos_SubImg	= (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg	= (position_img(3)-position_img(1))/num_y_SubImgs


Step5_1:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 2
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= theta_arr_TV
sub_BadVal	= Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
	num_BadVal	= N_Elements(sub_BadVal)
	image_TV(sub_BadVal)	= 9999.0
EndIf Else Begin
	num_BadVal	= 0
EndElse
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= 'time'
ytitle	= 'period (s)'
title	= TexToIDL('\theta_{B^R}')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange	= [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange	= [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time	= xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv		= xtickv_time
xticks		= N_Elements(xtickv)-1
xticknames	= xticknames_time
xminor		= 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_SubImg,$
	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=0L,$
	/NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB		= [position_SubImg(2)+0.08,position_SubImg(1),$
					position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB			= TexToIDL('\theta')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


Step5_2:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 1
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= ALog10(PSD_Bpara_time_scale_arr_TV)
sub_BadVal	= Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
	num_BadVal	= N_Elements(sub_BadVal)
	image_TV(sub_BadVal)	= 9999.0
EndIf Else Begin
	num_BadVal	= 0
EndElse
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= 'time'
ytitle	= 'period (s)'
title	= TexToIDL('lg(PSD_Bpara)')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange	= [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange	= [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time	= xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv		= xtickv_time
xticks		= N_Elements(xtickv)-1
xticknames	= xticknames_time
xminor		= 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_SubImg,$
	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=0L,$
	/NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB		= [position_SubImg(2)+0.08,position_SubImg(1),$
					position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB			= TexToIDL('lg(PSD_Bpara)')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

Step5_3:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 0
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= ALog10(PSD_Bpara_theta_scale_arr_TV)
sub_BadVal	= Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
	num_BadVal	= N_Elements(sub_BadVal)
	image_TV(sub_BadVal)	= 9999.0
EndIf Else Begin
	num_BadVal	= 0
EndElse
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= TexToIDL('\theta')
ytitle	= 'period (s)'
title	= TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange	= [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange	= [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_SubImg,$
;a	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=0L,$
	/NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB		= [position_SubImg(2)+0.08,position_SubImg(1),$
					position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB			= TexToIDL('lg(PSD_Bpara)')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp	= 'got from "get_PSD_of_Bpara_Bperp_theta_scale_arr_200802.pro"'
AnnotStr_arr	= [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot	= position_img
For i_str=0,num_strings-1 Do Begin
	position_v1		= [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
	CharSize		= 0.95
	XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
			CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd	= TVRD(true=1)
dir_fig		= 'C:\course\research\CDF\'+sub_dir_date
file_version= '(v1)'
file_fig	= 'PSD_of_Bpara_theta_scale_arr'+$
				TimeRange_str+$
				file_version+$
				'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background	= color_bg


Step6:
;===========================
;Step6:

;;--
time_min_TV	= time_vect_wavlet(0)
time_max_TV	= time_min_TV+24.*60.*60
sub_time_min_TV	= Where(time_vect_wavlet ge time_min_TV)
sub_time_min_TV	= sub_time_min_TV(0)
sub_time_max_TV	= Where(time_vect_wavlet le time_max_TV)
sub_time_max_TV	= sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV	= time_vect_wavlet(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
					(time_vect_wavlet(sub_time_min_TV)-time_vect_wavlet(0))/(24.*60.*60)+$
					JulDay_min_v2
;;;---
period_vect_TV	= period_vect_wavlet
theta_arr_TV	= theta_arr(sub_time_min_TV:sub_time_max_TV,*)
PSD_Bperp_time_scale_arr_TV	= PSD_Bperp_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
theta_vect_TV	= theta_bin_min_vect
PSD_Bperp_theta_scale_arr_TV= PSD_Bperp_theta_scale_arr(*,*)

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize	= 750.0
ysize	= 1300.0
Window,1,XSize=xsize,YSize=ysize

;;--
LoadCT,13
TVLCT,R,G,B,/Get
color_red	= 255L
TVLCT,255L,0L,0L,color_red
color_green	= 254L
TVLCT,0L,255L,0L,color_green
color_blue	= 253L
TVLCT,0L,0L,255L,color_blue
color_white	= 252L
TVLCT,255L,255L,255L,color_white
color_black	= 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--
color_bg		= color_white
!p.background	= color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData	;change the background

;;--
position_img	= [0.10,0.15,0.90,0.98]
num_x_SubImgs	= 1
num_y_SubImgs	= 3
dx_pos_SubImg	= (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg	= (position_img(3)-position_img(1))/num_y_SubImgs


Step6_1:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 2
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= theta_arr_TV
sub_BadVal	= Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
	num_BadVal	= N_Elements(sub_BadVal)
	image_TV(sub_BadVal)	= 9999.0
EndIf Else Begin
	num_BadVal	= 0
EndElse
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= 'time'
ytitle	= 'period (s)'
title	= TexToIDL('\theta_{B^R}')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange	= [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange	= [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time	= xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv		= xtickv_time
xticks		= N_Elements(xtickv)-1
xticknames	= xticknames_time
xminor		= 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_SubImg,$
	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=0L,$
	/NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB		= [position_SubImg(2)+0.08,position_SubImg(1),$
					position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB			= TexToIDL('\theta')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


Step6_2:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 1
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= ALog10(PSD_Bperp_time_scale_arr_TV)
sub_BadVal	= Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
	num_BadVal	= N_Elements(sub_BadVal)
	image_TV(sub_BadVal)	= 9999.0
EndIf Else Begin
	num_BadVal	= 0
EndElse
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= 'time'
ytitle	= 'period (s)'
title	= TexToIDL('lg(PSD_Bperp)')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange	= [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange	= [Min(period_vect_TV), Max(period_vect_TV)]
xrange_time	= xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv		= xtickv_time
xticks		= N_Elements(xtickv)-1
xticknames	= xticknames_time
xminor		= 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_SubImg,$
	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=0L,$
	/NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB		= [position_SubImg(2)+0.08,position_SubImg(1),$
					position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB			= TexToIDL('lg(PSD_Bperp)')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

Step6_3:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 0
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= ALog10(PSD_Bperp_theta_scale_arr_TV)
sub_BadVal	= Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
	num_BadVal	= N_Elements(sub_BadVal)
	image_TV(sub_BadVal)	= 9999.0
EndIf Else Begin
	num_BadVal	= 0
EndElse
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= TexToIDL('\theta')
ytitle	= 'period (s)'
title	= TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange	= [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange	= [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_SubImg,$
;a	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=0L,$
	/NoErase,Font=-1,CharThick=1.0,Thick=1.0,/YLog
;;;---
position_CB		= [position_SubImg(2)+0.08,position_SubImg(1),$
					position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB			= TexToIDL('lg(PSD_Bperp)')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp	= 'got from "get_PSD_of_Bpara_Bperp_theta_scale_arr_200802.pro"'
AnnotStr_arr	= [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot	= position_img
For i_str=0,num_strings-1 Do Begin
	position_v1		= [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
	CharSize		= 0.95
	XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
			CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd	= TVRD(true=1)
dir_fig		= 'C:\course\research\CDF\'+sub_dir_date
file_version= '(v1)'
file_fig	= 'PSD_of_Bperp_theta_scale_arr'+$
				TimeRange_str+$
				file_version+$
				'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background	= color_bg



End_Program:
End