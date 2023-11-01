;pro figure4_get_sf_fewdays_theta



sub_dir_date  = 'wind\slow\case1\'



n_jie = 14;;;
jie = (findgen(n_jie)+1)/2.0

for i_jie = 0,n_jie-1 do begin
  
for i_slow = 10,12 do begin



;Step1:
;===========================
;Step1:
jieshu = jie(i_jie)
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i_slow),/remove_all)+'_'+strcompress(string(jieshu),/remove_all)+'_'+'Bx'+'_guan_'+'_SF'+'.sav'
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
;  time_vect, period_vect, $
;  BComp_StructFunct_arr, $
;  BComp_StructFunct_vect, $
;  Diff_BComp_arr, $
;  num_times_vect
;;;---
if i_slow eq 10 then begin
time_vect_10 = time_vect
Bx_StructFunct_arr_10  = BComp_StructFunct_arr
Diff_Bx_arr_10 = Diff_BComp_arr
endif
if i_slow eq 11 then begin
time_vect_11 = time_vect
Bx_StructFunct_arr_11  = BComp_StructFunct_arr
Diff_Bx_arr_11 = Diff_BComp_arr
endif
if i_slow eq 12 then begin
time_vect_12 = time_vect
Bx_StructFunct_arr_12  = BComp_StructFunct_arr
Diff_Bx_arr_12 = Diff_BComp_arr
endif

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i_slow),/remove_all)+'_'+strcompress(string(jieshu),/remove_all)+'_'+'By'+'_guan_'+'_SF'+'.sav'
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
;  time_vect, period_vect, $
;  BComp_StructFunct_arr, $
;  BComp_StructFunct_vect, $
;  Diff_BComp_arr, $
;  num_times_vect
;;;---
if i_slow eq 10 then begin
By_StructFunct_arr_10  = BComp_StructFunct_arr
Diff_By_arr_10 = Diff_BComp_arr
endif
if i_slow eq 11 then begin
By_StructFunct_arr_11  = BComp_StructFunct_arr
Diff_By_arr_11 = Diff_BComp_arr
endif
if i_slow eq 12 then begin
By_StructFunct_arr_12  = BComp_StructFunct_arr
Diff_By_arr_12 = Diff_BComp_arr
endif


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i_slow),/remove_all)+'_'+strcompress(string(jieshu),/remove_all)+'_'+'Bz'+'_guan_'+'_SF'+'.sav'
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
;  time_vect, period_vect, $
;  BComp_StructFunct_arr, $
;  BComp_StructFunct_vect, $
;  Diff_BComp_arr, $
;  num_times_vect
;;;---
if i_slow eq 10 then begin
Bz_StructFunct_arr_10  = BComp_StructFunct_arr
Diff_Bz_arr_10 = Diff_BComp_arr
endif
if i_slow eq 11 then begin
Bz_StructFunct_arr_11  = BComp_StructFunct_arr
Diff_Bz_arr_11 = Diff_BComp_arr
endif
if i_slow eq 12 then begin
Bz_StructFunct_arr_12  = BComp_StructFunct_arr
Diff_Bz_arr_12 = Diff_BComp_arr
endif

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+strcompress(string(i_slow),/remove_all)+'_guan'+'_(time=*-*)(period=*-*).sav'
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
; JulDay_min_v2, time_vect, period_vect, $
; Bxyz_LBG_RTN_arr
;;;---
if i_slow eq 10 then begin
time_vect_LBG_10 = time_vect
period_vect_LBG_10 = period_vect
Bxyz_LBG_RTN_arr_10 = Bxyz_LBG_RTN_arr
endif
if i_slow eq 11 then begin
time_vect_LBG_11 = time_vect
period_vect_LBG_11 = period_vect
Bxyz_LBG_RTN_arr_11 = Bxyz_LBG_RTN_arr
endif
if i_slow eq 12 then begin
time_vect_LBG_12 = time_vect
period_vect_LBG_12 = period_vect
Bxyz_LBG_RTN_arr_12 = Bxyz_LBG_RTN_arr
endif

;;--
;diff_time   = time_vect_StructFunct(0)-time_vect_LBG(0)
;diff_num_times  = N_Elements(time_vect_StructFunct)-N_Elements(time_vect_LBG)
;diff_period   = period_vect_StructFunct(0)-period_vect_LBG(0)
;diff_num_periods= N_Elements(period_vect_StructFunct)-N_Elements(period_vect_LBG)
;If diff_time ne 0.0 or diff_num_times ne 0L or $
;  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
;  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
;  Stop
;EndIf

