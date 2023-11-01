;Pro plot_Figure1_for_paper_200206

;year_strf= '2005'
;mon_strf = '12'
;day_strf = '24'
;sub_dir_date= $
;;              year_str+'/'+$
;              year_strf+'-'+mon_strf+'-'+day_strf+'\'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\';+sub_dir_name+sub_dir_date+''
dir_data = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\';+sub_dir_date+''
dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\';+sub_dir_name+sub_dir_date+''


Step1:
;=====================
;Step1

;;--
TimeInterval_str  = '20'

;;--
year_str1 = '2002'
mon_str1 = '05'
day_str1 = '23'

year_str2 = '2002'
mon_str2 = '05'
day_str2 = '24'

year_str3 = '2002'
mon_str3 = '05'
day_str3 = '25'

file_restore = $
            'CorrCoeffs_B_V_components'+$
            '(EveryTimeInterval='+TimeInterval_str+'min)'+$
            '('+year_str1+mon_str1+day_str1+').sav'
Restore, dir_data+file_restore, /Verbose            
;data_descrip  = 'got from "get_CorrCoeffs_B_V_Components_EveryTimeInterval.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  dJulDay_seg, num_segments, JulDay_cent_seg_vect, $
;  Np_bg_seg_vect, Tp_bg_seg_vect, $
;  Bx_bg_seg_vect, By_bg_seg_vect, Bz_bg_seg_vect, $
;  Vx_bg_seg_vect, Vy_bg_seg_vect, Vz_bg_seg_vect, $
;  CC_BxVx_seg_vect, CC_ByVy_seg_vect, CC_BzVz_seg_vect, $
;  BComp_bg_seg_threshold, CC_BV_seg_threshold, $
;  sub_SWP_ASWMS_seg_vect, sub_SWP_SWMS_seg_vect, $
;  TimeStr_beg_seg_SWP_ASWMS_vect, TimeStr_end_seg_SWP_ASWMS_vect, $
;  TimeStr_beg_seg_SWP_SWMS_vect, TimeStr_end_seg_SWP_SWMS_vect
;;---
num_segments_v1 = num_segments
JulDay_cent_seg_vect_v1 = JulDay_cent_seg_vect
Np_bg_seg_vect_v1 = Np_bg_seg_vect
Tp_bg_seg_vect_v1 = Tp_bg_seg_vect
Bx_bg_seg_vect_v1=Bx_bg_seg_vect & By_bg_seg_vect_v1=By_bg_seg_vect & Bz_bg_seg_vect_v1=Bz_bg_seg_vect
AbsB_bg_seg_vect_v1 = Sqrt(Bx_bg_seg_vect^2+By_bg_seg_vect^2+Bz_bg_seg_vect^2)
Vx_bg_seg_vect_v1=Vx_bg_seg_vect & Vy_bg_seg_vect_v1=Vy_bg_seg_vect & Vz_bg_seg_vect_v1=Vz_bg_seg_vect
CC_BxVx_seg_vect_v1=CC_BxVx_seg_vect & CC_ByVy_seg_vect_v1=CC_ByVy_seg_vect & CC_BzVz_seg_vect_v1=CC_BzVz_seg_vect
;CC_nB_seg_vect_v1=CC_nB_seg_vect
sub_SWP_ASWMS_seg_vect_v1 = sub_SWP_ASWMS_seg_vect
sub_SWP_SWMS_seg_vect_v1  = sub_SWP_SWMS_seg_vect
If (sub_SWP_ASWMS_seg_vect_v1(0) eq -1) Then Begin
  sub_SWP_ASWMS_seg_vect_v1 = !values.F_NAN
EndIf
If (sub_SWP_SWMS_seg_vect_v1(0) eq -1) Then Begin
  sub_SWP_SWMS_seg_vect_v1 = !values.F_NAN
EndIf


;;--

file_restore = $
            'CorrCoeffs_B_V_components'+$
            '(EveryTimeInterval='+TimeInterval_str+'min)'+$
            '('+year_str2+mon_str2+day_str2+').sav'
