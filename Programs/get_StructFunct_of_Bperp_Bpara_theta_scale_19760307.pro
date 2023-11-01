;Pro get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307


sub_dir_date	= 'new\19950720-29-1\'

;read,'get 180(1) or 90(2):',is_fold
;if is_fold eq 1 then begin
;theta_str = '180'
;endif 
;if is_fold eq 2 then begin
;thata_str = '90'
;endif 

n_jie = 14;;;
jie = (findgen(n_jie)+1)/2.0

for i_jie = 0,n_jie-1 do begin

Step1:
;===========================
;Step1:
jieshu = jie(i_jie)
;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
;Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min, time_vect, period_vect, $
;	BComp_StructFunct_arr, $
;	Diff_BComp_arr
;;;---
time_vect_StructFunct	= time_vect
period_vect_StructFunct= period_vect
Bx_StructFunct_arr	= BComp_StructFunct_arr
Diff_Bx_arr	= Diff_BComp_arr

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
;Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min, time_vect, period_vect, $
;	BComp_StructFunct_arr, $
;	Diff_BComp_arr
;;;---
By_StructFunct_arr	= BComp_StructFunct_arr
Diff_By_arr	= Diff_BComp_arr

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
;Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min, time_vect, period_vect, $
;	BComp_StructFunct_arr, $
;	Diff_BComp_arr
;;;---
Bz_StructFunct_arr	= BComp_StructFunct_arr
Diff_Bz_arr	= Diff_BComp_arr

;;--
dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=*-*)(period=6.0-1999).sav'
file_array	= File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
;Read, 'i_select: ', i_select
file_restore	= file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_min_v2, time_vect, period_vect, $
;	Bxyz_LBG_RTN_arr
;;;---
time_vect_LBG	= time_vect
period_vect_LBG	= period_vect

