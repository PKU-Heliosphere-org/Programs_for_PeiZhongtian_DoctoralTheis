;pro culculate_RA



date = '20071113-16'
sub_dir_date  = 'wind\fast\'+date+'\'


step1:

  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Btotal'+'_time_scale_arr(time=*-*).sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Btotal_time_scale_arr  

PSD_BBtotal_time_scale_arr = PSD_Btotal_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Vtotal'+'_time_scale_arr(time=*-*).sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Btotal_time_scale_arr  

PSD_VVtotal_time_scale_arr = PSD_Btotal_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr


step2:


sizp = size(PSD_VVtotal_time_scale_arr)
ev = fltarr(sizp(2))
eb = fltarr(sizp(2))
ra = fltarr(sizp(2))
for i=0,sizp(2)-1 do begin
  ev(i) = mean(PSD_VVtotal_time_scale_arr(*,i))
  eb(i) = mean(PSD_BBtotal_time_scale_arr(*,i))
  ra(i) = ev(i)/eb(i)
endfor

plot,1.0/period_vect, ra,/xlog



step3:

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = 22.0*reform(Bxyz_GSE_2s_arr(0,*))/sqrt(P_DEN_3s_arr)
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = 22.0*reform(Bxyz_GSE_2s_arr(1,*))/sqrt(P_DEN_3s_arr)
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = 22.0*reform(Bxyz_GSE_2s_arr(2,*))/sqrt(P_DEN_3s_arr)
EndIf
wave_vect = BComp_RTN_vect

sub_BadVal  = Where(Finite(wave_vect) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse

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
num_periods = 16

Diff_Bcomp_arr  = Fltarr(num_times, num_periods)
get_Wavelet_zidingyi_v2, $   ;可以改为Haar或者Morlet
    time_vect, BComp_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    BComp_wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_BComp_arr

dtime  = time_vect(1)-time_vect(0)
if i_BComp eq 1 then begin
  Bx_wavlet_arr = BComp_wavlet_arr
  PSD_Bx_time_scale_arr  = Abs(Bx_wavlet_arr)^2*dtime
endif
if i_BComp eq 2 then begin
  By_wavlet_arr = BComp_wavlet_arr
  PSD_By_time_scale_arr  = Abs(By_wavlet_arr)^2*dtime
endif
if i_BComp eq 3 then begin
  Bz_wavlet_arr = BComp_wavlet_arr
  PSD_Bz_time_scale_arr  = Abs(Bz_wavlet_arr)^2*dtime
endif

endfor
PSD_Bt_time_scale_arr = PSD_Bx_time_scale_arr+PSD_By_time_scale_arr+PSD_Bz_time_scale_arr
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Vx'
If i_BComp eq 2 Then FileName_BComp='Vy'
If i_Bcomp eq 3 Then FileName_BComp='Vz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(0,*))
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(1,*))
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(P_VEL_3s_arr(2,*))
EndIf
wave_vect = BComp_RTN_vect

sub_BadVal  = Where(Finite(wave_vect) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse

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
num_periods = 16

Diff_Bcomp_arr  = Fltarr(num_times, num_periods)
get_Wavelet_zidingyi_v2, $   ;可以改为Haar或者Morlet
    time_vect, BComp_vect, $    ;input
    period_range=period_range, $  ;input
    num_scales=nscale, $         ;input
    BComp_wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect,  $
    Diff_BComp_arr=Diff_BComp_arr

dtime  = time_vect(1)-time_vect(0)
if i_BComp eq 1 then begin
  Vx_wavlet_arr = BComp_wavlet_arr
  PSD_Vx_time_scale_arr  = Abs(Vx_wavlet_arr)^2*dtime
endif
if i_BComp eq 2 then begin
  Vy_wavlet_arr = BComp_wavlet_arr
  PSD_Vy_time_scale_arr  = Abs(Vy_wavlet_arr)^2*dtime
endif
if i_BComp eq 3 then begin
  Vz_wavlet_arr = BComp_wavlet_arr
  PSD_Vz_time_scale_arr  = Abs(Vz_wavlet_arr)^2*dtime
endif

endfor
PSD_Vt_time_scale_arr = PSD_Vx_time_scale_arr+PSD_Vy_time_scale_arr+PSD_Vz_time_scale_arr
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




sizp = size(PSD_Vt_time_scale_arr)
ev = fltarr(sizp(2))
eb = fltarr(sizp(2))
ra = fltarr(sizp(2))
for i=0,sizp(2)-1 do begin
  ev(i) = mean(PSD_Vt_time_scale_arr(*,i))
  eb(i) = mean(PSD_Bt_time_scale_arr(*,i))
  ra(i) = ev(i)/eb(i)
endfor

window,2
plot,1.0/period_vect, ra,/xlog












END_program:
end
