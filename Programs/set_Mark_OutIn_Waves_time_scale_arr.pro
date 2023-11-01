Pro set_mark_OutIn_waves_time_scale_arr, $
    theta_zp_zm_arr, theta_zp_b0_arr, theta_zm_b0_arr, theta_kp_zm_arr, theta_km_zp_arr, theta_kp_b0_arr, theta_km_b0_arr, $
    SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
    SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
    CC_Np_AbsB_arr, $
    mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, mark_OutAW2_arr, $
    is_B0_AntiSunward=is_B0_AntiSunward, $
    val_nan=val_nan, AbsSigmaC_level=AbsSigmaC_level, AbsSigmaA_level=AbsSigmaA_level, dtheta_range=dtheta_range, $
    CC_Np_AbsB_level=CC_Np_AbsB_level

;;;--
;mark_OutAW_arr  = Intarr(num_times, num_periods)
;mark_OutQPSW_arr= Intarr(num_times, num_periods)
;mark_InAW_arr   = Intarr(num_times, num_periods)
;mark_InQPS_arr  = Intarr(num_times, num_periods)
;mark_OutAW2_arr = Intarr(num_times, num_periods)

;is_B0_AntiSunward = 1
;Print, 'is_B0_AntiSunward (0 or 1, 0 for sunward, 1 for anti-sunward): '
;Print, is_B0_AntiSunward
;is_continue = ' '
;Read, 'is_continue: ', is_continue

;;;--
;val_nan = 9999.0
;AbsSigmaC_level = 0.6
;AbsSigmaA_level = Sqrt(1-AbsSigmaC_level^2)
;dtheta_range  = 20.0 


If is_B0_AntiSunward eq 1 Then Begin
  ;;;---
  ThetaRange_zp_zm_OutAW  = [-val_nan, +val_nan]
  ThetaRange_zp_b0_OutAW  = [-val_nan, +val_nan]
  ThetaRange_zm_b0_OutAW  = [90-dtheta_range, 90.0]
  ThetaRange_kp_zm_OutAW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_OutAW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_OutAW  = [-val_nan, +val_nan]
  ThetaRange_km_b0_OutAW  = [0.0, 90.0]
  SigmaCRange_OutAW = [-1.0, -AbsSigmaC_level]
  SigmaARange_OutAW = [-AbsSigmaA_level, +AbsSigmaA_level]
  ;;;---
  ThetaRange_zp_zm_OutQPSW  = [-val_nan, +val_nan]  ;quasi-perpendicular outward propagating slow-mode wave
  ThetaRange_zp_b0_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_zm_b0_OutQPSW  = [0.0, dtheta_range]
  ThetaRange_kp_zm_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_km_b0_OutQPSW  = [90-dtheta_range, 90.0]
  SigmaCRange_OutQPSW = [-1.0, -AbsSigmaC_level]  ; <0
  SigmaARange_OutQPSW = [-AbsSigmaA_level, +AbsSigmaA_level]
  CC_NB_Range_OutQPSW = [-1., -Abs(CC_Np_AbsB_level)]
  ;;;---
  ThetaRange_zp_zm_InAW  = [-val_nan, +val_nan]
  ThetaRange_zp_b0_InAW  = [90-dtheta_range, 90.0]
  ThetaRange_zm_b0_InAW  = [-val_nan, +val_nan]
  ThetaRange_kp_zm_InAW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_InAW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_InAW  = [0.0, 90.0]
  ThetaRange_km_b0_InAW  = [-val_nan, +val_nan]
  SigmaCRange_InAW = [+AbsSigmaC_level, +1.0]  ; <0
  SigmaARange_InAW = [-AbsSigmaA_level, +AbsSigmaA_level]
  ;;;---
  ThetaRange_zp_zm_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_zp_b0_InQPSW  = [0.0, dtheta_range]
  ThetaRange_zm_b0_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_kp_zm_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_InQPSW  = [90-dtheta_range, 90.0]
  ThetaRange_km_b0_InQPSW  = [-val_nan, +val_nan]
  SigmaCRange_InQPSW = [+AbsSigmaC_level, +1.0]  ; <0
  SigmaARange_InQPSW = [-AbsSigmaA_level, +AbsSigmaA_level]
  CC_NB_Range_InQPSW  = [-1., -Abs(CC_Np_AbsB_level)]
  ;;;---
  ThetaRange_zp_zm_OutAW2 = [0.0, dtheta_range] ;signature of Alfven waves with sigma_A!=0
  ThetaRange_zp_b0_OutAW2 = [90-dtheta_range, 90.0]
  ThetaRange_zm_b0_OutAW2 = [-val_nan, +val_nan]
  ThetaRange_kp_zm_OutAW2 = [90-dtheta_range, 90.0]
  ThetaRange_km_zp_OutAW2 = [90-dtheta_range, 90.0]
  ThetaRange_kp_b0_OutAW2 = [-val_nan, +val_nan]
  ThetaRange_km_b0_OutAW2 = [-val_nan, +val_nan]
  SigmaCRange_OutAW2 = [-1.0, -AbsSigmaC_level]  ; <0
  SigmaARange_OutAW2 = [-AbsSigmaA_level, +AbsSigmaA_level]    
 
