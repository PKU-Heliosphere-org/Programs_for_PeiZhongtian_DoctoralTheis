Pro get_SubWave_Wavelet_of_BComp_vect_WIND_MFI, $
		time_vect, BComp_vect, $		;input
		period_range=period_range, $	;input
		SubWave_BComp_vect, $				;output
		time_vect_v2=time_vect_v2			;output

;purpose:
;	extract the sub-wave(daughter-wave) within specified period range
;	from the original wave by using the equation for reconstruction (Eq.(11) in Torrence & Compo (1998))
;Note for variable:
;	'period_range' is the range of period within which the daughter wave is expected to be extracted
;	'SubWave_BComp_vect' is the extracted daughter-wave
;	'time_vect_v2' is the re-defined time vector for 'SubWave_BComp_vect'


Step1:
;===========================
;Step1:

;;--
period_min	= period_range(0)
period_max	= period_range(1)
;;;---
k0	= 6.0
fourier_factor	= (4*!pi)/(k0 + SQRT(2+k0^2)) ; Scale-->Fourier [Sec.3h]
scale_min	= period_min / fourier_factor
scale_max	= period_max / fourier_factor
;;;---
J_wavlet	= 4;	;number of scales
dj_wavlet	= ALog10(scale_max/scale_min)/ALog10(2)/(J_wavlet-1)
scale_vect	= scale_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;;;---
period_vect	= scale_vect * fourier_factor

;;--
dt	= time_vect(1)-time_vect(0)
num_times	= N_Elements(time_vect)
T	= num_times*dt
is_ScaleMin_LargeEnough	= 2*dt le scale_min
is_ScaleMax_SmallEnough	= T ge scale_max
If (is_ScaleMin_LargeEnough and is_ScaleMax_SmallEnough) eq 0 Then Begin
	Print, 'is_ScaleMin_LargeEnough: ', is_ScaleMin_LargeEnough
	Print, 'is_ScaleMax_SmallEnough: ', is_ScaleMax_SmallEnough
	Stop
EndIf

;;--
wave_vect	= BComp_vect
dtime		= dt
s0			= scale_min
dj			= dj_wavlet
j			= J_wavlet-1
recon		= 1
wave_vect_v2= wave_vect
WaveLetCoeff_arr	= WAVELET(wave_vect,dtime,$		;input
								S0=s0,DJ=dj,J=j,/PAD,$	;input
								PERIOD=period_vect_v2,COI=coi_vect,SIGNIF=signif_arr,$
								recon=recon)
SubWave_BComp_vect	= wave_vect

;;--
time_vect_v2	= time_vect


End_Program:
Return
End
