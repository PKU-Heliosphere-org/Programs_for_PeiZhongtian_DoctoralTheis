;pro paper3_plot_SF_bperp_bpara

sub_dir_date  = 'wind\slow\case1\'

num_period = 6

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'paper3_thetavb_Bperp_Bpara_slowfast_haoguan.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;  period_guan,period_hao, $
;  m1_fast_90_theta_guan, m2_fast_90_theta_guan, m3_fast_90_theta_guan, m4_fast_90_theta_guan, m5_fast_90_theta_guan, $
;  m1_fast_60_theta_guan, m2_fast_60_theta_guan, m3_fast_60_theta_guan, m4_fast_60_theta_guan, m5_fast_60_theta_guan, $  
;  m1_fast_30_theta_guan, m2_fast_30_theta_guan, m3_fast_30_theta_guan, m4_fast_30_theta_guan, m5_fast_30_theta_guan, $  
;  m1_slow_90_theta_guan, m2_slow_90_theta_guan, m3_slow_90_theta_guan, m4_slow_90_theta_guan, m5_slow_90_theta_guan, $
;  m1_slow_60_theta_guan, m2_slow_60_theta_guan, m3_slow_60_theta_guan, m4_slow_60_theta_guan, m5_slow_60_theta_guan, $    
;  m1_slow_30_theta_guan, m2_slow_30_theta_guan, m3_slow_30_theta_guan, m4_slow_30_theta_guan, m5_slow_30_theta_guan, $
;  m1_fast_90_theta_hao, m2_fast_90_theta_hao, m3_fast_90_theta_hao, m4_fast_90_theta_hao, m5_fast_90_theta_hao, $
;  m1_fast_60_theta_hao, m2_fast_60_theta_hao, m3_fast_60_theta_hao, m4_fast_60_theta_hao, m5_fast_60_theta_hao, $  
;  m1_fast_30_theta_hao, m2_fast_30_theta_hao, m3_fast_30_theta_hao, m4_fast_30_theta_hao, m5_fast_30_theta_hao, $  
;  m1_slow_90_theta_hao, m2_slow_90_theta_hao, m3_slow_90_theta_hao, m4_slow_90_theta_hao, m5_slow_90_theta_hao, $
;  m1_slow_60_theta_hao, m2_slow_60_theta_hao, m3_slow_60_theta_hao, m4_slow_60_theta_hao, m5_slow_60_theta_hao, $    
;  m1_slow_30_theta_hao, m2_slow_30_theta_hao, m3_slow_30_theta_hao, m4_slow_30_theta_hao, m5_slow_30_theta_hao, $
;
;  m1_fast_90_theta_guan_perp, m2_fast_90_theta_guan_perp, m3_fast_90_theta_guan_perp, m4_fast_90_theta_guan_perp, m5_fast_90_theta_guan_perp, $
;  m1_fast_60_theta_guan_perp, m2_fast_60_theta_guan_perp, m3_fast_60_theta_guan_perp, m4_fast_60_theta_guan_perp, m5_fast_60_theta_guan_perp, $  
;  m1_fast_30_theta_guan_perp, m2_fast_30_theta_guan_perp, m3_fast_30_theta_guan_perp, m4_fast_30_theta_guan_perp, m5_fast_30_theta_guan_perp, $  
;  m1_slow_90_theta_guan_perp, m2_slow_90_theta_guan_perp, m3_slow_90_theta_guan_perp, m4_slow_90_theta_guan_perp, m5_slow_90_theta_guan_perp, $
;  m1_slow_60_theta_guan_perp, m2_slow_60_theta_guan_perp, m3_slow_60_theta_guan_perp, m4_slow_60_theta_guan_perp, m5_slow_60_theta_guan_perp, $    
;  m1_slow_30_theta_guan_perp, m2_slow_30_theta_guan_perp, m3_slow_30_theta_guan_perp, m4_slow_30_theta_guan_perp, m5_slow_30_theta_guan_perp, $
;  m1_fast_90_theta_hao_perp, m2_fast_90_theta_hao_perp, m3_fast_90_theta_hao_perp, m4_fast_90_theta_hao_perp, m5_fast_90_theta_hao_perp, $
;  m1_fast_60_theta_hao_perp, m2_fast_60_theta_hao_perp, m3_fast_60_theta_hao_perp, m4_fast_60_theta_hao_perp, m5_fast_60_theta_hao_perp, $  
;  m1_fast_30_theta_hao_perp, m2_fast_30_theta_hao_perp, m3_fast_30_theta_hao_perp, m4_fast_30_theta_hao_perp, m5_fast_30_theta_hao_perp, $  
;  m1_slow_90_theta_hao_perp, m2_slow_90_theta_hao_perp, m3_slow_90_theta_hao_perp, m4_slow_90_theta_hao_perp, m5_slow_90_theta_hao_perp, $
;  m1_slow_60_theta_hao_perp, m2_slow_60_theta_hao_perp, m3_slow_60_theta_hao_perp, m4_slow_60_theta_hao_perp, m5_slow_60_theta_hao_perp, $    
;  m1_slow_30_theta_hao_perp, m2_slow_30_theta_hao_perp, m3_slow_30_theta_hao_perp, m4_slow_30_theta_hao_perp, m5_slow_30_theta_hao_perp, $
;  
;  m1_fast_90_theta_guan_para, m2_fast_90_theta_guan_para, m3_fast_90_theta_guan_para, m4_fast_90_theta_guan_para, m5_fast_90_theta_guan_para, $
;  m1_fast_60_theta_guan_para, m2_fast_60_theta_guan_para, m3_fast_60_theta_guan_para, m4_fast_60_theta_guan_para, m5_fast_60_theta_guan_para, $  
;  m1_fast_30_theta_guan_para, m2_fast_30_theta_guan_para, m3_fast_30_theta_guan_para, m4_fast_30_theta_guan_para, m5_fast_30_theta_guan_para, $  
;  m1_slow_90_theta_guan_para, m2_slow_90_theta_guan_para, m3_slow_90_theta_guan_para, m4_slow_90_theta_guan_para, m5_slow_90_theta_guan_para, $
;  m1_slow_60_theta_guan_para, m2_slow_60_theta_guan_para, m3_slow_60_theta_guan_para, m4_slow_60_theta_guan_para, m5_slow_60_theta_guan_para, $    
;  m1_slow_30_theta_guan_para, m2_slow_30_theta_guan_para, m3_slow_30_theta_guan_para, m4_slow_30_theta_guan_para, m5_slow_30_theta_guan_para, $
;  m1_fast_90_theta_hao_para, m2_fast_90_theta_hao_para, m3_fast_90_theta_hao_para, m4_fast_90_theta_hao_para, m5_fast_90_theta_hao_para, $
;  m1_fast_60_theta_hao_para, m2_fast_60_theta_hao_para, m3_fast_60_theta_hao_para, m4_fast_60_theta_hao_para, m5_fast_60_theta_hao_para, $  
;  m1_fast_30_theta_hao_para, m2_fast_30_theta_hao_para, m3_fast_30_theta_hao_para, m4_fast_30_theta_hao_para, m5_fast_30_theta_hao_para, $  
;  m1_slow_90_theta_hao_para, m2_slow_90_theta_hao_para, m3_slow_90_theta_hao_para, m4_slow_90_theta_hao_para, m5_slow_90_theta_hao_para, $
;  m1_slow_60_theta_hao_para, m2_slow_60_theta_hao_para, m3_slow_60_theta_hao_para, m4_slow_60_theta_hao_para, m5_slow_60_theta_hao_para, $    
;  m1_slow_30_theta_hao_para, m2_slow_30_theta_hao_para, m3_slow_30_theta_hao_para, m4_slow_30_theta_hao_para, m5_slow_30_theta_hao_para    
;  

