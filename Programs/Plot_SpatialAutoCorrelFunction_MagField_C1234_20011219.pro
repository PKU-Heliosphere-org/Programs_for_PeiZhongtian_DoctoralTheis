;Pro Plot_SpatialAutoCorrelFunction_MagField_C1234_20011219

;previous program: "get_TimeLaggedCrossCorrelation_MagField_C1234_20011219.pro"
;					"get_dt_max_for_SpatialAutoCorrelate_20011219.pro"
;It is like Fig.2 in paper "Osman & Horbury (2007)"

sub_dir_date= '2001-12-19\'


Step1:
;=============================================
;Step1

;;--
choice_B_component	= 0
Read, 'choice_B_component(1/2/3/4/5/6: Bx/By/Bz/B_para/B_perp/B_mag): ', choice_B_component
If choice_B_component eq 1 Then Begin
	FileName_BComp	= 'Bx'
EndIf
If choice_B_component eq 2 Then Begin
	FileName_BComp	= 'By'
EndIf
If choice_B_component eq 3 Then Begin
	FileName_BComp	= 'Bz'
EndIf
If choice_B_component eq 4 Then Begin
	FileName_BComp	= 'Bpara'
EndIf
If choice_B_component eq 5 Then Begin
	FileName_BComp	= 'Bperp'
EndIf
If choice_B_component eq 6 Then Begin
	FileName_BComp	= 'Bmag'
EndIf

;;--
dir_restore	= GetEnv('FGM_Data_Dir')+sub_dir_date
file_restore= 'TimeRange_str_vect(for cross-correlation).sav'
;data_descrip= 'got from "get_TimeLaggedCrossCorrelation_MagField_C1234_20011219.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	TimeRange_str_vect, JulDay_beg_vect, JulDay_end_vect
Restore, dir_restore+file_restore, /Verbose
num_TimeRanges	= N_Elements(TimeRange_str_vect)
For i_TimeRange=0,num_TimeRanges-1 Do Begin
	TimeRange_str	= TimeRange_str_vect(i_TimeRange)
	JulDay_min		= JulDay_beg_vect(i_TimeRange)
	JulDay_max		= JulDay_end_vect(i_TimeRange)

;;--
dir_restore	= GetEnv('FGM_Data_Dir') + sub_dir_date
file_restore= 'TimeLaggedCrossCorrel_'+$
				FileName_BComp+'_C1234'+$
;a				'(Time=*-*)'+$
				TimeRange_str+$
				'.sav'
file_data	= dir_restore + file_restore
;file_array	= FindFile(dir_restore+file_restore,count=num_files)
;file_array	= file_array(Sort(file_array))
;For i_file=0,num_files-1 Do Begin
;	Print,'i_file:',i_file,', ',file_array(i_file)
;EndFor
;i_select	= 0L
;Read,'i_select:',i_select
;file_data	= file_array(i_select)
Restore, file_data, /Verbose
;data_descrip= 'got from "get_TimeLaggedCrossCorrelation_NumDens_C1234_20010405.pro"'
;Save,FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_vect, NumDens_vect_C1_v2, NumDens_vect_C2_v2, NumDens_vect_C3_v2, NumDens_vect_C4_v2, $
;	TimeLag_vect, CrossCorr_vect_C12, CrossCorr_vect_C13, CrossCorr_vect_C14, $
;	CrossCorr_vect_C23, CrossCorr_vect_C24, CrossCorr_vect_C34, AutoCorr_vect_C11, $
;	AverTheta_VB, MidTheta_VB, StdDevTheta_VB
;CalDat, Min(JulDay_vect), month_beg, day_beg, year_beg,$
;		hour_beg, minute_beg, second_beg
;hour_beg_str	= String(hour_beg, format='(I2.2)')
;minute_beg_str	= String(minute_beg, format='(I2.2)')
;second_beg_str	= String(second_beg, format='(I2.2)')
;time_beg_str	= hour_beg_str+minute_beg_str+second_beg_str
;CalDat, Max(JulDay_vect), month_end, day_end, year_end,$
;		hour_end, minute_end, second_end
;hour_end_str	= String(hour_end, format='(I2.2)')
;minute_end_str	= String(minute_end, format='(I2.2)')
;second_end_str	= String(second_end, format='(I2.2)')
;time_end_str	= hour_end_str+minute_end_str+second_end_str
;TimeRange_str	= '(Time='+time_beg_str+'-'+time_end_str+')'