EndIf Else Begin
If is_B0_AntiSunward eq 0 Then Begin
  ;;;---
  ThetaRange_zp_zm_OutAW  = [-val_nan, +val_nan]
  ThetaRange_zp_b0_OutAW  = [90-dtheta_range, 90.0]
  ThetaRange_zm_b0_OutAW  = [-val_nan, +val_nan]
  ThetaRange_kp_zm_OutAW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_OutAW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_OutAW  = [-val_nan, +val_nan]
  ThetaRange_km_b0_OutAW  = [0.0, 90.0]
  SigmaCRange_OutAW = [+AbsSigmaC_level, +1.0]
  SigmaARange_OutAW = [-AbsSigmaA_level, +AbsSigmaA_level]
  ;;;---
  ThetaRange_zp_zm_OutQPSW  = [-val_nan, +val_nan]  ;quasi-perpendicular outward propagating slow-mode wave
  ThetaRange_zp_b0_OutQPSW  = [0.0, dtheta_range]
  ThetaRange_zm_b0_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_kp_zm_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_OutQPSW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_OutQPSW  = [90-dtheta_range, 90.0]
  ThetaRange_km_b0_OutQPSW  = [-val_nan, +val_nan]
  SigmaCRange_OutQPSW = [+AbsSigmaC_level, +1.0]  ; <0
  SigmaARange_OutQPSW = [-AbsSigmaA_level, +AbsSigmaA_level]
  CC_NB_Range_OutQPSW = [-1., -Abs(CC_Np_AbsB_level)]  
  ;;;---
  ThetaRange_zp_zm_InAW  = [-val_nan, +val_nan]
  ThetaRange_zp_b0_InAW  = [-val_nan, +val_nan]
  ThetaRange_zm_b0_InAW  = [90-dtheta_range, 90.0]
  ThetaRange_kp_zm_InAW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_InAW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_InAW  = [-val_nan, +val_nan]
  ThetaRange_km_b0_InAW  = [0.0, 90.0]
  SigmaCRange_InAW = [-1.0, -AbsSigmaC_level]  ; <0
  SigmaARange_InAW = [-AbsSigmaA_level, +AbsSigmaA_level]
  ;;;---
  ThetaRange_zp_zm_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_zp_b0_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_zm_b0_InQPSW  = [0.0, dtheta_range]
  ThetaRange_kp_zm_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_km_zp_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_kp_b0_InQPSW  = [-val_nan, +val_nan]
  ThetaRange_km_b0_InQPSW  = [90-dtheta_range, 90.0]
  SigmaCRange_InQPSW = [-1.0, -AbsSigmaC_level]  ; <0
  SigmaARange_InQPSW = [-AbsSigmaA_level, +AbsSigmaA_level]
  CC_NB_Range_InQPSW = [-1., -Abs(CC_Np_AbsB_level)]
  ;;;---
  ThetaRange_zp_zm_OutAW2 = [0.0, dtheta_range] ;signature of Alfven waves with sigma_A!=0
  ThetaRange_zp_b0_OutAW2 = [-val_nan, +val_nan]
  ThetaRange_zm_b0_OutAW2 = [90-dtheta_range, 90.0]
  ThetaRange_kp_zm_OutAW2 = [90-dtheta_range, 90.0]
  ThetaRange_km_zp_OutAW2 = [90-dtheta_range, 90.0]
  ThetaRange_kp_b0_OutAW2 = [-val_nan, +val_nan]
  ThetaRange_km_b0_OutAW2 = [-val_nan, +val_nan]
  SigmaCRange_OutAW2 = [+AbsSigmaC_level, +1.0]  ; <0
  SigmaARange_OutAW2 = [-AbsSigmaA_level, +AbsSigmaA_level]    
 