Restore, dir_data+file_restore, /Verbose            
;data_descrip  = 'got from "get_CorrCoeffs_B_V_Components_EveryTimeInterval.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  dJulDay_seg, num_segments, JulDay_cent_seg_vect, $
;  Np_bg_seg_vect, Tp_bg_seg_vect, $
;  Bx_bg_seg_vect, By_bg_seg_vect, Bz_bg_seg_vect, $
;  Vx_bg_seg_vect, Vy_bg_seg_vect, Vz_bg_seg_vect, $
;  CC_BxVx_seg_vect, CC_ByVy_seg_vect, CC_BzVz_seg_vect, $
;  BComp_bg_seg_threshold, CC_BV_seg_threshold, $
;  sub_SWP_ASWMS_seg_vect, sub_SWP_SWMS_seg_vect, $
;  TimeStr_beg_seg_SWP_ASWMS_vect, TimeStr_end_seg_SWP_ASWMS_vect, $
;  TimeStr_beg_seg_SWP_SWMS_vect, TimeStr_end_seg_SWP_SWMS_vect
;;;---
num_segments_v2 = num_segments
JulDay_cent_seg_vect_v2 = JulDay_cent_seg_vect
Np_bg_seg_vect_v2 = Np_bg_seg_vect
Tp_bg_seg_vect_v2 = Tp_bg_seg_vect
Bx_bg_seg_vect_v2=Bx_bg_seg_vect & By_bg_seg_vect_v2=By_bg_seg_vect & Bz_bg_seg_vect_v2=Bz_bg_seg_vect
AbsB_bg_seg_vect_v2 = Sqrt(Bx_bg_seg_vect^2+By_bg_seg_vect^2+Bz_bg_seg_vect^2)
Vx_bg_seg_vect_v2=Vx_bg_seg_vect & Vy_bg_seg_vect_v2=Vy_bg_seg_vect & Vz_bg_seg_vect_v2=Vz_bg_seg_vect
CC_BxVx_seg_vect_v2=CC_BxVx_seg_vect & CC_ByVy_seg_vect_v2=CC_ByVy_seg_vect & CC_BzVz_seg_vect_v2=CC_BzVz_seg_vect
;CC_nB_seg_vect_v2=CC_nB_seg_vect
sub_SWP_ASWMS_seg_vect_v2 = sub_SWP_ASWMS_seg_vect
sub_SWP_SWMS_seg_vect_v2  = sub_SWP_SWMS_seg_vect
If (sub_SWP_ASWMS_seg_vect_v2(0) eq -1) Then Begin
  sub_SWP_ASWMS_seg_vect_v2 = !values.F_NAN
EndIf
If (sub_SWP_SWMS_seg_vect_v2(0) eq -1) Then Begin
  sub_SWP_SWMS_seg_vect_v2 = !values.F_NAN
EndIf

;;--
;day_str = '23'
file_restore = $
            'CorrCoeffs_B_V_components'+$
            '(EveryTimeInterval='+TimeInterval_str+'min)'+$
            '('+year_str3+mon_str3+day_str3+').sav'