;;--
dir_restore	= GetEnv('CIS_Data_Dir') + sub_dir_date
file_restore= 'r1234&Vsw&VA'+$
;a				'(Time=*-*)'+$
				TimeRange_str+$
				'.sav'
file_data	= dir_restore+file_restore
;file_array	= FindFile(dir_restore+file_restore,count=num_files)
;file_array	= file_array(Sort(file_array))
;For i_file=0,num_files-1 Do Begin
;	Print,'i_file:',i_file,', ',file_array(i_file)
;EndFor
;i_select	= 0L
;Read,'i_select:',i_select
;file_data	= file_array(i_select)
Restore, file_data, /Verbose
;data_descrip= 'got from "get_dt_max_for_SpatialAutoCorrelate_20010405.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	r12_xyz_aver,r13_xyz_aver,r14_xyz_aver,r23_xyz_aver,r24_xyz_aver,r34_xyz_aver,$
;	Vsw_xyz_aver,VA_xyz_aver,$
;	theta_LowerLimit,theta_UpperLimit,$
;	theta_r12_Vsw,theta_r13_Vsw,theta_r14_Vsw,theta_r23_Vsw,theta_r24_Vsw,theta_r34_Vsw,$
;	dt_C12,dt_C13,dt_C14,dt_C23,dt_C24,dt_C34


Step2:
;=============================================
;Step2

;;--
If (Imaginary(dt_C12(0)) le 1.e-4) Then Begin
	dt_C12_min	= Min(Real_Part(dt_C12))
	dt_C12_max	= Max(Real_part(dt_C12))
	sub_good_TimeLag	= Where(TimeLag_vect le dt_C12_min or TimeLag_vect ge dt_C12_max)
	TimeLag_C12_vect	= TimeLag_vect(sub_good_TimeLag)
EndIf Else Begin
	TimeLag_C12_vect	= TimeLag_vect
EndELse

;;--
If (Imaginary(dt_C13(0)) le 1.e-4) Then Begin
	dt_C13_min	= Min(Real_Part(dt_C13))
	dt_C13_max	= Max(Real_part(dt_C13))
	sub_good_TimeLag	= Where(TimeLag_vect le dt_C13_min or TimeLag_vect ge dt_C13_max)
	TimeLag_C13_vect	= TimeLag_vect(sub_good_TimeLag)
EndIf Else Begin
	TimeLag_C13_vect	= TimeLag_vect
EndELse

;;--
If (Imaginary(dt_C14(0)) le 1.e-4) Then Begin
	dt_C14_min	= Min(Real_Part(dt_C14))
	dt_C14_max	= Max(Real_part(dt_C14))
	sub_good_TimeLag	= Where(TimeLag_vect le dt_C14_min or TimeLag_vect ge dt_C14_max)
	TimeLag_C14_vect	= TimeLag_vect(sub_good_TimeLag)
EndIf Else Begin
	TimeLag_C14_vect	= TimeLag_vect
EndELse

;;--
If (Imaginary(dt_C23(0)) le 1.e-4) Then Begin
	dt_C23_min	= Min(Real_Part(dt_C23))
	dt_C23_max	= Max(Real_part(dt_C23))
	sub_good_TimeLag	= Where(TimeLag_vect le dt_C23_min or TimeLag_vect ge dt_C23_max)
	TimeLag_C23_vect	= TimeLag_vect(sub_good_TimeLag)
EndIf Else Begin
	TimeLag_C23_vect	= TimeLag_vect
EndELse

;;--
If (Imaginary(dt_C24(0)) le 1.e-4) Then Begin
	dt_C24_min	= Min(Real_Part(dt_C24))
	dt_C24_max	= Max(Real_part(dt_C24))
	sub_good_TimeLag	= Where(TimeLag_vect le dt_C24_min or TimeLag_vect ge dt_C24_max)
	TimeLag_C24_vect	= TimeLag_vect(sub_good_TimeLag)
