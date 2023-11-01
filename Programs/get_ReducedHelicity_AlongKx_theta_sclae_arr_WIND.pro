;Pro get_ReducedHelicity_AlongKx_theta_scale_arr_200802


sub_dir_date  = '1995-12-25/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


;Goto, Step4
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
pos_beg	= StrPos(file_restore, '(time=')
TimeRange_str	= StrMid(file_restore, pos_beg, 24)


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
JulDay_vect_wavlet  = JulDay_min_v2 + time_vect_wavlet/(24*60*60.)
period_vect_wavlet  = period_vect
Bz_wavlet_arr = BComp_wavlet_arr


;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'LocalBG_of_MagField(time=*-*)*.sav'
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
time_vect_LBG   = time_vect_v2
period_vect_LBG = period_vect
num_times   = N_Elements(time_vect_LBG)
num_periods = N_Elements(period_vect_LBG)
Bxyz_LBG_RTN_arr  = Fltarr(3,num_times,num_periods)
Bxyz_LBG_RTN_arr(0,*,*) = -Bxyz_LBG_GSE_arr(0,*,*)
Bxyz_LBG_RTN_arr(1,*,*) = -Bxyz_LBG_GSE_arr(1,*,*)
Bxyz_LBG_RTN_arr(2,*,*) = +Bxyz_LBG_GSE_arr(2,*,*)


;;--
dir_restore	= GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'EffDataNum_theta_scale_arr(time=*-*)*.sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_WIND.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;	DataNum_scale_theta_arr, EffDataNum_scale_theta_arr

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


;;;---    
dir_restore  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
file_restore = 'Bins_BadVal_DataGap'+'*'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_beg_BadBins_vect, JulDay_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

;;--
Flag_GoodVal_vect = Fltarr(N_Elements(JulDay_vect_wavlet))+1.0
If (JulDay_beg_BadBins_vect(0) ne -1) Then Begin
  num_BadBins = N_ELements(JulDay_beg_BadBins_vect)
  For i_BadBin=0,num_BadBins-1 Do Begin
    sub_tmp = Where(JulDay_vect_wavlet ge JulDay_beg_BadBins_vect(i_BadBin) and JulDay_vect_wavlet le JulDay_end_BadBins_vect(i_BadBin))
    If (sub_tmp(0) ne -1) Then Begin
      Flag_GoodVal_vect(sub_tmp)  = 0.0
    EndIf
  EndFor
EndIf
If (JulDay_beg_DataGap_vect(0) ne -1) Then Begin  
  For i_DataGap=0,num_DataGaps-1 Do Begin
    sub_tmp = Where(JulDay_vect_wavlet ge JulDay_beg_DataGap_vect(i_DataGap) and JulDay_vect_wavlet le JulDay_end_DataGap_vect(i_DataGap))
    If (sub_tmp(0) ne -1) Then Begin
      Flag_GoodVal_vect(sub_tmp)  = 0.0
    EndIf
  EndFor
EndIf
sub_BadVal_vect = Where(Flag_GoodVal_vect eq 0.0)
If (sub_BadVal_vect(0) ne -1) Then Begin
  Bx_wavlet_arr([sub_BadVal_vect],*)  = !values.f_nan
  By_wavlet_arr([sub_BadVal_vect],*)  = !values.f_nan
  Bz_wavlet_arr([sub_BadVal_vect],*)  = !values.f_nan
EndIf
    

Step2:
;===========================
;Step2:

;;--
num_times	= N_Elements(time_vect_wavlet)
num_periods	= N_Elements(period_vect_wavlet)
theta_arr	= Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr	= Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr	= Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr	= ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi

;;--
Syz_wavlet_arr	= (-By_wavlet_arr)*Conj(Bz_wavlet_arr) ;(-By_wavlet_arr) not (+By_wavlet_arr), since here y is GSE-y not RTN-T, while reduced magnetic helicity means rotation around R-direction
ImSyz_wavlet_arr= Imaginary(Syz_wavlet_arr)
;;;---
freq_vect_wavlet= 1./period_vect_wavlet
freq_time_scale_arr	= freq_vect_wavlet ## (Fltarr(num_times)+1.0)
Vsw_assumed			= 1.0	;assume the solar wind velocity to be a constant 1.0
kx_time_scale_arr	= freq_time_scale_arr / Vsw_assumed
Hm_yz_time_scale_arr	= 2*ImSyz_wavlet_arr / kx_time_scale_arr