;m1f30g = fltarr(num_period)
;m1f60g = fltarr(num_period)
;m1f90g = fltarr(num_period)
;m2f30g = fltarr(num_period)
;m2f60g = fltarr(num_period)
;m2f90g = fltarr(num_period)
;m3f30g = fltarr(num_period)
;m3f60g = fltarr(num_period)
;m3f90g = fltarr(num_period)
;m4f30g = fltarr(num_period)
;m4f60g = fltarr(num_period)
;m4f90g = fltarr(num_period)
;m5f30g = fltarr(num_period)
;m5f60g = fltarr(num_period)
;m5f90g = fltarr(num_period)
;m1f30h = fltarr(num_period)
;m1f60h = fltarr(num_period)
;m1f90h = fltarr(num_period)
;m2f30h = fltarr(num_period)
;m2f60h = fltarr(num_period)
;m2f90h = fltarr(num_period)
;m3f30h = fltarr(num_period)
;m3f60h = fltarr(num_period)
;m3f90h = fltarr(num_period)
;m4f30h = fltarr(num_period)
;m4f60h = fltarr(num_period)
;m4f90h = fltarr(num_period)
;m5f30h = fltarr(num_period)
;m5f60h = fltarr(num_period)
;m5f90h = fltarr(num_period)
;m1s30g = fltarr(num_period)
;m1s60g = fltarr(num_period)
;m1s90g = fltarr(num_period)
;m2s30g = fltarr(num_period)
;m2s60g = fltarr(num_period)
;m2s90g = fltarr(num_period)
;m3s30g = fltarr(num_period)
;m3s60g = fltarr(num_period)
;m3s90g = fltarr(num_period)
;m4s30g = fltarr(num_period)
;m4s60g = fltarr(num_period)
;m4s90g = fltarr(num_period)
;m5s30g = fltarr(num_period)
;m5s60g = fltarr(num_period)
;m5s90g = fltarr(num_period)
;m1s30h = fltarr(num_period)
;m1s60h = fltarr(num_period)
;m1s90h = fltarr(num_period)
;m2s30h = fltarr(num_period)
;m2s60h = fltarr(num_period)
;m2s90h = fltarr(num_period)
;m3s30h = fltarr(num_period)
;m3s60h = fltarr(num_period)
;m3s90h = fltarr(num_period)
;m4s30h = fltarr(num_period)
;m4s60h = fltarr(num_period)
;m4s90h = fltarr(num_period)
;m5s30h = fltarr(num_period)
;m5s60h = fltarr(num_period)
;m5s90h = fltarr(num_period)

