;Pro get_WavePara_BasedOn_SVD_of_H2MagF_Sequence_MainProgram



year_str= '2002'
mon_str = '05'
day_str = '24'
sub_dir_date= 'wind\Alfven\';'1995-01--1995-02/';'1995-'+mon_str+'-'+day_str+'/'
;sub_dir_date= year_str+'/'+year_str+'-'+mon_str+'/'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''
dir_data = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''


;Goto, Step4_4
Step1:
;=====================
;Step1

;;--
file_restore = 'wi_h2_mfi_'+year_str+mon_str+day_str+'_v05.sav'
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_MainProgram.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect
Restore, dir_data + file_restore, /Verbose
;;;---
;a JulDay_MFI_vect = JulDay_vect



Step2:
;=====================
;Step2

;;--
year_plot = Float(year_str)
mon_plot  = Float(mon_str)
day_plot  = Float(day_str)
hour_beg=6.0 & min_beg=0.0 & sec_beg=0.0 ;From 'TimeStr_beg_seg_SWP_A/SWMS_vect' & 'TimeStr_end_seg_SWP_A/SWMS_vect' as resulted from 'get_CorrCoeffs_B_V_Components_EveryTimeInterval.pro'
hour_end=16.0 & min_end=0.0 & sec_end=0.0 ;time interval usually =5 or 10 min (<30min)
JulDay_beg_plot = JulDay(mon_plot, day_plot, year_plot, hour_beg, min_beg, sec_beg)
JulDay_end_plot = JulDay(mon_plot, day_plot, year_plot, hour_end, min_end, sec_end)
;JulDay_beg_plot_v2 = 0.5*(JulDay_beg_plot + JulDay_end_plot) - 15./(24.*60)
;JulDay_end_plot_v2 = 0.5*(JulDay_beg_plot + JulDay_end_plot) + 15./(24.*60)
;JulDay_beg_plot = JulDay_beg_plot_v2
;JulDay_end_plot = JulDay_end_plot_v2
Print, 'year/mon/day/hour/min/sec_beg_plot: '
Print, year_plot, mon_plot, day_plot, hour_beg, min_beg, sec_beg
Print, 'year/mon/day/hour/min/sec_end_plot: '
Print, year_plot, mon_plot, day_plot, hour_end, min_end, sec_end
is_continue = ' '
Read, 'is_continue: ', is_continue
CalDat, JulDay_beg_plot, mon_tmp,day_tmp,year_tmp,hour_beg_plot,min_beg_plot,sec_beg_plot
CalDat, JulDay_end_plot, mon_tmp,day_tmp,year_tmp,hour_end_plot,min_end_plot,sec_end_plot
timestr_beg_plot  = String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')
timestr_end_plot  = String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')
timerange_str_plot= '(time='+timestr_beg_plot+'-'+timestr_end_plot+')'


;;;--
;dJulDay_plot      = 3.0/(24.*60*60)
;num_times_plot    = Floor((JulDay_end_plot-JulDay_beg_plot)/dJulDay_plot)+1L
;JulDay_vect_plot  = JulDay_beg_plot + Dindgen(num_times_plot) * dJulDay_plot 
;
;Bx_GSE_vect = Reform(Bxyz_GSE_arr(0,*))
;By_GSE_vect = Reform(Bxyz_GSE_arr(1,*))
;Bz_GSE_vect = Reform(Bxyz_GSE_arr(2,*))
;Bx_GSE_vect_plot  = Interpol(Bx_GSE_vect, JulDay_MFI_vect, JulDay_vect_plot)
;By_GSE_vect_plot  = Interpol(By_GSE_vect, JulDay_MFI_vect, JulDay_vect_plot)
;Bz_GSE_vect_plot  = Interpol(Bz_GSE_Vect, JulDay_MFI_vect, JulDay_vect_plot)

