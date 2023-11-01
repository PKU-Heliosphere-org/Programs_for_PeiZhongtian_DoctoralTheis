
Pro get_ion_gyrofrequency, B_nT, Z_charge, mu_mass, ion_gyrofreq
;a Function get_IonGyrofrequency_v2, B_nT, Z_charge, mu_mass
;note: Z_charge: dimensionless, charge-state
;note: mu_mass: dimensionless, m_i/m_p, in unit of proton mass

B_nT	= B_nT			;unit: nT
B_Gauss	= B_nT*1.e-5	;unit: Gauss

IonGyrofreq	= 9.58*10.^3*Z_charge/mu_mass*B_gauss	;unit: rad/s
IonGyrofreq	= IonGyrofreq/(2*!pi) ;unit: Hz

ion_gyrofreq = IonGyrofreq

Return
End
