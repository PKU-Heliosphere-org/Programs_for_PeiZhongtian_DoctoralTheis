;Pro plot_Figure4567_for_paper_200206
;pro get_Spectra_of_ZpZm_SigmaC_SigmaA_SVD_MVA

;wk_dir  = '/Work/Data Analysis/Helios data process/Program/VDF_interpolate/VDF_interpolate/'
;wk_dir  = '/Work/Data Analysis/WIND data process/Programs/2000-06/VDF_interpolate/';/VDF_interpolate/'
;CD, wk_dir

year_str= '2002'
mon_str = '05'
day_str = '24'
sub_dir_date= 'wind\Alfven\';'1995-01--1995-02/';'1995-'+mon_str+'-'+day_str+'/'
;sub_dir_date= year_str+'/'+year_str+'-'+mon_str+'/'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''
dir_data = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''


Step1:
;=====================
;Step1

;;--
file_restore  = 'wi_pm_3dp_'+year_str+mon_str+day_str+'_v03.sav'
;data_descrip= 'got from "Read_pm_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: velocity [km/s in SC coordinate similar to GSE coordinate]; number density [cm^-3]; '+$
;                  'temperature [10^4 K]; tensor [(km/s)^2, in SC coordinate]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr
;Note: sequence order stored in the tensor 
; vv_uniq  = [0,4,8,1,2,5]           ; => Uniq elements of a symmetric 3x3 matrix
; vv_trace = [0,4,8]                 ; => diagonal elements of a 3x3 matrix 
Restore, dir_data + file_restore, /Verbose
;;;---
JulDay_3DP_vect = JulDay_vect