;;--
sub_tmp = Where(JulDay_vect_interp ge JulDay_beg_plot and JulDay_vect_interp le JulDay_end_plot)
JulDay_vect_plot  = JulDay_vect_interp(sub_tmp)
Bx_GSE_vect_plot  = Bx_GSE_vect_interp(sub_tmp)
By_GSE_vect_plot  = By_GSE_vect_interp(sub_tmp)
Bz_GSE_vect_plot  = Bz_GSE_vect_interp(sub_tmp)


Step3:
;=====================
;Step3

;;--
time_vect = (JulDay_vect_plot - JulDay_vect_plot(0))*(24.*60*60)
dtime     = time_vect(1) - time_vect(0)
time_interval = Max(time_vect) - Min(time_vect)
period_min= dtime*3
period_max= time_interval/7
period_range  = [period_min, period_max]
num_periods = 16L
num_times   = N_Elements(time_vect)

;;--
For i=0,2 Do Begin
  If i eq 0 Then wave_vect = Bx_GSE_vect_plot
  If i eq 1 Then wave_vect = By_GSE_vect_plot
  If i eq 2 Then wave_vect = Bz_GSE_vect_plot
get_Wavelet_Transform_of_BComp_vect_STEREO_v3, $
    time_vect, wave_vect, $    ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $
    Wavlet_arr, $       ;output
    time_vect_v2=time_vect_v2, $
    period_vect=period_vect
PSD_arr  = Abs(wavlet_arr)^2 * dtime    
If i eq 0 Then Begin
  wavlet_Bx_arr=wavlet_arr & PSD_Bx_arr=PSD_arr
EndIf  
If i eq 1 Then Begin
  wavlet_By_arr=wavlet_arr & PSD_By_arr=PSD_arr
EndIf  
If i eq 2 Then Begin
  wavlet_Bz_arr=wavlet_arr & PSD_Bz_arr=PSD_arr
EndIf  

EndFor  


;;--
Bxyz_GSE_arr_plot = [[Bx_GSE_vect_plot],[By_GSE_vect_plot],[Bz_GSE_vect_plot]]
Bxyz_GSE_arr_plot = Transpose(Bxyz_GSE_arr_plot)
get_LocalBG_of_MagField_at_Scales_WIND_MFI, $
    time_vect, Bxyz_GSE_arr_plot, $  ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, $ ;input
    Bxyz_LBG_GSE_arr_plot, $   ;output
    time_vect_v2=time_vect_v2, $  ;output
    period_vect=period_vect     ;output



Step4:
;=====================
;Step4

;;--
Bxyz_LBG_GSE_arr  = Bxyz_LBG_GSE_arr_plot
get_WavePara_BasedOn_SVD_of_MagF_Sequence, $
      wavlet_Bx_arr, wavlet_By_arr, wavlet_Bz_arr, $
      time_vect, period_vect, $
      Bxyz_LBG_GSE_arr, $
      EigVal_arr, EigVect_arr, $
      PlanarityPolarization_arr=PlanPolar_arr, $
      EplipticPolarization_arr=ElipPolar_arr, $
      SensePolarization_arr=SensePolar_arr, $
      DegreePolarization_arr=DegreePolar_arr
      

Step4_2:
;=====================
;Step4_2

;;--
i_eigenval_min  = 0
i_eigenval_mid  = 1
i_eigenval_max  = 2


;;--
theta_k_db_arr  = Fltarr(num_times,num_periods)
theta_k_b0_arr  = Fltarr(num_times,num_periods)
theta_db_b0_arr = Fltarr(num_times,num_periods)

