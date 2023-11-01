;pro get_Spectra_of_ZpZm_SigmaC_SigmaA_SVD_MVA

;wk_dir  = '/Work/Data Analysis/Helios data process/Program/VDF_interpolate/VDF_interpolate/'
;wk_dir  = '/Work/Data Analysis/WIND data process/Programs/2000-06/VDF_interpolate/';/VDF_interpolate/'
;CD, wk_dir

year_str= '2002'
mon_str = '05'
day_str = '24'
sub_dir_date= 'wind\Alfven\'
;a sub_dir_date= '1995-02/';'1995-01--1995-02/'
;sub_dir_date= year_str+'/'+year_str+'-'+mon_str+'/'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''
dir_data_v2 = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
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
Restore, dir_data_v1 + file_restore, /Verbose
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


;;--
file_restore = 'wi_h0_mfi_'+year_str+mon_str+day_str+'_v05.sav'
;data_descrip  = 'got from "Read_WIND_MFI_H0_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr
Restore, dir_data_v2 + file_restore, /Verbose
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

Np_vect_plot  = Interpol(numdens_p_vect, JulDay_3DP_vect, JulDay_vect_plot)
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
  SVDC, A_arr, W, U, V     ;;需要svd方法
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

is_theta_kperp_z  = 0
Print, 'is_theta_kperp_z (0/1, 1 for angle between kperp_Zp/Zm and e_Zm/Zp, 0 for angle between k_Zp/Zm and e_Zm/Zp)'
Print, is_theta_kperp_z
is_continue = ' '
Read, 'is_continue: ', is_continue

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
AbsSigmaC_level = 0.6
AbsSigmaA_level = Sqrt(1-AbsSigmaC_level^2) ; |CorrCoeff_min|=sqrt(|sigma_C_level|^2) = 0.60
dtheta_range  = 40.0 
CC_Np_AbsB_level  = 0.5

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
;;--
Set_Plot,'win'
Device,DeComposed=0;, /Retain
xsize=1300.0 & ysize=900.0
Window,3,XSize=xsize,YSize=ysize,Retain=2

;;--
LoadCT,13
TVLCT,R,G,B,/Get
;Restore, '/Work/Data Analysis/Programs/RainBow(reset).sav', /Verbose
n_colors  = 256
RainBow_Matlab, R,G,B, n_colors
color_red = 0L
TVLCT,255L,0L,0L,color_red
R_red=255L & G_red=0L & B_red=0L
color_green = 1L
TVLCT,0L,255L,0L,color_green
R_green=0L & G_green=255L & B_green=0L
color_blue  = 2L
TVLCT,0L,0L,255L,color_blue
R_blue=0L & G_blue=0L & B_blue=255L
color_white = 4L
TVLCT,255L,255L,255L,color_white
R_white=255L & G_white=255L & B_white=255L
color_black = 3L
TVLCT,0L,0L,0L,color_black
R_black=0L & G_black=0L & B_black=0L
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
R = [R_red,R_green,R_blue,R_black,R_white,R]
G = [G_red,G_green,G_blue,G_black,G_white,G]
B = [B_red,B_green,B_blue,B_black,B_white,B]
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

;;--
position_img  = [0.04,0.08,0.96,0.99]

;;--
num_subimgs_x = 2
num_subimgs_y = 3;10
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.07
x_margin_right= 0.93
y_margin_bot  = 0.07
y_margin_top  = 0.93