sub_tmp = Where(Vxyz_GSE_p_arr eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  Vxyz_GSE_p_arr(sub_tmp) = !values.f_nan
EndIf
sub_tmp = Where(NumDens_p_vect eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  NumDens_p_vect(sub_tmp) = !values.f_nan
EndIf
sub_tmp = Where(Temper_p_vect eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  Temper_p_vect(sub_tmp) = !values.f_nan
EndIf
;;密度滑动平均密度
n_win = 200.0;多少个点做平滑
n_p = n_elements(numdens_p_vect)
Np_10min_sm = fltarr(n_p-n_win+1)
JulDay_sm_vect = JulDay_3DP_vect((round(n_win/2.0)-1):(round(n_p-n_win/2.0)-1))


for i_s = 0,n_p-n_win do begin
  Np_10min_sm(i_s) = mean(numdens_p_vect(i_s:(i_s+n_win-1)),/nan)
endfor

;;;


;;--
file_restore = 'wi_h0_mfi_'+year_str+mon_str+day_str+'_v05.sav'
;data_descrip  = 'got from "Read_WIND_MFI_H0_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr
Restore, dir_data + file_restore, /Verbose
;;;---
JulDay_MFI_vect = JulDay_vect



Step2:
;=====================
;Step2

;;--
year_plot = Float(year_str)
mon_plot  = Float(mon_str)
day_plot  = Float(day_str)
hour_beg=6.0 & min_beg=0.0 & sec_beg=0.0 ;From 'TimeStr_beg_seg_SWP_A/SWMS_vect' & 'TimeStr_end_seg_SWP_A/SWMS_vect' as resulted from 'get_CorrCoeffs_B_V_Components_EveryTimeInterval.pro'
hour_end=16.0 & min_end=0.0 & sec_end=0.0 ;time interval usually =5 or 10 min (<30min)
JulDay_beg_plot = JulDay(mon_plot, day_plot, year_plot, hour_beg, min_beg, sec_beg)
JulDay_end_plot = JulDay(mon_plot, day_plot, year_plot, hour_end, min_end, sec_end)
;JulDay_beg_plot_v2 = 0.5*(JulDay_beg_plot + JulDay_end_plot) - 15./(24.*60)
;JulDay_end_plot_v2 = 0.5*(JulDay_beg_plot + JulDay_end_plot) + 15./(24.*60)
;JulDay_beg_plot = JulDay_beg_plot_v2
;JulDay_end_plot = JulDay_end_plot_v2
CalDat, JulDay_beg_plot, mon_tmp,day_tmp,year_tmp,hour_beg_plot,min_beg_plot,sec_beg_plot
CalDat, JulDay_end_plot, mon_tmp,day_tmp,year_tmp,hour_end_plot,min_end_plot,sec_end_plot
timestr_beg_plot  = String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')
timestr_end_plot  = String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')
timerange_str_plot= '(time='+timestr_beg_plot+'-'+timestr_end_plot+')'


;;--
dJulDay_plot      = 3.0/(24.*60*60)
num_times_plot    = Floor((JulDay_end_plot-JulDay_beg_plot)/dJulDay_plot)+1L
JulDay_vect_plot  = JulDay_beg_plot + Dindgen(num_times_plot) * dJulDay_plot 

read,'smooth(1) or not(2)',is_smooth
if is_smooth eq 1 then begin
  Np_vect_plot = Interpol(Np_10min_sm, JulDay_sm_vect, JulDay_vect_plot)
  sm = 'sm'
endif
if is_smooth eq 2 then begin
  Np_vect_plot  = Interpol(numdens_p_vect, JulDay_3DP_vect, JulDay_vect_plot)
  sm = ''
endif
Tp_vect_plot  = Interpol(temper_p_vect, JulDay_3DP_vect, JulDay_vect_plot)
Vx_GSE_vect   = Reform(Vxyz_GSE_p_arr(0,*))
Vy_GSE_vect   = Reform(Vxyz_GSE_p_arr(1,*))
Vz_GSE_vect   = Reform(Vxyz_GSE_p_arr(2,*))
Vx_GSE_vect_plot  = Interpol(Vx_GSE_vect, JulDay_3DP_vect, JulDay_vect_plot)
Vy_GSE_vect_plot  = Interpol(Vy_GSE_vect, JulDay_3DP_vect, JulDay_vect_plot)
Vz_GSE_vect_plot  = Interpol(Vz_GSE_vect, JulDay_3DP_vect, JulDay_vect_plot)

Bx_GSE_vect = Reform(Bxyz_GSE_arr(0,*))
By_GSE_vect = Reform(Bxyz_GSE_arr(1,*))
Bz_GSE_vect = Reform(Bxyz_GSE_arr(2,*))
Bx_GSE_vect_plot  = Interpol(Bx_GSE_vect, JulDay_MFI_vect, JulDay_vect_plot)
By_GSE_vect_plot  = Interpol(By_GSE_vect, JulDay_MFI_vect, JulDay_vect_plot)
Bz_GSE_vect_plot  = Interpol(Bz_GSE_Vect, JulDay_MFI_vect, JulDay_vect_plot)







;;--
n_cm3 = Np_vect_plot
B_G   = Bx_GSE_vect_plot * 1.e-9 * 1.e4
get_Alfven_velocity_v2, Np_vect_plot, B_G, VA_kmps
Va_x_GSE_vect_plot  = VA_kmps
B_G   = By_GSE_vect_plot * 1.e-9 * 1.e4
get_Alfven_velocity_v2, Np_vect_plot, B_G, VA_kmps
Va_y_GSE_vect_plot  = VA_kmps
B_G   = Bz_GSE_vect_plot * 1.e-9 * 1.e4
get_Alfven_velocity_v2, Np_vect_plot, B_G, VA_kmps
Va_z_GSE_vect_plot  = VA_kmps

;;--
Zp_x_GSE_vect_plot  = Vx_GSE_vect_plot + Va_x_GSE_vect_plot
Zp_y_GSE_vect_plot  = Vy_GSE_vect_plot + Va_y_GSE_vect_plot
Zp_z_GSE_vect_plot  = Vz_GSE_vect_plot + Va_z_GSE_vect_plot
Zm_x_GSE_vect_plot  = Vx_GSE_vect_plot - Va_x_GSE_vect_plot
Zm_y_GSE_vect_plot  = Vy_GSE_vect_plot - Va_y_GSE_vect_plot
Zm_z_GSE_vect_plot  = Vz_GSE_vect_plot - Va_z_GSE_vect_plot


Step3:
;=====================
;Step3

;;--
time_vect = (JulDay_vect_plot - JulDay_vect_plot(0))*(24.*60*60)
dtime     = time_vect(1) - time_vect(0)
time_interval = Max(time_vect) - Min(time_vect)
period_min= dtime*3
period_max= time_interval/7
period_range  = [period_min, period_max]
num_periods = 16L
num_times   = N_Elements(time_vect)

;;--
For i=0,11 Do Begin
  If i eq 0 Then wave_vect=Vx_GSE_vect_plot
  If i eq 1 Then wave_vect=Vy_GSE_vect_plot
  If i eq 2 Then wave_vect=Vz_GSE_vect_plot
  If i eq 3 Then wave_vect=Va_x_GSE_vect_plot
  If i eq 4 Then wave_vect=Va_y_GSE_vect_plot
  If i eq 5 Then wave_vect=Va_z_GSE_vect_plot
  If i eq 6 Then wave_vect  = Zp_x_GSE_vect_plot
  If i eq 7 Then wave_vect  = Zp_y_GSE_vect_plot
  If i eq 8 Then wave_vect  = Zp_z_GSE_vect_plot
  If i eq 9 Then wave_vect  = Zm_x_GSE_vect_plot
  If i eq 10 Then wave_vect = Zm_y_GSE_vect_plot
  If i eq 11 Then wave_vect = Zm_z_GSE_vect_plot
get_Wavelet_Transform_of_BComp_vect_STEREO_v3, $
    time_vect, wave_vect, $    ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $
    Wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $
    period_vect=period_vect
PSD_arr  = Abs(wavlet_arr)^2 * dtime    
If i eq 0 Then Begin
  wavlet_Vx_arr=wavlet_arr & PSD_Vx_arr=PSD_arr
EndIf   
If i eq 1 Then Begin
  wavlet_Vy_arr=wavlet_arr & PSD_Vy_arr=PSD_arr
EndIf  
If i eq 2 Then Begin
  wavlet_Vz_arr=wavlet_arr & PSD_Vz_arr=PSD_arr
EndIf  
If i eq 3 Then Begin
  wavlet_Va_x_arr=wavlet_arr & PSD_Va_x_arr=PSD_arr
EndIf  
If i eq 4 Then Begin
  wavlet_Va_y_arr=wavlet_arr & PSD_Va_y_arr=PSD_arr
EndIf  
If i eq 5 Then Begin
  wavlet_Va_z_arr=wavlet_arr & PSD_Va_z_arr=PSD_arr
EndIf  
If i eq 6 Then Begin
  wavlet_Zp_x_arr=wavlet_arr & PSD_Zp_x_arr=PSD_arr
EndIf  
If i eq 7 Then Begin
  wavlet_Zp_y_arr=wavlet_arr & PSD_Zp_y_arr=PSD_arr
EndIf
If i eq 8 Then Begin
  wavlet_Zp_z_arr=wavlet_arr & PSD_Zp_z_arr=PSD_arr
EndIf
If i eq 9 Then Begin
  wavlet_Zm_x_arr=wavlet_arr & PSD_Zm_x_arr=PSD_arr
EndIf
If i eq 10 Then Begin
  wavlet_Zm_y_arr=wavlet_arr & PSD_Zm_y_arr=PSD_arr
EndIf
If i eq 11 Then Begin
  wavlet_Zm_z_arr=wavlet_arr & PSD_Zm_z_arr=PSD_arr
EndIf  

EndFor  


;;--
SigmaC_x_arr  = (PSD_Zp_x_arr - PSD_Zm_x_arr) / (PSD_Zp_x_arr + PSD_Zm_x_arr)
SigmaC_y_arr  = (PSD_Zp_y_arr - PSD_Zm_y_arr) / (PSD_Zp_y_arr + PSD_Zm_y_arr)
SigmaC_z_arr  = (PSD_Zp_z_arr - PSD_Zm_z_arr) / (PSD_Zp_z_arr + PSD_Zm_z_arr)
SigmaC_t_arr  = (PSD_Zp_x_arr+PSD_Zp_y_arr+PSD_Zp_z_arr - PSD_Zm_x_arr-PSD_Zm_y_arr-PSD_Zm_z_arr) / $
                (PSD_Zp_x_arr+PSD_Zp_y_arr+PSD_Zp_z_arr + PSD_Zm_x_arr+PSD_Zm_y_arr+PSD_Zm_z_arr)
SigmaA_x_arr  = (PSD_Vx_arr - PSD_Va_x_arr) / (PSD_Vx_arr + PSD_Va_x_arr)
SigmaA_y_arr  = (PSD_Vy_arr - PSD_Va_y_arr) / (PSD_Vy_arr + PSD_Va_y_arr)
SigmaA_z_arr  = (PSD_Vz_arr - PSD_Va_z_arr) / (PSD_Vz_arr + PSD_Va_z_arr)
SigmaA_t_arr  = (PSD_Vx_arr+PSD_Vy_arr+PSD_Vz_arr - PSD_Va_x_arr-PSD_Va_y_arr-PSD_Va_z_arr) / $
                (PSD_Vx_arr+PSD_Vy_arr+PSD_Vz_arr + PSD_Va_x_arr+PSD_Va_y_arr+PSD_Va_z_arr)
RA_x_arr  = PSD_Vx_arr / PSD_Va_x_arr
RA_y_arr  = PSD_Vy_arr / PSD_Va_y_arr
RA_z_arr  = PSD_Vz_arr / PSD_Va_z_arr
RA_t_arr  = (PSD_Vx_arr+PSD_Vy_arr+PSD_Vz_arr) / (PSD_Va_x_arr+PSD_Va_y_arr+PSD_Va_z_arr)
;SigmaA_x_arr  = RA_x_arr
;SigmaA_y_arr  = RA_y_arr
;SigmaA_z_arr  = RA_z_arr
;SigmaA_t_arr  = RA_t_arr

;;;---
CC_x_arr  = Sqrt(Abs(SigmaC_x_arr/(1-SigmaA_x_arr))) * (SigmaC_x_arr/Abs(SigmaC_x_arr)) ;this is wrong
CC_y_arr  = Sqrt(Abs(SigmaC_y_arr/(1-SigmaA_y_arr))) * (SigmaC_y_arr/Abs(SigmaC_y_arr)) 
CC_z_arr  = Sqrt(Abs(SigmaC_z_arr/(1-SigmaA_z_arr))) * (SigmaC_z_arr/Abs(SigmaC_z_arr)) 
CC_t_arr  = Sqrt(Abs(SigmaC_t_arr/(1-SigmaA_t_arr))) * (SigmaC_t_arr/Abs(SigmaC_t_arr))

CC_x_arr  = Sqrt(SigmaC_x_arr^2/(1-SigmaA_x_arr^2)) * (SigmaC_x_arr/Abs(SigmaC_x_arr)) ;this is right
CC_y_arr  = Sqrt(SigmaC_y_arr^2/(1-SigmaA_y_arr^2)) * (SigmaC_y_arr/Abs(SigmaC_y_arr)) 
CC_z_arr  = Sqrt(SigmaC_z_arr^2/(1-SigmaA_z_arr^2)) * (SigmaC_z_arr/Abs(SigmaC_z_arr)) 
CC_t_arr  = Sqrt(SigmaC_t_arr^2/(1-SigmaA_t_arr^2)) * (SigmaC_t_arr/Abs(SigmaC_t_arr))


;;--
signal_a_vect = Np_vect_plot
signal_b_vect = Sqrt(Bx_GSE_vect_plot^2+By_GSE_vect_plot^2+Bz_GSE_vect_plot^2)
get_CorrCoeff_time_period_arr, $
        time_vect, signal_a_vect, signal_b_vect, $  ;input
        period_range=period_range, $  ;input
        num_periods=num_periods, $  ;input
        CorrCoeff_arr, $  ;output
        time_vect_v2=time_vect_v2, $  ;output
        period_vect=period_vect
CC_Np_AbsB_arr  = CorrCoeff_arr        


;;--
Bxyz_GSE_arr_plot = [[Bx_GSE_vect_plot],[By_GSE_vect_plot],[Bz_GSE_vect_plot]]
Bxyz_GSE_arr_plot = Transpose(Bxyz_GSE_arr_plot)
get_LocalBG_of_MagField_at_Scales_WIND_MFI, $
    time_vect, Bxyz_GSE_arr_plot, $  ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $ ;input
    Bxyz_LBG_GSE_arr_plot, $   ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect     ;output



Step4:
;=====================
;Step4

;;--
EigVect_Zp_time_scale_arr  = Fltarr(3, 3, num_times, num_periods)  ;eigvect_time_scale_arr(*,i_eigen,i_time,i_scale)=Reform(V_v2)
EigVal_Zp_time_scale_arr   = Fltarr(3, num_times, num_periods) ;ascending order
EigVect_Zm_time_scale_arr  = Fltarr(3, 3, num_times, num_periods)  ;eigvect_time_scale_arr(*,i_eigen,i_time,i_scale)=Reform(V_v2)
EigVal_Zm_time_scale_arr   = Fltarr(3, num_times, num_periods) ;ascending order

;;--
For i_Z=0,1 Do Begin
  If (i_Z eq 0) Then Begin
    wavlet_x_arr  = wavlet_Zp_x_arr
    wavlet_y_arr  = wavlet_Zp_y_arr
    wavlet_z_arr  = wavlet_Zp_z_arr
  EndIf Else Begin
  If (i_Z eq 1) Then Begin
    wavlet_x_arr  = wavlet_Zm_x_arr
    wavlet_y_arr  = wavlet_Zm_y_arr
    wavlet_z_arr  = wavlet_Zm_z_arr
  EndIf
  EndElse
For i_time=0,num_times-1 Do Begin
For i_scale=0,num_periods-1 Do Begin
  A_arr = Fltarr(3,6)
  A_arr(0,0)  = Real_Part(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_x_arr(i_time,i_scale)))  ;R_S11   A_ij=A(j,i)=Real(Bi*ConJ(Bj))
  A_arr(1,0)  = Real_Part(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_y_arr(i_time,i_scale)))  ;R_S12
  A_arr(2,0)  = Real_Part(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale)))  ;R_S13
  A_arr(0,1)  = Real_Part(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_y_arr(i_time,i_scale)))  ;R_S12
  A_arr(1,1)  = Real_Part(wavlet_y_arr(i_time,i_scale)*ConJ(wavlet_y_arr(i_time,i_scale)))  ;R_S22
  A_arr(2,1)  = Real_Part(wavlet_y_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale)))  ;R_S23
  A_arr(0,2)  = Real_Part(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale)))  ;R_S13
  A_arr(1,2)  = Real_Part(wavlet_y_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale)))  ;R_S23
  A_arr(2,2)  = Real_Part(wavlet_z_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale)))  ;R_S33
  A_arr(0,3)  = 0.0
  A_arr(1,3)  = -Imaginary(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_y_arr(i_time,i_scale))) ;-I_S12   A_ij=A(j,i)=-Imag(Bi*ConJ(Bj))
  A_arr(2,3)  = -Imaginary(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale))) ;-I_S13
  A_arr(0,4)  = +Imaginary(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_y_arr(i_time,i_scale))) ;+I_S12
  A_arr(1,4)  = 0.0
  A_arr(2,4)  = -Imaginary(wavlet_y_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale))) ;-I_S23
  A_arr(0,5)  = +Imaginary(wavlet_x_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale))) ;+I_S13
  A_arr(1,5)  = +Imaginary(wavlet_y_arr(i_time,i_scale)*ConJ(wavlet_z_arr(i_time,i_scale))) ;+I_S23
  A_arr(2,5)  = 0.0
  ;;;---
  SVDC, A_arr, W, U, V
  ascend_order  = Sort(W)
  W_v2  = W(ascend_order)
  V_v2  = Fltarr((Size(V))[1],(Size(V))[2]) ;3x3
  For i=0,2 Do Begin
    V_v2(i,*) = V(ascend_order(i),*)
  EndFor  
  ;;;---
  If i_Z eq 0 Then Begin
    For i=0,2 Do Begin
      EigVal_Zp_time_scale_arr(i,i_time,i_scale)     = W_v2(i)
      EigVect_Zp_time_scale_arr(*,i,i_time,i_scale)  = Reform(V_v2(i,*)) 
    EndFor
  EndIf Else Begin
  If i_Z eq 1 Then Begin
    For i=0,2 Do Begin
      EigVal_Zm_time_scale_arr(i,i_time,i_scale)     = W_v2(i)
      EigVect_Zm_time_scale_arr(*,i,i_time,i_scale)  = Reform(V_v2(i,*)) 
    EndFor  
  EndIf
  EndElse  
  ;;;---
