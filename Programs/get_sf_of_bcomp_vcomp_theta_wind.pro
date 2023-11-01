;Pro get_SF_of_BComp_VComp_theta_WIND

sub_dir_date  = 'wind\Alfven1\'



Step1:
;===========================
;;;;;;;
Step1_1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct_arr(time=*-*)(period=*-*)(v3).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  BComp_SF_2_arr,BComp_SF_4_arr, $
;  BComp_SF_2_vect,BComp_SF_4_vect, $
;  Diff_BComp_2_arr,Diff_BComp_4_arr, $
;  num_times_vect
;;;---
time_vect_StructFunct = time_vect
period_vect_StructFunct= period_vect
Bx_SF_2_arr  = BComp_SF_2_arr
Bx_SF_4_arr  = BComp_SF_4_arr
Diff_Bx_arr = Diff_BComp_2_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct_arr(time=*-*)(period=*-*)(v3).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  BComp_SF_2_arr,BComp_SF_4_arr, $
;  BComp_SF_2_vect,BComp_SF_4_vect, $
;  Diff_BComp_2_arr,Diff_BComp_4_arr, $
;  num_times_vect
;;;---
By_SF_2_arr  = BComp_SF_2_arr
By_SF_4_arr  = BComp_SF_4_arr
Diff_By_arr = Diff_BComp_2_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct_arr(time=*-*)(period=*-*)(v3).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  BComp_SF_2_arr,BComp_SF_4_arr, $
;  BComp_SF_2_vect,BComp_SF_4_vect, $
;  Diff_BComp_2_arr,Diff_BComp_4_arr, $
;  num_times_vect
;;;---
Bz_SF_2_arr  = BComp_SF_2_arr
Bz_SF_4_arr  = BComp_SF_4_arr
Diff_Bz_arr = Diff_BComp_2_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min_v2, time_vect, period_vect, $
;  Bxyz_LBG_RTN_arr
;;;---
time_vect_LBG = time_vect
period_vect_LBG = period_vect

;;--
diff_time   = time_vect_StructFunct(0)-time_vect_LBG(0)
diff_num_times  = N_Elements(time_vect_StructFunct)-N_Elements(time_vect_LBG)
diff_period   = period_vect_StructFunct(0)-period_vect_LBG(0)
diff_num_periods= N_Elements(period_vect_StructFunct)-N_Elements(period_vect_LBG)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf

;;;;;;;
Step1_2:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Vx'+'_StructFunct_arr(time=*-*)(period=*-*)(v3).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  BComp_SF_2_arr,BComp_SF_4_arr, $
;  BComp_SF_2_vect,BComp_SF_4_vect, $
;  Diff_BComp_2_arr,Diff_BComp_4_arr, $
;  num_times_vect
;;;---
time_vect_StructFunct = time_vect
period_vect_StructFunct= period_vect
Vx_SF_2_arr  = BComp_SF_2_arr
Vx_SF_4_arr  = BComp_SF_4_arr
Diff_Vx_arr = Diff_BComp_2_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Vy'+'_StructFunct_arr(time=*-*)(period=*-*)(v3).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  BComp_SF_2_arr,BComp_SF_4_arr, $
;  BComp_SF_2_vect,BComp_SF_4_vect, $
;  Diff_BComp_2_arr,Diff_BComp_4_arr, $
;  num_times_vect
;;;---
Vy_SF_2_arr  = BComp_SF_2_arr
Vy_SF_4_arr  = BComp_SF_4_arr
Diff_Vy_arr = Diff_BComp_2_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Vz'+'_StructFunct_arr(time=*-*)(period=*-*)(v3).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  BComp_SF_2_arr,BComp_SF_4_arr, $
;  BComp_SF_2_vect,BComp_SF_4_vect, $
;  Diff_BComp_2_arr,Diff_BComp_4_arr, $
;  num_times_vect
;;;---
Vz_SF_2_arr  = BComp_SF_2_arr
Vz_SF_4_arr  = BComp_SF_4_arr
Diff_Vz_arr = Diff_BComp_2_arr

