Pro get_ion_ThermalVelocity_v2, T_MK, V_Ti_kmps

;;;--
T_aver	= T_MK

;;--
val_eV2K        = 11604.0        ;1 eV = 11604 K
val_nT2Gauss= 1.e-5                ;1 nT = 1.e-5 Gauss
T_Aver        = T_Aver*1.e6/val_eV2K

mass_proton	= 1.0

;;--
V_Ti	= 9.79e5/mass_proton^(1./2)*T_aver^(1./2)	;unit: cm/s
V_Ti	= V_Ti/1.e5	;unit: km/s


V_Ti_kmps = V_Ti

Return

End
