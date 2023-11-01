pro jfcenw
;;--compute the confidence interval of PSD of defined confidence level
DegreeFreedom = 10;num_sets
ConfidenceLevel = 0.95
get_ConfidenceInterval_of_PSD, DegreeFreedom, ConfidenceLevel, dlg_PSD

print,dlg_PSD

end