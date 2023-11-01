;Pro get_SubWave_Wavelet_of_BComp_vect_WIND_MFI_199502


sub_dir_date  = '2005-03/';'1995-12-25/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date

file_restore= 'Bxyz_GSE_arr(time=*-*).sav'
;a file_restore= 'wi_h2_mfi_20050311_v05.sav'
date_str  = '(date=20050311)'

file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


Step2:
;===========================
;Step2:

;;--
i_BComp = 0
Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_GSE_vect  = Bx_GSE_vect_plot
EndIf
If i_BComp eq 2 Then Begin
  BComp_GSE_vect  = By_GSE_vect_plot
EndIf
If i_BComp eq 3 Then Begin
  BComp_GSE_vect  = Bz_GSE_vect_plot
EndIf
wave_vect = BComp_GSE_vect

;;--
num_times = N_Elements(JulDay_vect_plot)
time_vect = (JulDay_vect_plot(0:num_times-1)-JulDay_vect_plot(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

;;--
BComp_vect  = wave_vect

period_min  = 2.0;15.0;1.0;1.5;1.0;1.e0  ;unit: s
period_max  = 6.0;30.0;2.0;3.5;1.e3

period_range= [period_min, period_max]

;;--
get_SubWave_Wavelet_of_BComp_vect_WIND_MFI, $
    time_vect, BComp_vect, $    ;input
    period_range=period_range, $  ;input
    SubWave_BComp_vect, $       ;output
    time_vect_v2=time_vect_v2

;;--
dir_save  = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
PeriodRange_str = '(period='+$
    String(period_min,Format='(F4.1)')+'-'+$
    String(period_max,Format='(F4.1)')+')'
JulDay_min  = Min(JulDay_vect_plot)
JulDay_max  = Max(JulDay_vect_plot)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max

TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
TimeRange_str = '(time='+$
    String(hour_min,Format='(I4.4)')+String(min_min,Format='(I2.2)')+String(sec_min,Format='(I2.2)')+'-'+$
    String(hour_max,Format='(I4.4)')+String(min_max,Format='(I2.2)')+String(sec_max,Format='(I2.2)')+')'

file_version= ''
file_save = FileName_BComp+'_SubWave_vect'+$
        PeriodRange_str+$
        
        date_str+$

        TimeRange_str+file_version+'.sav'
JulDay_min_v2 = Min(JulDay_vect_plot)
data_descrip= 'got from "get_SubWave_Wavelet_of_BComp_vect_WIND_MFI_199502.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min_v2, time_vect_v2, period_range, $
  SubWave_BComp_vect


End_Program:
End