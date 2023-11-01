;Note:
; this function is to calculate the radial distance of bow shock for a certain angle theta
; based on the paper by "Chao JK et al., MODELS FOR THE SIZE AND SHAPE OF THE EARTH’S MAGNETOPAUSE AND BOW SHOCK"

Function get_r_certain_theta_BowShock_ChaoJK, $
    theta_deg, $
    n_cm3, Vsw_kmps, Bxyz_nT_vect, T_MK
    

;;--
a1=11.1266 & a2=0.0010 & a3=-0.0005 & a4=2.5966 & a5=0.8182
a6=-0.0170 & a7=-0.0122 & a8=1.3007 & a9=-0.0049 & a10=-0.0328
a11=6.047 & a12=1.029 & a13=0.0231 & a14=-0.002

;;--
T_eV  = T_MK*1.e6 / 11602.0

Bxyz_G_vect = Bxyz_nT_vect / 1.e9 * 1.e4
B_G   = Norm(Bxyz_G_vect)

plasma_beta = get_plasma_beta(n_cm3, T_eV, B_G)     

P_pa  = get_plasma_dynamic_pressure(n_cm3, Vsw_kmps)
P_npa = P_pa * 1.e9

charge_state  = 1.0 ;for protons
V_Cs  = get_ion_SoundVelocity(T_MK, charge_state)
VA    = get_Alfven_velocity(n_cm3, B_G)
Mach_MS = Vsw_kmps / Sqrt(V_Cs^2+VA^2)

Bz_G  = Bxyz_G_vect(2)
Bz_nT = Bz_G / 1.e4 * 1.e9

;;--
If (Bz_nT ge 0) Then Begin
  r0  = a1*(1+a2*Bz_nT)*(1+a9*plasma_beta)*$
        (1+a4*((a8-1)*Mach_MS^2+2)/((a8+1)*Mach_MS^2))*$
        P_npa^(-1./a11)
  alpha = a5*(1+a13*Bz_nT)*(1+a7*P_npa)*$
          (1+a10*Alog(1+plasma_beta))*$
          (1+a14*Mach_MS)
EndIf
If (Bz_nT lt 0) Then Begin
  r0  = a1*(1+a3*Bz_nT)*(1+a9*plasma_beta)*$
        (1+a4*((a8-1)*Mach_MS^2+2)/((a8+1)*Mach_MS^2))*$
        P_npa^(-1./a11)
  alpha = a5*(1+a6*Bz_nT)*(1+a7*P_npa)*$
          (1+a10*Alog(1+plasma_beta))*$
          (1+a14*Mach_MS)
EndIf        
        
;;--
epsilon = a12

r_Re = r0*((1+epsilon)/(1+epsilon*cos(theta_deg*!pi/180)))^alpha ;unit: Re



Return, r_Re

End