For i_subimg_x=0,1 Do Begin
For i_subimg_y=0,2 Do Begin
  If (i_subimg_x eq 0 and i_subimg_y eq 2) Then Begin ;kx for Zp with min eigen-value
    image_TV  = mark_OutAW_arr
    title = TexToIDL('mark_OutAW')
    levels=[1] & c_colors=[color_black] & c_orientation=45.0
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 2) Then Begin ;ky for Zp with min eigen-value
    image_TV  = mark_OutQPSW_arr
    title = TexToIDL('mark_OutQPSW')
    levels=[1] & c_colors=[color_green] & c_orientation=45.0 
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin ;kz for Zp with min eigen-value
    image_TV  = mark_InAW_arr
    title = TexToIDL('mark_InAW')
    levels=[1] & c_colors=[color_red] & c_orientation=135.0    
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin ;ky for Zp with min eigen-value
    image_TV  = mark_InQPSW_arr
    title = TexToIDL('mark_InQPSW')
    levels=[1] & c_colors=[color_blue] & c_orientation=135.0    
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin ;kz for Zp with min eigen-value
    image_TV  = mark_OutAW2_arr
    title = TexToIDL('mark_OutAW2(sigma_A!=0)')
    levels=[1] & c_colors=[color_black] & c_orientation=0.0    
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin ;ky for Zp with min eigen-value
    image_TV_v1 = mark_OutAW_arr
    image_TV_v2 = mark_OutQPSW_arr
    image_TV_v3 = mark_InAW_arr
    image_TV_v4 = mark_InQPSW_arr    
    title = TexToIDL('marks_Out/In_AW/SWs')
    levels_v1=[1] & c_colors_v1=[color_black] & c_orientation_v1=45.0
    levels_v2=[1] & c_colors_v2=[color_green] & c_orientation_v2=45.0
    levels_v3=[1] & c_colors_v3=[color_red] & c_orientation_v3=135.0
    levels_v4=[1] & c_colors_v4=[color_blue] & c_orientation_v4=135.0    
  EndIf
  
  
;;--  
xplot_vect  = JulDay_vect_plot
yplot_vect  = period_vect
xrange  = [Min(xplot_vect)-0.5*(xplot_vect(1)-xplot_vect(0)), Max(xplot_vect)+0.5*(xplot_vect(1)-xplot_vect(0))]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
lg_yplot_vect = ALog10(yplot_vect)
yrange    = 10^[Min(lg_yplot_vect)-0.5*(lg_yplot_vect(1)-lg_yplot_vect(0)),$
                Max(lg_yplot_vect)+0.5*(lg_yplot_vect(1)-lg_yplot_vect(0))]
xtitle    = ' '
If (i_subimg_x eq 0) Then Begin
  ytitle  = 'period [s]'
EndIf Else Begin
  ytitle  = ' '
EndElse  

image_TV  = Rebin(image_TV,(Size(image_TV))[1],(Size(image_TV))[2]*1, /Sample)
yplot_vect= 10^Congrid(ALog10(yplot_vect), N_Elements(yplot_vect)*1, /Minus_One)

;;--
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
position_SubImg   = position_SubPlot

c_spacing = 0.1
If i_subimg_x eq 1 and i_subimg_y eq 0 Then Begin
  contour_arr = image_TV_v1
  levels=levels_v1 & c_colors=c_colors_v1 & c_orientation=c_orientation_v1
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
  contour_arr = image_TV_v2
  levels=levels_v2 & c_colors=c_colors_v2 & c_orientation=c_orientation_v2
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
  contour_arr = image_TV_v3
  levels=levels_v3 & c_colors=c_colors_v3 & c_orientation=c_orientation_v3
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
  contour_arr = image_TV_v4
  levels=levels_v4 & c_colors=c_colors_v4 & c_orientation=c_orientation_v4
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot         
EndIf Else Begin
  contour_arr = image_TV
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
EndElse
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, CharSize=1.2, $
    Position=position_subimg, XTitle=' ', YTitle=' ', /NoData, /NoErase, Color=color_black, $
    XTickLen=-0.02,YTickLen=-0.02, YLog=1
   
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1,$
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  

 
EndFor
EndFor


;;--
AnnotStr_tmp  = 'got from "get_Spectra_of_ZpZm_SigmaC_SigmaA_SVD_MVA.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
Annotstr_tmp  = year_str+mon_str+day_str
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd  = TVRD(true=1)
file_fig= 'mark_Out_In_AW_SW'+$
        timerange_str_plot+$
        '('+year_str+mon_str+day_str+')'+$
 ;       file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b


;a Goto, End_Program
Step6:
;=====================
;Step6

;;--
perp_symbol_oct = "170
perp_symbol_str = String(Byte(perp_symbol_oct))
perp_symbol_str_v1  = '{!9' + perp_symbol_str + '!X}'
perp_symbol_str_v2  = '!9'+perp_symbol_str+'!X'