Restore, dir_data+file_restore, /Verbose            
;data_descrip  = 'got from "get_CorrCoeffs_B_V_Components_EveryTimeInterval.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  dJulDay_seg, num_segments, JulDay_cent_seg_vect, $
;  Np_bg_seg_vect, Tp_bg_seg_vect, $
;  Bx_bg_seg_vect, By_bg_seg_vect, Bz_bg_seg_vect, $
;  Vx_bg_seg_vect, Vy_bg_seg_vect, Vz_bg_seg_vect, $
;  CC_BxVx_seg_vect, CC_ByVy_seg_vect, CC_BzVz_seg_vect, $
;  BComp_bg_seg_threshold, CC_BV_seg_threshold, $
;  sub_SWP_ASWMS_seg_vect, sub_SWP_SWMS_seg_vect, $
;  TimeStr_beg_seg_SWP_ASWMS_vect, TimeStr_end_seg_SWP_ASWMS_vect, $
;  TimeStr_beg_seg_SWP_SWMS_vect, TimeStr_end_seg_SWP_SWMS_vect
;;;---
num_segments_v3 = num_segments
JulDay_cent_seg_vect_v3 = JulDay_cent_seg_vect
Np_bg_seg_vect_v3 = Np_bg_seg_vect
Tp_bg_seg_vect_v3 = Tp_bg_seg_vect
Bx_bg_seg_vect_v3=Bx_bg_seg_vect & By_bg_seg_vect_v3=By_bg_seg_vect & Bz_bg_seg_vect_v3=Bz_bg_seg_vect
AbsB_bg_seg_vect_v3 = Sqrt(Bx_bg_seg_vect^2+By_bg_seg_vect^2+Bz_bg_seg_vect^2)
Vx_bg_seg_vect_v3=Vx_bg_seg_vect & Vy_bg_seg_vect_v3=Vy_bg_seg_vect & Vz_bg_seg_vect_v3=Vz_bg_seg_vect
CC_BxVx_seg_vect_v3=CC_BxVx_seg_vect & CC_ByVy_seg_vect_v3=CC_ByVy_seg_vect & CC_BzVz_seg_vect_v3=CC_BzVz_seg_vect
;CC_nB_seg_vect_v3=CC_nB_seg_vect
sub_SWP_ASWMS_seg_vect_v3 = sub_SWP_ASWMS_seg_vect
sub_SWP_SWMS_seg_vect_v3  = sub_SWP_SWMS_seg_vect
If (sub_SWP_ASWMS_seg_vect_v3(0) eq -1) Then Begin
  sub_SWP_ASWMS_seg_vect_v3 = !values.F_NAN
EndIf
If (sub_SWP_SWMS_seg_vect_v3(0) eq -1) Then Begin
  sub_SWP_SWMS_seg_vect_v3 = !values.F_NAN
EndIf
  


;;--
JulDay_cent_seg_vect  = [JulDay_cent_seg_vect_v1, JulDay_cent_seg_vect_v2, JulDay_cent_seg_vect_v3]
Np_bg_seg_vect  = [Np_bg_seg_vect_v1,Np_bg_seg_vect_v2,Np_bg_seg_vect_v3]
AbsB_bg_seg_vect= [AbsB_bg_seg_vect_v1,AbsB_bg_seg_vect_v2,AbsB_bg_seg_vect_v3]
Tp_bg_seg_vect  = [Tp_bg_seg_vect_v1,Tp_bg_seg_vect_v2,Tp_bg_seg_vect_v3]
Bx_bg_seg_vect  = [Bx_bg_seg_vect_v1,Bx_bg_seg_vect_v2,Bx_bg_seg_vect_v3]
Vx_bg_seg_vect  = [Vx_bg_seg_vect_v1,Vx_bg_seg_vect_v2,Vx_bg_seg_vect_v3]
By_bg_seg_vect  = [By_bg_seg_vect_v1,By_bg_seg_vect_v2,By_bg_seg_vect_v3]
Vy_bg_seg_vect  = [Vy_bg_seg_vect_v1,Vy_bg_seg_vect_v2,Vy_bg_seg_vect_v3]
Bz_bg_seg_vect  = [Bz_bg_seg_vect_v1,Bz_bg_seg_vect_v2,Bz_bg_seg_vect_v3]
Vz_bg_seg_vect  = [Vz_bg_seg_vect_v1,Vz_bg_seg_vect_v2,Vz_bg_seg_vect_v3] 
CC_BxVx_seg_vect= [CC_BxVx_seg_vect_v1,CC_BxVx_seg_vect_v2,CC_BxVx_seg_vect_v3]
CC_ByVy_seg_vect= [CC_ByVy_seg_vect_v1,CC_ByVy_seg_vect_v2,CC_ByVy_seg_vect_v3]
CC_BzVz_seg_vect= [CC_BzVz_seg_vect_v1,CC_BzVz_seg_vect_v2,CC_BzVz_seg_vect_v3]
;CC_nB_seg_vect  = [CC_nB_seg_vect_v1,CC_nB_seg_vect_v2,CC_nB_seg_vect_v3]
sub_SWP_ASWMS_seg_vect  = [sub_SWP_ASWMS_seg_vect_v1, $
                            N_Elements(Np_bg_seg_vect_v1)+sub_SWP_ASWMS_seg_vect_v2, $
                            N_Elements(Np_bg_seg_vect_v1)+N_Elements(Np_bg_seg_vect_v2)+sub_SWP_ASWMS_seg_vect_v3]
