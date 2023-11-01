;pro paper3_caculate_sp


sub_dir_date  = 'wind\slow\case2\'
sub_dir_date1  = 'wind\fast\case2\'

n_jie = 10;;;
jie = (findgen(n_jie)+1)/2.0
slope_vect = fltarr(n_jie)
SigmaSlope_vect = fltarr(n_jie)

i_qu = 0

if i_qu eq 0 then quyu = 'haosan'
if i_qu eq 1 then quyu = 'guanxing'

;for i_slow = 1,15 do begin


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore=  '1-5'+quyu+'_SF.sav';strcompress(string(i_slow),/remove_all)
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  period_vect, $
;  Bt_SF,Bt_SF_bg,Bt_o



;;--
freq_vect_plot  = Reverse(1./period_vect)


for i_jie = 0,n_jie-1 do begin
;PSD_BComp_arr_plot  = Reverse(StructFunct_Bt_theta_scale_arr,2)
LgPSD_BComp_arr_plot= ALog10(abs(Bt_SF(i_jie,*)));;;;Bt_SF_bg or Bt_SF or Bt_o

freq_min_plot = Min(freq_vect_plot)
freq_max_plot = Max(freq_vect_plot)

freq_low = freq_min_plot;
freq_high = freq_max_plot;
sub_freq_in_seg = Where(freq_vect_plot ge freq_low and freq_vect_plot le freq_high)
num_points_LinFit   = N_Elements(sub_freq_in_seg)

  LgPSD_vect_tmp  = Reform(LgPSD_BComp_arr_plot)
  fit_para    = LinFit(ALog10(freq_vect_plot(sub_freq_in_seg)),LgPSD_vect_tmp(sub_freq_in_seg),$
              sigma=sigma_FitPara)
  slope_vect(i_jie)    = fit_para(1)
  SigmaSlope_vect(i_jie) = sigma_FitPara(1)
  
  
endfor

;endfor

file_save = 'sp_p_for_diff_days_'+'new_'+quyu+'_F.sav';S代表低速流，F代表高速流,quyu也得改
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "paper3_caculate_spy.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  slope_vect, $
  SigmaSlope_vect




end