m1f30gpa = fltarr(num_period)
m1f60gpa = fltarr(num_period)
m1f90gpa = fltarr(num_period)
m2f30gpa = fltarr(num_period)
m2f60gpa = fltarr(num_period)
m2f90gpa = fltarr(num_period)
m3f30gpa = fltarr(num_period)
m3f60gpa = fltarr(num_period)
m3f90gpa = fltarr(num_period)
m4f30gpa = fltarr(num_period)
m4f60gpa = fltarr(num_period)
m4f90gpa = fltarr(num_period)
m5f30gpa = fltarr(num_period)
m5f60gpa = fltarr(num_period)
m5f90gpa = fltarr(num_period)
m1f30hpa = fltarr(num_period)
m1f60hpa = fltarr(num_period)
m1f90hpa = fltarr(num_period)
m2f30hpa = fltarr(num_period)
m2f60hpa = fltarr(num_period)
m2f90hpa = fltarr(num_period)
m3f30hpa = fltarr(num_period)
m3f60hpa = fltarr(num_period)
m3f90hpa = fltarr(num_period)
m4f30hpa = fltarr(num_period)
m4f60hpa = fltarr(num_period)
m4f90hpa = fltarr(num_period)
m5f30hpa = fltarr(num_period)
m5f60hpa = fltarr(num_period)
m5f90hpa = fltarr(num_period)
m1s30gpa = fltarr(num_period)
m1s60gpa = fltarr(num_period)
m1s90gpa = fltarr(num_period)
m2s30gpa = fltarr(num_period)
m2s60gpa = fltarr(num_period)
m2s90gpa = fltarr(num_period)
m3s30gpa = fltarr(num_period)
m3s60gpa = fltarr(num_period)
m3s90gpa = fltarr(num_period)
m4s30gpa = fltarr(num_period)
m4s60gpa = fltarr(num_period)
m4s90gpa = fltarr(num_period)
m5s30gpa = fltarr(num_period)
m5s60gpa = fltarr(num_period)
m5s90gpa = fltarr(num_period)
m1s30hpa = fltarr(num_period)
m1s60hpa = fltarr(num_period)
m1s90hpa = fltarr(num_period)
m2s30hpa = fltarr(num_period)
m2s60hpa = fltarr(num_period)
m2s90hpa = fltarr(num_period)
m3s30hpa = fltarr(num_period)
m3s60hpa = fltarr(num_period)
m3s90hpa = fltarr(num_period)
m4s30hpa = fltarr(num_period)
m4s60hpa = fltarr(num_period)
m4s90hpa = fltarr(num_period)
m5s30hpa = fltarr(num_period)
m5s60hpa = fltarr(num_period)
m5s90hpa = fltarr(num_period)

m1f30gpe = fltarr(num_period)
m1f60gpe = fltarr(num_period)
m1f90gpe = fltarr(num_period)
m2f30gpe = fltarr(num_period)
m2f60gpe = fltarr(num_period)
m2f90gpe = fltarr(num_period)
m3f30gpe = fltarr(num_period)
m3f60gpe = fltarr(num_period)
m3f90gpe = fltarr(num_period)
m4f30gpe = fltarr(num_period)
m4f60gpe = fltarr(num_period)
m4f90gpe = fltarr(num_period)
m5f30gpe = fltarr(num_period)
m5f60gpe = fltarr(num_period)
m5f90gpe = fltarr(num_period)
m1f30hpe = fltarr(num_period)
m1f60hpe = fltarr(num_period)
m1f90hpe = fltarr(num_period)
m2f30hpe = fltarr(num_period)
m2f60hpe = fltarr(num_period)
m2f90hpe = fltarr(num_period)
m3f30hpe = fltarr(num_period)
m3f60hpe = fltarr(num_period)
m3f90hpe = fltarr(num_period)
m4f30hpe = fltarr(num_period)
m4f60hpe = fltarr(num_period)
m4f90hpe = fltarr(num_period)
m5f30hpe = fltarr(num_period)
m5f60hpe = fltarr(num_period)
m5f90hpe = fltarr(num_period)
m1s30gpe = fltarr(num_period)
m1s60gpe = fltarr(num_period)
m1s90gpe = fltarr(num_period)
m2s30gpe = fltarr(num_period)
m2s60gpe = fltarr(num_period)
m2s90gpe = fltarr(num_period)
m3s30gpe = fltarr(num_period)
m3s60gpe = fltarr(num_period)
m3s90gpe = fltarr(num_period)
m4s30gpe = fltarr(num_period)
m4s60gpe = fltarr(num_period)
m4s90gpe = fltarr(num_period)
m5s30gpe = fltarr(num_period)
m5s60gpe = fltarr(num_period)
m5s90gpe = fltarr(num_period)
m1s30hpe = fltarr(num_period)
m1s60hpe = fltarr(num_period)
m1s90hpe = fltarr(num_period)
m2s30hpe = fltarr(num_period)
m2s60hpe = fltarr(num_period)
m2s90hpe = fltarr(num_period)
m3s30hpe = fltarr(num_period)
m3s60hpe = fltarr(num_period)
m3s90hpe = fltarr(num_period)
m4s30hpe = fltarr(num_period)
m4s60hpe = fltarr(num_period)
m4s90hpe = fltarr(num_period)
m5s30hpe = fltarr(num_period)
m5s60hpe = fltarr(num_period)
m5s90hpe = fltarr(num_period)


step2:

