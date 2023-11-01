;Pro plot_PSD_Frequency

sub_dir_date  = 'strong\20030126-30\'


device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


Step1:
;===========================
;Step1:

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\others\'+sub_dir_date
file_restore= 'Bx'+'_wavlet_arr(time=*-*).sav'
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
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; Btotal_wavlet_arr


file_restore = 'PSD_'+'Bx'+'_time_scale_arr'+$
        '(time=*-*)'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr
PSD_Bx_time_scale_arr = PSD_BComp_time_scale_arr
  
  
file_restore = 'PSD_'+'By'+'_time_scale_arr'+$
        '(time=*-*)'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr
PSD_By_time_scale_arr = PSD_BComp_time_scale_arr



file_restore = 'PSD_'+'Bz'+'_time_scale_arr'+$
        '(time=*-*)'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr
PSD_Bz_time_scale_arr = PSD_BComp_time_scale_arr      


Step2:

PSD_Btotal_time_scale_arr = PSD_Bx_time_scale_arr + PSD_By_time_scale_arr + PSD_Bz_time_scale_arr
n = size(PSD_Btotal_time_scale_arr,/dimensions)
PSD = fltarr(n(1))
scale = fltarr(n(1))
for i_scale=0,n(1)-1 do begin
PSD(i_scale) = mean(PSD_Btotal_time_scale_arr(*,i_scale))
endfor

scale = 1./period_vect
y=-1.67*alog10(scale)-4.1
y2=-1.5*alog10(scale)-3.55
yrange=[min(alog10(PSD)),max(alog10(PSD))]
plot,alog10(scale),y,linestyle=2,Yrange=yrange, color = '0000FF'XL, thick = 3
plot,alog10(scale),y2,linestyle=2,Yrange=yrange,color = 'FF0000'XL, thick = 3, /noerase
plot,alog10(scale),alog10(PSD),xtitle='log(Frequency)',ytitle='log(PSD)',Yrange=yrange,thick = 3,/noerase

;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\others\'+sub_dir_date
file_fig  = 'PSD_frequency'+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd






End_Program:
End
  

