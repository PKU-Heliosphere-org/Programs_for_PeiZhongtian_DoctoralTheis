;pro plot_PSD_WIND_H2


sub_dir_date  = 'wind\Alfven1\'



Step1:
;===========================
;;;;;;;


;;--
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= 'Bt_StructFunct      2.00000_arr(time=20020524-20020524)(period=0.4-1000)(v3).sav'
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
;;  data_descrip, $
;;  JulDay_min, time_vect, period_vect, $
;;  Bt_StructFunct_arr, $
;;  Bt_StructFunct_vect, $
;;  Diff_Bt_arr, $
;;  num_times_vect
;period_vect_h2 = period_vect
;Bt_StructFunct_vect_h2 = Bt_StructFunct_vect
;
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= 'Bt_StructFunct      2.00000_arr(time=20020524-20020524)(period=6.0-1000)(v3)_h0.sav'
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
;;  data_descrip, $
;;  JulDay_min, time_vect, period_vect, $
;;  Bt_StructFunct_arr, $
;;  Bt_StructFunct_vect, $
;;  Diff_Bt_arr, $
;;  num_times_vect
;period_vect_h0 = period_vect
;Bt_StructFunct_vect_h0 = Bt_StructFunct_vect

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h2_mfi_20020524_v05.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h2_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

Bx_vect_h2 = Bx_GSE_vect_interp
By_vect_h2 = By_GSE_vect_interp
Bz_vect_h2 = Bz_GSE_vect_interp

time_vect = (JulDay_vect_interp - JulDay_vect_interp(0))*(24.*60*60)
dtime     = time_vect(1) - time_vect(0)
time_interval = Max(time_vect) - Min(time_vect)
period_min= dtime*3
period_max= dtime*10000;time_interval/7
period_range  = [period_min, period_max]
num_periods = 32L
num_times   = N_Elements(time_vect)

for i_fl =0,2 do begin
if i_fl eq 0 then wave_vect = Bx_vect_h2
if i_fl eq 1 then wave_vect = By_vect_h2
if i_fl eq 2 then wave_vect = Bz_vect_h2
get_Wavelet_Transform_of_BComp_vect_STEREO_v3, $
    time_vect, wave_vect, $    ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $
    Wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $
    period_vect=period_vect
dt_pix   = dtime
PixLag_vect = round((period_vect/dt_pix)/2)*2
period_vect = PixLag_vect*dt_pix
    
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
period_vect_h2 = period_vect

;;;;;;;;;;;;;;;;;;;;;;
time_vect_wavlet = time_vect
period_vect_wavlet = period_vect
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'LocalBG_of_MagField_for_AutoCorr(time=20020524-20020524)(period=  0.4- 1000).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  Bxyz_LBG_RTN_arr
;;;---
time_vect_LBG = time_vect
period_vect_LBG = period_vect

;;--
diff_time   = time_vect_wavlet(0)-time_vect_LBG(0)
diff_num_times  = N_Elements(time_vect_wavlet)-N_Elements(time_vect_LBG)
diff_period   = period_vect_wavlet(0)-period_vect_LBG(0)
diff_num_periods= N_Elements(period_vect_wavlet)-N_Elements(period_vect_LBG)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  diff_period ne 0.0 or diff_num_periods ne 0L Then Begin
  Print, 'wavlet and LBG has different time_vect and period_vect!!!'
  Stop
EndIf


Step2:
;===========================
;Step2:

;;--
Bt_LBG_RTN_arr  = Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr

;;--
Bpara_wavlet_arr  = wavlet_Bx_arr*dbx_LBG_RTN_arr + $
            wavlet_By_arr*dby_LBG_RTN_arr + $
            wavlet_Bz_arr*dbz_LBG_RTN_arr

;;--
dtime     = time_vect_wavlet(1)-time_vect_wavlet(0)
PSD_Bx_time_scale_arr = Abs(wavlet_Bx_arr)^2*dtime
PSD_By_time_scale_arr = Abs(wavlet_By_arr)^2*dtime
PSD_Bz_time_scale_arr = Abs(wavlet_Bz_arr)^2*dtime
PSD_Bt_time_scale_arr = PSD_Bx_time_scale_arr + PSD_By_time_scale_arr + PSD_Bz_time_scale_arr
;;;---
PSD_Bpara_time_scale_arr  = Abs(Bpara_wavlet_arr)^2*dtime
PSD_Bperp_time_scale_arr  = (PSD_Bt_time_scale_arr - PSD_Bpara_time_scale_arr) / 2