EndIf Else Begin
	TimeLag_C24_vect	= TimeLag_vect
EndELse

;;--
If (Imaginary(dt_C34(0)) le 1.e-4) Then Begin
	dt_C34_min	= Min(Real_Part(dt_C34))
	dt_C34_max	= Max(Real_part(dt_C34))
	sub_good_TimeLag	= Where(TimeLag_vect le dt_C34_min or TimeLag_vect ge dt_C34_max)
	TimeLag_C34_vect	= TimeLag_vect(sub_good_TimeLag)
EndIf Else Begin
	TimeLag_C34_vect	= TimeLag_vect
EndELse



Step3:
;=============================================
;Step3

;;--
unit_B_para	= VA_xyz_aver/Norm(VA_xyz_aver)

;;--
num_TimeLags	= N_Elements(TimeLag_C12_vect)
SpaAutoCorr_C12_vect	= Dblarr(num_TimeLags)
r_para_C12_vect	= Dblarr(num_TimeLags)
r_perp_C12_vect	= Dblarr(num_TimeLags)
For i_TimeLag=0,num_TimeLags-1 Do Begin
	TimeLag_tmp	= TimeLag_C12_vect(i_TimeLag)
	S12_xyz_tmp	= r12_xyz_aver-Vsw_xyz_aver*TimeLag_tmp
	S12_para_tmp= S12_xyz_tmp##Transpose(unit_B_para)
	S12_perp_tmp= Norm(S12_xyz_tmp-S12_para_tmp(0)*unit_B_para)
	r_para_C12_vect(i_TimeLag)	= Abs(S12_para_tmp(0))
	r_perp_C12_vect(i_TimeLag)	= S12_perp_tmp
	SpaAutoCorr_C12_vect(i_TimeLag)	= CrossCorr_vect_C12(i_TimeLag)
EndFor

;;--
num_TimeLags	= N_Elements(TimeLag_C13_vect)
SpaAutoCorr_C13_vect	= Dblarr(num_TimeLags)
r_para_C13_vect	= Dblarr(num_TimeLags)
r_perp_C13_vect	= Dblarr(num_TimeLags)
For i_TimeLag=0,num_TimeLags-1 Do Begin
	TimeLag_tmp	= TimeLag_C13_vect(i_TimeLag)
	S13_xyz_tmp	= r13_xyz_aver-Vsw_xyz_aver*TimeLag_tmp
;d	S13_xyz_tmp	= -Vsw_xyz_aver*TimeLag_tmp
	S13_para_tmp= S13_xyz_tmp##Transpose(unit_B_para)
	S13_perp_tmp= Norm(S13_xyz_tmp-S13_para_tmp(0)*unit_B_para)
	r_para_C13_vect(i_TimeLag)	= Abs(S13_para_tmp(0))
	r_perp_C13_vect(i_TimeLag)	= S13_perp_tmp
	SpaAutoCorr_C13_vect(i_TimeLag)	= CrossCorr_vect_C13(i_TimeLag)
EndFor

;;--
num_TimeLags	= N_Elements(TimeLag_C14_vect)
SpaAutoCorr_C14_vect	= Dblarr(num_TimeLags)
r_para_C14_vect	= Dblarr(num_TimeLags)
r_perp_C14_vect	= Dblarr(num_TimeLags)
For i_TimeLag=0,num_TimeLags-1 Do Begin
	TimeLag_tmp	= TimeLag_C14_vect(i_TimeLag)
	S14_xyz_tmp	= r14_xyz_aver-Vsw_xyz_aver*TimeLag_tmp
	S14_para_tmp= S14_xyz_tmp##Transpose(unit_B_para)
	S14_perp_tmp= Norm(S14_xyz_tmp-S14_para_tmp(0)*unit_B_para)
	r_para_C14_vect(i_TimeLag)	= Abs(S14_para_tmp(0))
	r_perp_C14_vect(i_TimeLag)	= S14_perp_tmp
	SpaAutoCorr_C14_vect(i_TimeLag)	= CrossCorr_vect_C14(i_TimeLag)
