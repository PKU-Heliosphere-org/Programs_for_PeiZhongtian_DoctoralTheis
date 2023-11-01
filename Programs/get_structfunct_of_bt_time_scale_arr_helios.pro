Pro get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, Bx_vect, By_vect, Bz_vect, $    ;input
    jieshu,             $           ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $       ;input
    StructFunct_Bt_arr, $        ;output
    period_vect=period_vect_exact, $      ;output
    Diff_Bx_arr=Diff_Bx_arr,Diff_By_arr=Diff_By_arr,Diff_Bz_arr=Diff_Bz_arr, $
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr

Step1:
;===========================
;Step1:

;;--
period_min  = period_range(0)
period_max  = period_range(1)

;;;---
J_wavlet  = num_periods
If (is_log eq 1) Then Begin
  dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
  period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
EndIf Else Begin
  dperiod   = (period_max-period_min)/(num_periods-1)
  period_vect = period_min + Findgen(num_periods)*dperiod
EndElse

;;;---
dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = (Round(period_vect/dt_pix)/2)*2
period_vect_exact = PixLag_vect*dt_pix

;;;---
If (period_min le dt_pix*2) Then Begin
  Stop, 'period_min < 2*dt_pix'
EndIf
num_times = N_Elements(time_vect)
If (period_max ge num_times*dt_pix) Then Begin
  Stop, 'period_max > num_times*dt_pix'
EndIf

for i_com = 0,2 do begin
  if i_com eq 0 then Bcomp_vect = Bx_vect
  if i_com eq 1 then Bcomp_vect = By_vect
  if i_com eq 2 then Bcomp_vect = Bz_vect

;;--
num_periods = J_wavlet
num_times = N_Elements(time_vect)
;StructFunct_BComp_arr = Fltarr(num_times, num_periods)
For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf
  ;StructFunct_BComp_vect  = (abs(BComp_vect_backward-BComp_vect_forward))^jieshu  ;二阶结构函数？
  ;StructFunct_BComp_arr(*,i_period) = StructFunct_BComp_vect
  ;;;---get 'diff_BComp_vect/arr' and transfer to the uppper level for calculating 'SF_para/perp_vect'
  Diff_BComp_vect = (BComp_vect_backward-BComp_vect_forward)
  Diff_BComp_arr(*,i_period)  = Diff_BComp_vect
EndFor
if i_com eq 0 then diff_Bx_arr = diff_Bcomp_arr
if i_com eq 1 then diff_By_arr = diff_Bcomp_arr
if i_com eq 2 then diff_Bz_arr = diff_Bcomp_arr
endfor

StructFunct_Bt_arr = Fltarr(num_times, num_periods)
For i_period=0,num_periods-1 Do Begin
  diff_Bt_arr(*,i_period) = sqrt(diff_Bx_arr(*,i_period)^2.0+diff_By_arr(*,i_period)^2.0+diff_Bz_arr(*,i_period)^2.0)
  StructFunct_Bt_arr(*,i_period) = (abs(diff_Bt_arr(*,i_period)))^jieshu
endfor
  
End_Program:
End