;;--
num_times = N_Elements(time_vect_wavlet)
num_periods = N_Elements(period_vect_wavlet)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi






step3:;计算四个拐点位置

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_20020524_v05.sav'
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
;    JulDay_vect, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp





;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_20020524_inB.sav'
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
;  JulDay_vect, Vxyz_GSE_p_arr, $
;  NumDens_p_vect, Temper_p_vect




;计算每个时间段平均的密度、速度、温度和磁场强度：
AbsB_vect_WholeMR = sqrt(Bx_GSE_vect_interp^2+By_GSE_vect_interp^2+Bz_GSE_vect_interp^2)
Vsw_vect_WholeMR = sqrt(Vxyz_GSE_p_arr(0,*)^2+Vxyz_GSE_p_arr(1,*)^2+Vxyz_GSE_p_arr(2,*)^2)

;sub_vect_reg_3DP = Where(JulDay_vect_pm_3DP_WholeMR ge JulDay_beg_reg and JulDay_vect_pm_3DP_WholeMR le JulDay_end_reg)
Np_aver_cm3  = Mean(NumDens_p_vect, /NaN)  ;unit: cm3
Tp_aver_MK   = Mean(Temper_p_vect, /NaN)*1.e4/1.e6  ;unit: MK
Vsw_aver_kmps= Mean(Vsw_vect_WholeMR, /NaN)
;sub_vect_reg_MFI = Where(JulDay_vect_MFI_WholeMRgeJulDay_beg_reg and JulDay_vect_MFI_WholeMR le JulDay_end_reg)
AbsB_aver_nT = Mean(AbsB_vect_WholeMR, /NaN)  ;unit: nT

;计算四个频率的位置，所用到的主要核心程序：
get_freqs_compare_with_PowerSpectralBreak, Np_aver_cm3, Vsw_aver_kmps, Tp_aver_MK, AbsB_aver_nT, $
freq_gyrofreq, freq_gyroradius, freq_skindepth, freq_cyclres, $
VA_kmps=VA_kmps, Vth_p_kmps=Vth_p_kmps, ion_gyroradius=ion_gyroradius, ion_SkinDepth=ion_SkinDepth, beta=beta

Np_aver_vect_regs = Np_aver_cm3
Tp_aver_vect_regs = Tp_aver_MK
Vsw_aver_vect_regs=Vsw_aver_kmps
AbsB_aver_vect_regs = AbsB_aver_nT
freq_gyrofreq_vect_regs   = freq_gyrofreq
freq_gyroradius_vect_regs = freq_gyroradius
freq_skindepth_vect_regs  = freq_skindepth
freq_cyclres_vect_regs    = freq_cyclres






;;--
read,'png(1) or eps(2)',is_png_eps

If is_png_eps eq 2 Then Begin
Set_Plot,'PS'
file_version  = '(v1)'
file_fig= 'Figure7'+$
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

fre_vect_h2 = 1./period_vect_h2
sub_inertial = where(fre_vect_h2 le freq_gyrofreq)  ;大于离子回旋尺度的作为惯性区拟合
sub_dissipation = where(fre_vect_h2 gt freq_gyrofreq and fre_vect_h2 le 1.5)  ;小于离子回旋尺度大于1Hz的作为惯性区拟合
sub_zao = where(fre_vect_h2 gt 1.5)  ;小于离子回旋尺度大于1Hz的作为惯性区拟合
;PSD_B_h2 = Bt_StructFunct_vect_h2*period_vect_h2
;PSD_B_h0 = Bt_StructFunct_vect_h0*period_vect_h0
PSD_B_arr_h2 = PSD_Bx_arr + PSD_Bz_arr + PSD_Bz_arr
PSD_ratio_para_trace = PSD_Bpara_time_scale_arr/PSD_B_arr_h2