;;--
PSD_Bx_time_scale_arr	= Abs(Bx_wavlet_arr)^2
PSD_By_time_scale_arr	= Abs(By_wavlet_arr)^2
PSD_Bz_time_scale_arr	= Abs(Bz_wavlet_arr)^2
PSD_time_scale_arr	= PSD_Bx_time_scale_arr + PSD_By_time_scale_arr + PSD_Bz_time_scale_arr
;a dtime			= time_vect_wavlet(1)-time_vect_wavlet(0)
;a PSD_BComp_time_scale_arr	= Abs(BComp_wavlet_arr)^2*dtime

;;--
NormHm_yz_time_scale_arr	= kx_time_scale_arr * Hm_yz_time_scale_arr / PSD_time_scale_arr

;;--get 'NormHm_yz_scale_vect'
NormHm_yz_scale_vect	= Fltarr(num_periods)
For i_period=0,num_periods-1 Do Begin
;a	NormHm_yz_time_vect	= NormHm_yz_time_scale_arr(*,i_period)
;a	sub_tmp	= Where(Finite(NormHm_yz_time_vect) eq 1)
;a	NormHm_yz_tmp	= Total(NormHm_yz_time_vect,/NaN)/N_Elements(sub_tmp)
	kx_scale_tmp	= kx_time_scale_arr(0,i_period)
	Hm_yz_scale_tmp	= Mean(Hm_yz_time_scale_arr(*,i_period),/NaN)
	PSD_scale_tmp	= Mean(PSD_time_scale_arr(*,i_period),/NaN)
	NormHm_yz_tmp	= kx_scale_tmp * Hm_yz_scale_tmp / PSD_scale_tmp
	NormHm_yz_scale_vect(i_period)	= NormHm_yz_tmp
EndFor


Step3:
;===========================
;Step3:

;;--define 'theta_bin_min/max_vect'
num_theta_bins	= 90L
dtheta_bin		= 180./num_theta_bins
theta_bin_min_vect	= Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect	= (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'PSD_BComp_theta_scale_arr'
Hm_yz_theta_scale_arr		= Fltarr(num_theta_bins, num_periods)+!values.f_nan
NormHm_yz_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)+!values.f_nan
SD_NormHm_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)+!values.f_nan	;standard deviation
CI_NormHm_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)+!values.f_nan	;confidence interval
ConfidenceLevel	= 0.90
;;;---
is_AverQuotient	= 1	; 0 for sigma_m=Aver(Hm)/Aver(|B|^2/k), 1 for sigma_m=Aver(Hm/|B|^2/k)
Print, 'is_AverQuotient: ', is_AverQuotient
is_continue	= ' '
Read, 'is_continue: ', is_continue
;;;---
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
;a	Print, 'theta, period: ', theta_bin_min_vect(i_theta), period_vect_wavlet(i_period)
	theta_min_bin	= theta_bin_min_vect(i_theta)
	theta_max_bin	= theta_bin_max_vect(i_theta)
	sub_tmp	= Where(theta_arr(*,i_period) ge theta_min_bin and $
					theta_arr(*,i_period) lt theta_max_bin)
	If N_Elements(sub_tmp) ge 2 Then Begin
		Hm_vect_tmp	= Hm_yz_time_scale_arr(*,i_period)
		Hm_tmp		= Mean(Hm_vect_tmp(sub_tmp),/NaN)
		PSD_vect_tmp= PSD_time_scale_arr(*,i_period)
		PSD_tmp		= Mean(PSD_vect_tmp(sub_tmp),/NaN)
		kx_tmp		= kx_time_scale_arr(0,i_period)
		NormHm_tmp	= kx_tmp * Hm_tmp / PSD_tmp
		;;;---
		Hm_yz_theta_scale_arr(i_theta,i_period)	= Hm_tmp
		;;;---get 'NormHm_yz_theta_scale_arr'
		If (is_AverQuotient eq 0) Then Begin
			NormHm_yz_theta_scale_arr(i_theta,i_period)	= NormHm_tmp
		EndIf Else Begin
		If (is_AverQuotient eq 1) Then Begin
			NormHm_vect_tmp	= kx_tmp*Hm_vect_tmp(sub_tmp)/PSD_vect_tmp(sub_tmp)
			NormHm_tmp		= Mean(NormHm_vect_tmp,/NaN)
			NormHm_yz_theta_scale_arr(i_theta,i_period)	= NormHm_tmp
		EndIf
		EndElse
		;;;---
		Hm_v1	= Hm_vect_tmp(sub_tmp)
		PSD_v1	= PSD_vect_tmp(sub_tmp)
		num_bins= 20L
		hist_Hm	= Histogram(Hm_v1,NBins=num_bins)
		hist_PSD= Histogram(PSD_v1,NBins=num_bins)
		hist_NormHm	= Histogram(NormHm_vect_tmp,NBins=num_bins)
		bin_Hm_vect	= Min(Hm_v1,/NaN)+(Max(Hm_v1,/NaN)-Min(Hm_v1,/NaN))/(num_bins-1)*(Findgen(num_bins)+0.5)
		bin_PSD_vect= Min(PSD_v1,/NaN)+(Max(PSD_v1,/NaN)-Min(PSD_v1,/NaN))/(num_bins-1)*(Findgen(num_bins)+0.5)
		bin_NormHm_vect	= Min(NormHm_vect_tmp,/NaN)+(Max(NormHm_vect_tmp,/NaN)-Min(NormHm_vect_tmp,/NaN))/(num_bins-1)*(Findgen(num_bins)+0.5)
