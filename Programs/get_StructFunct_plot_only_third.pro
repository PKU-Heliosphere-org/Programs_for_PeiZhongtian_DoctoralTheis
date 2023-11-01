;Pro get_StructFunct_plot_only_third


sub_dir_date  = 'new\19950720-29-1\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
dir_fig = dir_restore

n_jie = 7
jie = findgen(n_jie)+1

;;--
is_eps_png = 0
read,'eps(1) or png(2)',is_eps_png
if is_eps_png eq 1 then begin
Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'StructFunct_of_Btot_theta_scale_arr.eps', $   ;
    XSize=17,YSize=24,/Color,Bits=10,/Encapsul
Device,DeComposed=0
endif
if is_eps_png eq 2 then begin
set_Plot, 'win'
Device,DeComposed=0;, /Retain
xsize=850.0 & ysize=1200.0
Window,0,XSize=xsize,YSize=ysize,Retain=2
endif

;;--
LoadCT,13
TVLCT,R,G,B,/Get
color_red = 255L
TVLCT,255L,0L,0L,color_red
color_green = 254L
TVLCT,0L,255L,0L,color_green
color_blue  = 253L
TVLCT,0L,0L,255L,color_blue
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background


position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 4
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

;;
dir_restore  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'EffDataNum_theta_scale_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr
EffDataNum_scale_theta_arr_o = EffDataNum_scale_theta_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=19950720-19950729)(period=6.0-1999).sav'
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
Bxyz_LBG_RTN_arr_o = Bxyz_LBG_RTN_arr
time_vect_LBG_o = time_vect
period_vect_LBG_o = period_vect


dir_restore  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'EffDataNum_theta_scale_arr(time=*-*)_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr
EffDataNum_scale_theta_arr_r = EffDataNum_scale_theta_arr
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=19950720-19950729)(period=6.0-1999)_recon.sav'
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
Bxyz_LBG_RTN_arr_r = Bxyz_LBG_RTN_arr
time_vect_LBG_r = time_vect
period_vect_LBG_r = period_vect


for i_c = 0,3 do begin
if i_c eq 0 then begin
  i_jie = 1
  jieshu = jie(i_jie)
endif
if i_c eq 1 then begin
  i_jie = 2
  jieshu = jie(i_jie)
endif
if i_c eq 2 then begin
  i_jie = 4
  jieshu = jie(i_jie)
endif
if i_c eq 3 then begin
  i_jie = 6
  jieshu = jie(i_jie)
endif
  
  max_re = float(1)
  min_re = float(1)
;i_jie = 6
Step1:
;===========================
;Step1:
;jieshu = jie(i_jie)

;;--
step1_1:
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3).sav'
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
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
time_vect_StructFunct_o = time_vect
period_vect_StructFunct_o = period_vect
Bx_StructFunct_arr_o  = BComp_StructFunct_arr
Diff_Bx_arr_o = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3).sav'
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
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
By_StructFunct_arr_o  = BComp_StructFunct_arr
Diff_By_arr_o = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3).sav'
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
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
Bz_StructFunct_arr_o  = BComp_StructFunct_arr
Diff_Bz_arr_o = Diff_BComp_arr






;;--
diff_time   = time_vect_StructFunct_o(0)-time_vect_LBG_o(0)
diff_num_times  = N_Elements(time_vect_StructFunct_o)-N_Elements(time_vect_LBG_o)
diff_period   = period_vect_StructFunct_o(0)-period_vect_LBG_o(0)
diff_num_periods= N_Elements(period_vect_StructFunct_o)-N_Elements(period_vect_LBG_o)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf


step1_2:
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3)_recon.sav'
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
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---


time_vect_StructFunct_r = time_vect
period_vect_StructFunct_r= period_vect
Bx_StructFunct_arr_r  = BComp_StructFunct_arr
Diff_Bx_arr_r = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3)_recon.sav'
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
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
By_StructFunct_arr_r  = BComp_StructFunct_arr
Diff_By_arr_r = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=6.0-2000)(v3)_recon.sav'
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
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
Bz_StructFunct_arr_r  = BComp_StructFunct_arr
Diff_Bz_arr_r = Diff_BComp_arr




;;--
diff_time   = time_vect_StructFunct_r(0)-time_vect_LBG_r(0)
diff_num_times  = N_Elements(time_vect_StructFunct_r)-N_Elements(time_vect_LBG_r)
diff_period   = period_vect_StructFunct_r(0)-period_vect_LBG_r(0)
diff_num_periods= N_Elements(period_vect_StructFunct_r)-N_Elements(period_vect_LBG_r)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf


