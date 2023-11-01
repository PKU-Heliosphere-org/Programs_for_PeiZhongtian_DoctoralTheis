;pro plot_Figure2_for_paper_200206
; similar to 'plot_3DP_MFI_TimeSequence_v2'
year_str= '2002'
mon_str = '05'
day_str = '24'
sub_dir_date= 'wind\Alfven\';'1995-01--1995-02/';'1995-'+mon_str+'-'+day_str+'/'
;sub_dir_date= year_str+'/'+year_str+'-'+mon_str+'/'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''
dir_data = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''


Step1:
;=====================
;Step1


;;--
dir_restore = dir_data
file_restore= 'n&V&B&T_from_3DP_MFI_CDF'+$
                '(date=*)'+$
                '(time=*)'+$
                '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;
;data_descrip  = 'got from "plot_3DP_MFI_TimeSequence_v2.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_vect_3DP_plot, $
;  n_p_vect_3DP_plot, $
;  Vx_p_RTN_vect_3DP_plot, $
;  Vy_p_RTN_vect_3DP_plot, $
;  Vz_p_RTN_vect_3DP_plot, $
;  Tp_vect_3DP_plot, $
;  Tp_xx_vect_3DP_plot, Tp_yy_vect_3DP_plot, Tp_zz_vect_3DP_plot, $
;  Tp_para_vect_3DP_plot, Tp_perp1_vect_3DP_plot, Tp_perp2_vect_3DP_plot, $
;  JulDay_vect_MFI_plot, $
;  Bx_RTN_vect_MFI_plot, By_RTN_vect_MFI_plot, Bz_RTN_vect_MFI_plot, $
;  AbsB_vect_MFI_plot

;;--
JulDay_beg_plot = Min(JulDay_vect_3DP_plot)
JulDay_end_plot = Max(JulDay_vect_3DP_plot)

mean_Bx = mean(Bx_RTN_vect_MFI_plot,/nan)
print,mean_Bx

Step2:
;=====================
;Step2


;;--
read,'png(1) or eps(2)',is_png_eps

If is_png_eps eq 2 Then Begin
Set_Plot,'PS'
file_version  = '(v1)'
file_fig= 'Figure2_'+$
        ''+$
        file_version+$
        '.eps'
xsize = 20.0
ysize = 24.0
Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
EndIf 
If is_png_eps eq 1 Then Begin
  Set_Plot,'win'
  Device,DeComposed=0;, /Retain
  xsize=1000.0 & ysize=1200.0
  Window,4,XSize=xsize,YSize=ysize,Retain=2
endif



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

;;;--
If is_png_eps eq 1 Then Begin
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
endif
;;--
position_img  = [0.08,0.08,0.97,0.97]

;;--
num_subimgs_x = 1
num_subimgs_y = 7
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.07
x_margin_right= 0.93
y_margin_bot  = 0.07
y_margin_top  = 0.93

thick   = 3.0
xthick  = 3.0
ythick  = 3.0
charthick = 2.5
charsize  = 1.0

dxpos_xyouts  = 0.14

;;--
i_subimg_x  = 0
i_subimg_y  = 6
PanelMark_str = '(a)'
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
xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
yrange    = [0.0,yrange(1)]
xtitle    = ' '
ytitle    = TexToIDL('N_p [cm^{-3}]')
;ytitle    = 'Np [cm^-3]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick  
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
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=thick    

;;;---
xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 
  
;;--
i_subimg_x  = 0
i_subimg_y  = 4
PanelMark_str = '(c)'
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = (n_p_vect_3DP_plot*Tp_vect_3DP_plot/AbsB_vect_MFI_plot^2.0)*0.35
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
yrange    = [0,0.05];[Min(yplot_vect),Max(yplot_vect)]
yrange    = [yrange(0)-0.5*(yrange(1)-yrange(0)), yrange(1)+0.7*(yrange(1)-yrange(0))]
xtitle    = ' '
ytitle    = TexToIDL('beta')
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick 


;;;---
xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 

;;--
i_subimg_x  = 0
i_subimg_y  = 3
PanelMark_str = '(d)'
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot

AbsB_aver_G  = AbsB_vect_MFI_plot*1.e-9*1.e4  ;unit: Gauss
get_Alfven_velocity_v2, n_p_vect_3DP_plot, AbsB_aver_G, VA_kmps