;		Set_Plot,'Win'
;		Window,1,XSize=900,YSize=500
;		!P.Multi	= [0,3,1]
;		Plot,bin_Hm_vect,hist_Hm,PSym=10
;		Plot,bin_PSD_vect,hist_PSD,PSym=10
;		Plot,bin_NormHm_vect,hist_NormHm,PSym=10
		;;;---get 'CI_NormHm_theta_scale_arr'
		If (is_AverQuotient eq 0 or is_AverQuotient eq 1) Then Begin
			num_Numerator_tmp		= EffDataNum_scale_theta_arr(i_theta,i_period)
			num_Denominator_tmp		= num_Numerator_tmp
			Mean_Numerator_tmp		= kx_tmp*Hm_tmp
			Mean_Denominator_tmp	= PSD_tmp
			SD_Numerator_tmp		= kx_tmp*StdDev(Hm_vect_tmp(sub_tmp),/NaN)
			SD_Denominator_tmp		= StdDev(PSD_vect_tmp(sub_tmp),/NaN)
			get_ConfidenceInterval_for_Quotient_of_TwoMeans_v2, $
				num_Numerator_tmp, num_Denominator_tmp, $
				Mean_Numerator_tmp, SD_Numerator_tmp, $
				Mean_Denominator_tmp, SD_Denominator_tmp, $	;input
				ConfidenceLevel=ConfidenceLevel, $				;input
				CI_low=CI_low, CI_high=CI_high
			CI_Quotient_tmp	= Abs(CI_high-CI_low)
			CI_NormHm_theta_scale_arr(i_theta,i_period)	= CI_Quotient_tmp
		EndIf Else Begin
		If (is_AverQuotient eq 2) Then Begin
			NormHm_vect_tmp	= kx_tmp*Hm_vect_tmp(sub_tmp)/PSD_vect_tmp(sub_tmp)
			DegreeFreedom	= N_Elements(sub_tmp)-1
			If DegreeFreedom le 1 Then Begin
				ConfIntv_NormHm_tmp	= !values.f_nan
			EndIf Else Begin
				StdDev_NormHm_tmp	= StdDev(NormHm_vect_tmp,/NaN)
				get_ConfidenceInterval_for_T_Test, DegreeFreedom, ConfidenceLevel, ConfidenceInterval
				ConfIntv_NormHm_tmp	= ConfidenceInterval*StdDev_NormHm_tmp/Sqrt(DegreeFreedom+1)
			EndElse
			CI_NormHm_theta_scale_arr(i_theta,i_period)	= ConfIntv_NormHm_tmp
		EndIf
		EndElse
	EndIf