;For i_theta=0,4-1 Do Begin
For i_time=0,num_times-1 Do Begin
For i_scale=0,num_periods-1 Do Begin
  k_db_vect = Reform(EigVect_arr(*,i_eigenval_min,i_time,i_scale))  ;k_Zp
  e_db_vect = Reform(EigVect_arr(*,i_eigenval_max,i_time,i_scale))  ;e_Zp
  b0_vect   = Reform(Bxyz_LBG_GSE_arr_plot(*,i_time,i_scale))
  k_db_vect = k_db_vect/Norm(k_db_vect)
  e_db_vect = e_db_vect/Norm(e_db_vect)
  b0_vect   = b0_vect/Norm(b0_vect)

  theta_k_db_arr(i_time,i_scale) = ACos(Abs(k_db_vect ## Transpose(e_db_vect))) * 180/!pi  ;angle between k_Zp with e_Zm
  theta_k_b0_arr(i_time,i_scale) = ACos(Abs(k_db_vect ## Transpose(b0_vect))) * 180/!pi
  theta_db_b0_arr(i_time,i_scale) = ACos(Abs(e_db_vect ## Transpose(b0_vect))) * 180/!pi

EndFor
EndFor


Step4_3:
;=====================
;Step4_3
;;--
file_data = 'WavePara_BasedOn_SVD_of_H2MagF (for_paper)'+$
              '('+year_str+mon_str+day_str+')'+$
              '.sav'
data_descrip  = 'got from "plot_Figure8_for_paper_200206.pro"'
Save, FileName=dir_data+file_data, $
  data_descrip, $
  JulDay_vect_plot, period_vect, $
  theta_k_b0_arr, theta_db_b0_arr, $
  SensePolar_arr, ElipPolar_arr


Step4_4:
;=====================
;Step4_4
;;--
file_data = 'WavePara_BasedOn_SVD_of_H2MagF (for_paper)'+$
            '('+year_str+mon_str+day_str+')'+$
            '.sav'
FileName  = dir_data+file_data
Restore, FileName, /Verbose
;data_descrip  = 'got from "plot_Figure8_for_paper_200206.pro"'
;Save, FileName=dir_data+file_data, $
;  data_descrip, $
;  JulDay_vect_plot, period_vect, $
;  theta_k_b0_arr, theta_db_b0_arr, $
;  SensePolar_arr, ElipPolar_arr



Step5:
;=====================
;Step5

;;--
;read,'png(1) or eps(2)',is_png_eps
is_png_eps = 1
If is_png_eps eq 2 Then Begin
Set_Plot,'PS'
file_version  = '(v1)'
file_fig= 'Figure8_'+$
        ''+$
        file_version+$
        '.eps'
xsize = 24.0
ysize = 12.0
Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
EndIf 
If is_png_eps eq 1 Then Begin
Set_Plot,'win'
Device,DeComposed=0;, /Retain
xsize=1400.0 & ysize=700.0
Window,8,XSize=xsize,YSize=ysize,Retain=2
endif



;;--
;LoadCT,13
;TVLCT,R,G,B,/Get
;Restore, '/Work/Data Analysis/Programs/RainBow(reset).sav', /Verbose
n_colors  = 256
RainBow_Matlab, R,G,B, n_colors
color_red = 0L
TVLCT,255L,0L,0L,color_red
R_red=255L & G_red=0L & B_red=0L
color_green = 1L
TVLCT,0L,255L,0L,color_green
R_green=0L & G_green=255L & B_green=0L
color_blue  = 2L
TVLCT,0L,0L,255L,color_blue
R_blue=0L & G_blue=0L & B_blue=255L
color_white = 4L
TVLCT,255L,255L,255L,color_white
R_white=255L & G_white=255L & B_white=255L
color_black = 3L
TVLCT,0L,0L,0L,color_black
R_black=0L & G_black=0L & B_black=0L
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
R = [R_red,R_green,R_blue,R_black,R_white,R]
G = [G_red,G_green,G_blue,G_black,G_white,G]
B = [B_red,B_green,B_blue,B_black,B_white,B]
TVLCT,R,G,B

;;--
If is_png_eps eq 1 Then Begin
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
endif

XThick=2.0 & YThick=2.0
CharSize=1.5 & CharThick=1.9
Thick=3.0

;;--
position_img  = [0.04,0.08,0.96,0.99]

;;--
num_subimgs_x = 2
num_subimgs_y = 2;10
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.07
x_margin_right= 0.93
y_margin_bot  = 0.07
y_margin_top  = 0.93

is_contour_or_TV  = 1


;;--
For i_subimg_x=0,1 Do Begin
For i_subimg_y=0,1 Do Begin

  If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin ;kx for Zp with min eigen-value
    image_TV  = theta_k_b0_arr
    title = TexToIDL('\theta (k,B_0)')
    PanelMark = '(a)'
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin ;ky for Zp with min eigen-value
    image_TV  = theta_db_b0_arr
    title = TexToIDL('\theta (dB,B_0)')
    PanelMark = '(b)'
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin ;kz for Zp with min eigen-value
    image_TV  = SensePolar_arr
    title = TexToIDL('Sense of Polarization (About B_0 in SC frame)')
    PanelMark = '(c)'
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin ;ky for Zp with min eigen-value
    image_TV  = ElipPolar_arr
    title = TexToIDL('Ellipticity of Polarization')
    PanelMark = '(d)'
  EndIf  
 

;;--  
xplot_vect  = JulDay_vect_plot
yplot_vect  = period_vect
xrange  = [Min(xplot_vect)-0.5*(xplot_vect(1)-xplot_vect(0)), Max(xplot_vect)+0.5*(xplot_vect(1)-xplot_vect(0))]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
If i_subimg_y gt 0 Then Begin
  xticknames  = Replicate(' ', xticks+1)
EndIf  
xminor  = xminor_time
;xminor    = 6
lg_yplot_vect = ALog10(yplot_vect)
yrange    = 10^[Min(lg_yplot_vect)-0.5*(lg_yplot_vect(1)-lg_yplot_vect(0)),$
                Max(lg_yplot_vect)+0.5*(lg_yplot_vect(1)-lg_yplot_vect(0))]
xtitle    = ' '
If (i_subimg_x eq 0) Then Begin
  ytitle  = 'period [s]'
EndIf Else Begin
  ytitle  = ' '
EndElse  

image_TV  = Rebin(image_TV,(Size(image_TV))[1],(Size(image_TV))[2]*1, /Sample)
yplot_vect= 10^Congrid(ALog10(yplot_vect), N_Elements(yplot_vect)*1, /Minus_One)

;;--
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
position_SubImg   = position_SubPlot

;;;---
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = -9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV)))+num_BadVal)
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV))))
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
byt_image_TV= byt_image_TV+(256-num_CB_color)
color_BadVal= color_white
If sub_BadVal(0) ne -1 Then $
byt_image_TV(sub_BadVal)  = color_BadVal