for i_recon = 0,1 do begin
  if i_recon eq 0 then begin
    time_vect_StructFunct = time_vect_StructFunct_o
    period_vect_StructFunct = period_vect_StructFunct_o
    Bx_StructFunct_arr  = Bx_StructFunct_arr_o
    Diff_Bx_arr = Diff_Bx_arr_o
    By_StructFunct_arr  = By_StructFunct_arr_o
    Diff_By_arr = Diff_By_arr_o
    Bz_StructFunct_arr  = Bz_StructFunct_arr_o
    Diff_Bz_arr = Diff_Bz_arr_o
    Bxyz_LBG_RTN_arr = Bxyz_LBG_RTN_arr_o
    time_vect_LBG = time_vect_LBG_o
    period_vect_LBG = period_vect_LBG_o
    EffDataNum_scale_theta_arr = EffDataNum_scale_theta_arr_o
    strre = 'original'
  endif
  if i_recon eq 1 then begin
    time_vect_StructFunct = time_vect_StructFunct_r
    period_vect_StructFunct = period_vect_StructFunct_r
    Bx_StructFunct_arr  = Bx_StructFunct_arr_r
    Diff_Bx_arr = Diff_Bx_arr_r
    By_StructFunct_arr  = By_StructFunct_arr_r
    Diff_By_arr = Diff_By_arr_r
    Bz_StructFunct_arr  = Bz_StructFunct_arr_r
    Diff_Bz_arr = Diff_Bz_arr_r
    Bxyz_LBG_RTN_arr = Bxyz_LBG_RTN_arr_r
    time_vect_LBG = time_vect_LBG_r
    period_vect_LBG = period_vect_LBG_r
    EffDataNum_scale_theta_arr = EffDataNum_scale_theta_arr_r
    strre = 'LIM'
  endif  

Step2:
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
;StructFunct_Bpara_time_scale_arr  = Bpara_StructFunct_arr
;StructFunct_Bperp_time_scale_arr  = Bperp_StructFunct_arr
;StructFunct_Bt_time_scale_arr = Btot_StructFunct_arr


;;--save 'StructFunct_Bt/Bpara/Bperp_averaged_scale_vect'
num_scales  = (Size(Btot_StructFunct_arr))[2]
StructFunct_Bt_aver_scale_vect  = Fltarr(num_scales)
StructFunct_Bpara_aver_scale_vect = Fltarr(num_scales)
StructFunct_Bperp_aver_scale_vect = Fltarr(num_scales)
num_DataNum_aver_scale_vect   = Lonarr(num_scales)
For i_scale=0,num_scales-1 Do Begin
  StructFunct_vect  = Reform(Btot_StructFunct_arr(*,i_scale))
  StructFunct_tmp   = Mean(StructFunct_vect, /NaN)
  StructFunct_Bt_aver_scale_vect(i_scale) = StructFunct_tmp
  sub_tmp     = Where(Finite(StructFunct_vect) eq 1)
  num_DataNum_tmp = N_Elements(sub_tmp)
  num_DataNum_aver_scale_vect(i_scale)  = num_DataNum_tmp
  ;;;---
  StructFunct_vect  = Reform(Bpara_StructFunct_arr(*,i_scale))
  StructFunct_tmp   = Mean(StructFunct_vect, /NaN)
  StructFunct_Bpara_aver_scale_vect(i_scale)  = StructFunct_tmp
  ;;;---
  StructFunct_vect  = Reform(Bperp_StructFunct_arr(*,i_scale))
  StructFunct_tmp   = Mean(StructFunct_vect, /NaN)
  StructFunct_Bperp_aver_scale_vect(i_scale)  = StructFunct_tmp
EndFor



is_skip = 0
If is_skip eq 0 Then Begin
;;;---
period_max  = Max(period_vect)
If (period_max ge 4.e3 and num_scales gt 32L) Then Begin
  Print, 'period_max, num_scales: ', period_max, num_scales
  Goto, End_Program
EndIf
EndIf


Step3:
;===========================
;Step3:

;;--
num_times = N_Elements(time_vect_StructFunct)
num_periods = N_Elements(period_vect_StructFunct)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


Step4:
;===========================
;Step4:

;;--define 'theta_bin_min/max_vect'
num_theta_bins  = 90L
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin
num_theta_halfbins = num_theta_bins/2

;;--get 'StructFunct_Bpara_theta_scale_arr'
StructFunct_Bpara_theta_scale_arr = Fltarr(num_theta_halfbins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)) ;or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = Bpara_StructFunct_arr(*,i_period)
    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_Bpara_theta_scale_arr(i_theta,i_period) = StructFunct_tmp
  EndIf
EndFor
EndFor

