;pro get_wavlet_vb_zidingyiscale


date = '19950101'

sub_dir_date  = 'wind\another\slow\'

zf='b_n'

Step1:
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
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
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
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect

JulDay_2s_vect = JulDay_vect
Bxyz_GSE_2s_arr = Bxyz_GSE_arr



Step2:
;===========================
;Step2:

read,'+(0) or -(1)',sign
if sign eq 0 then sig = '+'
if sign eq 1 then sig = '-'

;;--


for i_Bcomp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Vx'+sig+'Bx';
If i_BComp eq 2 Then FileName_BComp='Vy'+sig+'By';
If i_Bcomp eq 3 Then FileName_BComp='Vz'+sig+'Bz';改+-

;;--
if sign eq 0 then begin
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(0,*))+22.0*reform(Bxyz_GSE_2s_arr(0,*))/sqrt(P_DEN_3s_arr);reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0+reform(Bxyz_GSE_2s_arr(0,*));
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(1,*))+22.0*reform(Bxyz_GSE_2s_arr(1,*))/sqrt(P_DEN_3s_arr)
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(2,*))+22.0*reform(Bxyz_GSE_2s_arr(2,*))/sqrt(P_DEN_3s_arr)
EndIf
endif

if sign eq 1 then begin
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(0,*))-22.0*reform(Bxyz_GSE_2s_arr(0,*))/sqrt(P_DEN_3s_arr);reform(P_VEL_3s_arr(0,*))*sqrt(P_DEN_3s_arr)/22.0+reform(Bxyz_GSE_2s_arr(0,*));
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(1,*))-22.0*reform(Bxyz_GSE_2s_arr(1,*))/sqrt(P_DEN_3s_arr)
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(2,*))-22.0*reform(Bxyz_GSE_2s_arr(2,*))/sqrt(P_DEN_3s_arr)
EndIf
endif
wave_vect = BComp_RTN_vect




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
num_periods=16

Diff_Bcomp_arr  = Fltarr(num_times, num_periods)
get_Wavelet_zidingyi_v2, $   
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
file_save = FileName_BComp+'_wavlet_arr'+$
        TimeRange_str+zf+'.sav'
JulDay_min_v2 = Min(JulDay_2s_vect)
data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_WIND_200107.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min_v2, time_vect_v2, period_vect, $
  BComp_wavlet_arr


endfor

End_Program:
End