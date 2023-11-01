;Pro Realign_Mag_PSD_HM_sequence_with_PlasmaPara_sequence_WIND_199502

sub_dir_date  = '2002/2002-06/';'2005-03/';'1995-12-25/'
sub_dir_date  = '1995-01--1995-02/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir

sub_dir_name  = ''
WIND_3DP_Data_Dir   = 'WIND_3DP_Data_Dir=/Work/Data Analysis/WIND data process/Data/'+sub_dir_name+sub_dir_date  ;+TimeRange_str
WIND_3DP_Figure_Dir = 'WIND_3DP_Figure_Dir=/Work/Data Analysis/WIND data process/Figures/'+sub_dir_name+sub_dir_date ;+TimeRange_str
SetEnv, WIND_3DP_Data_Dir
SetEnv, WIND_3DP_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'PDF_in_2D_space_PSD_Hm(time=*-*)(period_Hm=*-*)(period_PSD=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "get_PDF_in_2D_space_PSD_Hm_WIND.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_min_for_Hm, period_max_for_Hm, $
;  period_min_for_PSD, period_max_for_PSD, $
;  theta_min_2D_PDF, theta_max_2D_PDF, $
;  JulDay_vect, theta_vect, PSD_norm_vect, ImSyz_norm_vect, NormHm_vect, $
;  PSD_norm_BinCent_vect, ImSyz_norm_BinCent_vect, Hm_norm_BinCent_vect, $
;  PDF_in_PSD_ImSyz_arr, PDF_in_PSD_Hm_arr, PDF_in_ImSyz_Hm_arr
;;;---
JulDay_vect_MFI = JulDay_vect
  
  
;;--
dir_restore  = GetEnv('WIND_3DP_Data_Dir')
file_restore = 'wi_pm_3dp_*_v0?.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_pm_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: velocity [km/s in SC coordinate similar to GSE coordinate]; number density [cm^-3]; '+$
;                  'temperature [10^4 K]; tensor [(km/s)^2, in SC coordinate]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr
;;;---
JulDay_vect_3DP = JulDay_vect


Goto, Step3
Step2:
;===========================
;Step2:

;;--
num_times_3DP = N_Elements(JulDay_vect_3DP)
PSD_norm_3DP_vect   = Dblarr(num_times_3DP)
ImSyz_norm_3DP_vect = Dblarr(num_times_3DP)
NormHm_3DP_vect     = Dblarr(num_times_3DP)
theta_RB_3DP_vect   = Dblarr(num_times_3DP)

;;--
For i_time_3DP=0,num_times_3DP-1 Do Begin
  JulDay_cent_3DP_tmp   = JulDay_vect_3DP(i_time_3DP)
  JulDay_beg_3DP_tmp    = JulDay_vect_3DP(i_time_3DP) - 1.5/(24.*60*60)
  JulDay_end_3DP_tmp    = JulDay_vect_3DP(i_time_3DP) + 1.5/(24.*60*60) 
  sub_tmp = Where(JulDay_vect_MFI ge JulDay_beg_3DP_tmp and JulDay_vect_MFI lt JulDay_end_3DP_tmp)
  theta_tmp       = Mean(theta_vect(sub_tmp))
  PSD_norm_tmp    = Mean(PSD_norm_vect(sub_tmp))
  ImSyz_norm_tmp  = Mean(ImSyz_Norm_vect(sub_tmp))
  NormHm_tmp      = Mean(NormHm_vect(sub_tmp))
  theta_RB_3DP_vect(i_time_3DP) = theta_tmp
  PSD_norm_3DP_vect(i_time_3DP) = PSD_norm_tmp
  ImSyz_norm_3DP_vect(i_time_3DP) = ImSyz_norm_tmp
  NormHm_3DP_vect(i_time_3DP)   = NormHm_tmp
  If ((i_time_3DP mod 500) eq 0) Then Print, 'i_time_3DP, num_times_3DP: ', i_time_3DP, num_times_3DP
EndFor


;;--
JulDay_min  = Min(JulDay_vect_3DP)
JulDay_max  = Max(JulDay_vect_3DP)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'

PeriodRange_Hm_str  = '(period_Hm='+$
      String(period_min_for_Hm,format='(F6.1)')+'-'+$
      String(period_max_for_Hm,format='(F6.1)')+')'

PeriodRange_PSD_str  = '(period_PSD='+$
      String(period_min_for_PSD,format='(F6.1)')+'-'+$
      String(period_max_for_PSD,format='(F6.1)')+')'
      