;;--get 'StructFunct_Bperp_theta_scale_arr'
StructFunct_Bperp_theta_scale_arr = Fltarr(num_theta_halfbins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)); or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
         ; theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = Bperp_StructFunct_arr(*,i_period)
;a    PSD_tmp = 10.^Mean(Alog10(PSD_vect_tmp(sub_tmp)),/NaN)
    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_Bperp_theta_scale_arr(i_theta,i_period) = StructFunct_tmp
  EndIf
EndFor
EndFor

;;--get 'StructFunct_Bt_theta_scale_arr'
StructFunct_Bt_theta_scale_arr  = Fltarr(num_theta_halfbins, num_periods)
num_DataNum_theta_scale_arr = Lonarr(num_theta_halfbins, num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)); or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
        ;  theta_arr(*,i_period) lt (180-theta_min_bin)))
  If sub_tmp(0) ne -1 Then Begin
    StructFunct_vect_tmp  = Btot_StructFunct_arr(*,i_period)
;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
    StructFunct_tmp = Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
    StructFunct_Bt_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
    num_DataNum_tmp = N_Elements(sub_tmp_v2)
    num_DataNum_theta_scale_arr(i_theta,i_period) = num_DataNum_tmp
  EndIf
EndFor
EndFor






Step5:
;===========================
;Step5:

;;--
ntim=N_elements(time_vect_StructFunct)
time_min_TV = time_vect_StructFunct(0)
time_max_TV = time_vect_StructFunct(ntim-1)
sub_time_min_TV = Where(time_vect_StructFunct ge time_min_TV)
sub_time_min_TV = sub_time_min_TV(0)
sub_time_max_TV = Where(time_vect_StructFunct le time_max_TV)
sub_time_max_TV = sub_time_max_TV(N_Elements(sub_time_max_TV)-1)
JulDay_vect_TV  = time_vect_StructFunct(sub_time_min_TV:sub_time_max_TV)/(24.*60.*60)+$
          (time_vect_StructFunct(sub_time_min_TV)-time_vect_StructFunct(0))/(24.*60.*60)+$
          JulDay_min
;;;---
period_vect_TV  = period_vect_StructFunct
theta_arr_TV  = theta_arr(sub_time_min_TV:sub_time_max_TV,*)
StructFunct_Bt_time_scale_arr_TV  = Btot_StructFunct_arr(sub_time_min_TV:sub_time_max_TV,*)

;;--
theta_vect_TV = theta_bin_min_vect
StructFunct_Bt_theta_scale_arr_TV= StructFunct_Bt_theta_scale_arr(*,*)





Step5_1:
;;--

theta_vect_TV = theta_vect_TV(0:44)

i_x_SubImg  = i_recon
i_y_SubImg  = 3-i_c

if i_recon eq 0 then begin
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.17),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.83)]       
endif
if i_recon eq 1 then begin
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.25),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.17),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.83)]
           
endif

;;;---
image_TV  = ALog10(Abs(StructFunct_Bt_theta_scale_arr_TV))
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)

max_a = float(round(10.0*max_image))
min_a = float(round(10.0*min_image))
max_a = max_a/10.0
min_a = min_a/10.0

if i_recon eq 0 then begin
  max_re(0) = max_a
  min_re(0) = min_a
endif
if i_recon eq 1 then begin
  max_a = max_re(0)
  min_a = min_re(0)
endif
;max_a = 1.6    ;
;min_a = -6.3   ;

byt_image_TV= BytSCL(image_TV,min=min_a,max=max_a, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
title = TexToIDL(' ')
;;;---TV image
size_image = size(byt_image_TV)
byt_image_TV = rebin(byt_image_TV,5*size_image(1),5*size_image(2),/sample)

TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]

