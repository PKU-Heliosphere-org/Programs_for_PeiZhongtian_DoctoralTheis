Pro Get_EnergyDensity_MHD_waves_from_nVB_TimeSequence, $
  JulDay_vect_3DP, n_p_vect, Tp_vect, $
  Vx_p_RTN_vect, Vy_p_RTN_vect, Vz_p_RTN_vect, $
  JulDay_vect_MFI, $
  Bx_RTN_vect, By_RTN_vect, Bz_RTN_vect, $
  EnerDens_AlfvenWave, EnerDens_FastWave, $
  AlfvenRatio=AlfvenRatio, Sigma_C=Sigma_C
  
;;--
AbsB_vect   = Sqrt(Bx_RTN_vect^2 + By_RTN_vect^2 + Bz_RTN_vect^2)
AbsB_G_vect = AbsB_vect*1.e-5
Bx_RTN_G_vect = Bx_RTN_vect*1.e-5
By_RTN_G_vect = By_RTN_vect*1.e-5
Bz_RTN_G_vect = Bz_RTN_vect*1.e-5
AbsVA_vect  = get_Alfven_velocity(n_p_vect, AbsB_G_vect)
VA_x_vect   = get_Alfven_velocity(n_p_vect, Bx_RTN_G_vect)
VA_y_vect   = get_Alfven_velocity(n_p_vect, By_RTN_G_vect)
VA_z_vect   = get_Alfven_velocity(n_p_vect, Bz_RTN_G_vect)
dVA_x_vect  = VA_x_vect - Mean(VA_x_vect)
dVA_y_vect  = VA_y_vect - Mean(VA_y_vect)
dVA_z_vect  = VA_z_vect - Mean(VA_z_vect)
num_times_3DP = N_Elements(JulDay_vect_3DP)
num_times_MFI = N_ELements(JulDay_vect_MFI)
dVA_x_vect  = Congrid(dVA_x_vect,num_times_3DP,/Interp,/Minus_One)
dVA_y_vect  = Congrid(dVA_y_vect,num_times_3DP,/Interp,/Minus_One)
dVA_z_vect  = Congrid(dVA_z_vect,num_times_3DP,/Interp,/Minus_One)

;;--
dVx_p_RTN_vect  = Vx_p_RTN_vect - Mean(Vx_p_RTN_vect)
dVy_p_RTN_vect  = Vy_p_RTN_vect - Mean(Vy_p_RTN_vect)
dVz_p_RTN_vect  = Vz_p_RTN_vect - Mean(Vz_p_RTN_vect)
dAbsB_vect      = AbsB_vect - Mean(AbsB_vect)

;;--
EnerDens_AlfvenWave = n_p_vect*(dVx_p_RTN_vect^2 + dVy_p_RTN_vect^2 + dVz_p_RTN_vect^2)
EnerDens_AlfvenWave = Mean(EnerDens_AlfvenWave)

;;--
;;;---maximum energy density of fast wave, which has dn/n0:dV_perp/VA:dB_para/B0 = 1:sqrt(2):1 at the propagation angle of 90 degree
EnerDens_FastWave = 2*n_p_vect*(dAbsB_vect/Mean(AbsB_vect))^2*AbsVA_vect^2   
EnerDens_FastWave = Mean(EnerDens_FastWave)

;;--
AlfvenRatio_vect  = (dVx_p_RTN_vect^2+dVy_p_RTN_vect^2+dVz_p_RTN_vect^2) / $
                    (dVA_x_vect^2+dVA_y_vect^2+dVA_z_vect^2)
AlfvenRatio = Mean(AlfvenRatio_vect)
AlfvenRatio = Mean(dVx_p_RTN_vect^2+dVy_p_RTN_vect^2+dVz_p_RTN_vect^2) / $
              Mean(dVA_x_vect^2+dVA_y_vect^2+dVA_z_vect^2)

;;--
E_plus_vect   = (dVx_p_RTN_vect+dVA_x_vect)^2+(dVy_p_RTN_vect+dVA_y_vect)^2+(dVz_p_RTN_vect+dVA_z_vect)^2
E_minus_vect  = (dVx_p_RTN_vect-dVA_x_vect)^2+(dVy_p_RTN_vect-dVA_y_vect)^2+(dVz_p_RTN_vect-dVA_z_vect)^2 
sigma_c_vect  = (E_plus_vect-E_minus_vect) / (E_plus_vect+E_minus_vect)
sigma_c = Mean(sigma_c_vect) 
sigma_c = Mean(E_plus_vect-E_minus_vect) / Mean(E_plus_vect+E_minus_vect)                  

Window,0,XSize=600,YSize=500
!P.Multi  = [0,1,3]
Plot, Findgen(num_times_3DP), dVx_p_RTN_vect, LineStyle=0,YTitle='dVx & dVA_x', CharSize=1.5
Plots, Findgen(num_times_3DP), dVA_x_vect, LineStyle=2
Plot, Findgen(num_times_3DP), dVy_p_RTN_vect, LineStyle=0,YTitle='dVy & dVA_y', CharSize=1.5
Plots, Findgen(num_times_3DP), dVA_y_vect, LineStyle=2
Plot, Findgen(num_times_3DP), dVz_p_RTN_vect, LineStyle=0,YTitle='dVz & dVA_z', CharSize=1.5
Plots, Findgen(num_times_3DP), dVA_z_vect, LineStyle=2


is_continue = ' '
Read, 'is_continue: ', is_continue

End_Program:
Return
End  