dir_save  = dir_restore
file_save = 'T_theta_PSD_Hm_vect(3DP_cadence)'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        '.sav'
data_descrip  = 'got from "Realign_Mag_PSD_HM_sequence_with_PlasmaPara_sequence_WIND_199502.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_min_for_Hm, period_max_for_Hm, $
  period_min_for_PSD, period_max_for_PSD, $
  JulDay_vect_3DP, $
  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
  theta_RB_3DP_vect, PSD_norm_3DP_vect, ImSyz_norm_3DP_vect, NormHm_3DP_vect


Step2_1:
;===========================
;Step2_1:

;;--
dir_restore  = GetEnv('WIND_3DP_Data_Dir')
file_restore = 'T_theta_PSD_Hm_vect(3DP_cadence)(time=*-*)(period_Hm=*-*)(period_PSD=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Realign_Mag_PSD_HM_sequence_with_PlasmaPara_sequence_WIND_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_min_for_Hm, period_max_for_Hm, $
;  period_min_for_PSD, period_max_for_PSD, $
;  JulDay_vect_3DP, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  theta_RB_3DP_vect, PSD_norm_3DP_vect, ImSyz_norm_3DP_vect, NormHm_3DP_vect

;;--
theta_vect      = theta_RB_3DP_vect
PSD_norm_vect   = PSD_norm_3DP_vect
ImSyz_norm_vect = ImSyz_norm_3DP_vect
NormHm_3DP_vect = NormHm_vect


Goto, Step5
Step3:
;===========================
;Step2:

;;--
num_times_MFI       = N_Elements(JulDay_vect_MFI)
NumDens_p_MFI_vect  = Dblarr(num_times_MFI)
NumDens_p_MFI_vect  = Dblarr(num_times_MFI)
Temper_p_MFI_vect   = Dblarr(num_times_MFI)
Temper_a_MFI_vect   = Dblarr(num_times_MFI)


;;--
NumDens_p_MFI_vect  = Interpol(NumDens_p_vect, JulDay_vect_3DP, JulDay_vect_MFI)
NumDens_a_MFI_vect  = Interpol(NumDens_a_vect, JulDay_vect_3DP, JulDay_vect_MFI)
Temper_p_MFI_vect   = Interpol(Temper_p_vect, JulDay_vect_3DP, JulDay_vect_MFI)
Temper_a_MFI_vect   = Interpol(Temper_a_vect, JulDay_vect_3DP, JulDay_vect_MFI)


;;--
JulDay_min  = Min(JulDay_vect_3DP)
JulDay_max  = Max(JulDay_vect_3DP)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'

PeriodRange_Hm_str  = '(period_Hm='+$
      String(period_min_for_Hm,format='(F6.1)')+'-'+$
      String(period_max_for_Hm,format='(F6.1)')+')'

PeriodRange_PSD_str  = '(period_PSD='+$
      String(period_min_for_PSD,format='(F6.1)')+'-'+$
      String(period_max_for_PSD,format='(F6.1)')+')'
      
dir_save  = dir_restore
file_save = 'T_theta_PSD_Hm_vect(MFI_cadence)'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        '.sav'
data_descrip  = 'got from "Realign_Mag_PSD_HM_sequence_with_PlasmaPara_sequence_WIND_199502.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_min_for_Hm, period_max_for_Hm, $
  period_min_for_PSD, period_max_for_PSD, $
  JulDay_vect_MFI, $
  NumDens_p_MFI_vect, NumDens_a_MFI_vect, Temper_p_MFI_vect, Temper_a_MFI_vect, $
  theta_vect, PSD_norm_vect, ImSyz_norm_vect, NormHm_vect
  

Step3_1:
;===========================
;Step2_1:

;;--
dir_restore  = GetEnv('WIND_3DP_Data_Dir')
file_restore = 'T_theta_PSD_Hm_vect(MFI_cadence)(time=*-*)(period_Hm=*-*)(period_PSD=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Realign_Mag_PSD_HM_sequence_with_PlasmaPara_sequence_WIND_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_min_for_Hm, period_max_for_Hm, $
;  period_min_for_PSD, period_max_for_PSD, $
;  JulDay_vect_MFI, $
;  NumDens_p_vect_MFI, NumDens_a_vect_MFI, Temper_p_vect_MFI, Temper_a_vect_MFI, $
;  theta_vect, PSD_norm_vect, ImSyz_norm_vect, NormHm_vect
;;--
NumDens_p_vect  = NumDens_p_MFI_vect
NumDens_a_vect  = NumDens_a_MFI_vect
Temper_p_vect   = Temper_p_MFI_vect
Temper_a_vect   = Temper_a_MFI_vect

