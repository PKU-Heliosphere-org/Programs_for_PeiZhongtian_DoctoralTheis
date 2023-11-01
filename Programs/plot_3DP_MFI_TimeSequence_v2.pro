;pro plot_3DP_MFI_TimeSequence

;wk_dir  = '/Work/Data Analysis/Helios data process/Program/VDF_interpolate/VDF_interpolate/'
;wk_dir  = '/Work/Data Analysis/WIND data process/Programs/2000-06/VDF_interpolate/';/VDF_interpolate/'
;CD, wk_dir

year_str= '2002'
mon_str = '05'
day_str = '24'
date_str = year_str+'-'+mon_str+'-'+day_str
;sub_dir_date= '1995-02/';'1995-01--1995-02/';'1995-'+mon_str+'-'+day_str+'/'
;sub_dir_date= '1995-01--1995-02/'
sub_dir_date= $
;              year_str+'/'+$
              year_str+'-'+mon_str+'-'+day_str+'\'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
dir_data_v2 = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'

  

Step1:
;=====================
;Step1

;;--
file_restore  = 'wi_pm_3dp_'+year_str+mon_str+day_str+'_v03.sav'
;data_descrip= 'got from "Read_pm_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: velocity [km/s in SC coordinate similar to GSE coordinate]; number density [cm^-3]; '+$
;                  'temperature [10^4 K]; tensor [(km/s)^2, in SC coordinate]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr
;Note: sequence order stored in the tensor 
; vv_uniq  = [0,4,8,1,2,5]           ; => Uniq elements of a symmetric 3x3 matrix
; vv_trace = [0,4,8]                 ; => diagonal elements of a 3x3 matrix 
Restore, dir_data_v1 + file_restore, /Verbose
;;;---
JulDay_3DP_vect = JulDay_vect