PSD_B_h2 = fltarr(num_periods)
PSD_ratio = fltarr(num_periods)
for i_per =0,num_periods-1 do begin
PSD_B_h2(i_per) = mean(PSD_B_arr_h2(*,i_per),/nan)
PSD_ratio(i_per) = mean(PSD_ratio_para_trace(*,i_per),/nan)
endfor
;fre_vect_h0 = 1./period_vect_h0
result_B_inertial = linfit(alog10(fre_vect_h2(sub_inertial)),alog10(PSD_B_h2(sub_inertial)),sigma=sigma_B_1)
result_B_dissipation = linfit(alog10(fre_vect_h2(sub_dissipation)),alog10(PSD_B_h2(sub_dissipation)),sigma=sigma_B_2)
result_B_zao = linfit(alog10(fre_vect_h2(sub_zao)),alog10(PSD_B_h2(sub_zao)),sigma=sigma_B_3)
yrange = [10.^(-5),10.^4]
plot,fre_vect_h2,PSD_B_h2,color = color_black,xrange=[0.0005,10],yrange=yrange,position = position_SubImg,/xlog,/ylog,/noerase,  $
  xtitle = 'Frequency(Hz)',ytitle = textoidl('PSD(nT^2/Hz)'),xstyle=1,ystyle=1,thick=2,charthick=2,charsize=1.5
axis,yaxis=1,yrange = yrange,ytitle = textoidl('PSD_{||}')+'/'+textoidl('PSD_{trace}'),charsize=1.5,charthick=2,color = color_blue,ystyle=1
oplot,fre_vect_h2,PSD_ratio,color = color_blue,thick=2

y_B_ine = result_B_inertial(0)+result_B_inertial(1)*alog10(fre_vect_h2(sub_inertial))
oplot,fre_vect_h2(sub_inertial),10^y_B_ine,linestyle=2,color = color_red,thick=2
xyouts,0.1,30,TexToIDL('Slope_{MHD}')+'='+string(result_B_inertial(1),format='(F5.2)'),color = color_red,charthick=2,charsize=1.5

y_B_dis = result_B_dissipation(0)+result_B_dissipation(1)*alog10(fre_vect_h2(sub_dissipation))
oplot,fre_vect_h2(sub_dissipation),10^y_B_dis,linestyle=2,color = color_red,thick=2
xyouts,0.1,10,TexToIDL('Slope_{ion-scale}')+'='+string(result_B_dissipation(1),format='(F5.2)'),color = color_red,charthick=2,charsize=1.5

;y_B_zao = result_B_zao(0)+result_B_zao(1)*alog10(fre_vect_h2(sub_zao))
;oplot,fre_vect_h2(sub_zao),10^y_B_zao,linestyle=2,color = color_red,thick=2
;xyouts,0.1,3,TexToIDL('Slope_{highfre}')+'='+string(result_B_zao(1),format='(F5.2)'),color = color_red,charthick=2,charsize=1.5

;;;写图例
;oplot,[0.0002,0.0004],[2.e-2,2.e-2],color = color_black,thick=2
;;oplot,[0.0002,0.0004],[1.e-2,1.e-2],color = color_blue
;xyouts,0.0006,2.e-2,'B_PSD_h2',color = color_black,charthick=2,charsize=1.5
;;xyouts,0.0006,1.e-2,'B_PSD_h0',color = color_blue


;在不同时间段的功率谱上标出四个频率的位置：
;For i_reg=0,num_regions-1 Do Begin

PSD_vect = PSD_B_h2 & color_psym=color_black



freq_gyrofreq   = freq_gyrofreq_vect_regs
freq_gyroradius = freq_gyroradius_vect_regs
freq_skindepth  =freq_skindepth_vect_regs
freq_cyclres    = freq_cyclres_vect_regs 
val_tmp = Min(Abs(Alog10(fre_vect_h2)-Alog10(freq_gyrofreq)), sub_tmp)
PSD_at_gyrofreq = PSD_vect(sub_tmp)
val_tmp = Min(Abs(Alog10(fre_vect_h2)-Alog10(freq_gyroradius)), sub_tmp)
PSD_at_gyroradius = PSD_vect(sub_tmp)
val_tmp = Min(Abs(Alog10(fre_vect_h2)-Alog10(freq_skindepth)), sub_tmp)
PSD_at_skindepth = PSD_vect(sub_tmp)
val_tmp = Min(Abs(Alog10(fre_vect_h2)-Alog10(freq_cyclres)), sub_tmp)
PSD_at_cyclres = PSD_vect(sub_tmp)

