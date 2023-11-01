Function get_IonGyrofrequency, B_nT, Z_charge, mu_mass

B_nT	= B_nT			;unit: nT
B_Gauss	= B_nT*1.e-5	;unit: Gauss

IonGyrofreq	= 9.58*10.^3*Z_charge/mu_mass*B_gauss	;unit: rad/s
IonGyrofreq	= IonGyrofreq/(2*!pi)

Return, IonGyrofreq
End