endfor

;;;接数据
n_periods = n_elements(period_vect)

n1 = n_elements(time_vect_10)
n2 = n_elements(time_vect_11)
n3 = n_elements(time_vect_12)
time_vect = fltarr(n1+n2+n3)
time_vect(0:(n1-1)) = time_vect_10
time_vect(n1:(n1+n2-1)) = time_vect_11+time_vect_10(n1-1)
time_vect((n1+n2):(n1+n2+n3-1)) = time_vect_12+time_vect_10(n1-1)+time_vect_11(n2-1)

Bx_StructFunct_arr = fltarr(n1+n2+n3,n_periods)
Bx_StructFunct_arr(0:(n1-1),*) = Bx_StructFunct_arr_10
Bx_StructFunct_arr(n1:(n1+n2-1),*) = Bx_StructFunct_arr_11
Bx_StructFunct_arr((n1+n2):(n1+n2+n3-1),*) = Bx_StructFunct_arr_12

By_StructFunct_arr = fltarr(n1+n2+n3,n_periods)
By_StructFunct_arr(0:(n1-1),*) = By_StructFunct_arr_10
By_StructFunct_arr(n1:(n1+n2-1),*) = By_StructFunct_arr_11
By_StructFunct_arr((n1+n2):(n1+n2+n3-1),*) = By_StructFunct_arr_12

Bz_StructFunct_arr = fltarr(n1+n2+n3,n_periods)
Bz_StructFunct_arr(0:(n1-1),*) = Bz_StructFunct_arr_10
Bz_StructFunct_arr(n1:(n1+n2-1),*) = Bz_StructFunct_arr_11
Bz_StructFunct_arr((n1+n2):(n1+n2+n3-1),*) = Bz_StructFunct_arr_12

Diff_Bx_arr = fltarr(n1+n2+n3,n_periods)
Diff_Bx_arr(0:(n1-1),*) = Diff_Bx_arr_10
Diff_Bx_arr(n1:(n1+n2-1),*) = Diff_Bx_arr_11
Diff_Bx_arr((n1+n2):(n1+n2+n3-1),*) = Diff_Bx_arr_12

Diff_By_arr = fltarr(n1+n2+n3,n_periods)
Diff_By_arr(0:(n1-1),*) = Diff_By_arr_10
Diff_By_arr(n1:(n1+n2-1),*) = Diff_By_arr_11
Diff_By_arr((n1+n2):(n1+n2+n3-1),*) = Diff_By_arr_12

Diff_Bz_arr = fltarr(n1+n2+n3,n_periods)
Diff_Bz_arr(0:(n1-1),*) = Diff_Bz_arr_10
Diff_Bz_arr(n1:(n1+n2-1),*) = Diff_Bz_arr_11
Diff_Bz_arr((n1+n2):(n1+n2+n3-1),*) = Diff_Bz_arr_12

Bxyz_LBG_RTN_arr = fltarr(3,n1+n2+n3,n_periods)
Bxyz_LBG_RTN_arr(*,0:(n1-1),*) = Bxyz_LBG_RTN_arr_10
Bxyz_LBG_RTN_arr(*,n1:(n1+n2-1),*) = Bxyz_LBG_RTN_arr_11
Bxyz_LBG_RTN_arr(*,(n1+n2):(n1+n2+n3-1),*) = Bxyz_LBG_RTN_arr_12




;Step2:
;===========================
;Step2:

;;--
Bt_LBG_RTN_arr  = Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr

;;--
;;;some problem for the calculation of Bpara_SF_arr
;Bpara_StructFunct_arr  = Bx_StructFunct_arr*dbx_LBG_RTN_arr^2 + $
;           By_StructFunct_arr*dby_LBG_RTN_arr^2 + $
;           Bz_StructFunct_arr*dbz_LBG_RTN_arr^2
Btot_StructFunct_arr  = Bx_StructFunct_arr + By_StructFunct_arr + Bz_StructFunct_arr
Bpara_StructFunct_arr = (Diff_Bx_arr*dbx_LBG_RTN_arr + Diff_By_arr*dby_LBG_RTN_arr + Diff_Bz_arr*dbz_LBG_RTN_arr)^2
Bperp_StructFunct_arr = (Btot_StructFunct_arr - Bpara_StructFunct_arr) / 2
;;;---
StructFunct_Bpara_time_scale_arr  = Bpara_StructFunct_arr
StructFunct_Bperp_time_scale_arr  = Bperp_StructFunct_arr
StructFunct_Bt_time_scale_arr = Btot_StructFunct_arr