;;;--
;Set_Plot,'PS'
;file_version  = '(v2)'
;file_fig= 'n&V&T'+$
;        ''+$
;        file_version+$
;        '.png'
;xsize = 21.0
;ysize = 24.0
;Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul

;;--
Set_Plot,'win'
Device,DeComposed=0;, /Retain
xsize=1300.0 & ysize=1000.0
Window,3,XSize=xsize,YSize=ysize,Retain=2

;;--
LoadCT,13
TVLCT,R,G,B,/Get
;Restore, '/Work/Data Analysis/Programs/RainBow(reset).sav', /Verbose
n_colors  = 256
RainBow_Matlab, R,G,B, n_colors
color_red = 0L
TVLCT,255L,0L,0L,color_red
R_red=255L & G_red=0L & B_red=0L
color_green = 1L
TVLCT,0L,255L,0L,color_green
R_green=0L & G_green=255L & B_green=0L
color_blue  = 2L
TVLCT,0L,0L,255L,color_blue
R_blue=0L & G_blue=0L & B_blue=255L
color_white = 4L
TVLCT,255L,255L,255L,color_white
R_white=255L & G_white=255L & B_white=255L
color_black = 3L
TVLCT,0L,0L,0L,color_black
R_black=0L & G_black=0L & B_black=0L
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
R = [R_red,R_green,R_blue,R_black,R_white,R]
G = [G_red,G_green,G_blue,G_black,G_white,G]
B = [B_red,B_green,B_blue,B_black,B_white,B]
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

;;--
position_img  = [0.04,0.08,0.96,0.99]

;;--
num_subimgs_x = 2
num_subimgs_y = 6;10
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.07
x_margin_right= 0.93
y_margin_bot  = 0.07
y_margin_top  = 0.93

is_contour_or_TV  = 1

;;--
;For i_subimg_x=0,1 Do Begin
;For i_subimg_y=0,9 Do Begin
;  If (i_subimg_x eq 0 and i_subimg_y eq 9) Then Begin ;kx for Zp with min eigen-value
;    image_TV  = Reform(EigVect_Zp_time_scale_arr(0,i_eigenval_min,*,*))
;    title = 'kx_Zp'
;  EndIf
;  If (i_subimg_x eq 0 and i_subimg_y eq 8) Then Begin ;ky for Zp with min eigen-value
;    image_TV  = Reform(EigVect_Zp_time_scale_arr(1,i_eigenval_min,*,*))
;    title = 'ky_Zp'
;  EndIf
;  If (i_subimg_x eq 0 and i_subimg_y eq 7) Then Begin ;kz for Zp with min eigen-value
;    image_TV  = Reform(EigVect_Zp_time_scale_arr(2,i_eigenval_min,*,*))
;    title = 'kz_Zp'
;  EndIf
;  
;  If (i_subimg_x eq 1 and i_subimg_y eq 9) Then Begin ;kx for Zm with min eigen-value
;    image_TV  = Reform(EigVect_Zm_time_scale_arr(0,i_eigenval_min,*,*))
;    title = 'kx_Zm'
;  EndIf  
;  If (i_subimg_x eq 1 and i_subimg_y eq 8) Then Begin ;ky for Zm with min eigen-value
;    image_TV  = Reform(EigVect_Zm_time_scale_arr(1,i_eigenval_min,*,*))
;    title = 'kx_Zm'
;  EndIf  
;  If (i_subimg_x eq 1 and i_subimg_y eq 7) Then Begin ;kz for Zm with min eigen-value
;    image_TV  = Reform(EigVect_Zm_time_scale_arr(2,i_eigenval_min,*,*))
;    title = 'kx_Zm'
;  EndIf  
;
;  If (i_subimg_x eq 0 and i_subimg_y eq 6) Then Begin ;zp_x for Zp with max eigen-value
;    image_TV  = Reform(EigVect_Zp_time_scale_arr(0,i_eigenval_max,*,*))
;    title = 'ex_dZp'
;  EndIf  
;  If (i_subimg_x eq 0 and i_subimg_y eq 5) Then Begin ;zp_y for Zp with max eigen-value
;    image_TV  = Reform(EigVect_Zp_time_scale_arr(1,i_eigenval_max,*,*))
;    title = 'ey_dZp'
;  EndIf  
;  If (i_subimg_x eq 0 and i_subimg_y eq 4) Then Begin ;zp_z for Zp with max eigen-value
;    image_TV  = Reform(EigVect_Zp_time_scale_arr(2,i_eigenval_max,*,*))
;    title = 'ez_dZp'
;  EndIf  
;  
;  If (i_subimg_x eq 1 and i_subimg_y eq 6) Then Begin ;zm_x for Zm with max eigen-value
;    image_TV  = Reform(EigVect_Zm_time_scale_arr(0,i_eigenval_max,*,*))
;    title = 'ex_dZp'
;  EndIf  
;  If (i_subimg_x eq 1 and i_subimg_y eq 5) Then Begin ;zm_y for Zm with max eigen-value
;    image_TV  = Reform(EigVect_Zm_time_scale_arr(1,i_eigenval_max,*,*))
;    title = 'ey_dZm'
;  EndIf  
;  If (i_subimg_x eq 1 and i_subimg_y eq 4) Then Begin ;zm_z for Zm with max eigen-value
;    image_TV  = Reform(EigVect_Zm_time_scale_arr(2,i_eigenval_max,*,*))
;    title = 'ez_dZm'
;  EndIf  

