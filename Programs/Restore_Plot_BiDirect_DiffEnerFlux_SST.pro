;Pro Restore_Plot_BiDirect_DiffEnerFlux_SST


;   t_p:  time in seconds from 1970-1-1
;   eng_par_p : the energy  (eV)  of protons travelling parallel to the IMF
;   eflx_par_p : the energy flux (eV/ (s str cm^2))  of protons travelling parallel to the IMF
;   eng_antip_p : the energy  (eV)  of protons travelling anti-parallel to the IMF
;   eflx_antip_p : the energy flux (eV/ (s str cm^2))  of protons travelling anti-parallel to the IMF
;
;   t_e:  time in seconds from 1970-1-1
;   eng_par_e : the energy  (eV)  of electrons travelling parallel to the IMF
;   eflx_par_e : the energy flux (eV/ (s str cm^2))  of electrons travelling parallel to the IMF
;   eng_antip_e : the energy  (eV)  of electrons travelling anti-parallel to the IMF
;   eflx_antip_e : the energy flux (eV/ (s str cm^2))  of electrons travelling anti-parallel to the IMF
;
;    flx_par_e and flx_antip_e : electron difference flux 1/(cm^2 s sr eV))    
;    flx_par_p and flx_antip_p : electron difference flux 1/(cm^2 s sr eV))  
    
year_str  = '2002'
mon_str   = '05'
day_str   = '24'
sub_dir_date  = 'wind\Alfven\'
dir_data  = 'C:\Users\pzt\course\Research\CDF_wind\'+  $
            sub_dir_date
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+$
            sub_dir_date  


Step1:
;=====================
;Step1

;;--
file_data = 'SST_flx_2002May24 (1).dat'

Restore, dir_data+file_data, /Verbose

;;--
JulDay_1970 = JulDay(1, 1, 1970, 0, 0, 0)
JulDay_p_vect = JulDay_1970 + t_p / (24.*60*60)
JulDay_e_vect = JulDay_1970 + t_e / (24.*60*60)

num_times_p = (Size(eng_par_p))[1]
num_times_e = (Size(eng_par_e))[1]
num_engs_e  = (Size(eng_par_e))[2]
num_engs_p  = (Size(eng_par_p))[2]

eng_par_p_vect  = Fltarr(num_engs_p)
eng_antip_p_vect= Fltarr(num_engs_p)
eng_par_e_vect  = Fltarr(num_engs_e)
eng_antip_e_vect= Fltarr(num_engs_e)
For i_eng=0,num_engs_p-1 Do Begin
  eng_par_p_vect(i_eng)   = Mean(eng_par_p(*,i_eng),/nan)
  eng_antip_p_vect(i_eng) = Mean(eng_antip_p(*,i_eng),/nan)
EndFor
For i_eng=0,num_engs_e-1 Do Begin
  eng_par_e_vect(i_eng)   = Mean(eng_par_e(*,i_eng),/nan)
  eng_antip_e_vect(i_eng) = Mean(eng_antip_e(*,i_eng),/nan)
EndFor  
eng_par_p_v2  = (Fltarr(num_times_p)+1.0) # eng_par_p_vect
eng_antip_p_v2= (Fltarr(num_times_p)+1.0) # eng_antip_p_vect
eng_par_e_v2  = (Fltarr(num_times_e)+1.0) # eng_par_e_vect
eng_antip_e_v2= (Fltarr(num_times_e)+1.0) # eng_antip_e_vect


;flux_par_p  = eflx_par_p / eng_par_p_v2  ;unit: 1/cm^2/sr/s
;flux_antip_p= eflx_antip_p / eng_antip_p_v2
;flux_par_e  = eflx_par_e / eng_par_e_v2
;flux_antip_e= eflx_antip_e / eng_antip_e_v2
flux_par_p  = flx_par_p
flux_antip_p= flx_antip_p
flux_par_e  = flx_par_e
flux_antip_e= flx_antip_e