EndIf
EndElse

  
;;--
sub_tmp  = Where(theta_zp_zm_arr ge ThetaRange_zp_zm_OutAW(0) and theta_zp_zm_arr le ThetaRange_zp_zm_OutAW(1) and $
                theta_zp_b0_arr ge ThetaRange_zp_b0_OutAW(0) and theta_zp_b0_arr le ThetaRange_zp_b0_OutAW(1) and $
                theta_zm_b0_arr ge ThetaRange_zm_b0_OutAW(0) and theta_zm_b0_arr le ThetaRange_zm_b0_OutAW(1) and $
                theta_kp_zm_arr ge ThetaRange_kp_zm_OutAW(0) and theta_kp_zm_arr le ThetaRange_kp_zm_OutAW(1) and $
                theta_km_zp_arr ge ThetaRange_km_zp_OutAW(0) and theta_km_zp_arr le ThetaRange_km_zp_OutAW(1) and $
                theta_kp_b0_arr ge ThetaRange_kp_b0_OutAW(0) and theta_kp_b0_arr le ThetaRange_kp_b0_OutAW(1) and $
                theta_km_b0_arr ge ThetaRange_km_b0_OutAW(0) and theta_km_b0_arr le ThetaRange_km_b0_OutAW(1) and $
                (SigmaC_x_arr ge SigmaCRange_OutAW(0) and SigmaC_x_arr le SigmaCRange_OutAW(1) or $
                 SigmaC_y_arr ge SigmaCRange_OutAW(0) and SigmaC_y_arr le SigmaCRange_OutAW(1) or $
                 SigmaC_z_arr ge SigmaCRange_OutAW(0) and SigmaC_z_arr le SigmaCRange_OutAW(1)) and $
                SigmaA_t_arr ge SigmaARange_OutAW(0) and SigmaA_t_arr le SigmaARange_OutAW(1)) 
If (sub_tmp(0) ne -1) Then Begin
  mark_OutAW_arr(sub_tmp) = 1