For i_subimg_x=0,1 Do Begin
For i_subimg_y=0,5 Do Begin
  If (i_subimg_x eq 0 and i_subimg_y eq 5) Then Begin ;kx for Zp with min eigen-value
    image_TV  = theta_kp_km_arr
    title = TexToIDL('\theta_{kp,km}')
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 4) Then Begin ;ky for Zp with min eigen-value
    image_TV  = theta_zp_b0_arr
    title = TexToIDL('\theta_{zp,b0}')
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 5) Then Begin ;kz for Zp with min eigen-value
    image_TV  = theta_zp_zm_arr
    title = TexToIDL('\theta_{zp,zm}')
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 4) Then Begin ;ky for Zp with min eigen-value
    image_TV  = theta_zm_b0_arr
    title = TexToIDL('\theta_{zm,b0}')
  EndIf
  
  
  If (i_subimg_x eq 0 and i_subimg_y eq 3) Then Begin ;theta_kp_zm
    image_TV  = theta_kp_zm_arr
    title = TexToIDL('\theta_{kp,zm}')
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 2) Then Begin ;theta_kp_b0
    image_TV  = theta_kp_b0_arr
    title = TexToIDL('\theta_{kp,b0}')
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 3) Then Begin ;theta_km_zp
    image_TV  = theta_km_zp_arr
    title = TexToIDL('\theta_{km,zp}')
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 2) Then Begin ;theta_km_b0
    image_TV  = theta_km_b0_arr
    title = TexToIDL('\theta_{km,b0}')
  EndIf
  
  If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin ;eigval_max/eigval_min for Zp
    image_TV  = EigVal_Zp_time_scale_arr(i_eigenval_max,*,*) / EigVal_Zp_time_scale_arr(i_eigenval_min,*,*)
    image_TV  = ALog10(Reform(image_TV))
    title = TexToIDL('lg\lambda_{max/min}(Zp)')
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin ;eigval_max/eigval_mid for Zp
    image_TV  = EigVal_Zp_time_scale_arr(i_eigenval_max,*,*) / EigVal_Zp_time_scale_arr(i_eigenval_mid,*,*)
    image_TV  = ALog10(Reform(image_TV))
    title = TexToIDL('lg\lambda_{max/mid}(Zp)')
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin ;eigval_max/eigval_min for Zm
    image_TV  = EigVal_Zm_time_scale_arr(i_eigenval_max,*,*) / EigVal_Zm_time_scale_arr(i_eigenval_min,*,*)
    image_TV  = ALog10(Reform(image_TV))
    title = TexToIDL('lg\lambda_{max/min}(Zm)')
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin ;eigval_max/eigval_mid for Zm
    image_TV  = EigVal_Zm_time_scale_arr(i_eigenval_max,*,*) / EigVal_Zm_time_scale_arr(i_eigenval_mid,*,*)
    image_TV  = ALog10(Reform(image_TV))
    title = TexToIDL('lg\lambda_{max/mid}(Zm)')
  EndIf  

