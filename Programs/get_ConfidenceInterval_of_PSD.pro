;Notice:
;	assume that PSD measurements follows the chi-square distribution
;	degree of freedom (k) is the number of samples

Pro get_ConfidenceInterval_of_PSD, DegreeFreedom, ConfidenceLevel, dlg_PSD

;;--
k		= DegreeFreedom
;d alpha 	= 1-ConfidenceLevel	;significance level
alpha	= ConfidenceLevel

;;--
chisqr_LowerLimit	= ChiSqr_CVF(0.5+0.5*alpha, k)
chisqr_UpperLimit	= ChiSqr_CVF(0.5-0.5*alpha, k)
;d chisqr_LowerLimit	= ChiSqr_CVF(0.95,k)
;d chisqr_UpperLimit	= ChiSqr_CVF(0.05,k)
dlg_PSD	= ALog10(chisqr_UpperLimit/k)-ALog10(chisqr_LowerLimit/k)


End_Program:
Return
End