;;--save 'StructFunct_Bt/Bpara/Bperp_averaged_scale_vect'
num_scales  = (Size(StructFunct_Bt_time_scale_arr))[2]
StructFunct_Bt_aver_scale_vect  = Fltarr(num_scales)
StructFunct_Bpara_aver_scale_vect = Fltarr(num_scales)
StructFunct_Bperp_aver_scale_vect = Fltarr(num_scales)
num_DataNum_aver_scale_vect   = Lonarr(num_scales)
For i_scale=0,num_scales-1 Do Begin
  StructFunct_vect  = Reform(StructFunct_Bt_time_scale_arr(*,i_scale))
  StructFunct_tmp   = Mean(StructFunct_vect, /NaN)
  StructFunct_Bt_aver_scale_vect(i_scale) = StructFunct_tmp
  sub_tmp     = Where(Finite(StructFunct_vect) eq 1)
  num_DataNum_tmp = N_Elements(sub_tmp)
  num_DataNum_aver_scale_vect(i_scale)  = num_DataNum_tmp
  ;;;---
  StructFunct_vect  = Reform(StructFunct_Bpara_time_scale_arr(*,i_scale))
  StructFunct_tmp   = Mean(StructFunct_vect, /NaN)
  StructFunct_Bpara_aver_scale_vect(i_scale)  = StructFunct_tmp
  ;;;---
  StructFunct_vect  = Reform(StructFunct_Bperp_time_scale_arr(*,i_scale))
  StructFunct_tmp   = Mean(StructFunct_vect, /NaN)
  StructFunct_Bperp_aver_scale_vect(i_scale)  = StructFunct_tmp
EndFor




;Step3:
;===========================
;Step3:
time_vect_StructFunct = time_vect
period_vect_StructFunct = period_vect

;;--
num_times = N_Elements(time_vect_StructFunct)
num_periods = N_Elements(period_vect_StructFunct)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


;Step4:
;===========================
;Step4:

;;--define 'theta_bin_min/max_vect'

num_theta_bins  = 18L
dtheta_bin    = 180./num_theta_bins
 
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'StructFunct_Bpara_theta_scale_arr'
StructFunct_Bpara_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)

  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = StructFunct_Bpara_time_scale_arr(*,i_period)
    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_Bpara_theta_scale_arr(i_theta,i_period) = StructFunct_tmp
  EndIf
EndFor
EndFor

;;--get 'StructFunct_Bperp_theta_scale_arr'
StructFunct_Bperp_theta_scale_arr = Fltarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = StructFunct_Bperp_time_scale_arr(*,i_period)
;a    PSD_tmp = 10.^Mean(Alog10(PSD_vect_tmp(sub_tmp)),/NaN)
    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_Bperp_theta_scale_arr(i_theta,i_period) = StructFunct_tmp
  EndIf
EndFor
EndFor

;;--get 'StructFunct_Bt_theta_scale_arr'
StructFunct_Bt_theta_scale_arr  = Fltarr(num_theta_bins, num_periods)
num_DataNum_theta_scale_arr = Lonarr(num_theta_bins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = StructFunct_Bt_time_scale_arr(*,i_period)
;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_tmp = Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
    StructFunct_Bt_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
    num_DataNum_tmp = N_Elements(sub_tmp_v2)
    num_DataNum_theta_scale_arr(i_theta,i_period) = num_DataNum_tmp
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
period_min_str  = String(Min(period_vect),'(F5.1)')
period_max_str  = String(Max(period_vect),'(I5.4)')
PeriodRange_str = '(period='+period_min_str+'-'+period_max_str+')'
file_save = 'StructFunct_'+strcompress(string(jieshu),/remove_all)+'_guan_'+'day10-12_theta_period_arr'+$
 ;       TimeRange_str+$
 ;       PeriodRange_str+ $
        'V2.sav'
period_vect = period_vect_StructFunct
data_descrip= 'got from "get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_bin_min_vect, theta_bin_max_vect, $
  period_vect, $
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
  StructFunct_Bt_theta_scale_arr
;  num_DataNum_theta_scale_arr



endfor
;

;
;
;end


end



