;;--
diff_time		= time_vect_StructFunct(0)-time_vect_LBG(0)
diff_num_times	= N_Elements(time_vect_StructFunct)-N_Elements(time_vect_LBG)
diff_period		= period_vect_StructFunct(0)-period_vect_LBG(0)
diff_num_periods= N_Elements(period_vect_StructFunct)-N_Elements(period_vect_LBG)
If diff_time ne 0.0 or diff_num_times ne 0L or $
	Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
	Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
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
;;;some problem for the calculation of Bpara_SF_arr
;Bpara_StructFunct_arr	= Bx_StructFunct_arr*dbx_LBG_RTN_arr^2 + $
;						By_StructFunct_arr*dby_LBG_RTN_arr^2 + $
;						Bz_StructFunct_arr*dbz_LBG_RTN_arr^2
Btot_StructFunct_arr	= Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
Bpara_StructFunct_arr	= abs(Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^jie(i_jie)
Bperp_StructFunct_arr	= (Btot_StructFunct_arr - Bpara_StructFunct_arr) / 2
;;;---
StructFunct_Bpara_time_scale_arr	= Bpara_StructFunct_arr
StructFunct_Bperp_time_scale_arr	= Bperp_StructFunct_arr
StructFunct_Bt_time_scale_arr	= Btot_StructFunct_arr


;;--save 'StructFunct_Bt/Bpara/Bperp_averaged_scale_vect'
num_scales	= (Size(StructFunct_Bt_time_scale_arr))[2]
StructFunct_Bt_aver_scale_vect	= Fltarr(num_scales)
StructFunct_Bpara_aver_scale_vect	= Fltarr(num_scales)
StructFunct_Bperp_aver_scale_vect	= Fltarr(num_scales)
num_DataNum_aver_scale_vect		= Lonarr(num_scales)
For i_scale=0,num_scales-1 Do Begin
	StructFunct_vect	= Reform(StructFunct_Bt_time_scale_arr(*,i_scale))
	StructFunct_tmp		= Mean(StructFunct_vect, /NaN)
	StructFunct_Bt_aver_scale_vect(i_scale)	= StructFunct_tmp
	sub_tmp			= Where(Finite(StructFunct_vect) eq 1)
	num_DataNum_tmp	= N_Elements(sub_tmp)
	num_DataNum_aver_scale_vect(i_scale)	= num_DataNum_tmp
	;;;---
	StructFunct_vect	= Reform(StructFunct_Bpara_time_scale_arr(*,i_scale))
	StructFunct_tmp		= Mean(StructFunct_vect, /NaN)
	StructFunct_Bpara_aver_scale_vect(i_scale)	= StructFunct_tmp
	;;;---
	StructFunct_vect	= Reform(StructFunct_Bperp_time_scale_arr(*,i_scale))
	StructFunct_tmp		= Mean(StructFunct_vect, /NaN)
	StructFunct_Bperp_aver_scale_vect(i_scale)	= StructFunct_tmp
EndFor

;;;---
JulDay_min	= JulDay_min
JulDay_max	= JulDay_min+(Max(time_vect)-Min(time_vect))/(24.*60.*60)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str	= '(time='+$
		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
period_min_str	= String(Min(period_vect),'(F3.1)')
period_max_str	= String(Max(period_vect),'(I4.4)')
PeriodRange_str	= '(period='+period_min_str+'-'+period_max_str+')'
file_save	= 'StructFunct'+string(jieshu)+'_Bt_average_period_arr'+$
				TimeRange_str+$
				PeriodRange_str+ $
				'.sav'
period_vect	= period_vect_StructFunct
data_descrip= 'got from "get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307.pro"'
dir_save	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
Save, FileName=dir_save+file_save, $
	data_descrip, $
;a	theta_bin_min_vect, theta_bin_max_vect, $
	period_vect, $
	StructFunct_Bt_aver_scale_vect, $
	StructFunct_Bpara_aver_scale_vect, $
	StructFunct_Bperp_aver_scale_vect, $
	num_DataNum_aver_scale_vect

is_skip	= 0
If is_skip eq 0 Then Begin
;;;---
period_max	= Max(period_vect)
If (period_max ge 4.e3 and num_scales gt 32L) Then Begin
	Print, 'period_max, num_scales: ', period_max, num_scales
	Goto, End_Program
EndIf
EndIf


Step3:
;===========================
;Step3:

;;--
num_times	= N_Elements(time_vect_StructFunct)
num_periods	= N_Elements(period_vect_StructFunct)
theta_arr	= Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr	= Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr	= Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr	= ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


Step4:
;===========================
;Step4:

;;--define 'theta_bin_min/max_vect'

num_theta_bins	= 90L
dtheta_bin		= 180./num_theta_bins
 
theta_bin_min_vect	= Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect	= (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'StructFunct_Bpara_theta_scale_arr'
StructFunct_Bpara_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
	theta_min_bin	= theta_bin_min_vect(i_theta)
	theta_max_bin	= theta_bin_max_vect(i_theta)

	sub_tmp	= Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
	If sub_tmp(0) ne -1 Then Begin
		StructFunct_vect_tmp	= StructFunct_Bpara_time_scale_arr(*,i_period)
		StructFunct_tmp	= Median(StructFunct_vect_tmp(sub_tmp))
		StructFunct_Bpara_theta_scale_arr(i_theta,i_period)	= StructFunct_tmp
	EndIf
EndFor
EndFor

;;--get 'StructFunct_Bperp_theta_scale_arr'
StructFunct_Bperp_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
	theta_min_bin	= theta_bin_min_vect(i_theta)
	theta_max_bin	= theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
	If sub_tmp(0) ne -1 Then Begin
		StructFunct_vect_tmp	= StructFunct_Bperp_time_scale_arr(*,i_period)
;a		PSD_tmp	= 10.^Mean(Alog10(PSD_vect_tmp(sub_tmp)),/NaN)
		StructFunct_tmp	= Median(StructFunct_vect_tmp(sub_tmp))
		StructFunct_Bperp_theta_scale_arr(i_theta,i_period)	= StructFunct_tmp
	EndIf
EndFor
EndFor

;;--get 'StructFunct_Bt_theta_scale_arr'
StructFunct_Bt_theta_scale_arr	= Fltarr(num_theta_bins, num_periods)
num_DataNum_theta_scale_arr	= Lonarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
	theta_min_bin	= theta_bin_min_vect(i_theta)
	theta_max_bin	= theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
	If sub_tmp(0) ne -1 Then Begin
		StructFunct_vect_tmp	= StructFunct_Bt_time_scale_arr(*,i_period)
;a		StructFunct_tmp	= Median(StructFunct_vect_tmp(sub_tmp))
		StructFunct_tmp	= Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
		StructFunct_Bt_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
		sub_tmp_v2		= Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
		num_DataNum_tmp	= N_Elements(sub_tmp_v2)
		num_DataNum_theta_scale_arr(i_theta,i_period)	= num_DataNum_tmp
	EndIf
EndFor
EndFor

;;--
dir_save	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min	= JulDay_min
JulDay_max	= JulDay_min+(Max(time_vect_StructFunct)-Min(time_vect_StructFunct))/(24.*60.*60)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str	= '(time='+$
		String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
		String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
period_min_str	= String(Min(period_vect),'(F3.1)')
period_max_str	= String(Max(period_vect),'(I4.4)')
PeriodRange_str	= '(period='+period_min_str+'-'+period_max_str+')'
file_save	= 'StructFunct'+string(jieshu)+'_Bperp_Bpara_theta_period_arr'+$
				TimeRange_str+$
				PeriodRange_str+ $
				'.sav'
period_vect	= period_vect_StructFunct
data_descrip= 'got from "get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	theta_bin_min_vect, theta_bin_max_vect, $
	period_vect, $
	StructFunct_Bt_time_scale_arr, $
	StructFunct_Bperp_theta_scale_arr, $
	StructFunct_Bpara_theta_scale_arr, $
	StructFunct_Bt_theta_scale_arr, $
	num_DataNum_theta_scale_arr




endfor
End_Program:
End