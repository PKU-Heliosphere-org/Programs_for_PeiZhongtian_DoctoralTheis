
Pro get_HaarWavelet_Transform_of_BComp_vect_WIND_v2, $
    time_vect, BComp_vect, $  ;input
    period_range=period_range, $  ;input
    num_scales=num_scales, $    ;input
    BComp_wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect, scale_vect=scale_vect      ;output


Step1:
;===========================
;Step1:

;;--
period_min  = period_range(0)
period_max  = period_range(1)
;;;---
k0  = 6.0
fourier_factor  = 1;(4*!pi)/(k0 + SQRT(2+k0^2)) ; Scale-->Fourier [Sec.3h]
scale_min = period_min / fourier_factor
scale_max = period_max / fourier_factor
;;;---
If (Not(keyword_set(num_scales))) Then num_scales=16
J_wavlet  = num_scales;24;32  ;number of scales
dj_wavlet = ALog10(scale_max/scale_min)/ALog10(2)/(J_wavlet-1)
scale_vect  = scale_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;;;---
period_vect = scale_vect * fourier_factor

;;--
num_times = N_Elements(time_vect)
dt  = mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
T = num_times*dt
is_ScaleMin_LargeEnough = dt le scale_min
is_ScaleMax_SmallEnough = T ge scale_max
If (is_ScaleMin_LargeEnough and is_ScaleMax_SmallEnough) eq 0 Then Begin
  Print, 'is_ScaleMin_LargeEnough: ', is_ScaleMin_LargeEnough
  Print, 'is_ScaleMax_SmallEnough: ', is_ScaleMax_SmallEnough
  Stop
EndIf

;;--
num_levels = FIX(alog(num_times)/alog(2))
num_periods = N_Elements(period_vect)
print,num_periods
num_times_p2 = 2.^(FIX(alog(num_times)/alog(2))+1)
BComp_wavlet_arr_p2  = fltarr(num_times_p2, num_levels)

wave_vect = fltarr(num_times_p2)
wave_vect(0:num_times-1) = BComp_vect
x = wave_vect
BComp_wavlet_arr_p2(*,0) = wave_vect

info = WV_FN_HAAR(1, wavelet, scaling, ioff, joff) 

for i_scale = 1,num_levels-1 do begin
wv_level = WV_PWT(x, wavelet, scaling, ioff, joff) 
a = wv_level[num_times_p2/(2.^i_scale):*]
b = transpose(a)
c = rebin(b,num_times_p2/n_elements(a),n_elements(a))
d = reform(c,num_times_p2,1)
x = wv_level(0:num_times_p2/(2.^i_scale)-1)
BComp_wavlet_arr_p2(*,i_scale) = d
endfor

;;--
time_vect_v2  = time_vect
sub_min_scale = round(alog(round(period_min/dt))/alog(2))
sub_max_scale = round(alog(round(period_max/dt))/alog(2))
print,sub_min_scale,sub_max_scale
BComp_wavlet_arr = BComp_wavlet_arr_p2(0:num_times-1,sub_min_scale:sub_max_scale)

End_Program:
End