EndIf
;;;---
sub_tmp  = Where(theta_zp_zm_arr ge ThetaRange_zp_zm_OutQPSW(0) and theta_zp_zm_arr le ThetaRange_zp_zm_OutQPSW(1) and $
                theta_zp_b0_arr ge ThetaRange_zp_b0_OutQPSW(0) and theta_zp_b0_arr le ThetaRange_zp_b0_OutQPSW(1) and $
                theta_zm_b0_arr ge ThetaRange_zm_b0_OutQPSW(0) and theta_zm_b0_arr le ThetaRange_zm_b0_OutQPSW(1) and $
                theta_kp_zm_arr ge ThetaRange_kp_zm_OutQPSW(0) and theta_kp_zm_arr le ThetaRange_kp_zm_OutQPSW(1) and $
                theta_km_zp_arr ge ThetaRange_km_zp_OutQPSW(0) and theta_km_zp_arr le ThetaRange_km_zp_OutQPSW(1) and $
                theta_kp_b0_arr ge ThetaRange_kp_b0_OutQPSW(0) and theta_kp_b0_arr le ThetaRange_kp_b0_OutQPSW(1) and $
                theta_km_b0_arr ge ThetaRange_km_b0_OutQPSW(0) and theta_km_b0_arr le ThetaRange_km_b0_OutQPSW(1) and $
                (SigmaC_x_arr ge SigmaCRange_OutQPSW(0) and SigmaC_x_arr le SigmaCRange_OutQPSW(1) or $
                 SigmaC_y_arr ge SigmaCRange_OutQPSW(0) and SigmaC_y_arr le SigmaCRange_OutQPSW(1) or $
                 SigmaC_z_arr ge SigmaCRange_OutQPSW(0) and SigmaC_z_arr le SigmaCRange_OutQPSW(1)) and $
                SigmaA_t_arr ge SigmaARange_OutQPSW(0) and SigmaA_t_arr le SigmaARange_OutQPSW(1) and $
                CC_Np_AbsB_arr ge CC_NB_Range_OutQPSW(0) and CC_Np_AbsB_arr le CC_NB_Range_OutQPSW(1)) 
If (sub_tmp(0) ne -1) Then Begin
  mark_OutQPSW_arr(sub_tmp) = 1
EndIf
;;;---
sub_tmp  = Where(theta_zp_zm_arr ge ThetaRange_zp_zm_InAW(0) and theta_zp_zm_arr le ThetaRange_zp_zm_InAW(1) and $
                theta_zp_b0_arr ge ThetaRange_zp_b0_InAW(0) and theta_zp_b0_arr le ThetaRange_zp_b0_InAW(1) and $
                theta_zm_b0_arr ge ThetaRange_zm_b0_InAW(0) and theta_zm_b0_arr le ThetaRange_zm_b0_InAW(1) and $
                theta_kp_zm_arr ge ThetaRange_kp_zm_InAW(0) and theta_kp_zm_arr le ThetaRange_kp_zm_InAW(1) and $
                theta_km_zp_arr ge ThetaRange_km_zp_InAW(0) and theta_km_zp_arr le ThetaRange_km_zp_InAW(1) and $
                theta_kp_b0_arr ge ThetaRange_kp_b0_InAW(0) and theta_kp_b0_arr le ThetaRange_kp_b0_InAW(1) and $
                theta_km_b0_arr ge ThetaRange_km_b0_InAW(0) and theta_km_b0_arr le ThetaRange_km_b0_InAW(1) and $
                (SigmaC_x_arr ge SigmaCRange_InAW(0) and SigmaC_x_arr le SigmaCRange_InAW(1) or $
                 SigmaC_y_arr ge SigmaCRange_InAW(0) and SigmaC_y_arr le SigmaCRange_InAW(1) or $
                 SigmaC_z_arr ge SigmaCRange_InAW(0) and SigmaC_z_arr le SigmaCRange_InAW(1)) and $
                SigmaA_t_arr ge SigmaARange_InAW(0) and SigmaA_t_arr le SigmaARange_InAW(1)) 
If (sub_tmp(0) ne -1) Then Begin
  mark_InAW_arr(sub_tmp) = 1
