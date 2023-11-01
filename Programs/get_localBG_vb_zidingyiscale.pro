;pro get_localBG_vb_zidingyiscale

date = '20080406-08'

sub_dir_date  = 'wind\fast\'+date+'\'

zf='b_n'

Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_inB.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_'+date+'_v05.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect

JulDay_2s_vect = JulDay_vect
Bxyz_GSE_2s_arr = Bxyz_GSE_arr
n_b = n_elements(JulDay_2s_vect)

read,'+(0) or -(1)',sign
if sign eq 0 then sig = '+'
if sign eq 1 then sig = '-'

BVxyz_arr = fltarr(3,n_b)

if sign eq 0 then begin
BVx_RTN_vect  = reform(P_VEL_3s_arr(0,*))+22.0*reform(Bxyz_GSE_2s_arr(0,*))/sqrt(P_DEN_3s_arr);改+-
BVy_RTN_vect  = reform(P_VEL_3s_arr(1,*))+22.0*reform(Bxyz_GSE_2s_arr(1,*))/sqrt(P_DEN_3s_arr);
BVz_RTN_vect  = reform(P_VEL_3s_arr(2,*))+22.0*reform(Bxyz_GSE_2s_arr(2,*))/sqrt(P_DEN_3s_arr);
endif
if sign eq 1 then begin
BVx_RTN_vect  = reform(P_VEL_3s_arr(0,*))-22.0*reform(Bxyz_GSE_2s_arr(0,*))/sqrt(P_DEN_3s_arr);改+-
BVy_RTN_vect  = reform(P_VEL_3s_arr(1,*))-22.0*reform(Bxyz_GSE_2s_arr(1,*))/sqrt(P_DEN_3s_arr);
BVz_RTN_vect  = reform(P_VEL_3s_arr(2,*))-22.0*reform(Bxyz_GSE_2s_arr(2,*))/sqrt(P_DEN_3s_arr);
endif

BVxyz_arr(0,*) = transpose(BVx_RTN_vect)
BVxyz_arr(1,*) = transpose(BVy_RTN_vect)
BVxyz_arr(2,*) = transpose(BVz_RTN_vect)


Step2:
;===========================
;Step2:

;;--
num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

;;--
period_min  = 12.0;1.0;0.3;1.0 ;unit: s
period_max  = 1200.0;1.e3
period_range= [period_min, period_max]

;;--
get_LocalBG_WIND_v2, $
    time_vect, BVxyz_arr, $ ;input
    period_range=period_range, $  ;input
      num_scales=nscale, $         ;input
    BVxyz_LBG_arr, $   ;output
  ; time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect     ;output

;;--
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\'
JulDay_min  = Min(JulDay_2s_vect)
JulDay_max  = Max(JulDay_2s_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'
file_save = 'LocalBG_of_MagField_v'+sig+'b'+$  ;改+-
        TimeRange_str+zf+'.sav'
JulDay_min_v2 = Min(JulDay_2s_vect)
data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_WIND_200107.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_min_v2, time_vect, period_vect, $
  BVxyz_LBG_arr


End_Program:
End