for i_p = 0,num_period-1 do begin
  m1f30gpa(i_p) = median(m1_fast_30_theta_guan_para(*,i_p))
  m1f60gpa(i_p) = median(m1_fast_60_theta_guan_para(*,i_p))  
  m1f90gpa(i_p) = median(m1_fast_90_theta_guan_para(*,i_p)) 
  m2f30gpa(i_p) = median(m2_fast_30_theta_guan_para(*,i_p))
  m2f60gpa(i_p) = median(m2_fast_60_theta_guan_para(*,i_p))  
  m2f90gpa(i_p) = median(m2_fast_90_theta_guan_para(*,i_p)) 
  m3f30gpa(i_p) = median(m3_fast_30_theta_guan_para(*,i_p))
  m3f60gpa(i_p) = median(m3_fast_60_theta_guan_para(*,i_p))  
  m3f90gpa(i_p) = median(m3_fast_90_theta_guan_para(*,i_p))
  m4f30gpa(i_p) = median(m4_fast_30_theta_guan_para(*,i_p))
  m4f60gpa(i_p) = median(m4_fast_60_theta_guan_para(*,i_p))  
  m4f90gpa(i_p) = median(m4_fast_90_theta_guan_para(*,i_p))
  m5f30gpa(i_p) = median(m5_fast_30_theta_guan_para(*,i_p))
  m5f60gpa(i_p) = median(m5_fast_60_theta_guan_para(*,i_p))  
  m5f90gpa(i_p) = median(m5_fast_90_theta_guan_para(*,i_p))  
  m1f30hpa(i_p) = median(m1_fast_30_theta_hao_para(*,i_p))
  m1f60hpa(i_p) = median(m1_fast_60_theta_hao_para(*,i_p))  
  m1f90hpa(i_p) = median(m1_fast_90_theta_hao_para(*,i_p)) 
  m2f30hpa(i_p) = median(m2_fast_30_theta_hao_para(*,i_p))
  m2f60hpa(i_p) = median(m2_fast_60_theta_hao_para(*,i_p))  
  m2f90hpa(i_p) = median(m2_fast_90_theta_hao_para(*,i_p)) 
  m3f30hpa(i_p) = median(m3_fast_30_theta_hao_para(*,i_p))
  m3f60hpa(i_p) = median(m3_fast_60_theta_hao_para(*,i_p))  
  m3f90hpa(i_p) = median(m3_fast_90_theta_hao_para(*,i_p))
  m4f30hpa(i_p) = median(m4_fast_30_theta_hao_para(*,i_p))
  m4f60hpa(i_p) = median(m4_fast_60_theta_hao_para(*,i_p))  
  m4f90hpa(i_p) = median(m4_fast_90_theta_hao_para(*,i_p))
  m5f30hpa(i_p) = median(m5_fast_30_theta_hao_para(*,i_p))
  m5f60hpa(i_p) = median(m5_fast_60_theta_hao_para(*,i_p))  
  m5f90hpa(i_p) = median(m5_fast_90_theta_hao_para(*,i_p))      
  m1s30gpa(i_p) = median(m1_slow_30_theta_guan_para(*,i_p))
  m1s60gpa(i_p) = median(m1_slow_60_theta_guan_para(*,i_p))  
  m1s90gpa(i_p) = median(m1_slow_90_theta_guan_para(*,i_p)) 
  m2s30gpa(i_p) = median(m2_slow_30_theta_guan_para(*,i_p))
  m2s60gpa(i_p) = median(m2_slow_60_theta_guan_para(*,i_p))  
  m2s90gpa(i_p) = median(m2_slow_90_theta_guan_para(*,i_p)) 
  m3s30gpa(i_p) = median(m3_slow_30_theta_guan_para(*,i_p))
  m3s60gpa(i_p) = median(m3_slow_60_theta_guan_para(*,i_p))  
  m3s90gpa(i_p) = median(m3_slow_90_theta_guan_para(*,i_p))
  m4s30gpa(i_p) = median(m4_slow_30_theta_guan_para(*,i_p))
  m4s60gpa(i_p) = median(m4_slow_60_theta_guan_para(*,i_p))  
  m4s90gpa(i_p) = median(m4_slow_90_theta_guan_para(*,i_p))
  m5s30gpa(i_p) = median(m5_slow_30_theta_guan_para(*,i_p))
  m5s60gpa(i_p) = median(m5_slow_60_theta_guan_para(*,i_p))  
  m5s90gpa(i_p) = median(m5_slow_90_theta_guan_para(*,i_p))  
  m1s30hpa(i_p) = median(m1_slow_30_theta_hao_para(*,i_p))
  m1s60hpa(i_p) = median(m1_slow_60_theta_hao_para(*,i_p))  
  m1s90hpa(i_p) = median(m1_slow_90_theta_hao_para(*,i_p)) 
  m2s30hpa(i_p) = median(m2_slow_30_theta_hao_para(*,i_p))
  m2s60hpa(i_p) = median(m2_slow_60_theta_hao_para(*,i_p))  
  m2s90hpa(i_p) = median(m2_slow_90_theta_hao_para(*,i_p)) 
  m3s30hpa(i_p) = median(m3_slow_30_theta_hao_para(*,i_p))
  m3s60hpa(i_p) = median(m3_slow_60_theta_hao_para(*,i_p))  
  m3s90hpa(i_p) = median(m3_slow_90_theta_hao_para(*,i_p))
  m4s30hpa(i_p) = median(m4_slow_30_theta_hao_para(*,i_p))
  m4s60hpa(i_p) = median(m4_slow_60_theta_hao_para(*,i_p))  
  m4s90hpa(i_p) = median(m4_slow_90_theta_hao_para(*,i_p))
  m5s30hpa(i_p) = median(m5_slow_30_theta_hao_para(*,i_p))
  m5s60hpa(i_p) = median(m5_slow_60_theta_hao_para(*,i_p))  
  m5s90hpa(i_p) = median(m5_slow_90_theta_hao_para(*,i_p))    
  
  m1f30gpe(i_p) = median(m1_fast_30_theta_guan_perp(*,i_p))
  m1f60gpe(i_p) = median(m1_fast_60_theta_guan_perp(*,i_p))  
  m1f90gpe(i_p) = median(m1_fast_90_theta_guan_perp(*,i_p)) 
  m2f30gpe(i_p) = median(m2_fast_30_theta_guan_perp(*,i_p))
  m2f60gpe(i_p) = median(m2_fast_60_theta_guan_perp(*,i_p))  
  m2f90gpe(i_p) = median(m2_fast_90_theta_guan_perp(*,i_p)) 
  m3f30gpe(i_p) = median(m3_fast_30_theta_guan_perp(*,i_p))
  m3f60gpe(i_p) = median(m3_fast_60_theta_guan_perp(*,i_p))  
  m3f90gpe(i_p) = median(m3_fast_90_theta_guan_perp(*,i_p))
  m4f30gpe(i_p) = median(m4_fast_30_theta_guan_perp(*,i_p))
  m4f60gpe(i_p) = median(m4_fast_60_theta_guan_perp(*,i_p))  
  m4f90gpe(i_p) = median(m4_fast_90_theta_guan_perp(*,i_p))
  m5f30gpe(i_p) = median(m5_fast_30_theta_guan_perp(*,i_p))
  m5f60gpe(i_p) = median(m5_fast_60_theta_guan_perp(*,i_p))  
  m5f90gpe(i_p) = median(m5_fast_90_theta_guan_perp(*,i_p))  
  m1f30hpe(i_p) = median(m1_fast_30_theta_hao_perp(*,i_p))
  m1f60hpe(i_p) = median(m1_fast_60_theta_hao_perp(*,i_p))  
  m1f90hpe(i_p) = median(m1_fast_90_theta_hao_perp(*,i_p)) 
  m2f30hpe(i_p) = median(m2_fast_30_theta_hao_perp(*,i_p))
  m2f60hpe(i_p) = median(m2_fast_60_theta_hao_perp(*,i_p))  
  m2f90hpe(i_p) = median(m2_fast_90_theta_hao_perp(*,i_p)) 
  m3f30hpe(i_p) = median(m3_fast_30_theta_hao_perp(*,i_p))
  m3f60hpe(i_p) = median(m3_fast_60_theta_hao_perp(*,i_p))  
  m3f90hpe(i_p) = median(m3_fast_90_theta_hao_perp(*,i_p))
  m4f30hpe(i_p) = median(m4_fast_30_theta_hao_perp(*,i_p))
  m4f60hpe(i_p) = median(m4_fast_60_theta_hao_perp(*,i_p))  
  m4f90hpe(i_p) = median(m4_fast_90_theta_hao_perp(*,i_p))
  m5f30hpe(i_p) = median(m5_fast_30_theta_hao_perp(*,i_p))
  m5f60hpe(i_p) = median(m5_fast_60_theta_hao_perp(*,i_p))  
  m5f90hpe(i_p) = median(m5_fast_90_theta_hao_perp(*,i_p))      
  m1s30gpe(i_p) = median(m1_slow_30_theta_guan_perp(*,i_p))
  m1s60gpe(i_p) = median(m1_slow_60_theta_guan_perp(*,i_p))  
  m1s90gpe(i_p) = median(m1_slow_90_theta_guan_perp(*,i_p)) 
  m2s30gpe(i_p) = median(m2_slow_30_theta_guan_perp(*,i_p))
  m2s60gpe(i_p) = median(m2_slow_60_theta_guan_perp(*,i_p))  
  m2s90gpe(i_p) = median(m2_slow_90_theta_guan_perp(*,i_p)) 
  m3s30gpe(i_p) = median(m3_slow_30_theta_guan_perp(*,i_p))
  m3s60gpe(i_p) = median(m3_slow_60_theta_guan_perp(*,i_p))  
  m3s90gpe(i_p) = median(m3_slow_90_theta_guan_perp(*,i_p))
  m4s30gpe(i_p) = median(m4_slow_30_theta_guan_perp(*,i_p))
  m4s60gpe(i_p) = median(m4_slow_60_theta_guan_perp(*,i_p))  
  m4s90gpe(i_p) = median(m4_slow_90_theta_guan_perp(*,i_p))
  m5s30gpe(i_p) = median(m5_slow_30_theta_guan_perp(*,i_p))
  m5s60gpe(i_p) = median(m5_slow_60_theta_guan_perp(*,i_p))  
  m5s90gpe(i_p) = median(m5_slow_90_theta_guan_perp(*,i_p))  
  m1s30hpe(i_p) = median(m1_slow_30_theta_hao_perp(*,i_p))
  m1s60hpe(i_p) = median(m1_slow_60_theta_hao_perp(*,i_p))  
  m1s90hpe(i_p) = median(m1_slow_90_theta_hao_perp(*,i_p)) 
  m2s30hpe(i_p) = median(m2_slow_30_theta_hao_perp(*,i_p))
  m2s60hpe(i_p) = median(m2_slow_60_theta_hao_perp(*,i_p))  
  m2s90hpe(i_p) = median(m2_slow_90_theta_hao_perp(*,i_p)) 
  m3s30hpe(i_p) = median(m3_slow_30_theta_hao_perp(*,i_p))
  m3s60hpe(i_p) = median(m3_slow_60_theta_hao_perp(*,i_p))  
  m3s90hpe(i_p) = median(m3_slow_90_theta_hao_perp(*,i_p))
  m4s30hpe(i_p) = median(m4_slow_30_theta_hao_perp(*,i_p))
  m4s60hpe(i_p) = median(m4_slow_60_theta_hao_perp(*,i_p))  
  m4s90hpe(i_p) = median(m4_slow_90_theta_hao_perp(*,i_p))
  m5s30hpe(i_p) = median(m5_slow_30_theta_hao_perp(*,i_p))
  m5s60hpe(i_p) = median(m5_slow_60_theta_hao_perp(*,i_p))  
  m5s90hpe(i_p) = median(m5_slow_90_theta_hao_perp(*,i_p))   