;;--
TV_option_for_Temper  = 1
Print, 'TV_option_for_Temper(0/1/2: original/difference/subtract-bg: ', TV_option_for_Temper
Read, 'TV_option_for_Temper: ', TV_option_for_Temper
If TV_option_for_Temper eq 0 Then Begin
  title_Temper  = 'T_ori'
EndIf Else Begin
If TV_option_for_Temper eq 1 Then Begin
  title_Temper  = 'T_diff'
  dt_MFI  = Mean(JulDay_vect_MFI(1:num_times_MFI-1)-JulDay_vect_MFI(0:num_times_MFI-2))
  dt_MFI  = dt_MFI * (24.*60*60)
  dtime_shift   = 20.0
  dnum_pix_shift= Round(dtime_shift / dt_MFI)
  Temper_p_vect = 2*Temper_p_vect - Shift(Temper_p_vect, dnum_pix_shift) - Shift(Temper_p_vect, -dnum_pix_shift)
EndIf Else Begin
If TV_option_for_Temper eq 2 Then Begin
  title_Temper  = 'T_subtract'
  dt_MFI  = Mean(JulDay_vect_MFI(1:num_times_MFI-1)-JulDay_vect_MFI(0:num_times_MFI-2))
  dt_MFI  = dt_MFI * (24.*60*60)
  dtime_smooth   = 30.*60
  dnum_pix_smooth= Round(dtime_smooth / dt_MFI)
  Temper_p_vect = Temper_p_vect - Smooth(Temper_p_vect, dnum_pix_smooth, /Edge_Truncate)
  
  sub_beg = dnum_pix_smooth / 2
  sub_end = N_Elements(Temper_p_vect)-1 - dnum_pix_smooth/2
  Temper_p_vect = Temper_p_vect(sub_beg:sub_end)
  theta_vect    = theta_vect(sub_beg:sub_end)
  PSD_norm_vect = PSD_norm_vect(sub_beg:sub_end)
  ImSyz_norm_vect = ImSyz_norm_vect(sub_beg:sub_end)
  NormHm_vect     = NormHm_vect(sub_beg:sub_end)
  
EndIf
EndElse
EndElse
  


Goto, Step5
Step4:
;===========================
;Step4:

;;--
theta_min_2D_PDF  = 60.0
theta_max_2D_PDF  = 90.0
sub_tmp = Where(theta_RB_3DP_vect ge theta_min_2D_PDF and theta_RB_3DP_vect le theta_max_2D_PDF)
PSD_norm_3DP_vect_2D_PDF  = PSD_norm_3DP_vect(sub_tmp)
ImSyz_norm_3DP_vect_2D_PDF= ImSyz_norm_3DP_vect(sub_tmp)
Hm_norm_3DP_vect_2D_PDF   = NormHm_3DP_vect(sub_tmp)
Temper_p_vect_2D_PDF      = Temper_p_vect(sub_tmp)
Temper_a_vect_2D_PDF      = Temper_a_vect(sub_tmp)

;;--
PSD_norm_min=Min(PSD_norm_BinCent_vect) & PSD_norm_max=Max(PSD_norm_BinCent_vect)
ImSyz_norm_min=Min(ImSyz_norm_BinCent_vect) & PSD_norm_max=Max(PSD_norm_BinCent_vect)
Hm_norm_norm_min=Min(Hm_norm_BinCent_vect) & PSD_norm_max=Max(PSD_norm_BinCent_vect)
num_bins_PSD  = 50L
num_bins_ImSyz  = 50L
num_bins_Hm  = 50L
PSD_norm_BinCent_vect  = PSD_norm_min + Findgen(num_bins_PSD)*(PSD_norm_max-PSD_norm_min)/(num_bins_PSD-1)
ImSyz_norm_BinCent_vect  = ImSyz_norm_min + Findgen(num_bins_ImSyz)*(ImSyz_norm_max-ImSyz_norm_min)/(num_bins_ImSyz-1)
Hm_norm_BinCent_vect  = Hm_norm_min + Findgen(num_bins_Hm)*(Hm_norm_max-Hm_norm_min)/(num_bins_Hm-1)

;;--
Tp_in_PSD_ImSyz_arr = Fltarr(num_bins_PSD, num_bins_ImSyz)
Tp_in_PSD_Hm_arr    = Fltarr(num_bins_PSD, num_bins_ImSyz)
Tp_in_ImSyz_Hm_arr  = Fltarr(num_bins_ImSyz, num_bins_Hm)
PDF_in_PSD_ImSyz_arr  = Fltarr(num_bins_PSD, num_bins_ImSyz)
PDF_in_PSD_Hm_arr     = Fltarr(num_bins_PSD, num_bins_Hm)
PDF_in_ImSyz_Hm_arr   = Fltarr(num_bins_ImSyz, num_bins_Hm)

