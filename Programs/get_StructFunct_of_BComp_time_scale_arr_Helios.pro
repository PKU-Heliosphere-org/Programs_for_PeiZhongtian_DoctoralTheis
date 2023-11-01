Pro get_StructFunct_of_BComp_time_scale_arr_Helios, $
		time_vect, BComp_vect, $		;input
		jieshu,             $           ;input
		period_range=period_range, $	;input
		num_periods=num_periods, is_log=is_log, $				;input
		StructFunct_BComp_arr, $				;output
		period_vect=period_vect_exact, $			;output
		Diff_BComp_arr=Diff_BComp_arr	;output, added on 2012-10-31

Step1:
;===========================
;Step1:

;;--
period_min	= period_range(0)
period_max	= period_range(1)

;;;---
k0  = 6.0
fourier_factor  = (4*!pi)/(k0 + SQRT(2+k0^2)) ; Scale-->Fourier [Sec.3h]
scale_min = period_min / fourier_factor
scale_max = period_max / fourier_factor
;;;---
If (Not(keyword_set(num_periods))) Then num_periods=16
J_wavlet  = num_periods;24;32  ;number of scales
dj_wavlet = ALog10(scale_max/scale_min)/ALog10(2)/(J_wavlet-1)
scale_vect  = scale_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;;;---
period_vect = scale_vect * fourier_factor


;;;---
dt_pix		= time_vect(1)-time_vect(0)
PixLag_vect	= round((period_vect/dt_pix)/2)*2
period_vect_exact	= PixLag_vect*dt_pix

;;;---
If (period_min le dt_pix*2) Then Begin
	Stop, 'period_min < 2*dt_pix'
EndIf
num_times	= N_Elements(time_vect)
If (period_max ge num_times*dt_pix) Then Begin
	Stop, 'period_max > num_times*dt_pix'
EndIf

;;--
num_periods	= J_wavlet
num_times	= N_Elements(time_vect)
StructFunct_BComp_arr	= Fltarr(num_times, num_periods)
For i_period=0,num_periods-1 Do Begin
	pix_shift	= PixLag_vect(i_period)/2
	BComp_vect_backward	= Shift(BComp_vect, +pix_shift)
	BComp_vect_forward	= Shift(BComp_vect, -pix_shift)
	If (pix_shift ge 1) Then Begin
		BComp_vect_backward(0:pix_shift-1)	= !values.f_nan
		BComp_vect_forward(num_times-pix_shift:num_times-1)	= !values.f_nan
	EndIf
	StructFunct_BComp_vect	= (abs(BComp_vect_backward-BComp_vect_forward))^jieshu  ;二阶结构函数？
	StructFunct_BComp_arr(*,i_period)	= StructFunct_BComp_vect
	;;;---get 'diff_BComp_vect/arr' and transfer to the uppper level for calculating 'SF_para/perp_vect'
	Diff_BComp_vect	= (BComp_vect_backward-BComp_vect_forward)
	Diff_BComp_arr(*,i_period)	= Diff_BComp_vect
EndFor


End_Program:
End