If is_contour_or_TV eq 1 Then Begin
num_levels  = 15
levels_vect = Byte(Findgen(num_levels)*Float(num_CB_color-1)/(num_levels-1))
level_val_vect= min_image + Float(levels_vect)/(num_CB_color-1)*(max_image-min_image)
levels_vect   = [color_BadVal, levels_vect+(256-num_CB_color)]
color_vect    = levels_vect
contour_arr = byt_image_TV
Contour, contour_arr, xplot_vect, yplot_vect, $
  XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
  /Cell_Fill, /NoErase, YLog=1, $
  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
EndIf Else Begin
TVImage, byt_image_TV,Position=position_SubPlot, NOINTERPOLATION=1 
EndElse

;If is_contour_or_TV eq 1 Then Begin
;num_levels  = 15
;levels_vect = Byte(Findgen(num_levels)*Float(num_CB_color-1)/(num_levels-1))
;level_val_vect= min_image + Float(levels_vect)/(num_CB_color-1)*(max_image-min_image)
;levels_vect   = [color_BadVal, levels_vect+(256-num_CB_color)]
;color_vect    = levels_vect
;contour_arr = byt_image_TV
;Contour, contour_arr, xplot_vect, yplot_vect, $
;  XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
;  /Cell_Fill, /NoErase, YLog=1, $
;  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
;EndIf Else Begin
;TVImage, byt_image_TV,Position=position_SubPlot, NOINTERPOLATION=1 
;EndElse
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, CharSize=1.2, $
    Position=position_subimg, XTitle=' ', YTitle=' ', /NoData, /NoErase, Color=color_black, $
    XTickLen=-0.02,YTickLen=-0.02, YLog=1
    
