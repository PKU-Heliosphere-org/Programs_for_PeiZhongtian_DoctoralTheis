Pro get_Wavelet_zidingyi_v2, $
    time_vect, BComp_vect, $  ;input
    period_range=period_range, $  ;input
    num_scales=num_scales, $    ;input
    BComp_wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect, scale_vect=scale_vect,  $      ;output
    Diff_BComp_arr=Diff_BComp_arr        ;output

;help,scale_vect,Cdelta,psi0,wavepad
Step1:
;===========================
;Step1:

;;--
period_min  = period_range(0)
period_max  = period_range(1)
;;;---
k0  = 6.0
fourier_factor  = (4*!pi)/(k0 + SQRT(2+k0^2)) ; Scale-->Fourier [Sec.3h]
scale_min = period_min / fourier_factor
scale_max = period_max / fourier_factor
;scale_min = period_min
;scale_max = period_max 
;;;---
;If Not(Keyword_Set(num_scales)) Then num_scales=16
J_wavlet  = 16;16;16  ;number of scales
dj_wavlet = ALog10(scale_max/scale_min)/ALog10(2)/(J_wavlet-1)
;dj_wavlet = 6.0 
scale_vect  = scale_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;period_vect = [12.0,18.0,24.0,60.0,180.0,300.0,480.0,600.0]
;scale_vect = period_vect
;;;---
period_vect = scale_vect * fourier_factor

;;--
dt  = round(time_vect(1)-time_vect(0))
num_times = N_Elements(time_vect)
T = num_times*dt
is_ScaleMin_LargeEnough = 2*dt le scale_min
is_ScaleMax_SmallEnough = T ge scale_max
If (is_ScaleMin_LargeEnough and is_ScaleMax_SmallEnough) eq 0 Then Begin
  Print, 'is_ScaleMin_LargeEnough: ', is_ScaleMin_LargeEnough
  Print, 'is_ScaleMax_SmallEnough: ', is_ScaleMax_SmallEnough
  Stop
EndIf
;;--

dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = (Round(period_vect/dt_pix)/2)*2

;;--
num_periods = N_Elements(period_vect)
BComp_wavlet_arr  = Complexarr(num_times, num_periods)
For i_period=0,num_periods-1 Do Begin
  wave_vect = BComp_vect
  scale_scalar  = scale_vect(i_period)
  dtime   = dt
  s0      = scale_scalar
  dj      = dj_wavlet
  J_wavlet  = 1
  j     = J_wavlet-1
  recon   = 1
  wave_vect_v2= wave_vect
  WaveLetCoeff_arr  = WAVELET(wave_vect,dtime,$   ;input
                S0=s0,DJ=dj,J=j,/PAD,$  ;input
                PERIOD=period_vect_v2,COI=coi_vect,SIGNIF=signif_arr,$
                recon=recon)
  BComp_wavlet_arr(*,i_period)  = WaveLetCoeff_arr(*,0)
  Wait,5.e-2
  ;;--
   pix_shift = PixLag_vect(i_period)/2
  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf
  Diff_BComp_vect = (BComp_vect_backward-BComp_vect_forward)
  Diff_BComp_arr(*,i_period)  = Diff_BComp_vect
EndFor

;;--
time_vect_v2  = time_vect

End_Program:
End
