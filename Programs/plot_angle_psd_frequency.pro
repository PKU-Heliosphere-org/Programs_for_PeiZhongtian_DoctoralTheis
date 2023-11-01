;Pro plot_angle_PSD_Frequency

sub_dir_date  = '19971223\'


Step1:
;===========================
;Step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'PSD_'+'Btotal'+'_theta_period_arr'+$
        '(time=*-*)'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  theta_bin_min_vect, theta_bin_max_vect, $
;  period_vect, $
;  PSD_Btotal_theta_scale_arr

step2:
n = size(PSD_Btotal_time_scale_arr,/dimensions)
PSD_ang = fltarr(22,n(1))
PSD_ang(0:10,*) = PSD_Btotal_theta_scale_arr(30:40,*)
PSD_ang(11:21,*) = PSD_Btotal_theta_scale_arr(50:60,*)

PSD = fltarr(n(1))
scale = fltarr(n(1))
for i_scale=0,n(1)-1 do begin
PSD(i_scale) = mean(PSD_ang(*,i_scale))
endfor

scale = 1./period_vect
y=-1.67*alog10(scale)-3.8
y2=-1.5*alog10(scale)-3.25
yrange=[min(alog10(PSD)),max(alog10(PSD))]
plot,alog10(scale),y,linestyle=2,Yrange=yrange, color = '0000FF'XL, thick = 3
plot,alog10(scale),y2,linestyle=2,Yrange=yrange,color = 'FF0000'XL, thick = 3, /noerase
plot,alog10(scale),alog10(PSD),xtitle='log(Frequency)',ytitle='log(PSD)',Yrange=yrange,thick = 3,/noerase

;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_fig  = 'Ang_PSD_frequency'+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd






End_Program:
End
