;;--  
xplot_vect  = JulDay_vect_plot
yplot_vect  = period_vect
xrange  = [Min(xplot_vect)-0.5*(xplot_vect(1)-xplot_vect(0)), Max(xplot_vect)+0.5*(xplot_vect(1)-xplot_vect(0))]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
lg_yplot_vect = ALog10(yplot_vect)
yrange    = 10^[Min(lg_yplot_vect)-0.5*(lg_yplot_vect(1)-lg_yplot_vect(0)),$
                Max(lg_yplot_vect)+0.5*(lg_yplot_vect(1)-lg_yplot_vect(0))]
xtitle    = ' '
If (i_subimg_x eq 0) Then Begin
  ytitle  = 'period [s]'
EndIf Else Begin
  ytitle  = ' '
EndElse  

image_TV  = Rebin(image_TV,(Size(image_TV))[1],(Size(image_TV))[2]*1, /Sample)
yplot_vect= 10^Congrid(ALog10(yplot_vect), N_Elements(yplot_vect)*1, /Minus_One)

;;--
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
position_SubImg   = position_SubPlot

;;;---
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = -9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV)))+num_BadVal)
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV))))
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
byt_image_TV= byt_image_TV+(256-num_CB_color)
color_BadVal= color_white
If sub_BadVal(0) ne -1 Then $
byt_image_TV(sub_BadVal)  = color_BadVal

If is_contour_or_TV eq 1 Then Begin
num_levels  = 15
levels_vect = Byte(Findgen(num_levels)*Float(num_CB_color-1)/(num_levels-1))
level_val_vect= min_image + Float(levels_vect)/(num_CB_color-1)*(max_image-min_image)
levels_vect   = [color_BadVal, levels_vect+(256-num_CB_color)]
color_vect    = levels_vect
contour_arr = byt_image_TV
Contour, contour_arr, xplot_vect, yplot_vect, $
  XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
  /Cell_Fill, /NoErase, YLog=1, $
  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
EndIf Else Begin
TVImage, byt_image_TV,Position=position_SubPlot, NOINTERPOLATION=1 
EndElse

;If is_contour_or_TV eq 1 Then Begin
;num_levels  = 15
;levels_vect = Byte(Findgen(num_levels)*Float(num_CB_color-1)/(num_levels-1))
;level_val_vect= min_image + Float(levels_vect)/(num_CB_color-1)*(max_image-min_image)
;levels_vect   = [color_BadVal, levels_vect+(256-num_CB_color)]
;color_vect    = levels_vect
;contour_arr = byt_image_TV
;Contour, contour_arr, xplot_vect, yplot_vect, $
;  XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
;  /Cell_Fill, /NoErase, YLog=1, $
;  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
;EndIf Else Begin
;TVImage, byt_image_TV,Position=position_SubPlot, NOINTERPOLATION=1 
;EndElse
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, CharSize=1.2, $
    Position=position_subimg, XTitle=' ', YTitle=' ', /NoData, /NoErase, Color=color_black, $
    XTickLen=-0.02,YTickLen=-0.02, YLog=1
    
If is_contour_or_TV eq 3 Then Begin
levels_vect_v2  = levels_vect(1:N_Elements(levels_vect)-1)
c_annotate_vect = String(level_val_vect, format='(F5.2)')
c_linestyle_vect= Intarr(N_Elements(levels_vect_v2))    
Contour, contour_arr, xplot_vect, yplot_vect, /noerase, $
  levels=levels_vect_v2,$
  C_ANNOTATION=c_annotate_vect,$
  C_LINESTYLE=c_linestyle_vect, NoClip=0, Color=color_white, /OverPlot
EndIf

;;;---
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1,$
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  

;;;---
position_CB   = [position_SubImg(2)+0.05,position_SubImg(1),$
          position_SubImg(2)+0.06,position_SubImg(3)]
num_ticks   = 5
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = title
bottom_color  = 256-num_CB_color  ;0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=num_ticks-1,YTickName=tickn_CB,CharSize=1.4, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
 