endfor

step3:


  Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=800.0 & ysize=1200.0
    Window,1,XSize=xsize,YSize=ysize,Retain=2
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

position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

i_x_SubImg  = 0
i_y_SubImg  = 2

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,m1f30gpe,xrange=[5,400],yrange=[0.01,1000],xstyle=1,ystyle=1,color = color_black, $
  title = 'fast stream inertial 0-30 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_guan,m2f30gpe,color = color_black
oplot,period_guan,m3f30gpe,color = color_black
oplot,period_guan,m4f30gpe,color = color_black
oplot,period_guan,m5f30gpe,color = color_black
oplot,period_guan,m1f30gpa,color = color_red
oplot,period_guan,m2f30gpa,color = color_red
oplot,period_guan,m3f30gpa,color = color_red
oplot,period_guan,m4f30gpa,color = color_red
oplot,period_guan,m5f30gpa,color = color_red
xyouts,100,0.08,'perp',color = color_black
xyouts,100,0.03,'para',color = color_red
xyouts,250,m1f30gpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,250,m2f30gpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,250,m3f30gpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,250,m4f30gpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,250,m5f30gpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,250,m1f30gpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,250,m2f30gpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,250,m3f30gpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,250,m4f30gpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,250,m5f30gpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 0
i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,m1f60gpe,xrange=[5,400],yrange=[0.01,1000],xstyle=1,ystyle=1,color = color_black, $
  title = 'fast stream inertial 30-60 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_guan,m2f60gpe,color = color_black
