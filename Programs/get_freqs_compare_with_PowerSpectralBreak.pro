 Pro get_freqs_compare_with_PowerSpectralBreak, Np_aver_cm3, Vsw_aver_kmps, Tp_aver_MK, AbsB_aver_nT, $
     freq_gyrofreq, freq_gyroradius, freq_skindepth, freq_cyclres, $
     VA_kmps=VA_kmps, Vth_p_kmps=Vth_p_kmps, ion_gyroradius=ion_gyroradius, ion_SkinDepth=ion_SkinDepth, beta=beta



AbsB_aver_G  = AbsB_aver_nT*1.e-9*1.e4  ;unit: Gauss

get_Alfven_velocity_v2, Np_aver_cm3, AbsB_aver_G, VA_kmps
 
get_ion_ThermalVelocity_v2, Tp_aver_MK, Vth_p_kmps

Z_charge = 1 & mu_mass = 1
get_ion_gyrofrequency, AbsB_aver_nT, Z_charge, mu_mass, GyroFreq_Hz
freq_gyrofreq = GyroFreq_Hz


get_ion_Gyroradius_SkinDepth, AbsB_aver_nT, Tp_aver_MK, Np_aver_cm3, $
    ion_gyroradius=ion_gyroradius, ion_SkinDepth=ion_SkinDepth, beta=beta

k_gyroradius = 1./ion_gyroradius
freq_gyroradius = Vsw_aver_kmps / (2*!pi/k_gyroradius) 

k_skindepth  = 1./ion_SkinDepth
freq_skindepth = Vsw_aver_kmps / (2*!pi/k_skindepth) 

k_para_cyclres  = GyroFreq_Hz*(2*!pi) / (VA_kmps + Vth_p_kmps)
freq_cyclres  = Vsw_aver_kmps / (2*!pi/k_para_cyclres)


Return
End