EndIf
;;;---
sub_tmp  = Where(theta_zp_zm_arr ge ThetaRange_zp_zm_InQPSW(0) and theta_zp_zm_arr le ThetaRange_zp_zm_InQPSW(1) and $
                theta_zp_b0_arr ge ThetaRange_zp_b0_InQPSW(0) and theta_zp_b0_arr le ThetaRange_zp_b0_InQPSW(1) and $
                theta_zm_b0_arr ge ThetaRange_zm_b0_InQPSW(0) and theta_zm_b0_arr le ThetaRange_zm_b0_InQPSW(1) and $
                theta_kp_zm_arr ge ThetaRange_kp_zm_InQPSW(0) and theta_kp_zm_arr le ThetaRange_kp_zm_InQPSW(1) and $
                theta_km_zp_arr ge ThetaRange_km_zp_InQPSW(0) and theta_km_zp_arr le ThetaRange_km_zp_InQPSW(1) and $
                theta_kp_b0_arr ge ThetaRange_kp_b0_InQPSW(0) and theta_kp_b0_arr le ThetaRange_kp_b0_InQPSW(1) and $
                theta_km_b0_arr ge ThetaRange_km_b0_InQPSW(0) and theta_km_b0_arr le ThetaRange_km_b0_InQPSW(1) and $
                (SigmaC_x_arr ge SigmaCRange_InQPSW(0) and SigmaC_x_arr le SigmaCRange_InQPSW(1) or $
                 SigmaC_y_arr ge SigmaCRange_InQPSW(0) and SigmaC_y_arr le SigmaCRange_InQPSW(1) or $
                 SigmaC_z_arr ge SigmaCRange_InQPSW(0) and SigmaC_z_arr le SigmaCRange_InQPSW(1)) and $
                SigmaA_t_arr ge SigmaARange_InQPSW(0) and SigmaA_t_arr le SigmaARange_InQPSW(1)and $
                CC_Np_AbsB_arr ge CC_NB_Range_InQPSW(0) and CC_Np_AbsB_arr le CC_NB_Range_InQPSW(1)) 
If (sub_tmp(0) ne -1) Then Begin
  mark_InQPSW_arr(sub_tmp) = 1
EndIf
;;;---
sub_tmp  = Where(theta_zp_zm_arr ge ThetaRange_zp_zm_OutAW2(0) and theta_zp_zm_arr le ThetaRange_zp_zm_OutAW2(1) and $
                theta_zp_b0_arr ge ThetaRange_zp_b0_OutAW2(0) and theta_zp_b0_arr le ThetaRange_zp_b0_OutAW2(1) and $
                theta_zm_b0_arr ge ThetaRange_zm_b0_OutAW2(0) and theta_zm_b0_arr le ThetaRange_zm_b0_OutAW2(1) and $
                theta_kp_zm_arr ge ThetaRange_kp_zm_OutAW2(0) and theta_kp_zm_arr le ThetaRange_kp_zm_OutAW2(1) and $
                theta_km_zp_arr ge ThetaRange_km_zp_OutAW2(0) and theta_km_zp_arr le ThetaRange_km_zp_OutAW2(1) and $
                theta_kp_b0_arr ge ThetaRange_kp_b0_OutAW2(0) and theta_kp_b0_arr le ThetaRange_kp_b0_OutAW2(1) and $
                theta_km_b0_arr ge ThetaRange_km_b0_OutAW2(0) and theta_km_b0_arr le ThetaRange_km_b0_OutAW2(1) and $
                (SigmaC_x_arr ge SigmaCRange_OutAW2(0) and SigmaC_x_arr le SigmaCRange_OutAW2(1) or $
                 SigmaC_y_arr ge SigmaCRange_OutAW2(0) and SigmaC_y_arr le SigmaCRange_OutAW2(1) or $
                 SigmaC_z_arr ge SigmaCRange_OutAW2(0) and SigmaC_z_arr le SigmaCRange_OutAW2(1)) and $
                SigmaA_t_arr ge SigmaARange_OutAW2(0) and SigmaA_t_arr le SigmaARange_OutAW2(1)) 
If (sub_tmp(0) ne -1) Then Begin
  mark_OutAW2_arr(sub_tmp) = 1
EndIf


Return
End