sub_tmp = Where(Vxyz_GSE_p_arr eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  Vxyz_GSE_p_arr(sub_tmp) = !values.f_nan
EndIf
sub_tmp = Where(NumDens_p_vect eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  NumDens_p_vect(sub_tmp) = !values.f_nan
EndIf
sub_tmp = Where(Temper_p_vect eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  Temper_p_vect(sub_tmp) = !values.f_nan
EndIf


;;--
file_restore = 'wi_h0_mfi_'+year_str+mon_str+day_str+'_v05.sav'
;data_descrip  = 'got from "Read_WIND_MFI_H0_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr
Restore, dir_data_v2 + file_restore, /Verbose
;;;---
JulDay_MFI_vect = JulDay_vect




Step2:
;=====================
;Step2

;;--
num_times_MFI = N_Elements(JulDay_MFI_vect)
e_para_arr  = Fltarr(3, num_times_MFI)
e_perp1_arr = Fltarr(3, num_times_MFI)
e_perp2_arr = Fltarr(3, num_times_MFI)

e_Vsw_vect  = [-1.0, 0.0, 0.0]
For i_time=0,num_times_MFI-1 Do Begin
  Bxyz_GSE_tmp  = Reform(Bxyz_GSE_arr(*,i_time))
  e_para_vect = Bxyz_GSE_tmp / Norm(Bxyz_GSE_tmp)
  e_perp1_vect= CrossP(e_para_vect, e_Vsw_vect)
  e_perp1_vect= e_perp1_vect / Norm(e_perp1_vect)
  e_perp2_vect= CrossP(e_para_vect, e_perp1_vect)
  e_perp2_vect= e_perp2_vect / Norm(e_perp2_vect)
  e_para_arr(*,i_time)  = e_para_vect
  e_perp1_arr(*,i_time) = e_perp1_vect
  e_perp2_arr(*,i_time) = e_perp2_vect
EndFor


;;--
num_times_3DP = N_Elements(JulDay_3DP_vect)
Tensor_p_matrix = Fltarr(3,3)
vv_para_vect  = Fltarr(num_times_3DP)
vv_perp1_vect = Fltarr(num_times_3DP) ;perp to B0 & Vsw
vv_perp2_vect = Fltarr(num_times_3DP)
For i_time=0,num_times_3DP-1 Do Begin
  JulDay_3DP_tmp = JulDay_3DP_vect(i_time)
  dJulDay_vect  = JulDay_MFI_vect - JulDay_3DP_tmp
  val_min = Min(Abs(dJulDay_vect), sub_min)
  i_time_MFI  = sub_min(0)
;  Print, 'i_time, i_time_MFI: ', i_time, i_time_MFI
  e_para_vect = Reform(e_para_arr(*,i_time_MFI))
  e_perp1_vect= Reform(e_perp1_arr(*,i_time_MFI))
  e_perp2_vect= Reform(e_perp2_arr(*,i_time_MFI))
  
  Tensor_p_matrix(0,0)  = Tensor_p_arr(0,i_time)
  Tensor_p_matrix(1,1)  = Tensor_p_arr(1,i_time)
  Tensor_p_matrix(2,2)  = Tensor_p_arr(2,i_time)
  Tensor_p_matrix(1,0)  = Tensor_p_arr(3,i_time)
  Tensor_p_matrix(2,0)  = Tensor_p_arr(4,i_time)
  Tensor_p_matrix(2,1)  = Tensor_p_arr(5,i_time)
  Tensor_p_matrix(0,1)  = Tensor_p_matrix(1,0)
  Tensor_p_matrix(0,2)  = Tensor_p_matrix(2,0)
  Tensor_p_matrix(1,2)  = Tensor_p_matrix(2,1)
  
  transformMatrix = dblarr(3,3)
  transformMatrix(0,*) = e_para_vect
  transformMatrix(1,*) = e_perp1_vect
  transformMatrix(2,*) = e_perp2_vect
  vvTransformed = Transpose(transformMatrix) ## (Tensor_p_matrix ## transformMatrix)
 
  ;vv_para   = e_para_vect ## (Tensor_p_matrix ## Transpose(e_para_vect))
  ;vv_perp1  = e_perp1_vect ## (Tensor_p_matrix ## Transpose(e_perp1_vect))
  ;vv_perp2  = e_perp2_vect ## (Tensor_p_matrix ## Transpose(e_perp2_vect))
  vv_para = reform(vvTransformed(0, 0))
  vv_perp1 = reform(vvTransformed(1, 1))
  vv_perp2 = reform(vvTransformed(2, 2))
  
  vv_para_vect(i_time)  = vv_para
  vv_perp1_vect(i_time) = vv_perp1
  vv_perp2_vect(i_time) = vv_perp2  
EndFor
  

;;--
; vthp = SQRT(TOTAL(protons.DIST.VV[vv_trace],1,/NAN)*2/3)
; vtha = SQRT(TOTAL(alphas.DIST.VV[vv_trace],1,/NAN)*2/3)
; protons.DIST.TEMP = .00522 * vthp^2
; alphas.DIST.TEMP  = 4* .00522 * vtha^2
temper_para_vect  = 0.00522 * 2*vv_para_vect
temper_perp1_vect = 0.00522 * 2*vv_perp1_vect
temper_perp2_vect = 0.00522 * 2*vv_perp2_vect

;;--
temper_xx_vect  = 0.00522*2*Reform(Tensor_p_arr(0,*))
temper_yy_vect  = 0.00522*2*Reform(Tensor_p_arr(1,*))
temper_zz_vect  = 0.00522*2*Reform(Tensor_p_arr(2,*))



Step3:
;=====================
;Step3

;;--
year_plot = Float(year_str)
mon_plot  = Float(mon_str)
day_plot  = Float(day_str)
hour_beg=06.0 & min_beg=0.0 & sec_beg=0.0 ;From 'TimeStr_beg_seg_SWP_A/SWMS_vect' & 'TimeStr_end_seg_SWP_A/SWMS_vect' as resulted from 'get_CorrCoeffs_B_V_Components_EveryTimeInterval.pro'
hour_end=16.0 & min_end=0.0 & sec_end=0.0 ;time interval usually =5 or 10 min (<30min)
JulDay_beg_plot = JulDay(mon_plot, day_plot, year_plot, hour_beg, min_beg, sec_beg)
JulDay_end_plot = JulDay(mon_plot, day_plot, year_plot, hour_end, min_end, sec_end)
;JulDay_beg_plot_v2 = 0.5*(JulDay_beg_plot + JulDay_end_plot) - 15./(24.*60)
;JulDay_end_plot_v2 = 0.5*(JulDay_beg_plot + JulDay_end_plot) + 15./(24.*60)
;JulDay_beg_plot = JulDay_beg_plot_v2
;JulDay_end_plot = JulDay_end_plot_v2
CalDat, JulDay_beg_plot, mon_tmp,day_tmp,year_tmp,hour_beg_plot,min_beg_plot,sec_beg_plot
CalDat, JulDay_end_plot, mon_tmp,day_tmp,year_tmp,hour_end_plot,min_end_plot,sec_end_plot
timestr_beg_plot  = String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')
timestr_end_plot  = String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')
timerange_str_plot= '(time='+timestr_beg_plot+'-'+timestr_end_plot+')'

;;;---
sub_3DP = Where(JulDay_3DP_vect ge JulDay_beg_plot and JulDay_3DP_vect le JulDay_end_plot)
JulDay_vect_3DP_plot  = JulDay_3DP_vect(sub_3DP)
n_p_vect_3DP_plot = numdens_p_vect(sub_3DP)
Vx_p_RTN_vect_3DP_plot  = -Vxyz_GSE_p_arr(0,Min(sub_3DP):Max(sub_3DP))
Vy_p_RTN_vect_3DP_plot  = -Vxyz_GSE_p_arr(1,Min(sub_3DP):Max(sub_3DP))
Vz_p_RTN_vect_3DP_plot  = +Vxyz_GSE_p_arr(2,Min(sub_3DP):Max(sub_3DP))
Tp_vect_3DP_plot = temper_p_vect(sub_3DP)
Tp_para_vect_3DP_plot = temper_para_vect(sub_3DP)
Tp_perp1_vect_3DP_plot= temper_perp1_vect(sub_3DP)
Tp_perp2_vect_3DP_plot= temper_perp2_vect(sub_3DP)
Tp_xx_vect_3DP_plot = temper_xx_vect(sub_3DP)
Tp_yy_vect_3DP_plot = temper_yy_vect(sub_3DP)
Tp_zz_vect_3DP_plot = temper_zz_vect(sub_3DP)
;a Tp_perp1_vect_3DP_plot= 0.5*(Tp_perp1_vect_3DP_plot+Tp_perp2_vect_3DP_plot)
;a Tp_perp2_vect_3DP_plot= Tp_perp1_vect_3DP_plot
;Tp_para_vect_3DP_plot = temper_xx_vect(sub_3DP)
;Tp_perp1_vect_3DP_plot= temper_yy_vect(sub_3DP)
;Tp_perp2_vect_3DP_plot= temper_zz_vect(sub_3DP)
;;;---
sub_MFI = Where(JulDay_MFI_vect ge JulDay_beg_plot and JulDay_MFI_vect le JulDay_end_plot)
JulDay_vect_MFI_plot  = JulDay_MFI_vect(sub_MFI)
Bx_RTN_vect_MFI_plot  = -Bxyz_GSE_arr(0,Min(sub_MFI):Max(sub_MFI))
By_RTN_vect_MFI_plot  = -Bxyz_GSE_arr(1,Min(sub_MFI):Max(sub_MFI))
Bz_RTN_vect_MFI_plot  = +Bxyz_GSE_arr(2,Min(sub_MFI):Max(sub_MFI))
AbsB_vect_MFI_plot  = Sqrt(Bx_RTN_vect_MFI_plot^2 + By_RTN_vect_MFI_plot^2 + Bz_RTN_vect_MFI_plot^2)


;Goto,Step4
Step3_2:
;=====================
;Step3_2

;;--
dir_save = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
file_save = 'n&V&B&T_from_3DP_MFI_CDF'+$
                '(date='+date_str+')'+$
                '(time='+timestr_beg_plot+''+timestr_end_plot+')'+$
                '.sav'
data_descrip  = 'got from "Compare_n_V_T_from_CDF_VDF_for_WangXin.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_vect_3DP_plot, $
  n_p_vect_3DP_plot, $
  Vx_p_RTN_vect_3DP_plot, $
  Vy_p_RTN_vect_3DP_plot, $
  Vz_p_RTN_vect_3DP_plot, $
  Tp_vect_3DP_plot, $
  JulDay_vect_MFI_plot, $
  Bx_RTN_vect_MFI_plot, By_RTN_vect_MFI_plot, Bz_RTN_vect_MFI_plot, $
  AbsB_vect_MFI_plot


Step4:
;=====================
;Step4

;;--
is_skip_MVA = 1
Print, 'is_skip_MVA (0 or 1): ', is_skip_MVA
is_continue = ' '
Read, 'is_continue: ', is_continue
If (is_skip_MVA eq 1) Then Goto, Step5;Step4_2

;;--
JulDay_beg_MVA = JulDay(12, 26, 1995, 9, 0, 0.0)
JulDay_end_MVA = JulDay(12, 26, 1995, 10, 0, 0.0)
sub_MVA = Where(JulDay_MFI_vect ge JulDay_beg_MVA and JulDay_MFI_vect le JulDay_end_MVA)
Bx_vect_MVA = -Bxyz_GSE_arr(0,Min(sub_MVA):Max(sub_MVA))
By_vect_MVA = -Bxyz_GSE_arr(1,Min(sub_MVA):Max(sub_MVA))
Bz_vect_MVA = +Bxyz_GSE_arr(2,Min(sub_MVA):Max(sub_MVA))

;;--
Bxyz_arr  = [[Reform(Bx_vect_MVA)],[Reform(By_vect_MVA)],[Reform(Bz_vect_MVA)]]
get_LMN_from_MVA, Bxyz_arr, $
      l_vect=l_vect, m_vect=m_vect, n_vect=n_vect, $
      lambda_l=lambda_l, lambda_m=lambda_m, lambda_n=lambda_n
      
;;--
Bxyz_arr  = [[Reform(Bx_RTN_vect_MFI_plot)],[Reform(By_RTN_vect_MFI_plot)],[Reform(Bz_RTN_vect_MFI_plot)]]
B_LMN_arr = Transpose(Bxyz_arr) ## [[l_vect],[m_vect],[n_vect]]
B_L_vect  = Reform(B_LMN_arr(0,*))
B_M_vect  = Reform(B_LMN_arr(1,*))
B_N_vect  = Reform(B_LMN_arr(2,*))
;;;---
Bx_RTN_vect_MFI_plot  = B_L_vect
By_RTN_vect_MFI_plot  = B_M_vect
Bz_RTN_vect_MFI_plot  = B_N_vect

;;--
V_xyz_arr = [[Reform(Vx_p_RTN_vect_3DP_plot)],[Reform(Vy_p_RTN_vect_3DP_plot)],[Reform(Vz_p_RTN_vect_3DP_plot)]]
V_LMN_arr = Transpose(V_xyz_arr) ##  [[l_vect],[m_vect],[n_vect]]
V_L_vect  = Reform(V_LMN_arr(0,*))
V_M_vect  = Reform(V_LMN_arr(1,*))
V_N_vect  = Reform(V_LMN_arr(2,*))     
;;;---
Vx_p_RTN_vect_3DP_plot  = V_L_vect
Vy_p_RTN_vect_3DP_plot  = V_M_vect
Vz_p_RTN_vect_3DP_plot  = V_N_vect


Goto, Step5
Step4_2:
;=====================
;Step4_2

;;--estimate energies of Aflven waves, fast waves, or slow waves
Get_EnergyDensity_MHD_waves_from_nVB_TimeSequence, $
  JulDay_vect_3DP_plot, n_p_vect_3DP_plot, Tp_vect_3DP_plot, $
  Vx_p_RTN_vect_3DP_plot, Vy_p_RTN_vect_3DP_plot, Vz_p_RTN_vect_3DP_plot, $
  JulDay_vect_MFI_plot, $
  Bx_RTN_vect_MFI_plot, By_RTN_vect_MFI_plot, Bz_RTN_vect_MFI_plot, $
  EnerDens_AlfvenWave, EnerDens_FastWave, $
  AlfvenRatio=AlfvenRatio, Sigma_C=Sigma_C

Print, 'EnerDens_AlfvenWave, EnerDens_FastWave: ', EnerDens_AlfvenWave, EnerDens_FastWave
Print, 'EnerDens_AlfvenWave/EnerDens_FastWave: ', EnerDens_AlfvenWave/EnerDens_FastWave 
Print, 'AlfvenRatio, Sigma_C: ', AlfvenRatio, Sigma_C 
is_continue = ' '
Read, 'is_continue: ', is_continue  


Step5:
;=====================
;Step5

;;--
perp_symbol_oct = "170
perp_symbol_str = String(Byte(perp_symbol_oct))
perp_symbol_str_v1  = '{!9' + perp_symbol_str + '!X}'
perp_symbol_str_v2  = '!9'+perp_symbol_str+'!X'


;;;--
;Set_Plot,'PS'
;file_version  = '(v2)'
;file_fig= 'n&V&T'+$
;        ''+$
;        file_version+$
;        '.png'
;xsize = 21.0
;ysize = 24.0
;Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul

;;--
Set_Plot,'win'
Device,DeComposed=0;, /Retain
xsize=800.0 & ysize=1000.0
Window,3,XSize=xsize,YSize=ysize,Retain=2

;;--
LoadCT,13
TVLCT,R,G,B,/Get
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
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

;;--
position_img  = [0.06,0.08,0.99,0.95]

;;--
num_subimgs_x = 1
num_subimgs_y = 5
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.07
x_margin_right= 0.93
y_margin_bot  = 0.07
y_margin_top  = 0.93


;;--
i_subimg_x  = 0
i_subimg_y  = 4
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = n_p_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
yrange    = [0.0,yrange(1)]
xtitle    = ' '
;ytitle    = TexToIDL('Np [cm^{-3}]')
ytitle    = 'Np [cm^-3]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = AbsB_vect_MFI_plot
yrange  = [Min(yplot_vect)-1.0,Max(yplot_vect)+1.0]
yrange  = [0.0,yrange(1)]
;ytitle  = TexToIDL('|B| [nT]')
ytitle  = '|B| [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=1.5    
 
 

;;--
i_subimg_x  = 0
i_subimg_y  = 3
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = Vx_p_RTN_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-10,Max(yplot_vect)+10]
xtitle    = ' '
;ytitle    = TexToIDL('V_{R} [cm^{-3}]')
ytitle    = 'V_R [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = Bx_RTN_vect_MFI_plot
yrange  = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
;ytitle  = TexToIDL('B_{R} [nT]')
ytitle  = 'B_R [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=1.5  
  

;;--
i_subimg_x  = 0
i_subimg_y  = 2
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = Vy_p_RTN_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-10,Max(yplot_vect)+10]
xtitle    = ' '
;ytitle    = TexToIDL('V_{R} [cm^{-3}]')
ytitle    = 'V_T [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = By_RTN_vect_MFI_plot
yrange  = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
;ytitle  = TexToIDL('B_{R} [nT]')
ytitle  = 'B_T [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=1.5  


;;--
i_subimg_x  = 0
i_subimg_y  = 1
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = Vz_p_RTN_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-10,Max(yplot_vect)+10]
xtitle    = ' '
;ytitle    = TexToIDL('V_{R} [cm^{-3}]')
ytitle    = 'V_N [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = Bz_RTN_vect_MFI_plot
yrange  = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
;ytitle  = TexToIDL('B_{R} [nT]')
ytitle  = 'B_N [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=1.5  


