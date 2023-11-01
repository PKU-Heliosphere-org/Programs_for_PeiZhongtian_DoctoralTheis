;Pro get_slope



sub_dir_date  = 'weak\20040108\'



device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
file_restore= 'EffDataNum_theta_scale_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\others\'+sub_dir_date
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


;PSD_slope = fltarr(11,16)
;PSD_slope = PSD_Btotal_theta_scale_arr(30:40,*)*EffDataNum_scale_theta_arr(30:40,*)
PSD_mean = fltarr(16)
PSD_mean1 = fltarr(16)
PSD_mean2 = fltarr(16)
PSD_nunmean = fltarr(16)
for i = 0,15 do begin 

for j = 29,40 do begin
if EffDataNum_scale_theta_arr(j,i) LT 0 then begin
EffDataNum_scale_theta_arr(j,i) = 0
;if DataNum_scale_theta_arr(j,i) LT 0 then begin
;DataNum_scale_theta_arr(j,i) = 0
endif
endfor
n = mean(EffDataNum_scale_theta_arr(30:40,i))*n_elements(EffDataNum_scale_theta_arr(30:40,i))
PSD_mean1(i) = mean(PSD_Bcomp_theta_scale_arr(30:40,i)*EffDataNum_scale_theta_arr(30:40,i))*11/n
;n = mean(DataNum_scale_theta_arr(30:40,i))*n_elements(DataNum_scale_theta_arr(30:40,i))
;PSD_mean(i) = mean(PSD_Bcomp_theta_scale_arr(30:40,i)*DataNum_scale_theta_arr(30:40,i))*11/n
;PSD_nunmean(i) = mean(PSD_Bcomp_theta_scale_arr(30:40,i))

endfor


for i = 0,15 do begin 
for j = 49,60 do begin
if EffDataNum_scale_theta_arr(j,i) LT 0 then begin
EffDataNum_scale_theta_arr(j,i) = 0
;if DataNum_scale_theta_arr(j,i) LT 0 then begin
;DataNum_scale_theta_arr(j,i) = 0
endif
endfor
n = mean(EffDataNum_scale_theta_arr(50:60,i))*n_elements(EffDataNum_scale_theta_arr(50:60,i))
PSD_mean2(i) = mean(PSD_Bcomp_theta_scale_arr(50:60,i)*EffDataNum_scale_theta_arr(50:60,i))*11/n
;n = mean(DataNum_scale_theta_arr(30:40,i))*n_elements(DataNum_scale_theta_arr(30:40,i))
;PSD_mean(i) = mean(PSD_Bcomp_theta_scale_arr(30:40,i)*DataNum_scale_theta_arr(30:40,i))*11/n
;PSD_nunmean(i) = mean(PSD_Bcomp_theta_scale_arr(50:60,i))

endfor
PSD_mean = (PSD_mean1+PSD_mean2)/2.0

result = linfit(alog10(1.0/period_vect),alog10(PSD_mean),prob = prob ,sigma = sigma)
;esult = linfit(alog10(1.0/period_vect),alog10(PSD_nunmean),prob = probnun ,sigma = nunsigma)

print,result,sigma
;print,esult,nunsigma

scale = 1./period_vect
y=-1.67*alog10(scale)-4.3
y2=-1.5*alog10(scale)-3.75
yrange=[min(alog10(PSD_mean)),max(alog10(PSD_mean))]
plot,alog10(scale),y,linestyle=2,Yrange=yrange, color = '0000FF'XL, thick = 3
plot,alog10(scale),y2,linestyle=2,Yrange=yrange,color = 'FF0000'XL, thick = 3, /noerase
plot,alog10(scale),alog10(PSD_mean),xtitle='log(Frequency)',ytitle='log(PSD)',Yrange=yrange,thick = 3,/noerase

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\others\'+sub_dir_date
file_fig  = 'Ang_PSD_frequency'+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd


End_Program:
End



