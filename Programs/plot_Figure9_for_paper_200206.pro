;Pro plot_Figure9_for_paper_200206
;pro plot_vdf_in_planes_VB_perp2B_WIND_200006


year_str= '2002'
mon_str = '06'
day_str = '28'
sub_dir_date= $
;a              year_str+'/'+$
              year_str+'-'+mon_str+'/'
sub_dir_date_v2 = year_str+'-'+mon_str+'(v2)/'

dir_data  = '/Work/Data Analysis/WIND data process/Data/Data_for_Paper/'+sub_dir_date+''
dir_fig   = '/Work/Data Analysis/WIND data process/Figures/Figures_for_Paper/'+sub_dir_date_v2+''
dir_figure= dir_fig


Step1:
;=====================
;Step1

num_times = 4L
TimeStr_vect  = Strarr(num_times)
TimeStr_vect(0) = 'y2002m06d28h03m23s27'
TimeStr_vect(1) = 'y2002m06d28h03m27s13'
TimeStr_vect(2) = 'y2002m06d28h03m27s38'
TimeStr_vect(3) = 'y2002m06d28h03m46s29'
TimeStr_vect_v2 = Strarr(num_times)
TimeStr_vect_v2(0)  = '03:23:27'
TimeStr_vect_v2(1)  = '03:27:13'
TimeStr_vect_v2(2)  = '03:27:38'
TimeStr_vect_v2(3)  = '03:46:29'

For i_time=0,num_times-1 Do Begin
  time_str  = TimeStr_vect(i_time)
;;--  
;a time_str  = 'y2000m06d08h07m23s21'
OpenR, 2, dir_data+'WIND_VDF_'+time_str+'.txt'
ReadF, 2, id, jd, kd, format='(3I8)'
ReadF, 2, Vx_RTN, Vy_RTN, Vz_RTN, Bx_RTN, By_RTN, Bz_RTN, format='(6F15.8)' 
Close, 2

Vx_VDF=Vx_RTN & Vy_VDF=Vy_RTN & Vz_VDF=Vz_RTN
Bx_VDF=Bx_RTN & By_VDF=By_RTN & Bz_VDF=Bz_RTN
Vxyz_VDF  = [Vx_VDF,Vy_VDF,Vz_VDF]
Bxyz_VDF  = [Bx_VDF,By_VDF,Bz_VDF]
x_VDF = [1.0,0.0,0.0]
z_VDF = CrossP(Vxyz_VDF,Bxyz_VDF)
z_VDF = z_VDF/NOrm(z_VDF)
y_VDF = Crossp(x_VDF, z_VDF)
BComp_para_V  = Bxyz_VDF##Transpose(x_VDF)
BComp_perp_V  = Bxyz_VDF##Transpose(y_VDF)
BComp_para_V_unit = BComp_para_V/Norm([BComp_para_V,BComp_perp_V])
BComp_perp_V_unit = BComp_perp_V/Norm([BComp_para_V,BComp_perp_V])

time_byte = Byte(time_str)
year_tmp  = Float(String(time_byte(1:4)))
mon_tmp   = Float(String(time_byte(6:7)))
day_tmp   = Float(String(time_byte(9:10)))
hour_tmp  = Float(String(time_byte(12:13)))
min_tmp   = Float(String(time_byte(15:16)))
sec_tmp   = Float(String(time_byte(18:19)))
JulDay_tmp  = JulDay(mon_tmp, day_tmp, year_tmp, hour_tmp, min_tmp, sec_tmp)

;;--
mesh  = 40L
step  = 5.0
num_x = mesh*2 + 1
num_y = num_x

;;--read VDF in the plane with V and B in it, of which V is the x-axis
OpenR, 3, dir_data+'evlt_2d_V&B_'+time_str+'.dat'
ReadF, 3, vol_m,azi_m,el_m,fmax,bx_1,by_1,bx_2,by_2,format='(8e15.8)'
vdf_plane_VB_arr  = Fltarr(num_x, num_y)
xn_vect = step*(Findgen(num_x)-mesh)
yn_vect = step*(Findgen(num_y)-mesh)
lm  = num_x*num_y-1
result  = 0.0
For l=0,lm-1 Do Begin
  ReadF, 3, result,ibv,jbv,format='(e15.8,2i8)'
  vdf_plane_VB_arr(ibv,jbv) = result
EndFor
Close, 3