EndFor
EndFor


;;--
AnnotStr_tmp  = 'got from "get_Spectra_of_ZpZm_SigmaC_SigmaA_SVD_MVA.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
Annotstr_tmp  = year_str+mon_str+day_str
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd  = TVRD(true=1)
If is_contour_or_TV eq 1 Then Begin
  file_version='(contour)'
EndIf Else Begin
  file_version  = '(TV)'
EndElse  
file_fig= 'k&ez_for_Zp&Zm(from SVD)'+$
        timerange_str_plot+$
        '('+year_str+mon_str+day_str+')'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b


;;;--
;Device,/Close 




Step7:
;=====================
;Step7

;;--
Set_Plot,'win'
Device,DeComposed=0;, /Retain
xsize=1400.0 & ysize=800.0
Window,3,XSize=xsize,YSize=ysize,Retain=2

;;--
LoadCT,13
TVLCT,R,G,B,/Get
n_colors  = 256
RainBow_Matlab, R,G,B, n_colors 
color_red = 0L
TVLCT,255L,0L,0L,color_red
R_red=255L & G_red=0L & B_red=0L
color_green = 1L
TVLCT,0L,255L,0L,color_green
R_green=0L & G_green=255L & B_green=0L
color_blue  = 2L
TVLCT,0L,0L,255L,color_blue
R_blue=0L & G_blue=0L & B_blue=255L
color_white = 4L
TVLCT,255L,255L,255L,color_white
R_white=255L & G_white=255L & B_white=255L
color_black = 3L
TVLCT,0L,0L,0L,color_black
R_black=0L & G_black=0L & B_black=0L
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
R = [R_red,R_green,R_blue,R_black,R_white,R]
G = [G_red,G_green,G_blue,G_black,G_white,G]
B = [B_red,B_green,B_blue,B_black,B_white,B]
TVLCT,R,G,B

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

;;--
position_img  = [0.03,0.08,0.97,0.99]

;;--
num_subimgs_x = 3
num_subimgs_y = 4
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.10
x_margin_right= 0.90
y_margin_bot  = 0.10
y_margin_top  = 0.90

is_contour_or_TV  = 1

;;--
For i_subimg_x=0,2 Do Begin
For i_subimg_y=0,3 Do Begin
  If (i_subimg_x eq 0 and i_subimg_y eq 3) Then Begin
    image_TV  = SigmaC_x_arr
    title = TexToIDL('\sigma_{C,X}')
  EndIf  
  If (i_subimg_x eq 0 and i_subimg_y eq 2) Then Begin
    image_TV  = SigmaC_y_arr
    title = TexToIDL('\sigma_{C,Y}')
  EndIf  
  If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin
    image_TV  = SigmaC_z_arr
    title = TexToIDL('\sigma_{C,Z}')
  EndIf  
  If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin
    image_TV  = SigmaC_t_arr
    title = TexToIDL('\sigma_{C,T}')
  EndIf  

  If (i_subimg_x eq 1 and i_subimg_y eq 3) Then Begin
    image_TV  = SigmaA_x_arr
    title = TexToIDL('\sigma_{A,X}')
  EndIf  
  If (i_subimg_x eq 1 and i_subimg_y eq 2) Then Begin
    image_TV  = SigmaA_y_arr
    title = TexToIDL('\sigma_{A,Y}')
  EndIf  
  If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin
    image_TV  = SigmaA_z_arr
    title = TexToIDL('\sigma_{A,Z}')
  EndIf  
  If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin
    image_TV  = SigmaA_t_arr
    title = TexToIDL('\sigma_{A,T}')
  EndIf  

  If (i_subimg_x eq 2 and i_subimg_y eq 3) Then Begin
    image_TV  = CC_x_arr
    title = TexToIDL('CC_{X}')
  EndIf  
  If (i_subimg_x eq 2 and i_subimg_y eq 2) Then Begin
    image_TV  = CC_y_arr
    title = TexToIDL('CC_{Y}')
  EndIf  
  If (i_subimg_x eq 2 and i_subimg_y eq 1) Then Begin
    image_TV  = CC_z_arr
    title = TexToIDL('CC_{Z}')
  EndIf  
  If (i_subimg_x eq 2 and i_subimg_y eq 0) Then Begin
    image_TV  = CC_t_arr
    title = TexToIDL('CC_{T}')
  EndIf  
  