EndFor
EndFor

  
EndFor

;;--
i_eigenval_min  = 0
i_eigenval_mid  = 1
i_eigenval_max  = 2


;;--
theta_kp_zm_arr = Fltarr(num_times,num_periods)
theta_km_zp_arr = Fltarr(num_times,num_periods)
theta_kp_b0_arr = Fltarr(num_times,num_periods)
theta_km_b0_arr = Fltarr(num_times,num_periods)
theta_kp_km_arr = Fltarr(num_times,num_periods)
theta_zp_zm_arr = Fltarr(num_times,num_periods)
theta_zp_b0_arr = Fltarr(num_times,num_periods)
theta_zm_b0_arr = Fltarr(num_times,num_periods)

;is_theta_kperp_z  = 0
;Print, 'is_theta_kperp_z (0/1, 1 for angle between kperp_Zp/Zm and e_Zm/Zp, 0 for angle between k_Zp/Zm and e_Zm/Zp)'
;Print, is_theta_kperp_z
;is_continue = ' '
;Read, 'is_continue: ', is_continue

;For i_theta=0,4-1 Do Begin
For i_time=0,num_times-1 Do Begin
For i_scale=0,num_periods-1 Do Begin
  k_Zp_vect = Reform(EigVect_Zp_time_scale_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zp
  k_Zm_vect = Reform(EigVect_Zm_time_scale_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zm
  e_Zp_vect = Reform(EigVect_Zp_time_scale_arr(*,i_eigenval_max,i_time,i_scale))  ;e_Zp
  e_Zm_vect = Reform(EigVect_Zm_time_scale_arr(*,i_eigenval_max,i_time,i_scale))  ;e_Zm
  b0_vect   = Reform(Bxyz_LBG_GSE_arr_plot(*,i_time,i_scale))
  k_Zp_vect = k_Zp_vect/Norm(k_Zp_vect)
  k_Zm_vect = k_Zm_vect/Norm(k_Zm_vect)
  e_Zp_vect = e_Zp_vect/Norm(e_Zp_vect)
  e_Zm_vect = e_Zm_vect/Norm(e_Zm_vect)
  b0_vect   = b0_vect/Norm(b0_vect)
  kperp_Zp_vect = k_Zp_vect - (k_Zp_vect ## Transpose(b0_vect))[0]*b0_vect
  kperp_Zp_vect = kperp_Zp_vect/Norm(kperp_Zp_vect)
  kperp_Zm_vect = k_Zm_vect - (k_Zm_vect ## Transpose(b0_vect))[0]*b0_vect
  kperp_Zm_vect = kperp_Zm_vect/Norm(kperp_Zm_vect)

  theta_kp_zm_arr(i_time,i_scale) = ACos(Abs(k_Zp_vect ## Transpose(e_Zm_vect))) * 180/!pi  ;angle between k_Zp with e_Zm
  theta_km_zp_arr(i_time,i_scale) = ACos(Abs(k_Zm_vect ## Transpose(e_Zp_vect))) * 180/!pi  ;angle between k_Zm with e_Zp
  theta_kp_b0_arr(i_time,i_scale) = ACos(Abs(k_Zp_vect ## Transpose(b0_vect))) * 180/!pi
  theta_km_b0_arr(i_time,i_scale) = ACos(Abs(k_Zm_vect ## Transpose(b0_vect))) * 180/!pi
  theta_kp_km_arr(i_time,i_scale) = ACos(Abs(k_Zp_vect ## Transpose(k_Zm_vect))) * 180/!pi
  theta_zp_zm_arr(i_time,i_scale) = ACos(Abs(e_Zp_vect ## Transpose(e_Zm_vect))) * 180/!pi
  theta_zp_b0_arr(i_time,i_scale) = ACos(Abs(e_Zp_vect ## Transpose(b0_vect))) * 180/!pi
  theta_zm_b0_arr(i_time,i_scale) = ACos(Abs(e_Zm_vect ## Transpose(b0_vect))) * 180/!pi
;a  theta_zm_b0_arr(i_time,i_scale) = ACos(Abs(e_Zm_vect ## Transpose([1,0,0.]))) * 180/!pi

;  If i_theta eq 0 Then Begin  
;    a_vect  = Reform(EigVect_Zp_time_scale_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zp
;    b_vect  = Reform(EigVect_Zm_time_scale_arr(*,i_eigenval_max,i_time,i_scale))  ;e_Zm
;    If is_theta_kperp_z eq 0 Then Begin
;    theta_kp_zm_arr(i_time,i_scale) = ACos(Abs((a_vect/Norm(a_vect)) ## Transpose(b_vect/Norm(b_vect)))) * 180/!pi  ;angle between k_Zp with e_Zm
;    EndIf Else Begin
;    c_vect  = Reform(Bxyz_LBG_GSE_arr_plot(*,i_time,i_scale))
;    norm_a_vect=a_vect/Norm(a_vect) & norm_b_vect=b_vect/Norm(b_vect) & norm_c_vect=c_vect/Norm(c_vect)
;    kperp_Zp_vect = norm_a_vect - (norm_a_vect ## Transpose(norm_c_vect))[0]*norm_c_vect
;    norm_kperp_Zp_vect  = kperp_Zp_vect/Norm(kperp_Zp_vect)
;    theta_kp_zm_arr(i_time,i_scale) = ACos(Abs(norm_kperp_Zp_vect ## Transpose(norm_b_vect))) * 180/!pi ;angle between kperp_for_Zp with e_Zm
;;d    theta_kp_zm_arr(i_time,i_scale) = ACos(Abs(norm_c_vect ## Transpose(norm_b_vect))) * 180/!pi
;    EndElse
;  EndIf
;  If i_theta eq 1 Then Begin
;    a_vect  = Reform(EigVect_Zm_time_scale_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zm
;    b_vect  = Reform(EigVect_Zp_time_scale_arr(*,i_eigenval_max,i_time,i_scale))  ;e_Zp
;    If is_theta_kperp_z eq 0 Then Begin
;    theta_km_zp_arr(i_time,i_scale) = ACos(Abs((a_vect/Norm(a_vect)) ## Transpose(b_vect/Norm(b_vect)))) * 180/!pi
;    EndIf Else Begin  
;    c_vect  = Reform(Bxyz_LBG_GSE_arr_plot(*,i_time,i_scale))
;    norm_a_vect=a_vect/Norm(a_vect) & norm_b_vect=b_vect/Norm(b_vect) & norm_c_vect=c_vect/Norm(c_vect)
;    kperp_Zm_vect = norm_a_vect - (norm_a_vect ## Transpose(norm_c_vect))[0]*norm_c_vect
;    norm_kperp_Zm_vect  = kperp_Zm_vect/Norm(kperp_Zm_vect)
;    theta_km_zp_arr(i_time,i_scale) = ACos(Abs(norm_kperp_Zm_vect ## Transpose(norm_b_vect))) * 180/!pi ;angle between kperp_for_Zm with e_Zp
;;d    theta_km_zp_arr(i_time,i_scale) = ACos(Abs(norm_c_vect ## Transpose(norm_b_vect))) * 180/!pi
;    EndElse
;  EndIf
;  If i_theta eq 2 Then Begin
;    a_vect  = Reform(EigVect_Zp_time_scale_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zp
;    b_vect  = Reform(Bxyz_LBG_GSE_arr_plot(*,i_time,i_scale)) ;b0
;    theta_kp_b0_arr(i_time,i_scale) = ACos(Abs((a_vect/Norm(a_vect)) ## Transpose(b_vect/Norm(b_vect)))) * 180/!pi
;  EndIf
;  If i_theta eq 3 Then Begin
;    a_vect  = Reform(EigVect_Zm_time_scale_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zm
;    b_vect  = Reform(Bxyz_LBG_GSE_arr_plot(*,i_time,i_scale)) ;b0
;    theta_km_b0_arr(i_time,i_scale) = ACos(Abs((a_vect/Norm(a_vect)) ## Transpose(b_vect/Norm(b_vect)))) * 180/!pi   
;  EndIf
EndFor
EndFor
;EndFor  


Step5:
;=====================
;Step5

;;--
mark_OutAW_arr  = Intarr(num_times, num_periods)
mark_OutQPSW_arr= Intarr(num_times, num_periods)
mark_InAW_arr   = Intarr(num_times, num_periods)
mark_InQPSW_arr = Intarr(num_times, num_periods)
mark_OutAW2_arr = Intarr(num_times, num_periods)

is_B0_AntiSunward = 1
Print, 'is_B0_AntiSunward (0 or 1, 0 for sunward, 1 for anti-sunward): '
Print, is_B0_AntiSunward
Read, 'is_B0_AntiSunward: ', is_B0_AntiSunward
is_continue = ' '
Read, 'is_continue: ', is_continue

val_nan = 9999.0
AbsSigmaC_level = 0.7
AbsSigmaA_level = Sqrt(1-AbsSigmaC_level^2) ; |CorrCoeff_min|=sqrt(|sigma_C_level|^2) = 0.60
dtheta_range  = 30.0 
CC_Np_AbsB_level  = 0.7

;;--identify the locations of Out/In AW/SWs in the [time, period] space
;set_mark_OutIn_waves_time_scale_arr, $
;    theta_zp_zm_arr, theta_zp_b0_arr, theta_zm_b0_arr, theta_kp_zm_arr, theta_km_zp_arr, theta_kp_b0_arr, theta_km_b0_arr, $
;    SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
;    SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
;    mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, mark_OutAW2_arr, $
;    is_B0_AntiSunward=is_B0_AntiSunward, $
;    val_nan=val_nan, AbsSigmaC_level=AbsSigmaC_level, AbsSigmaA_level=AbsSigmaA_level, dtheta_range=dtheta_range

set_mark_OutIn_waves_time_scale_arr, $
    theta_zp_zm_arr, theta_zp_b0_arr, theta_zm_b0_arr, theta_kp_zm_arr, theta_km_zp_arr, theta_kp_b0_arr, theta_km_b0_arr, $
    SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
    SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
    CC_Np_AbsB_arr, $
    mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, mark_OutAW2_arr, $
    is_B0_AntiSunward=is_B0_AntiSunward, $
    val_nan=val_nan, AbsSigmaC_level=AbsSigmaC_level, AbsSigmaA_level=AbsSigmaA_level, dtheta_range=dtheta_range, $
    CC_Np_AbsB_level=CC_Np_AbsB_level
    

Step5_2:
;=====================
;Step5_2

;;--
file_data = 'CC_SVD_Mark_AWs_QPSWs (for_paper)'+$
                '('+year_str+mon_str+day_str+')'+$
                '.sav'
data_descrip  = 'got from "plot_Figure4567_for_paper_200206.pro"'
Save, FileName=dir_data+file_data, $
  data_descrip, $
  theta_zp_zm_arr, theta_zp_b0_arr, theta_zm_b0_arr, theta_kp_zm_arr, theta_km_zp_arr, theta_kp_b0_arr, theta_km_b0_arr, $
  SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
  SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
  CC_Np_AbsB_arr, $
  EigVal_Zp_time_scale_arr, EigVal_Zm_time_scale_arr, $
  i_eigenval_max, i_eigenval_mid, i_eigenval_min, $  
  mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, mark_OutAW2_arr, $
  JulDay_vect_plot, period_vect 


is_png_eps= 2
If is_png_eps eq 1 Then Begin
  eps_png_str = '.png'
EndIf Else Begin
  eps_png_str = '.eps'
EndElse
  

Step5_3:
;=====================
;Step5_3

;;;--
;file_version  = '(v1)'
;file_fig= 'Figure7_'+$
;        ''+$
;        file_version+sm+$
;        eps_png_str
;FileName  = dir_fig+file_fig
;
;subroutine_plot_Figure7_for_paper_200206, $
;  JulDay_vect_plot, period_vect, $
;  mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, $
;  FileName=FileName, is_png_eps=is_png_eps


;a Goto, End_Program
Step6:
;=====================
;Step6


;;--
file_version  = '(v1)'
file_fig= 'Figure6_'+$
        ''+$
        file_version+sm+$
        eps_png_str
FileName  = dir_fig+file_fig

subroutine_plot_Figure6_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  EigVal_Zp_time_scale_arr, EigVal_Zm_time_scale_arr, $
  i_eigenval_max, i_eigenval_mid, i_eigenval_min, $
  theta_zp_b0_arr, theta_zm_b0_arr, $
  theta_kp_b0_arr, theta_km_b0_arr, $
  theta_kp_zm_arr, theta_km_zp_arr, $
  theta_zp_zm_arr, theta_kp_km_arr, $
  FileName=FileName, is_png_eps=is_png_eps


;;--
;file_version  = '(v1)'
;file_fig= 'Figure10_'+$
;        ''+$
;        file_version+sm+$
;        eps_png_str
;FileName  = dir_fig+file_fig
;
;subroutine_plot_Figure10_for_paper_200206, $
;  JulDay_vect_plot, period_vect, $
;  EigVal_Zp_time_scale_arr, EigVal_Zm_time_scale_arr, $
;  i_eigenval_max, i_eigenval_mid, i_eigenval_min, $
;  theta_zp_b0_arr, theta_zm_b0_arr, $
;  theta_kp_b0_arr, theta_km_b0_arr, $
;  theta_kp_zm_arr, theta_km_zp_arr, $
;  theta_zp_zm_arr, theta_kp_km_arr, $
;  FileName=FileName, is_png_eps=is_png_eps
  
  

Step7:
;=====================
;Step7

;;--
file_version  = '(v1)'
file_fig= 'Figure4_'+$
        ''+$
        file_version+sm+$
        eps_png_str
FileName  = dir_fig+file_fig

subroutine_plot_Figure4_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
  SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
  CC_x_arr, CC_y_arr, CC_z_arr, CC_t_arr, $
  FileName=FileName, is_png_eps=is_png_eps
  
  
Step8:
;=====================
;Step8

;;--
;file_version  = '(v1)'
;file_fig= 'Figure5_'+$
;        ''+$
;        file_version+sm+$
;        eps_png_str
;FileName  = dir_fig+file_fig
;
;subroutine_plot_Figure5_for_paper_200206, $
;  JulDay_vect_plot, period_vect, $
;  CC_Np_AbsB_arr, $
;  FileName=FileName, is_png_eps=is_png_eps



End_Program:
end