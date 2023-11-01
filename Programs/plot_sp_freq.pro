;pro plot_sp_freq
;


sub_dir_date  = 'new\19950720-29-1\'


;read,'get 180(1) or 90(2):',is_fold
;if is_fold eq 1 then begin
;theta_str = '180'
;endif 
;if is_fold eq 2 then begin
;thata_str = '90'
;endif 
file_version = '(v3)'


Step1:
;===========================
;Step1:
n_jie = 14;;;
jie = (findgen(n_jie)+1)/2.0
slope = fltarr(45,n_jie);num_theta_bins_plot=46
num_theta_bins_plot = 45
sigmaslope = fltarr(n_jie,num_theta_bins_plot)

for i_jie = 0,n_jie-1 do begin

jieshu = jie(i_jie)
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct'+string(jieshu)+'_Bperp_Bpara_theta_period_arr'+$
       '(time=*-*)'+$
       '(period=*-*)'+ $
        '_recon.sav'
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
;  theta_bin_min_vect, theta_bin_max_vect, $
;  period_vect, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr


Step2:
;===========================
;Step2:

;;--
freq_vect_plot  = Reverse(1./period_vect)
PSD_BComp_arr_plot  = Reverse(StructFunct_Bt_theta_scale_arr,2)
LgPSD_BComp_arr_plot= ALog10(PSD_BComp_arr_plot)

;;--
num_theta_bins  = N_Elements(theta_bin_min_vect)
;theta_min_plot  = 0.0
;theta_max_plot  = 95.0
;sub_theta_bin_vect  = Where(theta_bin_min_vect ge theta_min_plot and $
;              theta_bin_max_vect le theta_max_plot)
;i_theta_min_plot  = Min(sub_theta_bin_vect)
;i_theta_max_plot  = Max(sub_theta_bin_vect)
;i_theta_incre_plot  = 2
;theta_bin_min_vect_plot = theta_bin_min_vect(i_theta_min_plot:i_theta_max_plot:i_theta_incre_plot)
;theta_bin_max_vect_plot = theta_bin_max_vect(i_theta_min_plot:i_theta_max_plot:i_theta_incre_plot)
;theta_bin_cen_vect_plot = 0.5*(theta_bin_min_vect_plot+theta_bin_max_vect_plot)
theta_bin_cen_vect_plot = findgen(45)*2.0+1.0
;LgPSD_BComp_arr_plot  = LgPSD_BComp_arr_plot(0:44,*)
;num_theta_bins_plot = 45

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 1200.0
Window,1,XSize=xsize,YSize=ysize

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

;;--
position_img  = [0.10,0.15,0.90,0.95]
freq_min_plot = Min(freq_vect_plot)
freq_max_plot = Max(freq_vect_plot)
xrange  = [ALog10(freq_min_plot)-0.1*(ALog10(freq_max_plot)-ALog10(freq_min_plot)),$
      ALog10(freq_max_plot)+0.1*(ALog10(freq_max_plot)-ALog10(freq_min_plot))]
LgPSD_min_tmp = Min(LgPSD_BComp_arr_plot,/NaN)
LgPSD_max_tmp = Max(LgPSD_BComp_arr_plot,/NaN)
dlgPSD_offset_plot  = 0.1*(LgPSD_max_tmp-LgPSD_min_tmp)
LgPSD_max_tmp = LgPSD_max_tmp + dLgPSD_offset_plot*(num_theta_bins_plot-1)
yrange  = [LgPSD_min_tmp-0.1*(LgPSD_max_tmp-LgPSD_min_tmp),$
      LgPSD_max_tmp+0.05*(LgPSD_max_tmp-LgPSD_min_tmp)]
xtitle  = 'lg(freq) [Hz]'
ytitle  = 'lg(structure)'
title = 'lg(structure) at various theta'
Plot, 10^xrange, 10^yrange, XRange=10^xrange,YRange=10^yrange,XStyle=1,YStyle=1, $
  XLog=1,YLog=1,XTitle=xtitle,YTitle=ytitle,Title=title, $
  /NoErase,/NoData,Position=position_img, Color=color_black

;;--
For i_theta=0,num_theta_bins_plot-1 Do Begin
  LgPSD_vect_tmp  = Reform(LgPSD_BComp_arr_plot(i_theta,*))
  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_theta)
  PlotSym, 0, 1.0, FILL=1,thick=1.5,Color=color_black
  Plots, freq_vect_plot, 10^LgPSD_vect_plot_tmp, PSym=8
  Plots, freq_vect_plot, 10^LgPSD_vect_plot_tmp, LineStyle=1, Thick=1.5, Color=color_black
EndFor

