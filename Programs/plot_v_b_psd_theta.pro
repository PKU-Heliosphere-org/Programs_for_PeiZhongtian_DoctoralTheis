;pro plot_V_B_PSD_theta

sub_dir_date  = 'wind\Alfven1\'



Step1:
;===========================
;;;;;;;

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_20020524_inV.sav'
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
;    JulDay_vect, VBA_X, VBA_y, VBA_z

time_vect = (JulDay_vect - JulDay_vect(0))*(24.*60*60)
dtime     = time_vect(1) - time_vect(0)
time_interval = Max(time_vect) - Min(time_vect)
period_min= 7.;dtime*3
period_max= 7500.;dtime*10000;time_interval/7
period_range  = [period_min, period_max]
num_periods = 32L
num_times   = N_Elements(time_vect)

for i_fl =0,2 do begin
if i_fl eq 0 then wave_vect = VBa_x
if i_fl eq 1 then wave_vect = VBa_y
if i_fl eq 2 then wave_vect = VBa_z
get_Wavelet_Transform_of_BComp_vect_STEREO_v3, $
    time_vect, wave_vect, $    ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $
    Wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $
    period_vect=period_vect
PSD_arr  = Abs(wavlet_arr)^2 * dtime   
If i_fl eq 0 Then Begin
  wavlet_Bx_arr=wavlet_arr & PSD_Bx_arr=PSD_arr
EndIf   
If i_fl eq 1 Then Begin
  wavlet_By_arr=wavlet_arr & PSD_By_arr=PSD_arr
EndIf  
If i_fl eq 2 Then Begin
  wavlet_Bz_arr=wavlet_arr & PSD_Bz_arr=PSD_arr
EndIf  
endfor
PSD_B_arr = PSD_Bx_arr + PSD_Bz_arr + PSD_Bz_arr
PSD_B = fltarr(num_periods)
for i_per =0,num_periods-1 do begin
PSD_B(i_per) = mean(PSD_B_arr(*,i_per),/nan)
endfor


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_20020524_v03.sav'
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
;  JulDay_vect, VX_GSE_VECT,Vy_GSE_VECT,Vz_GSE_VECT $
;  NumDens_p_vect, Temper_p_vect

time_vect = (JulDay_vect - JulDay_vect(0))*(24.*60*60)
dtime     = time_vect(1) - time_vect(0)
time_interval = Max(time_vect) - Min(time_vect)
period_min= 7.;dtime*3
period_max= 7500.;dtime*10000;time_interval/7
period_range  = [period_min, period_max]
num_periods = 32L
num_times   = N_Elements(time_vect)

VX_GSE_VECT = reform(VX_GSE_VECT,num_times)
Vy_GSE_VECT = reform(Vy_GSE_VECT,num_times)
Vz_GSE_VECT = reform(Vz_GSE_VECT,num_times)
for i_fl =0,2 do begin
if i_fl eq 0 then wave_vect = VX_GSE_VECT
if i_fl eq 1 then wave_vect = Vy_GSE_VECT
if i_fl eq 2 then wave_vect = Vz_GSE_VECT
get_Wavelet_Transform_of_BComp_vect_STEREO_v3, $
    time_vect, wave_vect, $    ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $
    Wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $
    period_vect=period_vect
PSD_arr  = Abs(wavlet_arr)^2 * dtime   
If i_fl eq 0 Then Begin
  wavlet_Vx_arr=wavlet_arr & PSD_Vx_arr=PSD_arr
EndIf   
If i_fl eq 1 Then Begin
  wavlet_Vy_arr=wavlet_arr & PSD_Vy_arr=PSD_arr
EndIf  
If i_fl eq 2 Then Begin
  wavlet_Vz_arr=wavlet_arr & PSD_Vz_arr=PSD_arr
EndIf  
endfor
PSD_V_arr = PSD_Vx_arr + PSD_Vz_arr + PSD_Vz_arr
PSD_V = fltarr(num_periods)
for i_per =0,num_periods-1 do begin
PSD_V(i_per) = mean(PSD_V_arr(*,i_per),/nan)
endfor