EndFor

;;--
num_TimeLags	= N_Elements(TimeLag_C23_vect)
SpaAutoCorr_C23_vect	= Dblarr(num_TimeLags)
r_para_C23_vect	= Dblarr(num_TimeLags)
r_perp_C23_vect	= Dblarr(num_TimeLags)
For i_TimeLag=0,num_TimeLags-1 Do Begin
	TimeLag_tmp	= TimeLag_C23_vect(i_TimeLag)
	S23_xyz_tmp	= r23_xyz_aver-Vsw_xyz_aver*TimeLag_tmp
	S23_para_tmp= S23_xyz_tmp##Transpose(unit_B_para)
	S23_perp_tmp= Norm(S23_xyz_tmp-S23_para_tmp(0)*unit_B_para)
	r_para_C23_vect(i_TimeLag)	= Abs(S23_para_tmp(0))
	r_perp_C23_vect(i_TimeLag)	= S23_perp_tmp
	SpaAutoCorr_C23_vect(i_TimeLag)	= CrossCorr_vect_C23(i_TimeLag)
EndFor

;;--
num_TimeLags	= N_Elements(TimeLag_C24_vect)
SpaAutoCorr_C24_vect	= Dblarr(num_TimeLags)
r_para_C24_vect	= Dblarr(num_TimeLags)
r_perp_C24_vect	= Dblarr(num_TimeLags)
For i_TimeLag=0,num_TimeLags-1 Do Begin
	TimeLag_tmp	= TimeLag_C24_vect(i_TimeLag)
	S24_xyz_tmp	= r24_xyz_aver-Vsw_xyz_aver*TimeLag_tmp
	S24_para_tmp= S24_xyz_tmp##Transpose(unit_B_para)
	S24_perp_tmp= Norm(S24_xyz_tmp-S24_para_tmp(0)*unit_B_para)
	r_para_C24_vect(i_TimeLag)	= Abs(S24_para_tmp(0))
	r_perp_C24_vect(i_TimeLag)	= S24_perp_tmp
	SpaAutoCorr_C24_vect(i_TimeLag)	= CrossCorr_vect_C24(i_TimeLag)
EndFor

;;--
num_TimeLags	= N_Elements(TimeLag_C34_vect)
SpaAutoCorr_C34_vect	= Dblarr(num_TimeLags)
r_para_C34_vect	= Dblarr(num_TimeLags)
r_perp_C34_vect	= Dblarr(num_TimeLags)
For i_TimeLag=0,num_TimeLags-1 Do Begin
	TimeLag_tmp	= TimeLag_C34_vect(i_TimeLag)
	S34_xyz_tmp	= r34_xyz_aver-Vsw_xyz_aver*TimeLag_tmp
	S34_para_tmp= S34_xyz_tmp##Transpose(unit_B_para)
	S34_perp_tmp= Norm(S34_xyz_tmp-S34_para_tmp(0)*unit_B_para)
	r_para_C34_vect(i_TimeLag)	= Abs(S34_para_tmp(0))
	r_perp_C34_vect(i_TimeLag)	= S34_perp_tmp
	SpaAutoCorr_C34_vect(i_TimeLag)	= CrossCorr_vect_C34(i_TimeLag)
EndFor

;;--
dir_save	= GetEnv('FGM_Data_Dir')+sub_dir_date
file_save	= 'SpatialAutoCorrelFunction_'+$
				FileName_BComp+'_C1234'+$
				TimeRange_str+$
;a				file_version+$
				'.sav'
data_descrip= 'got from "Plot_SpatialAutoCorrelFunction_MagField_C1234_20011219.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	r_para_C12_vect,r_perp_C12_vect,SpaAutoCorr_C12_vect, $
	r_para_C13_vect,r_perp_C13_vect,SpaAutoCorr_C13_vect, $
	r_para_C14_vect,r_perp_C14_vect,SpaAutoCorr_C14_vect, $
	r_para_C23_vect,r_perp_C23_vect,SpaAutoCorr_C23_vect, $
	r_para_C24_vect,r_perp_C24_vect,SpaAutoCorr_C24_vect, $
	r_para_C34_vect,r_perp_C34_vect,SpaAutoCorr_C34_vect