If is_contour_or_TV eq 3 Then Begin
levels_vect_v2  = levels_vect(1:N_Elements(levels_vect)-1)
c_annotate_vect = String(level_val_vect, format='(F5.2)')
c_linestyle_vect= Intarr(N_Elements(levels_vect_v2))    
Contour, contour_arr, xplot_vect, yplot_vect, /noerase, $
  levels=levels_vect_v2,$
  C_ANNOTATION=c_annotate_vect,$
  C_LINESTYLE=c_linestyle_vect, NoClip=0, Color=color_white, /OverPlot
EndIf

;;;---
If i_subimg_x eq 0 Then Begin
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,$
  XTickLen=-0.04,YTickLen=-0.02, YTick_Get=ytickv, $
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1,$
;a  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick
EndIf Else Begin
yticknames  = Replicate(' ', N_Elements(ytickv))
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,$
  XTickLen=-0.04,YTickLen=-0.02, YTickName=yticknames, $
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1,$
;a  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick
EndElse

;;--
JulDay_time_beg_v1  = JulDay(6,26,2002,18,1,30.)
JulDay_time_end_v1  = JulDay(6,26,2002,18,4,30.)
period_beg_v1 = 4.0
period_end_v1 = 20.0
JulDay_vertices_v1  = [JulDay_time_beg_v1,JulDay_time_end_v1,JulDay_time_end_v1,JulDay_time_beg_v1,JulDay_time_beg_v1]
period_vertices_v1  = [period_beg_v1,period_beg_v1,period_end_v1,period_end_v1,period_beg_v1]
Plots, JulDay_vertices_v1, period_vertices_v1, LineStyle=0, Color=color_black, Thick=thick

JulDay_time_beg_v1  = JulDay(6,26,2002,18,8,0.)
JulDay_time_end_v1  = JulDay(6,26,2002,18,12,0.)
period_beg_v1 = 3.0
period_end_v1 = 20.0
JulDay_vertices_v1  = [JulDay_time_beg_v1,JulDay_time_end_v1,JulDay_time_end_v1,JulDay_time_beg_v1,JulDay_time_beg_v1]
period_vertices_v1  = [period_beg_v1,period_beg_v1,period_end_v1,period_end_v1,period_beg_v1]
Plots, JulDay_vertices_v1, period_vertices_v1, LineStyle=0, Color=color_black, Thick=thick

JulDay_time_beg_v1  = JulDay(6,26,2002,18,14,0.)
JulDay_time_end_v1  = JulDay(6,26,2002,18,26,0.)
period_beg_v1 = 2.0
period_end_v1 = 20.0
JulDay_vertices_v1  = [JulDay_time_beg_v1,JulDay_time_end_v1,JulDay_time_end_v1,JulDay_time_beg_v1,JulDay_time_beg_v1]
period_vertices_v1  = [period_beg_v1,period_beg_v1,period_end_v1,period_end_v1,period_beg_v1]
Plots, JulDay_vertices_v1, period_vertices_v1, LineStyle=0, Color=color_black, Thick=thick
 
;;;---
xpos_tmp  = position_subplot(0)-0.02
ypos_tmp  = position_SubPlot(3)+0.01
xyouts_str= PanelMark
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 

  
;;;---
position_CB   = [position_SubImg(2)+0.04,position_SubImg(1),$
          position_SubImg(2)+0.05,position_SubImg(3)]
num_ticks   = 5
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = ' ';title
bottom_color  = 256-num_CB_color  ;0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=num_ticks-1,YTickName=tickn_CB, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, $ 
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick

 
EndFor
EndFor


;;--
AnnotStr_tmp  = ' ';'got from "plot_Figure8_for_paper_200206.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
;Annotstr_tmp  = year_str+mon_str+day_str
;AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--

If is_png_eps eq 1 Then Begin
image_tvrd  = TVRD(true=1)
If is_contour_or_TV eq 1 Then Begin
  file_version='(contour)'
EndIf Else Begin
  file_version  = '(TV)'
EndElse  
file_fig= 'Figure8_'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b
endif
If is_png_eps eq 2 Then Begin
Device,/Close 
endif

;;;--
;Device,/Close 


End      