sub_SWP_SWMS_seg_vect  = [sub_SWP_SWMS_seg_vect_v1, $
                            N_Elements(Np_bg_seg_vect_v1)+sub_SWP_SWMS_seg_vect_v2, $
                            N_Elements(Np_bg_seg_vect_v1)+N_Elements(Np_bg_seg_vect_v2)+sub_SWP_SWMS_seg_vect_v3]
                            


Step1_2:
;=====================
;Step1_2
;
;;--
file_restore  = 'wi_elpd_3dp_'+year_str1+mon_str1+day_str1+'_v02.sav'
Restore, dir_data+file_restore, /Verbose
;data_descrip= 'got from "Read_elpd_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: Flux [1/cm^2/s/sr/eV], Energy [eV]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Ener_arr, PitchAng_arr, Flux_arr, $
;  JulDay_vect_plot, PitchAng_vect_plot, Flux_arr_plot
;;;---
JulDay_vect_elpd_v1 = JulDay_vect_plot
Ener_vect = Reform(Ener_arr(*,0))
num_eners = N_Elements(Ener_vect)
ener_plot = 165.0 ;unit: eV
val_min = Min(Abs(Ener_vect - ener_plot), sub_min)
sub_ener= sub_min(0)
Flux_arr_plot_v1  = Reform(Flux_arr_plot(*,sub_ener,*))

;;--
file_restore  = 'wi_elpd_3dp_'+year_str2+mon_str2+day_str2+'_v02.sav'
Restore, dir_data+file_restore, /Verbose
;data_descrip= 'got from "Read_elpd_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: Flux [1/cm^2/s/sr/eV], Energy [eV]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Ener_arr, PitchAng_arr, Flux_arr, $
;  JulDay_vect_plot, PitchAng_vect_plot, Flux_arr_plot
;;;---
JulDay_vect_elpd_v2 = JulDay_vect_plot
Ener_vect = Reform(Ener_arr(*,0))
num_eners = N_Elements(Ener_vect)
ener_plot = 165.0 ;unit: eV
val_min = Min(Abs(Ener_vect - ener_plot), sub_min)
sub_ener= sub_min(0)
Flux_arr_plot_v2  = Reform(Flux_arr_plot(*,sub_ener,*))

;;--
file_restore  = 'wi_elpd_3dp_'+year_str3+mon_str3+day_str3+'_v02.sav'
Restore, dir_data+file_restore, /Verbose
;data_descrip= 'got from "Read_elpd_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: Flux [1/cm^2/s/sr/eV], Energy [eV]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Ener_arr, PitchAng_arr, Flux_arr, $
;  JulDay_vect_plot, PitchAng_vect_plot, Flux_arr_plot
;;;---
JulDay_vect_elpd_v3 = JulDay_vect_plot
Ener_vect = Reform(Ener_arr(*,0))
num_eners = N_Elements(Ener_vect)
ener_plot = 165.0 ;unit: eV
val_min = Min(Abs(Ener_vect - ener_plot), sub_min)
sub_ener= sub_min(0)
ener_plot = Ener_vect(sub_ener)
Flux_arr_plot_v3  = Reform(Flux_arr_plot(*,sub_ener,*))

;;--
JulDay_vect_elpd  = [JulDay_vect_elpd_v1, JulDay_vect_elpd_v2, JulDay_vect_elpd_v3]
Flux_arr_plot = [Transpose(Flux_arr_plot_v1),Transpose(Flux_arr_plot_v2),Transpose(Flux_arr_plot_v3)]



Step2:
;=====================
;Step2

;;--
read,'png(1) or eps(2)',is_png_eps