Step4:
;=============================================
;Step4

;;--
Set_Plot,'WIN'
Device,DeComposed=0
xsize	= 1000.0
ysize	= 900.0
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
position_plot_ThetaVB	= [0.10,0.70,0.90,0.95]
position_plot_TimeLagCC	= [0.10,0.20,0.50,0.65]
position_plot_SpaAutoCC	= [0.50,0.20,0.95,0.65]

;;--
xrange	= [0.0, 1.e4]	;unit: km
yrange	= [0.0, 1.e4]	;unit: km
win_position		= position_plot_SpaAutoCC
half_width_max		= 0.40
winsize_xy_ratio	= xsize/ysize
position_SubImg		= Fig_Position_v2(xrange,yrange,half_width_max=half_width_max,WinSize_xy_ratio=WinSize_xy_ratio,win_position=win_position)
xtitle	= 'r_para [km]'
ytitle	= 'r_perp [km]'
title	= 'Spatial Auto-Correlation Function'
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	XTitle=xtitle,YTitle=ytitle,Title=title,$
	Position=position_SubImg,/NoData,Color=color_black

;;--
r_para_vect			= [r_para_C12_vect,r_para_C13_vect,r_para_C14_vect,$
						r_para_C23_vect,r_para_C24_vect,r_para_C34_vect]
r_perp_vect			= [r_perp_C12_vect,r_perp_C13_vect,r_perp_C14_vect,$
						r_perp_C23_vect,r_perp_C24_vect,r_perp_C34_vect]
SpaAutoCorr_vect	= [SpaAutoCorr_C12_vect,SpaAutoCorr_C13_vect,SpaAutoCorr_C14_vect,$
						SpaAutoCorr_C23_vect,SpaAutoCorr_C24_vect,SpaAutoCorr_C34_vect]
sub_InArea	= Where(r_para_vect ge xrange(0) and r_para_vect le xrange(1) and $
					r_perp_vect ge yrange(0) and r_perp_vect le yrange(1))
image_TV	= SpaAutoCorr_vect(sub_InArea)
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.005*(N_Elements(image_TV))))
;a min_image= 0.70
max_image	= image_TV_v2(Long(0.995*(N_Elements(image_TV))))
;a max_image= 0.95
is_continue	= ' '
;Read, 'is_continue: ', is_continue
byt_image_TV= BytSCL(SpaAutoCorr_vect,min=min_image,max=max_image, Top=num_CB_color-1)
Color_SpaAutoCorr_vect	= byt_image_TV

;;--
num_points	= N_Elements(r_para_vect)
For i_point=0,num_points-1 Do Begin
	r_para_tmp	= r_para_vect(i_point)
	r_perp_tmp	= r_perp_vect(i_point)
	color_tmp	= Color_SpaAutoCorr_vect(i_point)
	PlotSym, 0, 1.8, FILL=1,thick=0.5,Color=color_tmp
	Plots, r_para_tmp, r_perp_tmp, Psym=8, NoClip=0
EndFor

;;--
position_CB		= [position_SubImg(2)+0.09,position_SubImg(1),$
					position_SubImg(2)+0.11,position_SubImg(3)]
num_ticks		= 3
num_divisions	= num_ticks-1
max_tickn		= max_image
min_tickn		= min_image
interv_ints		= (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB		= String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.2)');the tick-names of colorbar 15
;a tickn_CB		= Replicate(' ',num_ticks)
titleCB			= 'CorrelCoeff'
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;;---
xrange		= [Min(time_tags_vect_FGM),Max(time_tags_vect_FGM)]
xrange_time	= xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv		= xtickv_time
xticks		= N_Elements(xtickv)-1
xticknames	= xticknames_time
;a	xminor	= xminor_time
xminor		= 6
yrange		= [Min(theta_VB_vect),Max(theta_VB_vect)]
xtitle		= 'time'
ytitle		= 'theta_VB(degree)'
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
	Position=position_plot_ThetaVB,$
	XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
	XTitle=xtitle,YTitle=ytitle,$
	/NoData,Color=color_black,$
	/NoErase,Font=-1
