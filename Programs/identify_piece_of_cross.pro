;pro Identify_piece_of_cross


device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


date = '20080406-08'
sub_dir_date  = 'wind\fast\'+date+'\'



step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_restore= 'Correlation_'+'_of_'+'Vx&Bx'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_crosscorrelation_of_v_b_select_5min.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  wave_coher, wave_phase,period_vect , time_vect_wavlet
wave_coher_x = wave_coher
wave_phase_x = abs(wave_phase)

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_restore= 'Correlation_'+'_of_'+'Vy&By'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_crosscorrelation_of_v_b_select_5min.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  wave_coher, wave_phase,period_vect , time_vect_wavlet
wave_coher_y = wave_coher
wave_phase_y = abs(wave_phase)


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_restore= 'Correlation_'+'_of_'+'Vz&Bz'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_crosscorrelation_of_v_b_select_5min.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  wave_coher, wave_phase,period_vect , time_vect_wavlet
wave_coher_z = wave_coher
wave_phase_z = abs(wave_phase)


step2:

ntime = n_elements(time_vect_wavlet)
nbin = round(time_vect_wavlet(ntime-1)/(60.*5.))
subbin = 100L
count = 0
binuse = fltarr(nbin)
for i_bin = 0,nbin-1 do begin
  mean_coher_x = mean(wave_coher_x(i_bin*subbin:((i_bin+1)*subbin-1),4),/nan)
  mean_phase_x = mean(wave_phase_x(i_bin*subbin:((i_bin+1)*subbin-1),4),/nan)
  mean_fuhao_x = (mean_phase_x-90.)/abs(mean_phase_x-90.)  
  mean_coher_y = mean(wave_coher_y(i_bin*subbin:((i_bin+1)*subbin-1),4),/nan)
  mean_phase_y = mean(wave_phase_y(i_bin*subbin:((i_bin+1)*subbin-1),4),/nan) 
  mean_fuhao_y = (mean_phase_y-90.)/abs(mean_phase_y-90.)   
  mean_coher_z = mean(wave_coher_z(i_bin*subbin:((i_bin+1)*subbin-1),4),/nan)
  mean_phase_z = mean(wave_phase_z(i_bin*subbin:((i_bin+1)*subbin-1),4),/nan)
  mean_fuhao_z = (mean_phase_z-90.)/abs(mean_phase_z-90.)   
  if  mean_coher_x gt 0.5 and mean_coher_y gt 0.5 and mean_coher_z gt 0.5 then begin
     if (mean_fuhao_x eq -1 and mean_fuhao_y eq -1 and mean_fuhao_z eq 1) or  $
        (mean_fuhao_x eq -1 and mean_fuhao_y eq 1 and mean_fuhao_z eq -1) or  $
        (mean_fuhao_x eq 1 and mean_fuhao_y eq -1 and mean_fuhao_z eq -1) or  $        
        (mean_fuhao_x eq 1 and mean_fuhao_y eq 1 and mean_fuhao_z eq -1) or  $
        (mean_fuhao_x eq 1 and mean_fuhao_y eq -1 and mean_fuhao_z eq 1) or  $
        (mean_fuhao_x eq -1 and mean_fuhao_y eq 1 and mean_fuhao_z eq 1) then begin       
        count = count+1
        binuse(i_bin) = 1
      endif
   endif
endfor

sub_use = where(binuse eq 1) 
        
print,sub_use        
        
step3:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_h0_mfi_'+date+'_v05.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR

BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR
Bx_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(0,*))
By_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(1,*))
Bz_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(2,*))
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_inB.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
;  P_TEMP_3s_vect

nuse = n_elements(sub_use)
for i_use =0,nuse-1 do begin

window,1,xsize=1200,ysize=900


ytitle='B(nT)'


JulDay_use = JulDay_2s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))



xrange  = [JulDay_2s_vect(sub_use(i_use)*subbin), JulDay_2s_vect((sub_use(i_use)+1)*subbin-1)]
yrange  = [-2.0, 2.0]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.08,0.69,0.5,0.99],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  Font=-1,CharThick=1.0,Thick=1.0


Bx = Bx_GSE_2s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))
Bx_mean = mean(Bx,/nan)
plot,JulDay_use,Bx-Bx_mean,position=[0.08,0.69,0.5,0.99],thick=2,yrange=yrange,XStyle=4, YStyle=4,/NoErase
xyouts,150,850,'Bx-Bx0',charsize=1.2,charthick=2,/DEvice




Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.08,0.36,0.5,0.66],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /noerase,Font=-1,CharThick=1.0,Thick=1.0

By = By_GSE_2s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))
By_mean = mean(By,/nan)
plot,JulDay_use,By-By_mean,position=[0.08,0.36,0.5,0.66],thick=2,yrange=yrange,XStyle=4, YStyle=4,/NoErase
xyouts,150,550,'By-By0',charsize=1.2,charthick=2,/DEvice



Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.08,0.03,0.5,0.33],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /noerase,Font=-1,CharThick=1.0,Thick=1.0

Bz = Bz_GSE_2s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))
Bz_mean = mean(Bz,/nan)
plot,JulDay_use,Bz-Bz_mean,position=[0.08,0.03,0.5,0.33],thick=2,yrange=yrange,XStyle=4, YStyle=4,/NoErase
xyouts,150,250,'Bz-Bz0',charsize=1.2,charthick=2,/DEvice

;;;
;
ytitle='V(km/s)'


yrange=[-20.0,20.0]


Vx = Px_VEL_3s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))
Vx_mean = mean(Vx,/nan)
plot,JulDay_use,Vx-Vx_mean,position=[0.08,0.69,0.5,0.99],thick=2,yrange=yrange,XStyle=4, YStyle=4,color='ff0000'XL,/NoErase
axis,yaxis=1,yrange=yrange,color='ff0000'XL,ytitle=ytitle
xyouts,250,850,'Vx-Vx0',charsize=1.2,charthick=2,color='ff0000'XL,/DEvice






Vy = Py_VEL_3s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))
Vy_mean = mean(Vy,/nan)
plot,JulDay_use,Vy-Vy_mean,position=[0.08,0.36,0.5,0.66],thick=2,yrange=yrange,XStyle=4, YStyle=4,color='ff0000'XL,/NoErase
axis,yaxis=1,yrange=yrange,color='ff0000'XL,ytitle=ytitle
xyouts,250,550,'Vy-Vy0',charsize=1.2,charthick=2,color='ff0000'XL,/DEvice




Vz = Pz_VEL_3s_vect(sub_use(i_use)*subbin:((sub_use(i_use)+1)*subbin-1))
Vz_mean = mean(Vz,/nan)
plot,JulDay_use,Vz-Vz_mean,position=[0.08,0.03,0.5,0.33],thick=2,yrange=yrange,XStyle=4, YStyle=4,color='ff0000'XL,/NoErase
axis,yaxis=1,yrange=yrange,color='ff0000'XL,ytitle=ytitle
xyouts,250,250,'Vz-Vz0',charsize=1.2,charthick=2,color='ff0000'XL,/DEvice


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'cross\'
file_fig  = '5min_piece_'+$
        string(i_use)+'th_'+string(period_vect(4))+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

     
endfor        

end
