;Pro get_PSD_from_FFT_Ulysess

Date = '19950130-0203'
sub_dir_date  = 'wind\'+Date+'\'


device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

Step1:
;===========================
;Step1:
;
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_19950130-0203_v05_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect



step2:

;;--
i_BComp = 0
Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = reform(Bxyz_GSE_2s_arr(0,*))
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = reform(Bxyz_GSE_2s_arr(1,*))
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = reform(Bxyz_GSE_2s_arr(2,*))
EndIf
wave_vect = BComp_RTN_vect

num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times


;;;
num_sets  = 1
type_window = 1

get_PSD_from_FFT_Method, time_vect, wave_vect, $
    num_sets=num_sets, type_window=type_window, $
    freq_vect_FFT, PSD_vect_FFT
    
    


dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;TimeRange_str = '(time='+$
;    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
;    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save = FileName_BComp+'_FFT_arr'+$
        '(time=)'+'_recon.sav'
data_descrip='got from "get_PSD_from_FFT_Ulysess.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  freq_vect_FFT, PSD_vect_FFT
  
  
      


End_Program:
End