If is_png_eps eq 2 Then Begin
Set_Plot,'PS'
file_version  = '(v1)'
file_fig= 'Figure1_'+$
        '3d'+$
        file_version+$
        '.eps'
xsize = 23.0
ysize = 24.0
Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
EndIf 
If is_png_eps eq 1 Then Begin
  Set_Plot,'win'
  Device,DeComposed=0;, /Retain
  xsize=1100.0 & ysize=1200.0
  Window,4,XSize=xsize,YSize=ysize,Retain=2
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
position_img  = [0.07,0.08,0.97,0.9]

;;--
num_subimgs_x = 1
num_subimgs_y = 9
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.08
x_margin_right= 0.93
y_margin_bot  = 0.07
y_margin_top  = 0.93

thick   = 5.0
xthick  = 3.0
ythick  = 3.0
charthick = 2.5
charsize  = 1.0

;;--
For i_subimg_y = 0,8 Do Begin

If i_subimg_y eq 8 Then PanelMark_str = '(a)'
If i_subimg_y eq 7 Then PanelMark_str = '(b)'
If i_subimg_y eq 6 Then PanelMark_str = '(c)'
If i_subimg_y eq 5 Then PanelMark_str = '(d)'
If i_subimg_y eq 4 Then PanelMark_str = '(e)'
If i_subimg_y eq 3 Then PanelMark_str = '(f)'
If i_subimg_y eq 2 Then PanelMark_str = '(g)'
If i_subimg_y eq 1 Then PanelMark_str = '(h)'
If i_subimg_y eq 0 Then PanelMark_str = '(i)'

i_subimg_x  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
position_subimg = position_subplot
xplot_vect  = JulDay_cent_seg_vect


If i_subimg_y gt 0 Then Begin


If i_subimg_y eq 8 Then Begin
  is_two_yaxes  = 1
  yplot_vect_v1 = Np_bg_seg_vect
  yplot_vect_v2 = AbsB_bg_seg_vect
  ytitle_v1=TexToIDL('N_{p}[cm^{-3}]') & ytitle_v2=TexToIDL('|B| [nT]')
EndIf  
If i_subimg_y eq 7 Then Begin
  is_two_yaxes= 0
  yplot_vect  = Tp_bg_seg_vect
  ytitle=TexToIDL('Tp [10^4K]')
EndIf  
If i_subimg_y eq 6 Then Begin
  is_two_yaxes  = 1
  yplot_vect_v2= Bx_bg_seg_vect
  yplot_vect_v1= Vx_bg_seg_vect
  ytitle_v2=TexToIDL('Bx_{GSE} [nT]') & ytitle_v1=TexToIDL('Vx [km/s]')
EndIf  
If i_subimg_y eq 5 Then Begin
  is_two_yaxes  = 1
  yplot_vect_v2= By_bg_seg_vect
  yplot_vect_v1= Vy_bg_seg_vect 
  ytitle_v2=TexToIDL('By_{GSE} [nT]') & ytitle_v1=TexToIDL('Vy [km/s]') 
EndIf  
If i_subimg_y eq 4 Then Begin
  is_two_yaxes  = 1
  yplot_vect_v2= Bz_bg_seg_vect
  yplot_vect_v1= Vz_bg_seg_vect
  ytitle_v2=TexToIDL('Bz_{GSE} [nT]') & ytitle_v1=TexToIDL('Vz [km/s]')
EndIf  
If i_subimg_y eq 3 Then Begin
  is_two_yaxes  = 0
  yplot_vect  = CC_BxVx_seg_vect 
  ytitle  = TexToIDL('CC_{[Bx,Vx]}')
EndIf         
If i_subimg_y eq 2 Then Begin
  is_two_yaxes  = 0
  yplot_vect  = CC_ByVy_seg_vect 
  ytitle  = TexToIDL('CC_{[By,Vy]}')
EndIf  
If i_subimg_y eq 1 Then Begin
  is_two_yaxes  = 0
  yplot_vect  = CC_BzVz_seg_vect
  ytitle  = TexToIDL('CC_{[Bz,Vz]}')
EndIf 