JulDay_beg_plot = Min(JulDay_p_vect)
JulDay_end_plot = Max(JulDay_p_vect)
CalDat, JulDay_beg_plot, mon_tmp,day_tmp,year_tmp,hour_beg_plot,min_beg_plot,sec_beg_plot
CalDat, JulDay_end_plot, mon_tmp,day_tmp,year_tmp,hour_end_plot,min_end_plot,sec_end_plot
timestr_beg_plot  = String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')
timestr_end_plot  = String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')
timerange_str_plot= '(time='+timestr_beg_plot+'-'+timestr_end_plot+')'




Step2:
;=====================
;Step2

;;--
is_plot_eflux_flux  = 2 ;can only be flux
Print, 'is_plot_eflux_flux (1/2 for eflux/flux): '
Print, is_plot_eflux_flux
is_continue = ' '
Read, 'is_continue: ', is_continue
If is_plot_eflux_flux eq 2 Then Begin
  eflx_par_p=flux_par_p & eflx_antip_p=flux_antip_p
  eflx_par_e=flux_par_e & eflx_antip_e=flux_antip_e
EndIf  

;;--
Set_Plot,'win'
Device,DeComposed=0;, /Retain
xsize=1500.0 & ysize=800.0
Window,3,XSize=xsize,YSize=ysize,Retain=2

;;--
LoadCT,13
TVLCT,R,G,B,/Get
;Restore, '/Work/Data Analysis/Programs/RainBow(reset).sav', /Verbose
n_colors  = 256
;RainBow_Matlab, R,G,B, n_colors
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
color_magenta = 5L
TVLCT, 255L,0L,255L, color_magenta
R_magenta=255L & G_magenta=0L & B_magenta=255L
color_cyan = 6L
TVLCT, 0L,255L,255L, color_cyan
R_cyan=0L & G_cyan=255L & B_cyan=255L
color_orange = 7L
TVLCT, 255L,127L,0L, color_orange
R_orange=255L & G_orange=127L & B_orange=255L
color_brown = 8L
TVLCT, 153L,102L,51L, color_brown
R_brown=153L & G_brown=102L & B_brown=51L


num_CB_color= 256-9
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
R = [R_red,R_green,R_blue,R_black,R_white,R_magenta,R_cyan,R_orange,R_brown, R]
G = [G_red,G_green,G_blue,G_black,G_white,G_magenta,G_cyan,G_orange,G_brown, G]
B = [B_red,B_green,B_blue,B_black,B_white,B_magenta,B_cyan,B_orange,B_brown, B]
TVLCT,R,G,B

color_vect  = [color_red,color_green,color_blue,color_black,color_magenta,color_cyan,color_orange,color_brown]

;;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

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


For i_subimg_x=0,1 Do Begin
For i_subimg_y=0,1 Do Begin
  If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin ;kx for Zp with min eigen-value
    xplot_vect  = JulDay_p_vect
    yplot_arr   = eflx_par_p
    xyouts_vect = eng_par_p_vect    
    If is_plot_eflux_flux eq 1 Then title = 'eflux_par_p' Else title='flux_par_p'
  EndIf
  If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin ;ky for Zp with min eigen-value
    xplot_vect  = JulDay_p_vect
    yplot_arr   = eflx_antip_p    
    xyouts_vect = eng_antip_p_vect
    If is_plot_eflux_flux eq 1 Then title = 'eflux_antip_p' Else title='flux_antip_p'
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin ;kz for Zp with min eigen-value
    xplot_vect  = JulDay_e_vect
    yplot_arr   = eflx_par_e    
    xyouts_vect = eng_par_e_vect
    If is_plot_eflux_flux eq 1 Then title = 'eflux_par_e' Else title='flux_par_e'
  EndIf
  If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin ;ky for Zp with min eigen-value
    xplot_vect  = JulDay_e_vect
    yplot_arr   = eflx_antip_e  
    xyouts_vect = eng_antip_e_vect  
    If is_plot_eflux_flux eq 1 Then title = 'eflux_antip_e' Else title='flux_antip_e'
  EndIf
    
