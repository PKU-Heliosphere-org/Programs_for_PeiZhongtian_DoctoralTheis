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
file_data = 'CC_SVD_Mark_AWs_QPSWs (for_paper).sav'
Restore, dir_data+file_data, /Verbose
;data_descrip  = 'got from "plot_Figure4567_for_paper_200206.pro"'
;Save, FileName=dir_data+file_data, $
;  data_descrip, $
;  theta_zp_zm_arr, theta_zp_b0_arr, theta_zm_b0_arr, theta_kp_zm_arr, theta_km_zp_arr, theta_kp_b0_arr, theta_km_b0_arr, $
;  SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
;  SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
;  CC_Np_AbsB_arr, $
;  EigVal_Zp_time_scale_arr, EigVal_Zm_time_scale_arr, $
;  i_eigenval_max, i_eigenval_mid, i_eigenval_min, $
;  mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, mark_OutAW2_arr, $
;  JulDay_vect_plot, period_vect

CC_x_arr  = Sqrt(SigmaC_x_arr^2/(1-SigmaA_x_arr^2)) * (SigmaC_x_arr/Abs(SigmaC_x_arr)) ;this is right
CC_y_arr  = Sqrt(SigmaC_y_arr^2/(1-SigmaA_y_arr^2)) * (SigmaC_y_arr/Abs(SigmaC_y_arr))
CC_z_arr  = Sqrt(SigmaC_z_arr^2/(1-SigmaA_z_arr^2)) * (SigmaC_z_arr/Abs(SigmaC_z_arr))
CC_t_arr  = Sqrt(SigmaC_t_arr^2/(1-SigmaA_t_arr^2)) * (SigmaC_t_arr/Abs(SigmaC_t_arr))



Step5_3:
;=====================
;Step5_3

;;--
file_version  = '(v1)'
file_fig= 'Figure7_'+$
        ''+$
        file_version+$
        '.png'
FileName  = dir_fig+file_fig
is_png_eps= 1

subroutine_plot_Figure7_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, $
  FileName=FileName, is_png_eps=is_png_eps


;a Goto, End_Program
Step6:
;=====================
;Step6


;;--
file_version  = '(v1)'
file_fig= 'Figure6_'+$
        ''+$
        file_version+$
        '.png'
FileName  = dir_fig+file_fig
is_png_eps= 1

subroutine_plot_Figure6_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  EigVal_Zp_time_scale_arr, EigVal_Zm_time_scale_arr, $
  i_eigenval_max, i_eigenval_mid, i_eigenval_min, $
  theta_zp_b0_arr, theta_zm_b0_arr, $
  theta_kp_b0_arr, theta_km_b0_arr, $
  theta_kp_zm_arr, theta_km_zp_arr, $
  theta_zp_zm_arr, theta_kp_km_arr, $
  FileName=FileName, is_png_eps=is_png_eps




Step7:
;=====================
;Step7

;;--
file_version  = '(v1)'
file_fig= 'Figure4_'+$
        ''+$
        file_version+$
        '.png'
FileName  = dir_fig+file_fig
is_png_eps= 1

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
file_version  = '(v1)'
file_fig= 'Figure5_'+$
        ''+$
        file_version+$
        '.png'
FileName  = dir_fig+file_fig
is_png_eps= 1

subroutine_plot_Figure5_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  CC_Np_AbsB_arr, $
  FileName=FileName, is_png_eps=is_png_eps



End_Program:
end