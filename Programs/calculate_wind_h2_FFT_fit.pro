;pro calculate_wind_h2_FFT_fit


device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

sub_dir_date  = '2006-05-21\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\start\'+sub_dir_date
file_restore= 'Bxyz_GSE_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp




dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\start\'+sub_dir_date
file_restore= 'wi_pm_3dp_20060521_v03.sav'
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
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect
;  P_TEMP_3s_vect

Vtotal = sqrt(Px_VEL_3s_vect^2.0+Py_VEL_3s_vect^2.0+Pz_VEL_3s_vect^2.0)
Vave = mean(Vtotal,/nan)

Btotal = sqrt(Bx_GSE_vect_interp^2.0+By_GSE_vect_interp^2.0+Bz_GSE_vect_interp^2.0)
Bave = mean(Btotal,/nan)





step2:
;------------
;nscale = 64L
;PSD_Bx_wavlet = fltarr(nscale)
;PSD_By_wavlet = fltarr(nscale)
;PSD_Bz_wavlet = fltarr(nscale)

;----------------
;;--
i_BComp = 0
for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = Bx_GSE_vect_interp
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = By_GSE_vect_interp
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = Bz_GSE_vect_interp
EndIf
wave_vect = BComp_RTN_vect

num_times = N_Elements(JulDay_vect_interp)
time_vect = (JulDay_vect_interp(0:num_times-1)-JulDay_vect_interp(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

;if zuopu eq 0 then begin
;;;
num_sets  = 1
type_window = 1

get_PSD_from_FFT_Method, time_vect, wave_vect, $
    num_sets=num_sets, type_window=type_window, $
    freq_vect_FFT, PSD_vect_FFT
    
    


dir_save = 'C:\Users\pzt\course\Research\CDF_wind\start\'+sub_dir_date
file_save = FileName_BComp+'_FFT_arr'+$
        '.sav'
data_descrip='got from "get_PSD_from_FFT_Ulysess.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  freq_vect_FFT, PSD_vect_FFT


If i_BComp eq 1 Then Begin
  PSD_Bx_FFt  = PSD_vect_FFT
EndIf
If i_BComp eq 2 Then Begin
  PSD_By_FFT  = PSD_vect_FFT
EndIf
If i_BComp eq 3 Then Begin
  PSD_Bz_FFT  = PSD_vect_FFT
EndIf




endfor

PSD_Bt_FFT = PSD_Bx_FFT+PSD_By_FFT+PSD_Bz_FFT


;step3:

;计算拟合范围,考虑相对论效应
;step3_1:


r_min = (3.2/9.1/9.0+1.0)*9.1*3*1.e2/Bave/1.6*sqrt(1.-1./(3.2/9.1/9.0+1.0)^2.0)
r_max = (32./9.1/9.0+1.0)*9.1*3*1.e2/Bave/1.6*sqrt(1.-1./(32./9.1/9.0+1.0)^2.0)


f_max = Vave/2/!pi/r_min
f_min = Vave/2/!pi/r_max



print,f_min,f_max

;step3_2:

PSD_Bt = PSD_Bt_FFT



xrange=[0.001,10.0]
yrange=[1.0e-5,1.0e4]    
window,1,title='PSD-frequency'    
Plot,freq_vect_FFT, PSD_Bt,xtitle='frequency(Hz)',ytitle='PSD(nT^2/HZ)',xrange=xrange,yrange=yrange,/XLOG,/YLOG    




image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\start\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'Btotal'+'_PSD_FFT'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd
    
 ;sm_PSD_vect_FFT = smooth(PSD_total_vect_FFT,11)
 sm_PSD_vect_FFT = lsmth(PSD_Bt,0.1)
 
 window,2,title='PSD-frequency after smooth'
 Plot,freq_vect_FFT, sm_PSD_vect_FFT,xtitle='frequency(Hz)',ytitle='PSD(nT^2/Hz)',xrange=xrange,yrange=yrange,/XLOG,/YLOG  

; x=[0.00002,0.00002]
; y=[1.0e-2,0.0631]
; plot,  x,y,/XLOG,/YLOG ,/noerase,xrange=xrange,yrange=yrange
 
m=0L
n=0L
while  freq_vect_FFT(n) le f_min do begin  ;拟合范围
  n=n+1
endwhile
while  freq_vect_FFT(m) le f_max do begin
  m=m+1
endwhile
result = linfit(alog10(freq_vect_FFT(n:(m-1))),alog10(sm_PSD_vect_FFT(n:(m-1))),sigma=sigma)
print,result 
x=freq_vect_FFT(n:(m-1))
y=10.^(result(0)+result(1)*alog10(x))
;window,2
plot,x,y,xrange=xrange,yrange=yrange,color='0000ff'XL,xstyle=4,ystyle=4,/XLOG,/YLOG,/noerase

xyouts,350,330,'k='+string(result(1))+textoIDL('\pm')+string(sigma(1)),charsize=0.8,charthick=1,/DEvice 
xyouts,350,300,'log(PSD_0)='+string(result(0))+textoIDL('\pm')+string(sigma(0)),charsize=0.8,charthick=1,/DEvice
xyouts,350,270,'Date:'+sub_dir_date,charsize=0.8,charthick=1,/DEvice
xyouts,300,240,'fitting frequecy range:'+string(f_min)+'-'+string(f_max)+'Hz',charsize=0.8,charthick=1,/DEvice 
 
image_tvrd = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\start\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'Btotal'+'_PSD_FFT_smooth'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd





end