oplot,period_guan,m3f60gpe,color = color_black
oplot,period_guan,m4f60gpe,color = color_black
oplot,period_guan,m5f60gpe,color = color_black
oplot,period_guan,m1f60gpa,color = color_red
oplot,period_guan,m2f60gpa,color = color_red
oplot,period_guan,m3f60gpa,color = color_red
oplot,period_guan,m4f60gpa,color = color_red
oplot,period_guan,m5f60gpa,color = color_red
xyouts,100,0.08,'perp',color = color_black
xyouts,100,0.03,'para',color = color_red
xyouts,250,m1f60gpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,250,m2f60gpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,250,m3f60gpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,250,m4f60gpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,250,m5f60gpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,250,m1f60gpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,250,m2f60gpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,250,m3f60gpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,250,m4f60gpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,250,m5f60gpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 0
i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,m1f60gpe,xrange=[5,400],yrange=[0.01,1000],xstyle=1,ystyle=1,color = color_black, $
  title = 'fast stream inertial 60-90 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_guan,m2f90gpe,color = color_black
oplot,period_guan,m3f90gpe,color = color_black
oplot,period_guan,m4f90gpe,color = color_black
oplot,period_guan,m5f90gpe,color = color_black
oplot,period_guan,m1f90gpa,color = color_red
oplot,period_guan,m2f90gpa,color = color_red
oplot,period_guan,m3f90gpa,color = color_red
oplot,period_guan,m4f90gpa,color = color_red
oplot,period_guan,m5f90gpa,color = color_red
xyouts,100,0.08,'perp',color = color_black
xyouts,100,0.03,'para',color = color_red
xyouts,250,m1f90gpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,250,m2f90gpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,250,m3f90gpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,250,m4f90gpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,250,m5f90gpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,250,m1f90gpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,250,m2f90gpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,250,m3f90gpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,250,m4f90gpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,250,m5f90gpa(num_period-1),'5',color = color_red,charsize=0.8


i_x_SubImg  = 1
i_y_SubImg  = 2

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,m1f30hpe,xrange=[0.1,4],yrange=[0.0001,10],xstyle=1,ystyle=1,color = color_black, $
  title = 'fast stream dissipation 0-30 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_hao,m2f30hpe,color = color_black