yplot_vect  = sqrt(Vx_p_RTN_vect_3DP_plot^2.0+Vy_p_RTN_vect_3DP_plot^2.0+   $
  Vz_p_RTN_vect_3DP_plot^2.0)/VA_kmps
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
yrange    = [0,2];[Min(yplot_vect),Max(yplot_vect)]
yrange    = [yrange(0)-0.5*(yrange(1)-yrange(0)), yrange(1)+0.7*(yrange(1)-yrange(0))]
xtitle    = ' '
ytitle    = TexToIDL('Alfven Mach number')
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick 

xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 

;;--
i_subimg_x  = 0
i_subimg_y  = 2
PanelMark_str = '(e)'
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = -Vx_p_RTN_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-10,Max(yplot_vect)+10]
xtitle    = ' '
ytitle    = TexToIDL('Vx [km/s]')
;a ytitle    = 'V_R [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick 
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = -Bx_RTN_vect_MFI_plot
yrange  = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
ytitle  = TexToIDL('Bx [nT]')
;a ytitle  = 'B_R [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=thick

;;;---
xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 
  

;;--
i_subimg_x  = 0
i_subimg_y  = 1
PanelMark_str = '(f)'
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_3DP_plot
yplot_vect  = -Vy_p_RTN_vect_3DP_plot
xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-10,Max(yplot_vect)+10]
xtitle    = ' '
ytitle    = TexToIDL('Vy [km/s]')
;a ytitle    = 'V_T [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick 
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = -By_RTN_vect_MFI_plot
yrange  = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
ytitle  = TexToIDL('By [nT]')
;a ytitle  = 'B_T [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=thick 

;;;---
xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 


;;--
i_subimg_x  = 0
i_subimg_y  = 0
PanelMark_str = '(g)'
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
xtitle    = year_str+'/'+mon_str+'/'+day_str                    ;
ytitle    = TexToIDL('Vz [km/s]')
;a ytitle    = 'V_N [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1+8,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick 
;;;---
xplot_vect  = JulDay_vect_MFI_plot
yplot_vect  = Bz_RTN_vect_MFI_plot
yrange  = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
ytitle  = TexToIDL('Bz [nT]')
;a ytitle  = 'B_N [nT]'
Axis, xrange(1), YAxis=1, /Save, $
  YRange=yrange, YStyle=1, $
  YTitle=ytitle, Color=color_red, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick
Plots, xplot_vect, yplot_vect, Color=color_red, Thick=thick

;;;---
xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 


;;--
i_subimg_x  = 0
i_subimg_y  = 5
PanelMark_str = '(b)'
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
xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect),Max(yplot_vect)]
yrange    = [yrange(0)-0.5*(yrange(1)-yrange(0)), yrange(1)+0.7*(yrange(1)-yrange(0))]
xtitle    = ' '
ytitle    = TexToIDL('Tp [10^4 K]')
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick 
;;;;---
;yplot_vect  = Tp_xx_vect_3DP_plot ;Tp_para_vect_3DP_plot
;;yplot_vect  = (Tp_para_vect_3DP_plot + Tp_perp1_vect_3DP_plot + Tp_perp2_vect_3DP_plot)/3
;Plots, xplot_vect, yplot_vect, Color=color_red, Thick=1.5  
;yplot_vect  = Tp_yy_vect_3DP_plot ;Tp_perp1_vect_3DP_plot
;Plots, xplot_vect, yplot_vect, Color=color_green, Thick=1.5  
;yplot_vect  = Tp_zz_vect_3DP_plot ;Tp_perp2_vect_3DP_plot
;Plots, xplot_vect, yplot_vect, Color=color_blue, Thick=1.5  

;;;---
xpos_tmp  = position_subplot(0)-dxpos_xyouts
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 


;;--
AnnotStr_tmp  = ' ';'got from "plot_Figure2_for_paper_200206.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor



If is_png_eps eq 1 Then Begin
file_fig= 'Figure2_'+$
        '23'+$
;        file_version+$
        '.png'
FileName=dir_fig+file_fig
image_tvrd  = TVRD(true=1)
Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
endif
If is_png_eps eq 2 Then Begin
Device,/Close 
endif




end