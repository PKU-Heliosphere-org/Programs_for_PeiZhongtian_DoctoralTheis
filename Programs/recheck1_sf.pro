;pro recheck1_SF

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


sub_dir_date  = 'new\19950720-29\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date



step1:




dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_theta_tao.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "plot_sp_freq.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;theta_bin_cen_vect_plot, slope
slope_o = slope
sigmaslope_o = sigmaslope

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_theta_tao_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "plot_sp_freq.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;theta_bin_cen_vect_plot, slope ,sigmaslope
slope_r = slope
sigmaslope_r = sigmaslope

step2:


plot,theta_bin_cen_vect_plot,slope_o(*,3),yrange = [0.5,1.5],xtitle=textoidl('\theta'),ytitle='slope'
plot,theta_bin_cen_vect_plot,slope_r(*,3),yrange = [0.5,1.5],xstyle=4, ystyle=4, color='ff0000'XL,/noerase
xyouts,60,1.4,'original'
xyouts,60,1.2,'reconstruction',color='ff0000'XL




end