;;--


step2:

;;--
Bt_LBG_RTN_arr  = Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr


Btot_SF_2_arr  = Bx_SF_2_arr + By_SF_2_arr + Bz_SF_2_arr
Btot_SF_4_arr  = Bx_SF_4_arr + By_SF_4_arr + Bz_SF_4_arr
;;--
Vtot_SF_2_arr  = Vx_SF_2_arr + Vy_SF_2_arr + Vz_SF_2_arr
Vtot_SF_4_arr  = Vx_SF_4_arr + Vy_SF_4_arr + Vz_SF_4_arr
;;;
;;--
num_times = N_Elements(time_vect_StructFunct)
num_periods = N_Elements(period_vect_StructFunct)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi
;;--

;;--define 'theta_bin_min/max_vect'

num_theta_bins  = 90L
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'StructFunct_Bt_theta_scale_arr'
SF_Bt_2_theta_arr  = Fltarr(num_theta_bins, num_periods)
SF_Bt_4_theta_arr  = Fltarr(num_theta_bins, num_periods)
DataNum_theta_arr = Lonarr(num_theta_bins, num_periods)
;num_DataNum_theta_scale_arr = Lonarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp2  = Btot_SF_2_arr(*,i_period)
;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_tmp2 = Mean(StructFunct_vect_tmp2(sub_tmp), /NaN)   ;计算已除去坏点
    SF_Bt_2_theta_arr(i_theta,i_period)= StructFunct_tmp2
    StructFunct_vect_tmp4  = Btot_SF_4_arr(*,i_period)
;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_tmp4 = Mean(StructFunct_vect_tmp4(sub_tmp), /NaN)   ;计算已除去坏点
    SF_Bt_4_theta_arr(i_theta,i_period)= StructFunct_tmp4    
    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp2(sub_tmp)) eq 1)
    num_DataNum_tmp = N_Elements(sub_tmp_v2)
    DataNum_theta_arr(i_theta,i_period) = num_DataNum_tmp
  EndIf
EndFor
EndFor

;;--get 'StructFunct_Bt_theta_scale_arr'
SF_Vt_2_theta_arr  = Fltarr(num_theta_bins, num_periods)
SF_Vt_4_theta_arr  = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp2  = Vtot_SF_2_arr(*,i_period)
    StructFunct_tmp2 = Mean(StructFunct_vect_tmp2(sub_tmp), /NaN)   ;计算已除去坏点
    SF_Vt_2_theta_arr(i_theta,i_period)= StructFunct_tmp2
    StructFunct_vect_tmp4  = Vtot_SF_4_arr(*,i_period)
    StructFunct_tmp4 = Mean(StructFunct_vect_tmp4(sub_tmp), /NaN)   ;计算已除去坏点
    SF_Vt_4_theta_arr(i_theta,i_period)= StructFunct_tmp4    
  EndIf
EndFor
EndFor


;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
JulDay_min  = JulDay_min
JulDay_max  = JulDay_min+(Max(time_vect_StructFunct)-Min(time_vect_StructFunct))/(24.*60.*60)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
period_min_str  = String(Min(period_vect),'(F4.1)')
period_max_str  = String(Max(period_vect),'(I4.4)')
PeriodRange_str = '(period='+period_min_str+'-'+period_max_str+')'
file_save = 'StructFunct_theta_B_and_V_period_arr'+$
        TimeRange_str+$
        PeriodRange_str+ $
        '.sav'
period_vect = period_vect_StructFunct
data_descrip= 'got from "get_SF_of_BComp_VComp_theta_WIND.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_bin_min_vect, theta_bin_max_vect, $
  period_vect, Btot_SF_2_arr, Btot_SF_4_arr, Vtot_SF_2_arr, Vtot_SF_4_arr, $
  SF_Bt_2_theta_arr, SF_Bt_4_theta_arr, SF_Vt_2_theta_arr, SF_Vt_4_theta_arr, $
  DataNum_theta_arr








end