;;--read VDF in the plane with B and VxB in it, of which B is the x-axis
OpenR, 4, dir_data+'evlt_2d_B&VxB_'+time_str+'.dat'
ReadF, 4, vol_m,azi_m,el_m,fmax,format='(4e15.8)'
vdf_plane_B_VxB_arr  = Fltarr(num_x, num_y)
xn_vect = step*(Findgen(num_x)-mesh)
yn_vect = step*(Findgen(num_y)-mesh)
lm  = num_x*num_y-1
result  = 0.0
For l=0,lm-1 Do Begin
  ReadF, 4, result,ibv,jbv,format='(e15.8,2i8)'
  vdf_plane_B_VxB_arr(ibv,jbv) = result
EndFor
Close, 4
;;;---
If (Bx_VDF lt 0.0) Then Begin
  vdf_plane_B_VxB_arr = Reverse(vdf_plane_B_VxB_arr,1)
EndIf  

;;--read VDF in the plane perpendicular to B, with the axis perp to V and B being the y-axis, B is the z-axis,
OpenR, 5, dir_data+'evlt_2d_perp_B0_'+time_str+'.dat'
ReadF, 5, vol_m,azi_m,el_m,fmax,format='(4e15.8)'
vdf_plane_perp2VB_arr  = Fltarr(num_x, num_y)
xn_vect = step*(Findgen(num_x)-mesh)
yn_vect = step*(Findgen(num_y)-mesh)
lm  = num_x*num_y-1
result  = 0.0
For l=0,lm-1 Do Begin
  ReadF, 5, result,ibv,jbv,format='(e15.8,2i8)'
  vdf_plane_perp2VB_arr(ibv,jbv)  = result
EndFor
Close, 5

;;--
If i_time eq 0 Then Begin
  BComp_para_V_unit_vect  = Fltarr(num_times)
  BComp_perp_V_unit_vect  = Fltarr(num_times)
  vdf_plane_VB_3D_arr = Fltarr(num_x,num_y,num_times)
  vdf_plane_B_VxB_3D_arr = Fltarr(num_x,num_y,num_times)
  vdf_plane_perp2VB_3D_arr = Fltarr(num_x,num_y,num_times)
EndIf

;;--
BComp_para_V_unit_vect(i_time)  = BComp_para_V_unit
BComp_perp_V_unit_vect(i_time)  = BComp_perp_V_unit
vdf_plane_VB_3D_arr(*,*,i_time) = vdf_plane_VB_arr
vdf_plane_B_VxB_3D_arr(*,*,i_time)  = vdf_plane_B_VxB_arr
vdf_plane_perp2VB_3D_arr(*,*,i_time)= vdf_plane_perp2VB_arr


EndFor  ;For i_time=...  



Step3:
;=====================
;Step3


;;--
Set_Plot,'x'
Device,DeComposed=0;, /Retain
xsize=1400.0 & ysize=800.0
Window,9,XSize=xsize,YSize=ysize,Retain=2

;;;--
;LoadCT,13
;TVLCT,R,G,B,/Get
;color_red = 255L
;TVLCT,255L,0L,0L,color_red
;color_green = 254L
;TVLCT,0L,255L,0L,color_green
;color_blue  = 253L
;TVLCT,0L,0L,255L,color_blue
;color_white = 252L
;TVLCT,255L,255L,255L,color_white
;color_black = 251L
;TVLCT,0L,0L,0L,color_black
;num_CB_color= 256-5
;R=Congrid(R,num_CB_color)
;G=Congrid(G,num_CB_color)
;B=Congrid(B,num_CB_color)
;TVLCT,R,G,B

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

XThick=2.0 & YThick=2.0
CharSize=1.5 & CharThick=1.9
Thick=3.0

;;--
position_img  = [0.05,0.05,0.95,0.95]
num_subimgs_x = 4
num_subimgs_y = 2
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
For i_time=0,num_times-1 Do Begin
  time_str  = TimeStr_vect_v2(i_time)
  vdf_plane_VB_arr    = Reform(vdf_plane_VB_3D_arr(*,*,i_time))
  vdf_plane_B_VxB_arr = Reform(vdf_plane_B_VxB_3D_arr(*,*,i_time))
  BComp_para_V_unit = BComp_para_V_unit_vect(i_time)
  BComp_perp_V_unit = BComp_perp_V_unit_vect(i_time)
  
;;--
i_subimg_x  = i_time
i_subimg_y  = 1
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
xrange  = [-150., +150.]
yrange  = [-150., +150.]
half_width_max    = 0.47
winsize_xy_ratio  = xsize/ysize
position_SubImg   = Fig_Position_v2(xrange,yrange,half_width_max=half_width_max,WinSize_xy_ratio=WinSize_xy_ratio,win_position=win_position)
xtitle  = TexToIDL('V //R [km/s]')
ytitle  = TexToIDL('V //(B_0xR)xR [km/s]')
title   = time_str
;;;---
;Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
;    Position=position_subimg, XTitle=xtitle, YTitle=ytitle, /NoData, /NoErase, Color=color_black
contour_arr = vdf_plane_VB_arr/Max(vdf_plane_VB_arr) 
image_TV  = contour_arr