dJulDay_seg = JulDay_cent_seg_vect(1)-JulDay_cent_seg_vect(0)
xrange  = [Min(JulDay_cent_seg_vect)-0.5*dJulDay_seg, Max(JulDay_cent_seg_vect)+0.5*dJulDay_seg]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
;xminor  = xminor_time
xminor    = 8

num_ticks   = N_Elements(xticknames)
If i_subimg_y gt 0 Then Begin
  xticknames  = Replicate(' ', num_ticks)
EndIf  

If i_subimg_y gt 0 Then Begin
If is_two_yaxes eq 0 Then Begin
  yrange  = [Min(yplot_vect),Max(yplot_vect)]
  yrange  = [yrange(0)-0.1*(yrange(1)-yrange(0)), yrange(1)+0.1*(yrange(1)-yrange(0))]
EndIf Else Begin
  yrange  = [Min(yplot_vect_v1),Max(yplot_vect_v1)]
  yrange  = [yrange(0)-0.1*(yrange(1)-yrange(0)), yrange(1)+0.1*(yrange(1)-yrange(0))]
  yrange_v1 = yrange
  yrange  = [Min(yplot_vect_v2),Max(yplot_vect_v2)]
  yrange  = [yrange(0)-0.1*(yrange(1)-yrange(0)), yrange(1)+0.1*(yrange(1)-yrange(0))]
  yrange_v2 = yrange  
EndElse
EndIf

xtitle    = ' '

If i_subimg_y le 3 and i_subimg_y gt 0 Then Begin
  yrange  = [-1.2, +1.2]
EndIf  

If i_subimg_y ge 1 Then Begin
If is_two_yaxes eq 1 Then Begin
  yplot_vect  = yplot_vect_v1
  yrange      = yrange_v1
  ytitle      = ytitle_v1
  ystyle  = 1+8
EndIf Else Begin
  ystyle  = 1
EndElse  
EndIf
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=ystyle,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick


;;;---
If (i_subimg_y le 3) Then Begin
;  Plots, xrange, [0.0,0.0], LineStyle=2, Thick=1.2, Color=color_black
  Plots, xrange, [-.5,-.5], LineStyle=2, Color=color_black, NoClip=0, Thick=thick*0.8
  Plots, xrange, [+.5,+.5], LineStyle=2, Color=color_black, NoClip=0, Thick=thick*0.8
EndIf
  
;;;--画蓝色点
;If (sub_SWP_ASWMS_seg_vect(0) ne -1) Then Begin
;  sub_tmp = sub_SWP_ASWMS_seg_vect
;;a  Plots, xplot_vect(sub_tmp), yplot_vect(sub_tmp), Color=color_blue, PSym=2, Thick=1.5
;  PlotSym, 0, 1.0, FILL=1,thick=0.5,Color=color_blue
;  Plots, xplot_vect(sub_tmp), yplot_vect(sub_tmp), Psym=8, NoClip=0
;EndIf
;If (sub_SWP_SWMS_seg_vect(0) ne -1) Then Begin
;  sub_tmp = sub_SWP_SWMS_seg_vect
;;a  Plots, xplot_vect(sub_tmp), yplot_vect(sub_tmp), Color=color_blue, PSym=2, Thick=1.5
;  PlotSym, 0, 1.0, FILL=1,thick=0.5,Color=color_blue
;  Plots, xplot_vect(sub_tmp), yplot_vect(sub_tmp), Psym=8, NoClip=0    
;EndIf

;;;---
If is_two_yaxes eq 1 Then Begin
  Axis, xrange(1), YAxis=1, /Save, $
    YRange=yrange_v2, YStyle=1, $
    YTitle=ytitle_v2, Color=color_red, $
    XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick
  Plots, xplot_vect, yplot_vect_v2, Color=color_red, Thick=thick, NoClip=0    

;;--
If (i_subimg_y eq 4 or i_subimg_y eq 5 or i_subimg_y eq 6) Then Begin
  Plots, xrange, [0.0,0.0], LineStyle=2, Color=color_red, NoClip=0, Thick=thick*0.8