PolyFill, [JulDay_min,JulDay_max,JulDay_max,JulDay_min,JulDay_min],$
		[yrange(0),yrange(0),yrange(1),yrange(1),yrange(0)], Color=color_blue
Plots, time_tags_vect_FGM, theta_VB_vect, Color=color_black

;;--
xrange	= [Min(TimeLag_vect),Max(TimeLag_vect)]
yrange	= [Min([CrossCorr_vect_C12,CrossCorr_vect_C13,CrossCorr_vect_C14,CrossCorr_vect_C23,CrossCorr_vect_C24,CrossCorr_vect_C34,AutoCorr_vect_C11]),$
		   Max([CrossCorr_vect_C12,CrossCorr_vect_C13,CrossCorr_vect_C14,CrossCorr_vect_C23,CrossCorr_vect_C24,CrossCorr_vect_C34,AutoCorr_vect_C11])]
xtitle	= 'Time Lags (s)'
ytitle	= 'Correlation'
Plot, TimeLag_vect,CrossCorr_vect_C12,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,/NoErase,$
	XTitle=xtitle,YTitle=ytitle,Position=position_plot_TimeLagCC,LineStyle=0,Thick=1.0,Color=color_black
Plots, TimeLag_vect,CrossCorr_vect_C13,LineStyle=0,Thick=1.0,Color=color_red
Plots, TimeLag_vect,CrossCorr_vect_C14,LineStyle=0,Thick=1.0,Color=color_green
Plots, TimeLag_vect,CrossCorr_vect_C23,LineStyle=0,Thick=1.0,Color=color_blue
Plots, TimeLag_vect,CrossCorr_vect_C24,LineStyle=2,Thick=1.0,Color=color_black
Plots, TimeLag_vect,CrossCorr_vect_C34,LineStyle=2,Thick=1.0,Color=color_red
Plots, TimeLag_vect,AutoCorr_vect_C11,LineStyle=1,Thick=2.0,Color=color_black

;;--
AnnotStr_tmp	= 'got from "plot_SpatialAutoCorrelFunction_MagField_C1234_20011219.pro"'
AnnotStr_arr	= [AnnotStr_tmp]
Vsw_str			= String(Vsw_xyz_aver,Format='(F6.1)')
unit_B_str		= String(unit_B_para,Format='(F6.1)')
AnnotStr_arr	= [AnnotStr_arr, AnnotStr_tmp]
AnnotStr_tmp	= 'AverTheta_VB: '+String(AverTheta_VB,Format='(F6.1)')+';  '+$
					'MedianTheta_VB: '+String(MidTheta_VB,Format='(F6.1)')+';  '+$
					'StdDevTheta_VB: '+String(StdDevTheta_VB,Format='(F6.1)')+';   '+$
					'Vsw_xyz_aver: ['+Vsw_str(0)+', '+Vsw_str(1)+', '+Vsw_str(2)+'];   '+$
					'unit_B: ['+unit_B_str(0)+', '+unit_B_str(1)+', '+unit_B_str(2)+']; '
AnnotStr_arr	= [AnnotStr_arr, AnnotStr_tmp]
AnnotStr_tmp	= TimeRange_str
AnnotStr_arr	= [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot	= position_plot_TimeLagCC
For i_str=0,num_strings-1 Do Begin
	position_v1		= [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
	CharSize		= 0.95
	XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
			CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd	= TVRD(true=1)
dir_fig		= GetEnv('FGM_Figure_Dir')+sub_dir_date
file_version= '(v1)'
file_fig	= 'SpatialAutoCorrelFunction_'+$
				FileName_BComp+'_C1234'+$
				TimeRange_str+$
				file_version+$
				'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background	= color_bg


EndFor	;For i_TimeRange=0,num_TimeRanges-1 Do Begin


End_Program:
End