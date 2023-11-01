Function get_plasma_beta, n_cm3, T_eV, B_G

;Note for units:
; num_dens: cm^-3
; temper: eV
; B_mag: G

plasma_beta  = 4.03e-11 * n_cm3 * T_eV * B_G^(-2)

Return, plasma_beta


End