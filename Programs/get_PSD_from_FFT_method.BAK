;Notes:
;	time_vect should be in unit of 's'
;	num_sets=64/32/16/8/4/2/1
;	type_window=1/2/3 for 'Welch/Bartlett/Rectangle'

Pro get_PSD_from_FFT_Method, time_vect, wave_vect, $
		num_sets=num_sets, type_window=type_window, $
		freq_vect_FFT, PSD_vect_FFT

Step1:
;=============================================
;Step1
;-get 'wave_sets_arr'

;;--
num_times		= N_Elements(time_vect)
num_times_PerSet= num_times/num_sets
wave_sets_arr	= Fltarr(num_times_PerSet, num_sets)
For i_set=0,num_sets-1 Do Begin
	wave_sets_arr(*,i_set)	= wave_vect(num_times_PerSet*i_set:num_times_PerSet*(i_set+1)-1)
EndFor


Step2:
;=============================================
;Step2

;;--get 'time_vect_PerSet'
dt	= Mean(time_vect(1:num_times-1)-$
			time_vect(0:num_times-2))	;unit: s
time_vect_PerSet	= dt*Findgen(num_times_PerSet)

;;--get 'freq_vect'
num_freqs	= num_times_PerSet
num_freqs_fold	= Floor(num_freqs/2)+1
df			= 1.0/(num_times_PerSet*dt)
freq_vect	= Fltarr(num_freqs)
For i_freq=0L,num_freqs-1 Do Begin
	If (i_freq le Floor(num_freqs/2)) Then Begin
		freq_tmp	= i_freq*df
	EndIf Else Begin
		freq_tmp	= -1*(num_freqs-i_freq)*df
	EndElse
	freq_vect(i_freq)	= freq_tmp
EndFor

;;--set 'Welch/Bartlett/Rectangle_window_vect'
Welch_window_vect	= 1-(Findgen(num_times_PerSet)-0.5*num_times_PerSet)^2/$
						(0.5*num_times_PerSet)^2
Bartlett_window_vect= 1-Abs(Findgen(num_times_PerSet)-0.5*num_times_PerSet)/$
						Abs(0.5*num_times_PerSet)
Rectang_window_vect	= 1+Fltarr(num_times_PerSet)
;;;---
If type_window eq 1 Then Begin
	window_vect	= Welch_window_vect
	window_str	= 'window=Welch'
EndIf Else Begin
If type_window eq 2 Then Begin
	window_vect	= Bartlett_window_vect
	window_str	= 'window=Bartlett'
EndIf Else Begin
If type_window eq 3 Then Begin
	window_vect	= Rectang_window_vect
	window_str	= 'window=Rectangle'
EndIf
EndElse
EndElse


Step3:
;=============================================
;Step3
;-get 'PSD_sets_arr' & 'PSD_aver_vect'

;;--
PSD_sets_arr	= Fltarr(num_freqs_fold, num_sets)
PSD_aver_vect	= Fltarr(num_freqs_fold)

;;;---
For i_set=0,num_sets-1 Do Begin
	;;;;----
	wave_win_vect	= wave_sets_arr(*,i_set)*window_vect
	sub_wave_NaN		= Where(Finite(wave_win_vect) eq 0)
	If sub_wave_NaN(0) ne -1 Then Begin
		sub_wave_IsN	= Where(Finite(wave_win_vect) eq 1)
		wave_win_vect(sub_wave_NaN)	= Interpol(wave_win_vect(sub_wave_IsN), $
												time_vect_PerSet(sub_wave_IsN), time_vect_PerSet(sub_wave_NaN))
	EndIf
	;;;;----
	FFT_vect	= FFT(wave_win_vect,-1)
	PSD_vect	= Conj(FFT_vect)*FFT_vect
	;;;;----shift 'freq_vect' & 'PSD_vect'
	;;;;----change 'PSD_vect' with a unit of [nT^2] into one with a unit of [nT^2/Hz]
	freq_vect_shifted	= Shift(freq_vect,num_freqs-Floor(num_freqs/2)-1)
	PSD_vect_shifted	= Shift(Abs(PSD_vect),num_freqs-Floor(num_freqs/2)-1)	;unit: nT^2
	PSD_vect_shifted	= PSD_vect_shifted * (num_times_PerSet*dt)						;unit: nT^2/Hz
	;;;;----
	freq_vect_fold	= Findgen(num_freqs_fold)*df
	PSD_vect_fold	= Fltarr(num_freqs_fold)
	For i_freq_fold=0L,num_freqs_fold-1 Do Begin
		val_tmp	= ((i_freq_fold lt Floor(num_freqs/2)-1) or (num_freqs Mod 2) and (i_freq_fold ne 0))
		PSD_tmp	= Abs(PSD_vect(i_freq_fold))
		If val_tmp ne 0 Then Begin
			PSD_tmp	= PSD_tmp + $
						val_tmp * Abs(PSD_vect(num_freqs-i_freq_fold))
		EndIf
		PSD_vect_fold(i_freq_fold)	= PSD_tmp
	EndFor
	PSD_vect_fold	= PSD_vect_fold * (num_times_PerSet*dt)
	;;;;----
	PSD_sets_arr(*,i_set)	= PSD_vect_fold
EndFor
If num_sets gt 1 Then Begin
	PSD_aver_vect	= Total(PSD_sets_arr(*,*), 2)/num_sets
EndIf Else Begin
	PSD_aver_vect	= Reform(PSD_sets_arr(*,0))
EndElse


Step4:
;=============================================
;Step4
;-set 'freq/PSD_vect_FFT' and return them

freq_vect_FFT	= freq_vect_fold
PSD_vect_FFT	= PSD_aver_vect


End_Program:
Return
End