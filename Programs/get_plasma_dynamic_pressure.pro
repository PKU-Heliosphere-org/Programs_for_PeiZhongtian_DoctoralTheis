Function get_plasma_dynamic_pressure, n_cm3, v_kmps


n_m3  = n_cm3 * 1.e6
v_mps = v_kmps * 1.e3
m_kg  = 1.67e-27

P_pa  = 2*n_m3*m_kg*v_mps^2

Return, P_pa

End