;sub_BadVal  = Where(image_TV eq 0 OR Finite(image_TV) eq 0)
;If sub_BadVal(0) ne -1 Then Begin
;  num_BadVal  = N_Elements(sub_BadVal)
;  image_TV(sub_BadVal)  = 9999.0
;EndIf Else Begin
;  num_BadVal  = 0
;EndElse
;image_TV_v2 = image_TV(Sort(image_TV))
;min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
;If (0.99*(N_Elements(image_TV)) le num_BadVal) Then Begin
;  max_image = image_TV_v2(N_ELements(image_TV)-1)
;EndIf Else Begin  
;  max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
;EndElse  
;byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)

sub_BadVal  = Where(image_TV eq 0 OR Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = -9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV)))+num_BadVal)
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV))))
min_image=0.0 & max_image=0.9
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
byt_image_TV= byt_image_TV+(256-num_CB_color)

color_BadVal= color_white
If sub_BadVal(0) ne -1 Then $
byt_image_TV(sub_BadVal)  = color_BadVal

;levels_vect   = [Bindgen(num_CB_color), color_BadVal]
;color_vect    = [Bindgen(num_CB_color), color_BadVal]

levels_vect   = [color_BadVal, Bindgen(num_CB_color)+(256-num_CB_color)]
color_vect    = [color_BadVal, Bindgen(num_CB_color)+(256-num_CB_color)]

Contour, byt_image_TV, xn_vect, yn_vect, $
  XRange=xrange, YRange=yrange, Position=position_SubImg, XStyle=1+4, YStyle=1+4, $
  /Cell_Fill, /NoErase, $
  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
    Position=position_subimg, XTitle=xtitle, YTitle=ytitle, Title=' ', /NoData, /NoErase, Color=color_black, $
    XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick               
Contour, contour_arr, xn_vect, yn_vect, /noerase, $
  levels=[0.001,0.00316,0.01,0.0316,0.1,0.2,0.4,0.63,0.79,0.98],$
  C_ANNOTATION=['0.001','0.0032','0.01','0.032','0.1','0.2','0.4','0.6','0.8','0.98'],$
  C_LINESTYLE=[1,1,1,2,0,0,0,0,0,0], NoClip=0, Color=color_white, /OverPlot

xplot_vect  = xrange*3*BComp_para_V_unit(0)
yplot_vect  = xrange*3*BComp_perp_V_unit(0)
Plots, xplot_vect, yplot_vect, Color=color_white, Thick=thick, NoClip=0 

;;;---
xpos_tmp  = -130.0
ypos_tmp  = +120.0
xyouts_str= 'SunWard: '
XYOUts, xpos_tmp, ypos_tmp, xyouts_str, CharSize=charsize*1.4, CharThick=charthick*1.5, Color=color_black, /Data
xbeg_arrow  = -10.0
ybeg_arrow  = +120.0
xend_arrow  = xbeg_arrow+40.0
yend_arrow  = +120.0
Arrow, xend_arrow,yend_arrow,xbeg_arrow,ybeg_arrow, HSize=-0.5, /Data, Color=color_black,Thick=thick
  
;;;---
position_CB   = [position_SubImg(0),position_SubImg(3)+0.04,$
      position_SubImg(2),position_SubImg(3)+0.05]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.2)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = ' '
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)##(Bindgen(num_CB_color)+(256-num_CB_color))
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
If (Finite(min_image) eq 0 OR Finite(max_image) eq 0 OR min_image eq 9999.0) Then Begin
  min_image = -1.0
  max_image = 0.0
EndIf
Plot,[min_image,max_image],[1,2],Position=position_CB,XStyle=1,YStyle=1,$
  YTicks=1,YTickName=[' ',' '],XTicks=2,XTickName=tickn_CB,Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=title,XTitle=' ', $
;a  Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3, $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick
   