;;;--
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= 'StructFunct_theta_B_and_V_period_arr(time=*-*)(period=*-*).sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;;Save, FileName=dir_save+file_save, $
;; data_descrip, $
;;  theta_bin_min_vect, theta_bin_max_vect, $
;;  period_vect, Btot_SF_2_arr, Btot_SF_4_arr, Vtot_SF_2_arr, Vtot_SF_4_arr, $
;;  SF_Bt_2_theta_arr, SF_Bt_4_theta_arr, SF_Vt_2_theta_arr, SF_Vt_4_theta_arr, $
;;  DataNum_theta_arr



step2:


;;--
read,'png(1) or eps(2)',is_png_eps

If is_png_eps eq 2 Then Begin
Set_Plot,'PS'
file_version  = '(v1)'
file_fig= 'Figure6'+$
        file_version+$
        '.eps'
xsize = 23.0
ysize = 24.0
Device, FileName=dir_restore+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
EndIf 
If is_png_eps eq 1 Then Begin

Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=800.0 & ysize=800.0
    Window,1,XSize=xsize,YSize=ysize,Retain=2
endif

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


;;;--
If is_png_eps eq 1 Then Begin
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
endif
;;--


;
;num_periods = n_elements(period_vect)
;PSD_B_0 = fltarr(num_periods)
;PSD_B_90 = fltarr(num_periods)
;PSD_V_0 = fltarr(num_periods)
;PSD_V_90 = fltarr(num_periods)
;
;;for i_period = 0,num_periods-1 do begin
;;  SF_Bt_2_theta_vect(i_period) = mean(SF_Bt_2_theta_arr(*,i_period),/nan)
;;  SF_Vt_2_theta_vect(i_period) = mean(SF_Vt_2_theta_arr(*,i_period),/nan)
;;endfor
;for i_period = 0,num_periods-1 do begin
;PSD_B_0(i_period) = (total(SF_Bt_2_theta_arr(0:2,i_period)*DataNum_theta_arr(0:2,i_period),/nan)+total(SF_Bt_2_theta_arr(87:89,i_period)*DataNum_theta_arr(87:89,i_period),/nan))/(total(DataNum_theta_arr(0:2,i_period),/nan)+total(DataNum_theta_arr(87:89,i_period),/nan))*period_vect(i_period)
;PSD_B_90(i_period) = total(SF_Bt_2_theta_arr(42:47,i_period)*DataNum_theta_arr(42:47,i_period),/nan)/total(DataNum_theta_arr(42:47,i_period),/nan)*period_vect(i_period)
;PSD_V_0(i_period) = (total(SF_Vt_2_theta_arr(0:2,i_period)*DataNum_theta_arr(0:2,i_period),/nan)+total(SF_Vt_2_theta_arr(87:89,i_period)*DataNum_theta_arr(87:89,i_period),/nan))/(total(DataNum_theta_arr(0:2,i_period),/nan)+total(DataNum_theta_arr(87:89,i_period),/nan))*period_vect(i_period)
;PSD_V_90(i_period) = total(SF_Vt_2_theta_arr(42:47,i_period)*DataNum_theta_arr(42:47,i_period),/nan)/total(DataNum_theta_arr(42:47,i_period),/nan)*period_vect(i_period)
;endfor
;
;Set_Plot, 'win'
;    Device,DeComposed=0;, /Retain
;    xsize=800.0 & ysize=800.0
;    Window,2,XSize=xsize,YSize=ysize,Retain=2
;;;--
;    LoadCT,13
;    TVLCT,R,G,B,/Get
;    color_red = 255L
;    TVLCT,255L,0L,0L,color_red
;    color_green = 254L
;    TVLCT,0L,255L,0L,color_green
;    color_blue  = 253L
;    TVLCT,0L,0L,255L,color_blue
;    color_white = 252L
;    TVLCT,255L,255L,255L,color_white
;    color_black = 251L
;    TVLCT,0L,0L,0L,color_black
;    color_gray = 250L
;    TVLCT,127L,127L,127L,color_gray
;    num_CB_color= 256-6
;    R=Congrid(R,num_CB_color)
;    G=Congrid(G,num_CB_color)
;    B=Congrid(B,num_CB_color)
;    TVLCT,R,G,B
;    
;    ;;--
;    color_bg    = color_white
;    !p.background = color_bg
;    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 
;
;position_img  = [0.10,0.15,0.90,0.98]
;num_x_SubImgs = 1
;num_y_SubImgs = 1
;dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
;dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;
;    i_x_SubImg  = 0
;    i_y_SubImg  = 0
;
;position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
;           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]
;
;plot,1./period_vect,PSD_B_0,color = color_black,xrange=[1./3000,1./10],yrange=[1.e3,1.e7],position = position_SubImg,/xlog,/ylog,/noerase
;oplot,1./period_vect,PSD_B_90,color = color_blue
;oplot,1./period_vect,PSD_V_0,color = color_green
;oplot,1./period_vect,PSD_V_90,color = color_red
;;;;xie tu li
;oplot,[0.0002,0.0004],[2.e4,2.e4],color = color_black
;oplot,[0.0002,0.0004],[14.e3,14.e3],color = color_blue
;oplot,[0.0002,0.0004],[97.e2,97.e2],color = color_green
;oplot,[0.0002,0.0004],[7.e3,7.e3],color = color_red
;xyouts,0.0006,2.e4,'Bpara',color = color_black
;xyouts,0.0006,14.e3,'Bperp',color = color_blue
;xyouts,0.0006,97.e2,'Vpara',color = color_green
;xyouts,0.0006,7.e3,'Vperp',color = color_red
;
;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_fig  = 'PSD_B_V_perp_para.png'
;Write_PNG, dir_fig+file_fig, image_tvrd


