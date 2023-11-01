;Pro plot_Hodogram_ByBz_of_SubWaves_WIND_MFI_199502

sub_dir_date  = '2005-03/';'1995-12-25/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore	= GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'LocalBG_of_MagField(time=*-*)*.sav'
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
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_vect, $
;  Bxyz_LBG_GSE_arr
;;;---
time_vect_LBG	= time_vect_v2
period_vect_LBG	= period_vect
period_vect_LBG	= period_vect

;;--
num_times	= N_Elements(time_vect_LBG)
num_periods	= N_Elements(period_vect_LBG)
theta_arr	= Fltarr(num_times, num_periods)
Bx_LBG_GSE_arr	= Reform(Bxyz_LBG_GSE_arr(0,*,*))
Bt_LBG_GSE_arr	= Reform(Sqrt(Bxyz_LBG_GSE_arr(0,*,*)^2+Bxyz_LBG_GSE_arr(1,*,*)^2+Bxyz_LBG_GSE_arr(2,*,*)^2))
theta_arr	= ACos(Bx_LBG_GSE_arr/Bt_LBG_GSE_arr)*180/!pi
num_times_LBG	= num_times


Step2:
;===========================
;Step2:

;;--
FileName_BComp	= 'By'
PeriodRange_str	= '(period=*-*)'
TimeRange_str	= '(time=*-*)'
file_restore= FileName_BComp+'_SubWave_vect'+$
				PeriodRange_str+$
				TimeRange_str+file_version+'.sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_SubWave_Wavelet_of_BComp_vect_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_range, $
;  SubWave_BComp_vect
;;;---
time_vect_By	= time_vect_v2
SubWave_By_vect	= SubWave_BComp_vect

;;--
FileName_BComp	= 'Bz'
PeriodRange_str	= '(period=*-*)'
TimeRange_str	= '(time=*-*)'
file_restore= FileName_BComp+'_SubWave_vect'+$
				PeriodRange_str+$
				TimeRange_str+file_version+'.sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_SubWave_Wavelet_of_BComp_vect_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_range, $
;  SubWave_BComp_vect
;;;---
time_vect_Bz	= time_vect_v2
SubWave_Bz_vect	= SubWave_BComp_vect

;;--
JulDay_vect_wavlet  = JulDay_min_v2 + time_vect_v2 / (24.*60*60)

;;--
pos_beg	= StrPos(file_restore, '(time=')
TimeRange_str	= StrMid(file_restore, pos_beg, 24)
pos_beg	= StrPos(file_restore, '(period=')
PeriodRange_str	= StrMid(file_restore, pos_beg, 18)


Step3:
;===========================
;Step3:

;;--
sub_period		= Where((period_vect_LBG ge period_range(0)) and (period_vect_LBG le period_range(1)))
num_periods_v2	= N_Elements(sub_period)
theta_arr_v2	= theta_arr(*,sub_period(0):sub_period(num_periods_v2-1))
If num_periods_v2 ge 2 Then Begin
	theta_vect	= Total(theta_arr_v2,2)/num_periods_v2
EndIf Else Begin
	theta_vect	= Reform(theta_arr_v2)
EndElse

;;--
Bx_LBG_arr_v2	= Reform(Bxyz_LBG_GSE_arr(0,*,sub_period(0):sub_period(num_periods_v2-1)))
By_LBG_arr_v2	= Reform(Bxyz_LBG_GSE_arr(1,*,sub_period(0):sub_period(num_periods_v2-1)))
Bz_LBG_arr_v2	= Reform(Bxyz_LBG_GSE_arr(2,*,sub_period(0):sub_period(num_periods_v2-1)))
If num_periods_v2 ge 2 Then Begin
	Bx_LBG_vect	= Total(Bx_LBG_arr_v2,2)/num_periods_v2
	By_LBG_vect	= Total(By_LBG_arr_v2,2)/num_periods_v2
	Bz_LBG_vect	= Total(Bz_LBG_arr_v2,2)/num_periods_v2
EndIf Else Begin
	Bx_LBG_vect	= Reform(Bx_LBG_arr_v2)
	By_LBG_vect	= Reform(By_LBG_arr_v2)
	Bz_LBG_vect	= Reform(Bz_LBG_arr_v2)
EndElse

;;--
year_beg_plot=1995 & mon_beg_plot=2 & day_beg_plot=4
hour_beg_plot=7 & min_beg_plot=35 & sec_beg_plot=25
year_end_plot=1995 & mon_end_plot=2 & day_end_plot=4
hour_end_plot=7 & min_end_plot=35 & sec_end_plot=35

;;--
year_beg_plot=2005 & mon_beg_plot=3 & day_beg_plot=11
hour_beg_plot=15 & min_beg_plot=46 & sec_beg_plot=0
year_end_plot=2005 & mon_end_plot=3 & day_end_plot=11
hour_end_plot=15 & min_end_plot=51 & sec_end_plot=0

JulDay_beg_plot = JulDay(mon_beg_plot,day_beg_plot,year_beg_plot,hour_beg_plot,min_beg_plot,sec_beg_plot)
JulDay_end_plot = JulDay(mon_end_plot,day_end_plot,year_end_plot,hour_end_plot,min_end_plot,sec_end_plot)
sub_beg_tmp = Where(JulDay_vect_wavlet ge JulDay_beg_plot)
sub_beg_tmp = sub_beg_tmp(0)
sub_end_tmp = Where(JulDay_vect_wavlet le JulDay_end_plot)
sub_end_tmp = sub_end_tmp(N_Elements(sub_end_tmp)-1)