;;--
xplot_vect  = JulDay_vect_plot
yplot_vect  = period_vect
xrange  = [Min(xplot_vect)-0.5*(xplot_vect(1)-xplot_vect(0)), Max(xplot_vect)+0.5*(xplot_vect(1)-xplot_vect(0))]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
;a yrange    = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
lg_yplot_vect = ALog10(yplot_vect)
yrange    = 10^[Min(lg_yplot_vect)-0.5*(lg_yplot_vect(1)-lg_yplot_vect(0)),$
                Max(lg_yplot_vect)+0.5*(lg_yplot_vect(1)-lg_yplot_vect(0))]
xtitle    = ' '
If (i_subimg_x eq 0) Then Begin
  ytitle  = 'period [s]'
EndIf Else Begin
  ytitle  = ' '
EndElse  

image_TV  = Rebin(image_TV,(Size(image_TV))[1],(Size(image_TV))[2]*1, /Sample)
yplot_vect= 10^Congrid(ALog10(yplot_vect), N_Elements(yplot_vect)*1, /Minus_One)

;;--
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
position_SubImg   = position_SubPlot

;;;---
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = -9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV)))+num_BadVal)
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV))))
min_image=-1.0 & max_image=+1.0
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
byt_image_TV= byt_image_TV+(256-num_CB_color)
color_BadVal= color_white
If sub_BadVal(0) ne -1 Then $
byt_image_TV(sub_BadVal)  = color_BadVal

If is_contour_or_TV eq 1 Then Begin
num_levels  = 15
levels_vect = Byte(Findgen(num_levels)*Float(num_CB_color-1)/(num_levels-1))
level_val_vect= min_image + Float(levels_vect)/(num_CB_color-1)*(max_image-min_image)
levels_vect   = [color_BadVal, levels_vect+(256-num_CB_color)]
color_vect    = levels_vect
contour_arr = byt_image_TV
Contour, contour_arr, xplot_vect, yplot_vect, $
  XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
  /Cell_Fill, /NoErase, YLog=1, $
  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
EndIf Else Begin
TVImage, byt_image_TV,Position=position_SubPlot, NOINTERPOLATION=1 
EndElse
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, CharSize=1.2, $
    Position=position_subimg, XTitle=' ', YTitle=' ', /NoData, /NoErase, Color=color_black, $
    XTickLen=-0.02,YTickLen=-0.02, YLog=1
    
If is_contour_or_TV eq 3 Then Begin
levels_vect_v2  = levels_vect(1:N_Elements(levels_vect)-1)
c_annotate_vect = String(level_val_vect, format='(F5.2)')
c_linestyle_vect= Intarr(N_Elements(levels_vect_v2))    
Contour, contour_arr, xplot_vect, yplot_vect, /noerase, $
  levels=levels_vect_v2,$
  C_ANNOTATION=c_annotate_vect,$
  C_LINESTYLE=c_linestyle_vect, NoClip=0, Color=color_white, /OverPlot
EndIf

;;;---
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  

;;;---
position_CB   = [position_SubImg(2)+0.04,position_SubImg(1),$
          position_SubImg(2)+0.05,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = title
bottom_color  = 256-num_CB_color  ;0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=num_ticks-1,YTickName=tickn_CB,CharSize=1.2, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
 
EndFor
EndFor


;;--
AnnotStr_tmp  = 'got from "get_Spectra_of_ZpZm_SigmaC_SigmaA_SVD_MVA.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
Annotstr_tmp  = year_str+mon_str+day_str
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd  = TVRD(true=1)
If is_contour_or_TV eq 1 Then Begin
  file_version='(contour)'
EndIf Else Begin
  file_version  = '(TV)'
EndElse  
file_fig= 'Sigma_C&A_x&y&z&tot'+$
        timerange_str_plot+$
        '('+year_str+mon_str+day_str+')'+$
        file_version+$
        '(v2).png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b



End_Program:
end