step3:
;num_periods = n_elements(period_vect)
;PSD_B = fltarr(num_periods)
;
;PSD_V = fltarr(num_periods)
;
;
;;for i_period = 0,num_periods-1 do begin
;;  SF_Bt_2_theta_vect(i_period) = mean(SF_Bt_2_theta_arr(*,i_period),/nan)
;;  SF_Vt_2_theta_vect(i_period) = mean(SF_Vt_2_theta_arr(*,i_period),/nan)
;;endfor
;for i_period = 0,num_periods-1 do begin
;PSD_B(i_period) = mean(Btot_SF_2_arr(*,i_period),/nan)*period_vect(i_period)
;PSD_V(i_period) = mean(Vtot_SF_2_arr(*,i_period),/nan)*period_vect(i_period)
;endfor




position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

    i_x_SubImg  = 0
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]
fre_vect = 1./period_vect
result_B = linfit(alog10(fre_vect),alog10(PSD_B),sigma=sigma_B)
result_V = linfit(alog10(fre_vect),alog10(PSD_V),sigma=sigma_v)
plot,1./period_vect,PSD_B,color = color_black,xrange=[1./8000,1./3],yrange=[1.e2,1.e8], $
  position = position_SubImg,/xlog,/ylog,/noerase,xtitle = 'Frequency(Hz)',ytitle = textoidl('PSD((km/s)^2/Hz)'), $
  thick=2,charthick=2,charsize=1.5,xstyle=1,ystyle=1
oplot,1./period_vect,PSD_V,color = color_red,thick=2
y_B = result_B(0)+result_B(1)*alog10(fre_vect)
y_V = result_V(0)+result_V(1)*alog10(fre_vect)
;oplot,1./period_vect,10^y_B,linestyle=2,color = color_black,thick=2
;oplot,1./period_vect,10^y_V,linestyle=2,color = color_red,thick=2
;xyouts,0.01,3.e7,TexToIDL('Slope_{B}')+'='+string(result_B(1),format='(F5.2)'),color = color_black,charthick=2,charsize=1.5
;xyouts,0.01,1.e7,TexToIDL('Slope_{V}')+'='+string(result_V(1),format='(F5.2)'),color = color_red,charthick=2,charsize=1.5
;;;写图例
oplot,[0.0002,0.0004],[2.e3,2.e3],color = color_black,thick=2
oplot,[0.0002,0.0004],[7.e2,7.e2],color = color_red,thick=2
xyouts,0.0005,2.e3,textoidl('PSD(\deltaB/(\mu_{0}\rho)^{1/2})'),color = color_black,charthick=2,charsize=1.5
xyouts,0.0005,7.e2,textoidl('PSD(\deltaV)'),color = color_red,charthick=2,charsize=1.5




If is_png_eps eq 1 Then Begin
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'PSD_B_V.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif
If is_png_eps eq 2 Then Begin
Device,/Close 
endif



end