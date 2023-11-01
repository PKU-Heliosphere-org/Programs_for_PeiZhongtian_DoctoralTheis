Function get_Alfven_velocity, n_cm3, B_G

mass_proton	= 1.0


;;--
VA  = 2.18e11 * mass_proton^(-1./2) * n_cm3^(-1./2) * B_G
VA	= VA/1.e5	;unit: km/s


Return, VA

End