;=============
Step4:
;Step4

;;--
SubWave_By_vect_plot = SubWave_By_vect(sub_beg_tmp:sub_end_tmp)
SubWave_Bz_vect_plot = SubWave_Bz_vect(sub_beg_tmp:sub_end_tmp)

;;---
Bx_LBG_plot  = Mean(Bx_LBG_vect(sub_beg_tmp:sub_end_tmp),/NaN)
By_LBG_plot  = Mean(By_LBG_vect(sub_beg_tmp:sub_end_tmp),/NaN)
Bz_LBG_plot  = Mean(Bz_LBG_vect(sub_beg_tmp:sub_end_tmp),/NaN)
B_LBG_plot = Norm([Bx_LBG_plot, By_LBG_plot, Bz_LBG_plot])

;;--
TimeRange_str	= '(time='+String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')+'-'+$
						    String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')+')'

;;--
Set_Plot, 'X'
Device,DeComposed=0
xsize	= 750.0
ysize	= 750.0
Window,1,XSize=xsize,YSize=ysize,Retain=2

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
position_img	= [0.10,0.15,0.90,0.95]
;;;---
xrange	= [Min(SubWave_By_vect_plot),Max(SubWave_Bz_vect_plot)]
xrange	= [xrange(0)-0.05*(xrange(1)-xrange(0)), xrange(1)+0.05*(xrange(1)-xrange(0))]
yrange	= [Min(SubWave_Bz_vect_plot),Max(SubWave_Bz_vect_plot)]
yrange	= [yrange(0)-0.05*(yrange(1)-yrange(0)), yrange(1)+0.05*(yrange(1)-yrange(0))]
xrange	= [-0.6,+0.6]
yrange	= [-0.6,+0.6]
xtitle	= 'By [nT]'
ytitle	= 'Bz [nT]'
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
	Position=position_img, LineStyle=0, Color=color_black, Thick=2.0, $
	XTitle=xtitle, YTitle=ytitle, CharSize=1.2, /NoData

By_vect_tmp = SubWave_By_vect_plot
Bz_vect_tmp = SubWave_Bz_vect_plot
Plots, By_vect_tmp, Bz_vect_tmp, LineStyle=0, Color=color_black, NoClip=0
num_pnts_InSeg	= N_Elements(By_vect_tmp)
If num_pnts_InSeg eq 1 Then Stop
By_beg_v1=By_vect_tmp(0) & By_end_v1=By_vect_tmp(1)
Bz_beg_v1=Bz_vect_tmp(0) & Bz_end_v1=Bz_vect_tmp(1)
sub_tmp	= Where(By_vect_tmp ge 0.15 or Bz_vect_tmp ge 0.15)
sub_tmp = Where(Abs(By_vect_tmp) ge 0.10 or Abs(Bz_vect_tmp) ge 0.10)
If (sub_tmp(0) ne -1 and sub_tmp(0) lt N_Elements(By_vect_tmp)-1) Then Begin
		;;;---plot only one arrow
;		sub_tmp	= sub_tmp(0)
;    Arrow, By_vect_tmp(sub_tmp), Bz_vect_tmp(sub_tmp), By_vect_tmp(sub_tmp+1), Bz_vect_tmp(sub_tmp+1), /Data, Color=color_red,Thick=2.0
    ;;;---plot multiple arrows
		num_times = N_Elements(sub_tmp)
		For i_time=0,num_times,10 Do Begin
		  sub_tmp_v2  = sub_tmp(i_time)
      Arrow, By_vect_tmp(sub_tmp_v2), Bz_vect_tmp(sub_tmp_v2), By_vect_tmp(sub_tmp_v2+1), Bz_vect_tmp(sub_tmp_v2+1), /Data, Color=color_red,Thick=2.0
    EndFor  

EndIf

Bx_LBG_tmp=Bx_LBG_plot & By_LBG_tmp=By_LBG_plot & Bz_LBG_tmp=Bz_LBG_plot & B_LBG_tmp=B_LBG_plot
Plots, [0.,By_LBG_tmp],[0.,Bz_LBG_tmp], LineStyle=0, Color=color_blue, NoClip=0
;a Plots, -[0.,By_LBG_tmp],-[0.,Bz_LBG_tmp], LineStyle=0, Color=color_blue, NoClip=0
;a XYOuts, 0.2, 0.25, 'i_seg: '+String(i_seg, format='(I4.4)'), CharThick=2.0, Color=color_black, /Normal
XYOuts, 0.2, 0.20, 'B_LBG: '+String(B_LBG_tmp,format='(f5.2)'), CharThick=2.0, Color=color_blue, /Normal

;;--
AnnotStr_tmp	= 'got from "plot_Hodogram_ByBz_of_SubWaves_WIND_MFI_199502.pro"'
AnnotStr_arr	= [AnnotStr_tmp]
;a AnnotStr_tmp	= PeriodRange_str+'; '+ThetaRange_str+'; '+TimeRange_str
AnnotStr_tmp	= PeriodRange_str+'; '+TimeRange_str
AnnotStr_arr	= [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot	= position_img
For i_str=0,num_strings-1 Do Begin
	position_v1		= [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
	CharSize		= 1.0
	XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
			CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd	= TVRD(true=1)
dir_fig		= GetEnv('WIND_MFI_Figure_Dir')+''+sub_dir_date+''
fig_version	= ''
file_fig	= 'Hodogram_ByBz_of_SubWaves'+$
				PeriodRange_str+TimeRange_str+$
				fig_version+$
				'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background	= color_bg




End_Program:
End