Pro get_LocalBG_of_MagField_at_Scales_WIND_v2, $
		time_vect, Bxyzt_RTN_arr, $	;input
		period_range=period_range, $	;input
		num_scales=num_scales, $		;input
		Bxyz_LBG_RTN_arr, $		;output
		period_vect=period_vect			;output

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
If (Not(keyword_set(num_scales))) Then num_scales=16
J_wavlet	= num_scales;24;32	;number of scales
dj_wavlet	= ALog10(scale_max/scale_min)/ALog10(2)/(J_wavlet-1)
scale_vect	= scale_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;;;---
period_vect	= scale_vect * fourier_factor


;;;---
dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = round((period_vect/dt_pix)/2)*2
period_vect_exact = PixLag_vect*dt_pix
period_vect = period_vect_exact
;;--
dt	= time_vect(1)-time_vect(0)
num_times	= N_Elements(time_vect)
T	= num_times*dt
is_ScaleMin_LargeEnough	= 2*dt le scale_min
is_ScaleMax_SmallEnough	= T ge scale_max
If (is_ScaleMin_LargeEnough and is_ScaleMax_SmallEnough) eq 0 Then Begin
	Print, 'is_ScaleMin_LargeEnough: ', is_ScaleMin_LargeEnough
	Print, 'is_ScaleMax_LargeEnough: ', is_ScaleMax_LargeEnough
	Stop
EndIf


Step2:
;===========================
;Step2:

;;--
Bx_RTN_vect		= Reform(Bxyzt_RTN_arr(0,*))
By_RTN_vect		= Reform(Bxyzt_RTN_arr(1,*))
Bz_RTN_vect		= Reform(Bxyzt_RTN_arr(2,*))

;;--
num_scales		= N_Elements(scale_vect)
lambda			= 1.0
Bx_LBG_RTN_arr	= Fltarr(num_times,num_scales)
By_LBG_RTN_arr	= Fltarr(num_times,num_scales)
Bz_LBG_RTN_arr	= Fltarr(num_times,num_scales)
;;;---
For i_scale=0,num_scales-1 Do Begin
	scale_tmp	= scale_vect(i_scale)
	;;;;----
	num_times_seg	= Floor((3*lambda*scale_tmp)*2/dt)+1
	time_vect_seg	= Findgen(num_times_seg)*dt
	kernel_vect	= (1./Sqrt(2*!pi)/lambda/scale_tmp)*     $
	 Exp(-(time_vect_seg-3*lambda*scale_tmp)^2/(2*lambda^2*scale_tmp^2))
	;;;;----
	Bx_LBG_vect	= Convol(Bx_RTN_vect,kernel_vect,/Center,/Edge_Truncate)*dt
	By_LBG_vect	= Convol(By_RTN_vect,kernel_vect,/Center,/Edge_Truncate)*dt
	Bz_LBG_vect	= Convol(Bz_RTN_vect,kernel_vect,/Center,/Edge_Truncate)*dt
	Bx_LBG_RTN_arr(*,i_scale)	= Bx_LBG_vect
	By_LBG_RTN_arr(*,i_scale)	= By_LBG_vect
	Bz_LBG_RTN_arr(*,i_scale)	= Bz_LBG_vect
	Wait, 5.e-2
EndFor

;;--
Bxyz_LBG_RTN_arr	= Fltarr(3,num_times,num_scales)
Bxyz_LBG_RTN_arr(0,*,*)	= Bx_LBG_RTN_arr
Bxyz_LBG_RTN_arr(1,*,*)	= By_LBG_RTN_arr
Bxyz_LBG_RTN_arr(2,*,*)	= Bz_LBG_RTN_arr



End_Program:
Return
End