;;;---
position_subplot  = position_CB
xpos_tmp  = position_subplot(0)-0.02
ypos_tmp  = position_SubPlot(3)+0.01
PanelMark = '(a'+String(i_time+1,format='(I1.1)')+')'
xyouts_str= PanelMark
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 


      
;;--
i_subimg_x  = i_time
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
xrange  = [-150., +150.]
yrange  = [-150., +150.]
half_width_max    = 0.47
winsize_xy_ratio  = xsize/ysize
position_SubImg   = Fig_Position_v2(xrange,yrange,half_width_max=half_width_max,WinSize_xy_ratio=WinSize_xy_ratio,win_position=win_position)
xtitle  = TexToIDL('V //-B_0 [km/s]')
ytitle  = TexToIDL('V //RxB_0 [km/s]')
;;;---
;Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
;    Position=position_subimg, XTitle=xtitle, YTitle=ytitle, /NoData, /NoErase, Color=color_black
contour_arr = vdf_plane_B_VxB_arr/Max(vdf_plane_B_VxB_arr) 
image_TV  = contour_arr

;sub_BadVal  = Where(image_TV eq 0 OR Finite(image_TV) eq 0)
;If sub_BadVal(0) ne -1 Then Begin
;  num_BadVal  = N_Elements(sub_BadVal)
;  image_TV(sub_BadVal)  = 9999.0
;EndIf Else Begin
;  num_BadVal  = 0
;EndElse
;image_TV_v2 = image_TV(Sort(image_TV))
;min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
;If (0.99*(N_Elements(image_TV)) le num_BadVal) Then Begin
;  max_image = image_TV_v2(N_ELements(image_TV)-1)
;EndIf Else Begin  
;  max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
;EndElse  
;byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)

sub_BadVal  = Where(image_TV eq 0 OR Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = -9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV)))+num_BadVal)
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV))))
min_image=0.0 & max_image=0.9
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
byt_image_TV= byt_image_TV+(256-num_CB_color)


color_BadVal= color_white
If sub_BadVal(0) ne -1 Then $
byt_image_TV(sub_BadVal)  = color_BadVal

;levels_vect   = [Bindgen(num_CB_color), color_BadVal]
;color_vect    = [Bindgen(num_CB_color), color_BadVal]

levels_vect   = [color_BadVal, Bindgen(num_CB_color)+(256-num_CB_color)]
color_vect    = [color_BadVal, Bindgen(num_CB_color)+(256-num_CB_color)]

Contour, byt_image_TV, xn_vect, yn_vect, $
  XRange=xrange, YRange=yrange, Position=position_SubImg, XStyle=1+4, YStyle=1+4, $
  /Cell_Fill, /NoErase, $
  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
    Position=position_subimg, XTitle=xtitle, YTitle=ytitle, /NoData, /NoErase, Color=color_black, $
    XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick                    
Contour, contour_arr, xn_vect, yn_vect, /noerase, $
  levels=[0.001,0.00316,0.01,0.0316,0.1,0.2,0.4,0.63,0.79,0.98],$
  C_ANNOTATION=['0.001','0.0032','0.01','0.032','0.1','0.2','0.4','0.6','0.8','0.98'],$
  C_LINESTYLE=[1,1,1,2,0,0,0,0,0,0], NoClip=0, Color=color_white, /OverPlot

xplot_vect  = xrange*3  ;*BComp_para_V_unit(0)
yplot_vect  = xrange*3  ;*BComp_perp_V_unit(0)
yplot_vect  = [0.0, 0.0]
Plots, xplot_vect, yplot_vect, Color=color_white, Thick=thick, NoClip=0 

  
;;;---
position_CB   = [position_SubImg(0),position_SubImg(3)+0.04,$
      position_SubImg(2),position_SubImg(3)+0.05]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.2)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = ' '
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)##(Bindgen(num_CB_color)+(256-num_CB_color))
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
If (Finite(min_image) eq 0 OR Finite(max_image) eq 0 OR min_image eq 9999.0) Then Begin
  min_image = -1.0
  max_image = 0.0
EndIf
Plot,[min_image,max_image],[1,2],Position=position_CB,XStyle=1,YStyle=1,$
  YTicks=1,YTickName=[' ',' '],XTicks=2,XTickName=tickn_CB,Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=title,XTitle=' ', $
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick

;;;---
position_subplot  = position_CB
xpos_tmp  = position_subplot(0)-0.02
ypos_tmp  = position_SubPlot(3)+0.01
PanelMark = '(b'+String(i_time+1,format='(I1.1)')+')'
xyouts_str= PanelMark
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 

         
EndFor  ;For i_time=0,num_times-1 Do Begin

;;--
AnnotStr_tmp  = ' ';'got from "plot_Figure9_for_paper_200206.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
;WSet, 1
image_tvrd  = TVRD(true=1)
file_version= '(v1)'
file_fig  = 'Figure9_'+$
        file_version+$
        '.png'
dir_fig = dir_figure        
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b

;;--
;!p.background = color_bg



end