;a  Plots, xrange, [-1.,-1.], LineStyle=2, Color=color_red, NoClip=0, Thick=thick*0.8
;a  Plots, xrange, [+1.,+1.], LineStyle=2, Color=color_red, NoClip=0, Thick=thick*0.8
EndIf

;;;;;----画蓝色点
;If (sub_SWP_ASWMS_seg_vect(0) ne -1) Then Begin
;  sub_tmp = sub_SWP_ASWMS_seg_vect
;;a  Plots, xplot_vect(sub_tmp), yplot_vect_v2(sub_tmp), Color=color_blue, PSym=2, Thick=1.5
;  PlotSym, 0, 1.0, FILL=1,thick=0.5,Color=color_blue
;  Plots, xplot_vect(sub_tmp), yplot_vect_v2(sub_tmp), Psym=8, NoClip=0  
;EndIf
;If (sub_SWP_SWMS_seg_vect(0) ne -1) Then Begin
;  sub_tmp = sub_SWP_SWMS_seg_vect
;;a  Plots, xplot_vect(sub_tmp), yplot_vect_v2(sub_tmp), Color=color_blue, PSym=2, Thick=1.5
;  PlotSym, 0, 1.0, FILL=1,thick=0.5,Color=color_blue
;  Plots, xplot_vect(sub_tmp), yplot_vect_v2(sub_tmp), Psym=8, NoClip=0  
;EndIf

EndIf ;If is_two_yaxes eq 1



EndIf Else Begin  ;If i_subimg_y gt 0 Then Begin

image_TV  = Alog10(Flux_arr_plot)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = ' '
ytitle  = 'Pitch Angle'
title = String(ener_plot, format='(I)')
title = StrTrim(title, 1)
title = ' '
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
dJulDay_pix = JulDay_vect_elpd(1)-JulDay_vect_elpd(0)
xrange  = [Min(JulDay_vect_elpd)-0.5*dJulDay_pix, Max(JulDay_vect_elpd)+0.5*dJulDay_pix]
yrange  = [0.0, 180.0]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 8
;xminor    = xminor_time
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,YTicks=4,$
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,$
  CharThick=charthick,Thick=thick,XThick=xthick,YThick=ythick,CharSize=charsize,$
  YLog=0
;;;---
position_CB   = [position_SubImg(2)+0.07,position_SubImg(1),$
          position_SubImg(2)+0.09,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('lg[1/cm^2/s/sr/eV]@164eV')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=' ', $;titleCB, $
  CharThick=charthick,Thick=thick,XThick=xthick,YThick=ythick,CharSize=charsize
  
xpos_tmp  = position_CB(0)-0.04
ypos_tmp  = 0.5*(position_CB(1)+position_CB(3))+0.05  
XYOuts, xpos_tmp, ypos_tmp, titleCB,  Alignment=0.5, Orientation=90.0, $
      Color=color_black, /Normal, $
      CharThick=charthick,CharSize=charsize*0.8 


EndElse ;If i_subimg_y gt 0 Then Begin



If i_subimg_y eq 0 Then Begin
  JulDay_range  = xrange
  position_plot = position_subplot
  dypos_xyouts  = 0.05
  color_xyouts=color_black & charsize_xyouts=1.2 & charthick_xyouts=charthick
  xyouts_DateStr_at_XAxis_Bottom, $
    JulDay_range, position_plot, $
    dypos_xyouts=dypos_xyouts, $
    color=color_xyouts, charsize=charsize_xyouts, charthick=charthick_xyouts
EndIf  

;;;---
xpos_tmp  = position_subplot(0)-0.13
ypos_tmp  = 0.5*(position_subplot(1)+position_subplot(3))
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 
  
EndFor ;For i_subimg_y = 0,7 Do Begin


;;--
AnnotStr_tmp  = ' ';'got from "plot_Figure1_for_Paper_200206.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
;a Annotstr_tmp  = year_str+mon_str;+day_str+'; '+sub_dir_date
;a AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor




If is_png_eps eq 1 Then Begin
file_fig= 'Figure1_'+$
        '3d'+$
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