;;--
dPSD_bin    = PSD_norm_BinCent_vect(1) - PSD_norm_BinCent_vect(0)
dImSyz_bin  = ImSyz_norm_BinCent_vect(1) - ImSyz_norm_BinCent_vect(0)
dHm_bin     = Hm_norm_BinCent_vect(1) - Hm_norm_BinCent_vect(0)

;;--
For i_bin_PSD=0,num_bins_PSD-1 Do Begin
  print, 'i_bin_PSD: ', i_bin_PSD
For i_bin_ImSyz=0,num_bins_ImSyz-1 Do Begin
  PSD_min_bin = PSD_norm_BinCent_vect(i_bin_PSD) - 0.5*dPSD_bin
  PSD_max_bin = PSD_norm_BinCent_vect(i_bin_PSD) + 0.5*dPSD_bin
  ImSyz_min_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) - 0.5*dImSyz_bin
  ImSyz_max_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) + 0.5*dImSyz_bin
  sub_tmp = Where(PSD_norm_vect_2D_PDF ge PSD_min_bin and PSD_Norm_vect_2D_PDF le PSD_max_bin and $
                  ImSyz_norm_vect_2D_PDF ge ImSyz_min_bin and ImSyz_norm_vect_2D_PDF le ImSyz_max_bin)
  If (sub_tmp(0) ne -1) Then Begin
    Tp_in_PSD_ImSyz_arr(i_bin_PSD,i_bin_ImSyz)  = Mean(Temper_p_vect(sub_tmp))
    PDF_tmp = N_Elements(sub_tmp)
    PDF_in_PSD_ImSyz_arr(i_bin_PSD,i_bin_ImSyz) = PDF_tmp
  EndIf
EndFor
EndFor  

;;--
For i_bin_PSD=0,num_bins_PSD-1 Do Begin
  print, 'i_bin_PSD: ', i_bin_PSD
For i_bin_Hm=0,num_bins_Hm-1 Do Begin
  PSD_min_bin = PSD_norm_BinCent_vect(i_bin_PSD) - 0.5*dPSD_bin
  PSD_max_bin = PSD_norm_BinCent_vect(i_bin_PSD) + 0.5*dPSD_bin
  Hm_min_bin = Hm_norm_BinCent_vect(i_bin_Hm) - 0.5*dHm_bin
  Hm_max_bin = Hm_norm_BinCent_vect(i_bin_Hm) + 0.5*dHm_bin
  sub_tmp = Where(PSD_norm_vect_2D_PDF ge PSD_min_bin and PSD_Norm_vect_2D_PDF le PSD_max_bin and $
                  Hm_norm_vect_2D_PDF ge Hm_min_bin and Hm_norm_vect_2D_PDF le Hm_max_bin)
  If (sub_tmp(0) ne -1) Then Begin
    Tp_in_PSD_Hm_arr(i_bin_PSD,i_bin_ImSyz) = Mean(Temper_p_vect(sub_tmp))
    PDF_tmp = N_Elements(sub_tmp)
    PDF_in_PSD_Hm_arr(i_bin_PSD,i_bin_Hm) = PDF_tmp
  EndIf
EndFor
EndFor  

;;--
For i_bin_ImSyz=0,num_bins_ImSyz-1 Do Begin
  print, 'i_bin_ImSyz: ', i_bin_ImSyz
For i_bin_Hm=0,num_bins_Hm-1 Do Begin
  ImSyz_min_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) - 0.5*dHm_bin
  ImSyz_max_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) + 0.5*dHm_bin
  Hm_min_bin = Hm_norm_BinCent_vect(i_bin_Hm) - 0.5*dHm_bin
  Hm_max_bin = Hm_norm_BinCent_vect(i_bin_Hm) + 0.5*dHm_bin
  sub_tmp = Where(Hm_norm_vect_2D_PDF ge Hm_min_bin and Hm_Norm_vect_2D_PDF le Hm_max_bin and $
                  ImSyz_norm_vect_2D_PDF ge ImSyz_min_bin and ImSyz_norm_vect_2D_PDF le ImSyz_max_bin)
  If (sub_tmp(0) ne -1) Then Begin
    Tp_in_ImSyz_Hm_arr(i_bin_PSD,i_bin_ImSyz) = Mean(Temper_p_vect(sub_tmp))  
    PDF_tmp = N_Elements(sub_tmp)
    PDF_in_ImSyz_Hm_arr(i_bin_ImSyz,i_bin_Hm) = PDF_tmp
  EndIf