PSym_gyrofreq=0 & Psym_gyroradius=4 & Psym_skindepth=5 & Psym_cyclres=3
psize = 1
color_psym = color_black
  PLOTSYM, Psym_gyrofreq, PSIZE, FILL=1, THICK=1, COLOR=color_psym
  Plots, freq_gyrofreq, PSD_at_gyrofreq, Psym=8
  PLOTSYM, Psym_gyroradius, PSIZE, FILL=1, THICK=1, COLOR=color_psym
  Plots, freq_gyroradius, PSD_at_gyroradius, Psym=8
  PLOTSYM, Psym_skindepth, PSIZE, FILL=1, THICK=1, COLOR=color_psym
  Plots, freq_skindepth, PSD_at_skindepth, Psym=8
  PLOTSYM, Psym_cyclres, PSIZE, FILL=1, THICK=1, COLOR=color_psym
  Plots, freq_cyclres, PSD_at_cyclres, Psym=8

;EndFor
charthick=2
charsize=1.5
xrange=[0.0005,10]
yrange = [1.e-4,1.e4]
color_psym= color_black
lg_xrange = Alog10(xrange)
xplot_pos = 10.^(lg_xrange(0)+0.45*(lg_xrange(1)-lg_xrange(0)))
lg_yrange = Alog10(yrange)
yplot_pos = 10.^(lg_yrange(0)+0.95*(lg_yrange(1)-lg_yrange(0)))
PLOTSYM, Psym_gyrofreq, PSIZE, FILL=1, THICK=1, COLOR=color_psym
Plots, xplot_pos, yplot_pos, Psym=8
XYOuts_str = TexToIDL('\Omega_i/(2\pi)')
XYOuts, xplot_pos*1.5, yplot_pos, XYOuts_str, Color=color_psym, Charsize=charsize, CharThick=charThick, /Data

dypos = 0.05
yplot_pos = 10.^(lg_yrange(0)+(0.95-dypos)*(lg_yrange(1)-lg_yrange(0)))
PLOTSYM, Psym_gyroradius, PSIZE, FILL=1, THICK=1, COLOR=color_psym
Plots, xplot_pos, yplot_pos, Psym=8
XYOuts_str = TexToIDL('V_{sw}/(\rho_i)/(2\pi)')
XYOuts, xplot_pos*1.5, yplot_pos, XYOuts_str, Color=color_psym, Charsize=charsize, CharThick=charThick, /Data

yplot_pos = 10.^(lg_yrange(0)+(0.95-2*dypos)*(lg_yrange(1)-lg_yrange(0)))
PLOTSYM, Psym_skindepth, PSIZE, FILL=1, THICK=1, COLOR=color_psym
Plots, xplot_pos, yplot_pos, Psym=8
XYOuts_str = TexToIDL('V_{sw}/(d_i)/(2\pi)')
XYOuts, xplot_pos*1.5, yplot_pos, XYOuts_str, Color=color_psym, Charsize=charsize, CharThick=charThick, /Data

yplot_pos = 10.^(lg_yrange(0)+(0.95-3*dypos)*(lg_yrange(1)-lg_yrange(0)))
PLOTSYM, Psym_cyclres, PSIZE, FILL=1, THICK=1, COLOR=color_psym
Plots, xplot_pos, yplot_pos, Psym=8
XYOuts_str = TexToIDL('V_{sw}/(2\pi)\cdot\Omega_i/(V_A+V_{th})')
XYOuts, xplot_pos*1.5, yplot_pos, XYOuts_str, Color=color_psym, Charsize=charsize, CharThick=charThick, /Data



If is_png_eps eq 1 Then Begin
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'PSD_B_h2_4_turning_points_ratio.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif
If is_png_eps eq 2 Then Begin
Device,/Close 
endif




end