;;--  
xrange  = [Min(xplot_vect)-0.5*(xplot_vect(1)-xplot_vect(0)), Max(xplot_vect)+0.5*(xplot_vect(1)-xplot_vect(0))]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6

yplot_arr_v2  = yplot_arr
sub_BadVal  = Where(Finite(yplot_arr_v2) eq 0 or yplot_arr_v2 eq 0.0)
num_BadVal  = N_Elements(sub_BadVal)
Print, 'num_BadVal: ', num_BadVal
If sub_BadVal(0) ne -1 Then Begin
  yplot_arr_v2(sub_BadVal) = 0.0
EndIf  
yplot_arr_v2  = yplot_arr_v2(Sort(yplot_arr_v2))
min_yval  = yplot_arr_v2(Long(0.01*(N_Elements(yplot_arr_v2)))+num_BadVal)
yrange    = [Min(yplot_arr,/NaN) > min_yval, Max(yplot_arr,/NaN)]
lg_yrange = ALog10(yrange)
yrange    = 10.^[lg_yrange(0)-0.2*(lg_yrange(1)-lg_yrange(0)), lg_yrange(1)+0.1*(lg_yrange(1)-lg_yrange(0))]

xtitle    = ' '
If (i_subimg_x eq 0) Then Begin
  If is_plot_eflux_flux eq 1 Then Begin
    ytitle  = 'eflux [eV/cm^2/sr/s]'
  EndIf Else Begin
    ytitle  = 'flux [/cm^2/sr/s/eV]'
  EndElse
EndIf Else Begin
  ytitle  = ' '
EndElse  


;;--
win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
position_subplot  = win_position
position_SubImg   = position_SubPlot
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, CharSize=1.2, $
    Position=position_subimg, /NoData, /NoErase, Color=color_black, $
    XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,$
    XTitle=xtitle,YTitle=ytitle,Title=title, $
    XTickLen=-0.02,YTickLen=-0.02, YLog=1

num_engs  = (Size(yplot_arr))[2]
For i_eng=0,num_engs-1 Do Begin
  yplot_vect  = Reform(yplot_arr(*,i_eng))
  num_colors  = N_Elements(color_vect)
  i_color = i_eng Mod num_colors
  color_tmp = color_vect(i_color)
  Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1+4,YStyle=1+4,$
    Position=position_subplot,$
;a    XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
;a    XTitle=xtitle,YTitle=ytitle,$
    Color=color_tmp,$
    /NoErase, Font=-1, YLog=1,$
    XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5
  xyouts_str  = String(xyouts_vect(i_eng), format='(g12.5)')
  xpos_tmp  = position_subplot(2)+0.01
  ypos_tmp  = position_subplot(3)-(position_subplot(3)-position_subplot(1))/(num_engs+1)*(i_eng+1) 
  XYOuts, xpos_tmp, ypos_tmp, xyouts_str,  /Normal, CharSize=0.95, color=color_tmp, Font=-1   
EndFor
 
EndFor
EndFor


;;--
AnnotStr_tmp  = 'got from "Restore_Plot_BiDirect_DiffEnerFlux_SST.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
Annotstr_tmp  = year_str+mon_str+day_str+';  energy [eV]'
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
file_version  = ''
If is_plot_eflux_flux eq 1 Then Begin
file_fig= 'BiDirect_EnerFlux_p&e_SST'+$
        timerange_str_plot+$
        '('+year_str+mon_str+day_str+')'+$
        file_version+$
        '.png'
EndIf Else Begin
file_fig= 'BiDirect_DiffFlux_p&e_SST'+$
        timerange_str_plot+$
        '('+year_str+mon_str+day_str+')'+$
        file_version+$
        '.png'
EndElse        
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b






End_Program:
End