EndFor
EndFor 


;;--
JulDay_vect = JulDay_min+time_vect/(24.*60*60)
JulDay_min  = Min(JulDay_vect)
JulDay_max  = Max(JulDay_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'

;;--
PeriodRange_Hm_str  = '(period_Hm='+$
      String(period_min_for_Hm,format='(F6.1)')+'-'+$
      String(period_max_for_Hm,format='(F6.1)')+')'
;;--
PeriodRange_PSD_str  = '(period_PSD='+$
      String(period_min_for_PSD,format='(F6.1)')+'-'+$
      String(period_max_for_PSD,format='(F6.1)')+')'
      
;;--
ThetaRange_2D_PDF_str = '(theta='+$
      String(theta_min_2D_PDF,format='(F6.1)')+'-'+$
      String(theta_max_2D_PDF,format='(F6.1)')+')'
  
;;--
dir_save  = dir_restore
file_save = 'PDF_in_2D_space_PSD_Hm'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        ThetaRange_2D_PDF_str+$
        '.sav'
data_descrip  = 'got from "get_PDF_in_2D_space_PSD_Hm_WIND.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_min_for_Hm, period_max_for_Hm, $
  period_min_for_PSD, period_max_for_PSD, $
  theta_min_2D_PDF, theta_max_2D_PDF, $
  JulDay_vect, PSD_norm_vect, ImSyz_norm_vect, NormHm_vect, $
  PSD_norm_BinCent_vect, ImSyz_norm_BinCent_vect, Hm_norm_BinCent_vect, $
  PDF_in_PSD_ImSyz_arr, PDF_in_PSD_Hm_arr, PDF_in_ImSyz_Hm_arr
  

Step5:
;===========================
;Step5:

;;--
theta_min_2D_PDF  = 0.0
theta_max_2D_PDF  = 30.0
ThetaRange_str  = '(theta_RB='+String(theta_min_2D_PDF,format='(I2.2)')+'-'+String(theta_max_2D_PDF,format='(I2.2)')+')'

;;--
sub_tmp = Where(theta_vect ge theta_min_2D_PDF and theta_vect le theta_max_2D_PDF)
x_vect  = PSD_norm_vect(sub_tmp)
y_vect  = ImSyz_norm_vect(sub_tmp)
y_vect  = NormHm_vect(sub_tmp)
para_vect = ALog10(Temper_p_vect(sub_tmp))
para_vect = Temper_p_vect(sub_tmp)
;a para_vect = Temper_p_vect(sub_tmp) / NumDens_p_vect(sub_tmp)^(4./3) ;specific entropy in solar wind according to Schindler & Birn 1978
;a para_vect = NumDens_p_vect(sub_tmp)
num_x_pix_l1  = 10L
num_y_pix_l1  = 10L
xtitle  = 'PSD_norm'
ytitle  = 'ImSyz_norm'
ytitle  = 'NormHm'
title   = title_Temper

;a title   = 'NumDens_p'
;a title   = 'entropy_p'
remark_vect = Strarr(5)
remark_vect(0)  = TimeRange_str
remark_vect(1)  = PeriodRange_Hm_str
remark_vect(2)  = PeriodRange_PSD_str
remark_vect(3)  = ThetaRange_str
remark_vect(4)  = 'got from "TV_AverPara_in_2D_para_space_based_on_AMR.pro"'

;x_vect_ori=x_vect & y_vect_ori=y_vect & para_vect_ori=para_vect
;xtitle_ori=xtitle & ytitle_ori=ytitle & title_ori=title
;x_vect=para_vect_ori & y_vect=x_vect_ori & para_vect=y_vect_ori
;xtitle=title_ori & ytitle=xtitle_ori & title=ytitle_ori

position_panel  = Fltarr(4)
num_CB_color  = 0L

TV_AverPara_in_2D_para_space_based_on_AMR, x_vect, y_vect, para_vect, $
    num_x_pix_l1=num_x_pix_l1, num_y_pix_l1=num_y_pix_l1, $
    position_panel=position_panel, num_CB_color=num_CB_color, $
    xtitle=xtitle, ytitle=ytitle, title=title, $
    remark_vect=remark_vect

;;--    
image_tvrd  = TVRD(true=1)
file_version= ''
file_fig  = '(x='+xtitle+')'+$
        '(y='+ytitle+')'+$
        '(para='+title+')'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        ThetaRange_str+$        
        '.png'
dir_fig = GetEnv('WIND_MFI_Figure_Dir')+''+sub_dir_date        
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b
    


End_Program:
End  