;;--
i_subimg_x  = 0
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = Tp_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect),Max(yplot_vect)]
yrange    = [yrange(0)-0.5*(yrange(1)-yrange(0)), yrange(1)+0.7*(yrange(1)-yrange(0))]
xtitle    = ' '
;ytitle    = TexToIDL('V_{R} [cm^{-3}]')
ytitle    = 'Tp [10^4 K]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=3.0  
;;;---
yplot_vect  = Tp_xx_vect_3DP_plot ;Tp_para_vect_3DP_plot
;yplot_vect  = (Tp_para_vect_3DP_plot + Tp_perp1_vect_3DP_plot + Tp_perp2_vect_3DP_plot)/3
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=1.5  
yplot_vect  = Tp_yy_vect_3DP_plot ;Tp_perp1_vect_3DP_plot
Plots, xplot_vect, yplot_vect, Color=color_green, Thick=1.5  
yplot_vect  = Tp_zz_vect_3DP_plot ;Tp_perp2_vect_3DP_plot
Plots, xplot_vect, yplot_vect, Color=color_blue, Thick=1.5  


;;--
AnnotStr_tmp  = 'got from "plot_3DP_MFI_TimeSequence.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
Annotstr_tmp  = year_str+mon_str+day_str+'; '+sub_dir_date
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
image_tvrd  = TVRD(true=1)
file_version  = '(v1)'
file_fig= 'n&V&T'+$
        timerange_str_plot+$
        '('+year_str+mon_str+day_str+')'+$
        file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b


;;;--
;Device,/Close 



end