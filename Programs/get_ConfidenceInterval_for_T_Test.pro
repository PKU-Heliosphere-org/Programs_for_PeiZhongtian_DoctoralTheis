;Notice:
;	assume that PSD measurements follows the chi-square distribution
;	degree of freedom (k) is the number of samples

Pro get_ConfidenceInterval_for_T_Test, DegreeFreedom, ConfidenceLevel, ConfidenceInterval

;;--
k		= DegreeFreedom
alpha	= ConfidenceLevel

;;--
T_LowerLimit	= T_CVF(0.5+0.5*alpha, k)
T_UpperLimit	= T_CVF(0.5-0.5*alpha, k)

;;--
ConfidenceInterval	= T_UpperLimit-T_LowerLimit


End_Program:
Return
End