;;--
;Print, 'set freq_low in seg for fit: '
;Cursor, x_cursor, y_cursor, /Up, /Data
;freq_low  = x_cursor
;Print, 'set freq_high in seg for fit: '
;Cursor, x_cursor, y_cursor, /Up, /Data
;freq_high = x_cursor
freq_low = 0.005;freq_min_plot;0.01
freq_high = 0.05;freq_max_plot;1.0/7.0
sub_freq_in_seg = Where(freq_vect_plot ge freq_low and freq_vect_plot le freq_high)
slope_vect_plot = Fltarr(num_theta_bins_plot)
SigmaSlope_vect_plot  = Fltarr(num_theta_bins_plot)
num_points_LinFit   = N_Elements(sub_freq_in_seg)
For i_theta=0,num_theta_bins_plot-1 Do Begin
  LgPSD_vect_tmp  = Reform(LgPSD_BComp_arr_plot(i_theta,*))
  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_theta)
  fit_para    = LinFit(ALog10(freq_vect_plot(sub_freq_in_seg)),LgPSD_vect_plot_tmp(sub_freq_in_seg),$
              sigma=sigma_FitPara)
  slope_vect_plot(i_theta)    = fit_para(1)
  SigmaSlope_vect_plot(i_theta) = sigma_FitPara(1)
  LgPSD_at_LowFreq  = fit_para(0)+fit_para(1)*ALog10(freq_low)
  LgPSD_at_HighFreq = fit_para(0)+fit_para(1)*ALog10(freq_high)
  Plots, [freq_low,freq_high],10.^[LgPSD_at_LowFreq,LgPSD_at_HighFreq], Color=color_red,LineStyle=2,Thick=1.5
EndFor

;;--
theta_bin_cen_vect_plot_str = String(theta_bin_cen_vect_plot, Format='(F4.1)')
slope_vect_plot_str = String(slope_vect_plot, Format='(F4.2)')

;;--
AnnotStr_tmp  = 'got from "Plot_sp_freq.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'struct'+string(jieshu)+'_of_'+'Bt'+'_at_VariousTheta'+ $
 ;       TimeRange_str+$
        file_version+$
        '_recon.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


Step3:
;===========================
;Step3:
sigmaslope(i_jie,*) = SigmaSlope_vect_plot
;;--
ConfidenceLevel = 95./100
DegreeFreedom = num_points_LinFit-2
get_ConfidenceInterval_for_T_Test, DegreeFreedom, ConfidenceLevel, $
    ConfidenceInterval
;;;---
err_slope_vect_plot = SigmaSlope_vect_plot*(0.5*ConfidenceInterval)

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 800.0
ysize = 700.0
Window,1,XSize=xsize,YSize=ysize

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

;;--
position_img  = [0.10,0.15,0.90,0.95]
xrange  = [Min(theta_bin_cen_vect_plot),Max(theta_bin_cen_vect_plot)]
yrange  = [Min(slope_vect_plot-err_slope_vect_plot,/NaN),$
      Max(slope_vect_plot+err_slope_vect_plot,/NaN)]
xrange  = [xrange(0)-0.05*(xrange(1)-xrange(0)),$
      xrange(1)+0.05*(xrange(1)-xrange(0))]
yrange  = [yrange(0)-0.05*(yrange(1)-yrange(0)),$
      yrange(1)+0.05*(yrange(1)-yrange(0))]
;yrange = [-3.0,0.0]
xtitle  = TexToIDL('\theta')
ytitle  = 'slope'
title = 'slope of sreuct'+string(jieshu)+''

Plot, xrange, yrange, XRange=xrange, YRange=[-5,0], XStyle=1,YStyle=1, Position=position_img, $  ;range
    XTitle=xtitle, YTitle=ytitle, Color=color_black, $
    /NoErase, /NoData
Plots, theta_bin_cen_vect_plot, slope_vect_plot, Thick=1.5, Color=color_black
ErrPlot, theta_bin_cen_vect_plot, slope_vect_plot-err_slope_vect_plot, slope_vect_plot+err_slope_vect_plot, $
    Thick=1.5, Color=color_black

;;--
AnnotStr_tmp  = 'got from "Plot_sp_freq.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

slope(*,i_jie) = -slope_vect_plot
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date

file_fig  = 'Slopes_of_struct'+string(jieshu)+'_'+'Bt'+'_at_VariousTheta'+ $
;        TimeRange_str+$
        file_version+$
        '_recon.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg

endfor



dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date

file_save = 'slope_of_s(p)_vs_theta_tao'+file_version+'_recon.sav'

data_descrip= 'got from "plot_sp_freq.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_bin_cen_vect_plot, slope, sigmaslope



End_Program:
End




