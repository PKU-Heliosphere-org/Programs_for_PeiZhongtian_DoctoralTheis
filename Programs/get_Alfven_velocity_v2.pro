Pro get_Alfven_velocity_v2, n_cm3, B_G, VA_kmps

mass_proton	= 1.0


;;--
VA  = 2.18e11 * mass_proton^(-1./2) * n_cm3^(-1./2) * B_G
VA	= VA/1.e5	;unit: km/s

VA_kmps = VA

Return
End