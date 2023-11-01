;Pro get_ion_Gyroradius_SkinDepth

;;--
B_aver	= 0.2		;unit: nT
T_aver	= 0.2	;unit: MK
N_aver	= 0.09		;unit: cm^-3

;;--
val_eV2K        = 11604.0        ;1 eV = 11604 K
val_nT2Gauss= 1.e-5                ;1 nT = 1.e-5 Gauss
B_Aver        = B_Aver*val_nT2Gauss
T_Aver        = T_Aver*1.e6/val_eV2K

;;--
ion_gyroradius        = 1.02e2*Sqrt(T_Aver)/B_Aver *1.e-5        ;unit: km

;;--
ion_PlasmaFreq        = 1.32e3*Sqrt(N_Aver)        ;unit: rad/s
c_speed                        = 30.e4*1.e5        ;unit: cm/s
ion_SkinDepth        = c_speed/ion_PlasmaFreq *1.e-5        ;unit: km

;;--
beta	= 4.03e-11*N_aver*T_aver/B_aver^2

;;--
Print, 'ion_gyroradius, ion_SkinDepth, beta: '
Print, ion_gyroradius, ion_SkinDepth, beta

End