oplot,period_hao,m3f30hpe,color = color_black
oplot,period_hao,m4f30hpe,color = color_black
oplot,period_hao,m5f30hpe,color = color_black
oplot,period_hao,m1f30hpa,color = color_red
oplot,period_hao,m2f30hpa,color = color_red
oplot,period_hao,m3f30hpa,color = color_red
oplot,period_hao,m4f30hpa,color = color_red
oplot,period_hao,m5f30hpa,color = color_red
xyouts,1,0.0008,'perp',color = color_black
xyouts,1,0.0003,'para',color = color_red
xyouts,3,m1f30hpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,3,m2f30hpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,3,m3f30hpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,3,m4f30hpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,3,m5f30hpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,3,m1f30hpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,3,m2f30hpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,3,m3f30hpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,3,m4f30hpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,3,m5f30hpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 1
i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,m1f60hpe,xrange=[0.1,4],yrange=[0.0001,10],xstyle=1,ystyle=1,color = color_black, $
  title = 'fast stream dissipation 30-60 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_hao,m2f60hpe,color = color_black
oplot,period_hao,m3f60hpe,color = color_black
oplot,period_hao,m4f60hpe,color = color_black
oplot,period_hao,m5f60hpe,color = color_black
oplot,period_hao,m1f60hpa,color = color_red
oplot,period_hao,m2f60hpa,color = color_red
oplot,period_hao,m3f60hpa,color = color_red
oplot,period_hao,m4f60hpa,color = color_red
oplot,period_hao,m5f60hpa,color = color_red
xyouts,1,0.0008,'perp',color = color_black
xyouts,1,0.0003,'para',color = color_red
xyouts,3,m1f60hpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,3,m2f60hpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,3,m3f60hpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,3,m4f60hpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,3,m5f60hpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,3,m1f60hpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,3,m2f60hpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,3,m3f60hpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,3,m4f60hpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,3,m5f60hpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 1
i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,m1f60hpe,xrange=[0.1,4],yrange=[0.0001,10],xstyle=1,ystyle=1,color = color_black, $
  title = 'fast stream dissipation 60-90 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_hao,m2f90hpe,color = color_black
oplot,period_hao,m3f90hpe,color = color_black
oplot,period_hao,m4f90hpe,color = color_black
oplot,period_hao,m5f90hpe,color = color_black
oplot,period_hao,m1f90hpa,color = color_red
oplot,period_hao,m2f90hpa,color = color_red
oplot,period_hao,m3f90hpa,color = color_red
oplot,period_hao,m4f90hpa,color = color_red
oplot,period_hao,m5f90hpa,color = color_red
xyouts,1,0.0008,'perp',color = color_black
xyouts,1,0.0003,'para',color = color_red
xyouts,3,m1f90hpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,3,m2f90hpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,3,m3f90hpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,3,m4f90hpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,3,m5f90hpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,3,m1f90hpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,3,m2f90hpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,3,m3f90hpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,3,m4f90hpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,3,m5f90hpa(num_period-1),'5',color = color_red,charsize=0.8

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_SF_Bperp_Bpara_fast.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd



step4:

xsize=800.0 & ysize=1200.0
Window,2,XSize=xsize,YSize=ysize,Retain=2
    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 

position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

i_x_SubImg  = 0
i_y_SubImg  = 2

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,m1s30gpe,xrange=[5,400],yrange=[0.001,100],xstyle=1,ystyle=1,color = color_black, $
  title = 'slow stream inertial 0-30 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_guan,m2s30gpe,color = color_black
oplot,period_guan,m3s30gpe,color = color_black
oplot,period_guan,m4s30gpe,color = color_black
oplot,period_guan,m5s30gpe,color = color_black
oplot,period_guan,m1s30gpa,color = color_red
oplot,period_guan,m2s30gpa,color = color_red
oplot,period_guan,m3s30gpa,color = color_red
oplot,period_guan,m4s30gpa,color = color_red
oplot,period_guan,m5s30gpa,color = color_red
xyouts,100,0.08,'perp',color = color_black
xyouts,100,0.03,'para',color = color_red
xyouts,250,m1s30gpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,250,m2s30gpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,250,m3s30gpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,250,m4s30gpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,250,m5s30gpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,250,m1s30gpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,250,m2s30gpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,250,m3s30gpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,250,m4s30gpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,250,m5s30gpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 0
i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,m1s60gpe,xrange=[5,400],yrange=[0.001,100],xstyle=1,ystyle=1,color = color_black, $
  title = 'slow stream inertial 30-60 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_guan,m2s60gpe,color = color_black
oplot,period_guan,m3s60gpe,color = color_black
oplot,period_guan,m4s60gpe,color = color_black
oplot,period_guan,m5s60gpe,color = color_black
oplot,period_guan,m1s60gpa,color = color_red
oplot,period_guan,m2s60gpa,color = color_red
oplot,period_guan,m3s60gpa,color = color_red
oplot,period_guan,m4s60gpa,color = color_red
oplot,period_guan,m5s60gpa,color = color_red
xyouts,100,0.08,'perp',color = color_black
xyouts,100,0.03,'para',color = color_red
xyouts,250,m1s60gpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,250,m2s60gpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,250,m3s60gpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,250,m4s60gpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,250,m5s60gpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,250,m1s60gpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,250,m2s60gpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,250,m3s60gpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,250,m4s60gpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,250,m5s60gpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 0
i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,m1s60gpe,xrange=[5,400],yrange=[0.001,100],xstyle=1,ystyle=1,color = color_black, $
  title = 'slow stream inertial 60-90 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_guan,m2s90gpe,color = color_black
