Function get_ion_SoundVelocity, T_MK, charge_state

;;;--
T_aver	= T_MK ;electron temperature

;;--
val_eV2K        = 11604.0        ;1 eV = 11604 K
val_nT2Gauss= 1.e-5                ;1 nT = 1.e-5 Gauss
T_Aver        = T_Aver*1.e6/val_eV2K

mass_proton	= 1.0

gamma_PolyIndex = 5./3

;;--
V_Cs	= 9.79e5 * (gamma_PolyIndex*charge_state*T_aver/mass_proton)^(1./2);   /mass_proton^(1./2)*T_aver^(1./2)	;unit: cm/s
V_Cs	= V_Cs/1.e5	;unit: km/s


Return, V_Cs

End