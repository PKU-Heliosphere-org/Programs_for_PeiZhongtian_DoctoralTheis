;+
; :Author: pzt
;-
;Pro get_LocalBG_of_MagField_at_Scales_19760307_v2

;Note:
;	for 'Auto-Correlation' and 'Structure Function'


sub_dir_date  = 'wind\Alfven1\'
;sub_dir_date  = 'new\19950720-29-1\'


Step1:
;===========================
;Step1:



;for i = 1,15 do begin

;;--restore 'JulDay/Bx/By/Bz_vect_uni'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h2_mfi_20020524_v05.sav';strcompress(string(i),/remove_all)
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp

;Bxyz_GSE_2s_arr = B_RTN_1s_arr
JulDay_2s_vect = JulDay_vect_interp

;;;---
Bx_GSE_2s_vect = Bx_GSE_vect_interp;reform(Bxyz_GSE_2s_arr(0,*))
By_GSE_2s_vect = By_GSE_vect_interp;reform(Bxyz_GSE_2s_arr(1,*))
Bz_GSE_2s_vect = Bz_GSE_vect_interp;reform(Bxyz_GSE_2s_arr(2,*))
sub_DataGap_vect	= Where(Finite(Bx_GSE_2s_vect) eq 0)
If (sub_DataGap_vect(0) ne -1) Then Begin
	sub_GoodData_vect	= Where(Finite(Bx_GSE_2s_vect) eq 1)
	JulDay_vect_Good= JulDay_2s_vect(sub_GoodData_vect)
	Bx_vect_Good	= Bx_GSE_2s_vect(sub_GoodData_vect)
	By_vect_Good	= By_GSE_2s_vect(sub_GoodData_vect)
	Bz_vect_Good	= Bz_GSE_2s_vect(sub_GoodData_vect)
	Bx_GSE_2s_vect	= Interpol(Bx_vect_Good,JulDay_vect_Good,JulDay_2s_vect)
	By_GSE_2s_vect	= Interpol(By_vect_Good,JulDay_vect_Good,JulDay_2s_vect)
	Bz_GSE_2s_vect	= Interpol(Bz_vect_Good,JulDay_vect_Good,JulDay_2s_vect)
EndIf

;计算period_vect
num_times = n_elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
time_lag = time_vect(1)-time_vect(0)
print,'time lag:',time_lag
num_periods = 32L;32L;36全16，单6
period_min = 3*time_lag;4*time_lag;耗散0.4，惯性10,全0.4
period_max = 10000*time_lag;20*time_lag;耗散1.6，惯性100，全100
period_range = [period_min,period_max]

is_log = 1;;;;;线性0
J_wavlet  = num_periods
If (is_log eq 1) Then Begin
  dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
  period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
EndIf Else Begin
  dperiod   = (period_max-period_min)/(num_periods-1)
  period_vect = period_min + Findgen(num_periods)*dperiod
EndElse
  
 dt_pix   = time_lag
PixLag_vect = round((period_vect/dt_pix)/2)*2
period_vect = PixLag_vect*dt_pix
;;;--restore 'period_vect'
;dir_restore	= 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;a file_restore= 'Bz_AutoCorr_arr(time=*-*).sav'
;file_restore= 'Bx_StructFunct      1.00000_arr(time=19950720-19950729)(period=6.0-2000)(v3)_recon.sav'
;file_array	= File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select	= 0
;Read, 'i_select: ', i_select
;file_restore	= file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "get_AutoCorr_from_BComp_vect_Helios_19760307.pro"'
;;Save, FileName=dir_save+file_save, $
;;	data_descrip, $
;;	JulDay_min, time_vect, period_vect, $
;;	BComp_StructFunct_arr


Step2:
;===========================
;Step2:

;;--
num_times	= N_Elements(Bx_GSE_2s_vect)
Bxyzt_RTN_arr	= Fltarr(4,num_times)
Bxyzt_RTN_arr(0,*)	= Bx_GSE_2s_vect
Bxyzt_RTN_arr(1,*)	= By_GSE_2s_vect
Bxyzt_RTN_arr(2,*)	= Bz_GSE_2s_vect
Bxyzt_RTN_arr(3,*)	= Sqrt(Bx_GSE_2s_vect^2+By_GSE_2s_vect^2+Bz_GSE_2s_vect^2)
subroutine_get_LocalBG_of_MagField_at_Scales_Helios_v2, $
		time_vect, Bxyzt_RTN_arr, $	;input
		period_vect=period_vect, $	;input
		Bxyz_LBG_RTN_arr		;output

;;--


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min = Min(JulDay_2s_vect)
JulDay_max = Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str  = '(time='+$
   String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
   String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
period_min_str = String(Min(period_vect),'(F5.1)')
period_max_str  = String(Max(period_vect),'(I5.4)')
PeriodRange_str = '(period='+period_min_str+'-'+period_max_str+')'
file_save = 'LocalBG_of_MagField_for_AutoCorr'+$
        ; $;strcompress(string(i),/remove_all)+$
        TimeRange_str+PeriodRange_str+$
        '.sav'
;a JulDay_min_v2  = Min(JulDay_vect)
data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min, time_vect, period_vect, $
  Bxyz_LBG_RTN_arr

;endfor

End_Program:
End