oplot,period_guan,m3s90gpe,color = color_black
oplot,period_guan,m4s90gpe,color = color_black
oplot,period_guan,m5s90gpe,color = color_black
oplot,period_guan,m1s90gpa,color = color_red
oplot,period_guan,m2s90gpa,color = color_red
oplot,period_guan,m3s90gpa,color = color_red
oplot,period_guan,m4s90gpa,color = color_red
oplot,period_guan,m5s90gpa,color = color_red
xyouts,100,0.08,'perp',color = color_black
xyouts,100,0.03,'para',color = color_red
xyouts,250,m1s90gpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,250,m2s90gpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,250,m3s90gpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,250,m4s90gpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,250,m5s90gpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,250,m1s90gpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,250,m2s90gpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,250,m3s90gpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,250,m4s90gpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,250,m5s90gpa(num_period-1),'5',color = color_red,charsize=0.8


i_x_SubImg  = 1
i_y_SubImg  = 2

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,m1s30hpe,xrange=[0.1,4],yrange=[0.00001,1],xstyle=1,ystyle=1,color = color_black, $
  title = 'slow stream dissipation 0-30 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_hao,m2s30hpe,color = color_black
oplot,period_hao,m3s30hpe,color = color_black
oplot,period_hao,m4s30hpe,color = color_black
oplot,period_hao,m5s30hpe,color = color_black
oplot,period_hao,m1s30hpa,color = color_red
oplot,period_hao,m2s30hpa,color = color_red
oplot,period_hao,m3s30hpa,color = color_red
oplot,period_hao,m4s30hpa,color = color_red
oplot,period_hao,m5s30hpa,color = color_red
xyouts,1,0.0008,'perp',color = color_black
xyouts,1,0.0003,'para',color = color_red
xyouts,3,m1s30hpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,3,m2s30hpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,3,m3s30hpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,3,m4s30hpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,3,m5s30hpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,3,m1s30hpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,3,m2s30hpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,3,m3s30hpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,3,m4s30hpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,3,m5s30hpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 1
i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,m1s60hpe,xrange=[0.1,4],yrange=[0.00001,1],xstyle=1,ystyle=1,color = color_black, $
  title = 'slow stream dissipation 30-60 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_hao,m2s60hpe,color = color_black
oplot,period_hao,m3s60hpe,color = color_black
oplot,period_hao,m4s60hpe,color = color_black
oplot,period_hao,m5s60hpe,color = color_black
oplot,period_hao,m1s60hpa,color = color_red
oplot,period_hao,m2s60hpa,color = color_red
oplot,period_hao,m3s60hpa,color = color_red
oplot,period_hao,m4s60hpa,color = color_red
oplot,period_hao,m5s60hpa,color = color_red
xyouts,1,0.0008,'perp',color = color_black
xyouts,1,0.0003,'para',color = color_red
xyouts,3,m1s60hpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,3,m2s60hpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,3,m3s60hpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,3,m4s60hpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,3,m5s60hpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,3,m1s60hpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,3,m2s60hpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,3,m3s60hpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,3,m4s60hpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,3,m5s60hpa(num_period-1),'5',color = color_red,charsize=0.8

i_x_SubImg  = 1
i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,m1s60hpe,xrange=[0.1,4],yrange=[0.00001,1],xstyle=1,ystyle=1,color = color_black, $
  title = 'slow stream dissipation 60-90 thetavb',position=position_SubImg,/xlog,/ylog,/noerase
oplot,period_hao,m2s90hpe,color = color_black
oplot,period_hao,m3s90hpe,color = color_black
oplot,period_hao,m4s90hpe,color = color_black
oplot,period_hao,m5s90hpe,color = color_black
oplot,period_hao,m1s90hpa,color = color_red
oplot,period_hao,m2s90hpa,color = color_red
oplot,period_hao,m3s90hpa,color = color_red
oplot,period_hao,m4s90hpa,color = color_red
oplot,period_hao,m5s90hpa,color = color_red
xyouts,1,0.0008,'perp',color = color_black
xyouts,1,0.0003,'para',color = color_red
xyouts,3,m1s90hpe(num_period-1),'1',color = color_black,charsize=0.8
xyouts,3,m2s90hpe(num_period-1),'2',color = color_black,charsize=0.8
xyouts,3,m3s90hpe(num_period-1),'3',color = color_black,charsize=0.8
xyouts,3,m4s90hpe(num_period-1),'4',color = color_black,charsize=0.8
xyouts,3,m5s90hpe(num_period-1),'5',color = color_black,charsize=0.8
xyouts,3,m1s90hpa(num_period-1),'1',color = color_red,charsize=0.8
xyouts,3,m2s90hpa(num_period-1),'2',color = color_red,charsize=0.8
xyouts,3,m3s90hpa(num_period-1),'3',color = color_red,charsize=0.8
xyouts,3,m4s90hpa(num_period-1),'4',color = color_red,charsize=0.8
xyouts,3,m5s90hpa(num_period-1),'5',color = color_red,charsize=0.8



image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_SF_Bperp_Bpara_slow.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd


end_program:
end