EndFor
EndFor

;;--
dir_save	= GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
;JulDay_min	= JulDay_min_v2
;JulDay_max	= JulDay_min_v2+(Max(time_vect_wavlet)-Min(time_vect_wavlet))/(24.*60.*60)
;CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
;CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
;TimeRange_str	= '(time='+$
;		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
;		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save	= 'NormHelicity_yz_theta_period_arr'+$
				TimeRange_str+'.sav'
period_vect	= period_vect_wavlet
data_descrip= 'got from "get_ReducedHelicity_AlongKx_theta_scale_arr_WIND.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	theta_bin_min_vect, theta_bin_max_vect, $
	period_vect, $
	JulDay_min_v2, time_vect_v2, $
	NormHm_yz_time_scale_arr, NormHm_yz_scale_vect, $
	Hm_yz_theta_scale_arr, NormHm_yz_theta_scale_arr, $
	ConfidenceLevel, CI_NormHm_theta_scale_arr


;a Goto,End_Program
Step4:
;===========================
;Step4:

;;--
dir_restore  = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore = 'NormHelicity_yz_theta_period_arr'+$
                '*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose                
;data_descrip= 'got from "get_ReducedHelicity_AlongKx_theta_scale_arr_WIND.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  theta_bin_min_vect, theta_bin_max_vect, $
;  period_vect, $
;  JulDay_min_v2, time_vect_v2, $
;  NormHm_yz_time_scale_arr, NormHm_yz_scale_vect, $
;  Hm_yz_theta_scale_arr, NormHm_yz_theta_scale_arr, $
;  ConfidenceLevel, CI_NormHm_theta_scale_arr


;;--
time_min_TV	= time_vect_wavlet(0)
time_max_TV	= time_min_TV+(24.*60.*60)*5
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
NormHm_yz_time_scale_arr_TV	= NormHm_yz_time_scale_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
theta_vect_TV	= theta_bin_min_vect
NormHm_yz_theta_scale_arr_TV= NormHm_yz_theta_scale_arr(*,*)
CI_NormHm_theta_scale_arr_TV= CI_NormHm_theta_scale_arr(*,*)

;;--
Set_Plot, 'X'
Device,DeComposed=0
xsize	= 750.0
ysize	= 1400.0
Window,1,XSize=xsize,YSize=ysize, Retain=2

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
num_y_SubImgs	= 4
dx_pos_SubImg	= (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg	= (position_img(3)-position_img(1))/num_y_SubImgs


Step4_1:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 3
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


Step4_2:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 2
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= NormHm_yz_time_scale_arr_TV
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
min_image	= Max([min_image, -max_image])
max_image	= -min_image
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
	byt_image_TV(sub_BadVal)	= color_BadVal
EndIf
;;;---
xtitle	= 'time'
ytitle	= 'period (s)'
title	= TexToIDL('Norm-Helicity(ByBz)')
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
titleCB			= TexToIDL('Norm-Helicity')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

Step4_3:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 1
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= NormHm_yz_theta_scale_arr_TV
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
min_image	= Max([min_image, -max_image])
max_image	= -min_image
;min_image	= -0.4
;max_image	= +0.4
min_image = -0.2
max_image = +0.2
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
titleCB			= TexToIDL('Norm-Helicity')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

Step4_4:
;;--
i_x_SubImg	= 0
i_y_SubImg	= 0
position_SubImg	= [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
				   position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
				   position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV	= CI_NormHm_theta_scale_arr_TV
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
titleCB			= TexToIDL('ConfIntv(Norm-Helicity)')
bottom_color	= 0B
img_colorbar	= (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
	XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
	/NoData,/NoErase,Color=color_black,$
	TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp	= 'got from "get_ReducedHelicity_AlongKx_theta_scale_arr_200802.pro"'
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
dir_fig		= GetEnv('WIND_MFI_Figure_Dir')+''+sub_dir_date
file_version= '(v1)'
file_fig	= 'NormHelicity_yz_theta_scale_arr'+$
				TimeRange_str+$
				file_version+$
				'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background	= color_bg



End_Program:
End