;if i_jie eq 0 then begin
;  titleCB     = string(i_jie+1)+'st '+'order '+'SF of '+strre+' '+'Btotal' 
;endif
;if i_jie eq 1 then begin
;  titleCB     = string(i_jie+1)+'nd '+'order '+'SF of '+strre+' '+'Btotal' 
;endif
;if i_jie eq 2 then begin
;  titleCB     = string(i_jie+1)+'rd '+'order '+'SF of '+strre+' '+'Btotal'
;endif 
;if i_jie gt 3 then begin   ;
;titleCB     = string(i_jie+1)+'th '+'order '+'SF of '+strre+' '+'Btotal'   ;
;endif
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,xticklen=-0.04,yticklen=-0.04,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle, charsize = 0.9, $
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=4,xThick=4,ythick=4,/YLog
if i_c eq 0 and i_recon eq 0 then begin
xyouts,5,3000,'(a1)2nd order SF(original)',charsize = 0.9,charthick = 4,color = color_black
endif
 if i_c eq 0 and i_recon eq 1 then begin
 xyouts,5,3000,'(a2)2nd order SF(LIM)',charsize = 0.9,charthick = 4,color = color_black
 endif
  if i_c eq 1 and i_recon eq 0 then begin
 xyouts,5,3000,'(b1)3rd order SF(original)',charsize = 0.9,charthick = 4,color = color_black
 endif
  if i_c eq 1 and i_recon eq 1 then begin
 xyouts,5,3000,'(b2)3rd order SF(LIM)',charsize = 0.9,charthick = 4,color = color_black
 endif
  if i_c eq 2 and i_recon eq 0 then begin
 xyouts,5,3000,'(c1)5th order SF(original)',charsize = 0.9,charthick = 4,color = color_black
 endif
  if i_c eq 2 and i_recon eq 1 then begin
 xyouts,5,3000,'(c2)5th order SF(LIM)',charsize = 0.9,charthick = 4,color = color_black
 endif
  if i_c eq 3 and i_recon eq 0 then begin
 xyouts,5,3000,'(d1)7th order SF(original)',charsize = 0.9,charthick = 4,color = color_black
 endif
  if i_c eq 3 and i_recon eq 1 then begin
 xyouts,5,3000,'(d2)7th order SF(LIM)',charsize = 0.9,charthick = 4,color = color_black
 endif

  





position_CB   = [position_SubImg(2)+0.058,position_SubImg(1),$  ;co
          position_SubImg(2)+0.066,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1

max_tickn   = max_a
min_tickn   = min_a
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15

bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar

Plot,[1,2],[min_a,max_a],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=0.8, Font=-1,$
  /NoData,/NoErase,Color=color_black, $
  TickLen=0.02,Title=' ', Thick=1.5, XThick=1.5, YThick=1.5,CharThick=4
;
for  i_period=0,num_periods-1 Do Begin
sub_data_bad = where(EffDataNum_scale_theta_arr(*,i_period) lt 0)
EffDataNum_scale_theta_arr(sub_data_bad,i_period) = 0
endfor
 
CI_BComp_theta_scale_arr  = Fltarr(num_theta_halfbins, num_periods)+!values.f_nan
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
num_Numerator_tmp   = EffDataNum_scale_theta_arr(i_theta,i_period)+EffDataNum_scale_theta_arr(89-i_theta,i_period)
if num_Numerator_tmp LT 10000.0 then begin
CI_BComp_theta_scale_arr(i_theta,i_period) = 1
endif else begin
CI_BComp_theta_scale_arr(i_theta,i_period) = 0
endelse
endfor
endfor
;;;;---
;color_white = 252L
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]

CI_BComp_theta_scale_arr_TV= CI_BComp_theta_scale_arr(*,*)
num_xpixels_cont= (Size(CI_BComp_theta_scale_arr_TV))[1]*1
num_ypixels_cont= (Size(CI_BComp_theta_scale_arr_TV))[2]*5
image_cont    = Congrid(CI_BComp_theta_scale_arr_TV, num_xpixels_cont, num_ypixels_cont, Interp=0, /Minus_One)
sub_BadVal    = Where(Finite(image_cont) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  image_cont(sub_BadVal)  = -9999.0
EndIf
xaxis_vect_cont = xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
yaxis_vect_cont = yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
levels  = [1.0]
C_colors= [color_white]
C_LineStyle = [0]
C_Thick   = [3.5]
C_Orientation = [45.0]
Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
    /NoErase, /Fill, /Closed
Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,$
    /NoErase  
;  if i_jie eq 6 then begin
;    XYouts,-40.0,0.35+0.07*27.0,titleCB,=0.85
;    endif else begin
;XYouts,-40.0,0.35+0.07*i_jie^2,titleCB,charsize=0.85
;endelse
;
;;--
AnnotStr_tmp  = 'got from "get_StructFunct_of_Bpara_Bperp_theta_scale_arr_19760307.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
 ; XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
 ;     CharSize=charsize,color=color_black,Font=-1
EndFor

;;;--
;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
;file_fig  = 'StructFunct'+string(jieshu)+'_of_Btot_theta_scale_arr'+$
;;        TimeRange_str+$
;;        PeriodRange_str+$
;        file_version+$
;        '_temp.png'
;Write_PNG, dir_fig+file_fig, image_tvrd
endfor
endfor

if is_eps_png eq 1 then begin
Device,/close
endif
if is_eps_png eq 2 then begin
file_fig= 'Figure2'+$
        '_v2'+$
;        file_version+$
        '.png'
FileName=dir_fig+file_fig
image_tvrd  = TVRD(true=1)
Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
endif
;;--
!p.background = color_bg


End_Program:
End