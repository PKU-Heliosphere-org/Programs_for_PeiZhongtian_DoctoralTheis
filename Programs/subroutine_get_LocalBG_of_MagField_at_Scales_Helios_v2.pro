Pro subroutine_get_LocalBG_of_MagField_at_Scales_Helios_v2, $
		time_vect, Bxyzt_RTN_arr, $	;input
		period_vect=period_vect, $		;input
		Bxyz_LBG_RTN_arr		;output

;Note:
;	in collaboration with 'get_AutoCorr...pro'


Step1:
;===========================
;Step1:

;;--
k0	= 6.0
fourier_factor	= (4*!pi)/(k0 + SQRT(2+k0^2)) ; Scale-->Fourier [Sec.3h]
scale_vect	= period_vect / fourier_factor


Step2:
;===========================
;Step2:

;;--
Bx_RTN_vect		= Reform(Bxyzt_RTN_arr(0,*))
By_RTN_vect		= Reform(Bxyzt_RTN_arr(1,*))
Bz_RTN_vect		= Reform(Bxyzt_RTN_arr(2,*))

;;--
num_scales		= N_Elements(scale_vect)
num_times		= N_Elements(time_vect)
lambda			= 1.0
Bx_LBG_RTN_arr	= Fltarr(num_times,num_scales)
By_LBG_RTN_arr	= Fltarr(num_times,num_scales)
Bz_LBG_RTN_arr	= Fltarr(num_times,num_scales)
;;;---
dt	= time_vect(1)-time_vect(0)
;;;---
For i_scale=0,num_scales-1 Do Begin
	scale_tmp	= scale_vect(i_scale)
	;;;;----
	num_times_seg	= long64(Floor((3*lambda*scale_tmp)*2/dt)+1)
;	;;;;----
;	time_vect_seg	= Findgen(num_times_seg)*dt
;	kernel_vect	= (1./Sqrt(2*!pi)/lambda/scale_tmp)*Exp(-(time_vect_seg-3*lambda*scale_tmp)^2/(2*lambda^2*scale_tmp^2))
;	Bx_LBG_vect	= Convol(Bx_RTN_vect,kernel_vect,/Center,/Edge_Truncate)*dt
;	By_LBG_vect	= Convol(By_RTN_vect,kernel_vect,/Center,/Edge_Truncate)*dt
;	Bz_LBG_vect	= Convol(Bz_RTN_vect,kernel_vect,/Center,/Edge_Truncate)*dt
	;;;;----
	Bx_LBG_vect	= Smooth(Bx_RTN_vect, [num_times_seg], /NaN)
	By_LBG_vect	= Smooth(By_RTN_vect, [num_times_seg], /NaN)
	Bz_LBG_vect	= Smooth(Bz_RTN_vect, [num_times_seg], /NaN)
	;;;;----
	Bx_LBG_RTN_arr(*,i_scale)	= Bx_LBG_vect
	By_LBG_RTN_arr(*,i_scale)	= By_LBG_vect
	Bz_LBG_RTN_arr(*,i_scale)	= Bz_LBG_vect
;	Wait, 5.e-2
EndFor

;;--
Bxyz_LBG_RTN_arr	= Fltarr(3,num_times,num_scales)
Bxyz_LBG_RTN_arr(0,*,*)	= Bx_LBG_RTN_arr
Bxyz_LBG_RTN_arr(1,*,*)	= By_LBG_RTN_arr
Bxyz_LBG_RTN_arr(2,*,*)	= Bz_LBG_RTN_arr



End_Program:
Return
End

