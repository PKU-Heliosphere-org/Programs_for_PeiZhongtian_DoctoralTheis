;pro calculate_rele_between_two_LIM


sub_dir_date  = 'new\19950720-29re\'

i_BComp = 3
;for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3/4/5 for Bx/By/Bz/Btotal/Bvect): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = FileName_BComp+'_Morlet_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr

PSD_B_v1 = ABS(BComp_wavlet_arr)
PSD_B_v2 = real_part(BComp_wavlet_arr)
i_freq  = 12
PSD_v1 = reform(PSD_B_v1(*,i_freq))
PSD_v2 = reform(PSD_B_v2(*,i_freq))
PSD_I_v1 = PSD_v1^2./mean(PSD_v1^2.,/nan)
PSD_I_v2 = PSD_v2^2./mean(PSD_v2^2.,/nan)
N = n_elements(PSD_v1)



;Mean_v1 = mean(PSD_I_v1,/nan)
;Mean_v2 = mean(PSD_I_v2,/nan)

corre = Correlate(PSD_I_v1,PSD_I_v2)


print,period_vect(i_freq),corre







end















