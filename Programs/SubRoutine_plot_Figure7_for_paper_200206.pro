;Called by plot_Figure4567_for_paper_200206
Pro subroutine_plot_Figure7_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  mark_OutAW_arr, mark_OutQPSW_arr, mark_InAW_arr, mark_InQPSW_arr, $
  FileName=FileName, is_png_eps=is_png_eps


;;--
If is_png_eps eq 2 Then Begin
  Set_Plot,'PS'
  xsize = 20.0
  ysize = 24.0
  Device, FileName=FileName, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
EndIf Else Begin
If is_png_eps eq 1 Then Begin
  Set_Plot,'win'
  Device,DeComposed=0;, /Retain
  xsize=1300.0 & ysize=850.0
  Window,7,XSize=xsize,YSize=ysize,Retain=2
EndIf
EndElse

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
EndIf

XThick=2.0 & YThick=2.0
CharSize=1.5 & CharThick=1.5
Thick=2.0

;;--
position_img_v1 = [0.04,0.45,0.96,0.98]
position_img_v2 = [0.04,0.07,0.96,0.41] 

;;--
num_subimgs_x_v1 = 2
num_subimgs_y_v1 = 2;10
dx_subimg_v1   = (position_img_v1(2)-position_img_v1(0))/num_subimgs_x_v1
dy_subimg_v1   = (position_img_v1(3)-position_img_v1(1))/num_subimgs_y_v1

;;--
x_margin_left = 0.07
x_margin_right= 0.93
y_margin_bot  = 0.11
y_margin_top  = 0.90

i_plot  = 0L
For i_part=0,1 Do Begin
  If i_part eq 0 Then Begin
    For i_subimg_x=0,num_subimgs_x_v1-1 Do Begin
    For i_subimg_y=0,num_subimgs_y_v1-1 Do Begin
      Print,'i_subimg_x,i_subimg_y: ', i_subimg_x, i_subimg_y
      If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin ;kx for Zp with min eigen-value
        image_TV  = mark_OutAW_arr
        title = TexToIDL('Anti-Sunward Prop. Alfven Wave')
        levels=[1] & c_colors=[color_black] & c_orientation=45.0
        PanelMark = '(a)'
      EndIf
      If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin ;ky for Zp with min eigen-value
        image_TV  = mark_OutQPSW_arr
        title = TexToIDL('Anti-Sunward Prop. Quasi-Perp. Slow Wave')
        levels=[1] & c_colors=[color_green] & c_orientation=45.0
        PanelMark = '(b)' 
      EndIf
      If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin ;kz for Zp with min eigen-value
        image_TV  = mark_InAW_arr
        title = TexToIDL('Sunward Prop. Alfven Wave')
        levels=[1] & c_colors=[color_red] & c_orientation=135.0
        PanelMark = '(c)'    
      EndIf
      If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin ;ky for Zp with min eigen-value
        image_TV  = mark_InQPSW_arr
        title = TexToIDL('Sunward Prop. Quasi-Pepr. Slow Wave')
        levels=[1] & c_colors=[color_blue] & c_orientation=135.0    
        PanelMark = '(d)'
      EndIf  
      ;;;---
      win_position= [position_img_v1(0)+dx_subimg_v1*i_subimg_x+x_margin_left*dx_subimg_v1,$
                      position_img_v1(1)+dy_subimg_v1*i_subimg_y+y_margin_bot*dy_subimg_v1,$
                      position_img_v1(0)+dx_subimg_v1*i_subimg_x+x_margin_right*dx_subimg_v1,$
                      position_img_v1(1)+dy_subimg_v1*i_subimg_y+y_margin_top*dy_subimg_v1]
      position_subplot  = win_position
      position_SubImg   = position_SubPlot
      If i_subimg_x eq 0 Then position_img_v2(0)=position_SubImg(0)
      If i_subimg_x eq 1 Then position_img_v2(2)=position_SubImg(2)
      Goto, OutsideLoop
      InSideLoop:
    EndFor
    EndFor   
  EndIf Else Begin
  If i_part eq 1 Then Begin
    image_TV_v1 = mark_OutAW_arr
    image_TV_v2 = mark_OutQPSW_arr
    image_TV_v3 = mark_InAW_arr
    image_TV_v4 = mark_InQPSW_arr    
    title = TexToIDL('AntiSunward/Sunward Alfven-Wave/Slow-Wave')
    levels_v1=[1] & c_colors_v1=[color_black] & c_orientation_v1=45.0
    levels_v2=[1] & c_colors_v2=[color_green] & c_orientation_v2=45.0
    levels_v3=[1] & c_colors_v3=[color_red] & c_orientation_v3=135.0
    levels_v4=[1] & c_colors_v4=[color_blue] & c_orientation_v4=135.0 
    position_SubImg = position_img_v2   
    position_SubPlot= position_SubImg
    PanelMark = '(e)'
  EndIf
  EndElse

OutsideLoop:  
;;--  
xplot_vect  = JulDay_vect_plot
yplot_vect  = period_vect
xrange  = [Min(xplot_vect)-0.5*(xplot_vect(1)-xplot_vect(0)), Max(xplot_vect)+0.5*(xplot_vect(1)-xplot_vect(0))]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
lg_yplot_vect = ALog10(yplot_vect)
yrange    = 10^[Min(lg_yplot_vect)-0.5*(lg_yplot_vect(1)-lg_yplot_vect(0)),$
                Max(lg_yplot_vect)+0.5*(lg_yplot_vect(1)-lg_yplot_vect(0))]
xtitle    = ' '
If (i_subimg_x eq 0 or i_part eq 1) Then Begin
  ytitle  = 'period [s]'
EndIf Else Begin
  ytitle  = ' '
EndElse  

If i_part eq 0 Then Begin
  image_TV  = Rebin(image_TV,(Size(image_TV))[1],(Size(image_TV))[2]*5, /Sample)
EndIf Else Begin
  image_TV_v1 = Rebin(image_TV_v1,(Size(image_TV_v1))[1],(Size(image_TV_v1))[2]*5, /Sample)
  image_TV_v2 = Rebin(image_TV_v2,(Size(image_TV_v2))[1],(Size(image_TV_v2))[2]*5, /Sample)
  image_TV_v3 = Rebin(image_TV_v3,(Size(image_TV_v3))[1],(Size(image_TV_v3))[2]*5, /Sample)
  image_TV_v4 = Rebin(image_TV_v4,(Size(image_TV_v4))[1],(Size(image_TV_v4))[2]*5, /Sample)
EndElse
yplot_vect= 10^Congrid(ALog10(yplot_vect), N_Elements(yplot_vect)*5, /Minus_One)


c_spacing = 0.1
If i_part eq 1 Then Begin
  contour_arr = image_TV_v1
  levels=levels_v1 & c_colors=c_colors_v1 & c_orientation=c_orientation_v1
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    Cell_Fill=0, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, NoClip=0, Thick=thick 
    
  contour_arr = image_TV_v2
  levels=levels_v2 & c_colors=c_colors_v2 & c_orientation=c_orientation_v2
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    Cell_Fill=0, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, NoClip=0, Thick=thick     
    
  contour_arr = image_TV_v3
  levels=levels_v3 & c_colors=c_colors_v3 & c_orientation=c_orientation_v3
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    Cell_Fill=0, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, NoClip=0, Thick=thick      
     
  contour_arr = image_TV_v4
  levels=levels_v4 & c_colors=c_colors_v4 & c_orientation=c_orientation_v4
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot 
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    Cell_Fill=0, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, NoClip=0, Thick=thick  
                
EndIf Else Begin
  contour_arr = image_TV
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    /Cell_Fill, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, C_Orientation=c_orientation, C_Spacing=c_spacing, NoClip=0;, /OverPlot
  Contour, contour_arr, xplot_vect, yplot_vect, $
    XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
    Cell_Fill=0, /NoErase, YLog=1, $
    Levels=levels, C_Colors=c_colors, NoClip=0, Thick=thick  
         
EndElse
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, CharSize=1.2, $
    Position=position_subimg, XTitle=' ', YTitle=' ', /NoData, /NoErase, Color=color_black, $
    XTickLen=-0.02,YTickLen=-0.02, YLog=1
   
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1,$
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick
  
;;;---
xpos_tmp  = position_subplot(0)-0.02
ypos_tmp  = position_SubPlot(3)+0.01
xyouts_str= PanelMark
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 
    

i_plot  = i_plot+1
Print, 'i_plot: ', i_plot
If (i_part eq 0 and (i_subimg_x ne 1 or i_subimg_y ne 1)) Then Goto, InsideLoop
 
EndFor  ;For i_part=0,1 Do Begin


;;--
AnnotStr_tmp  = ' ';'got from "SubRoutine_plot_Figure7_for_paper_200206.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
;Annotstr_tmp  = year_str+mon_str+day_str
;AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img_v2(0),position_img_v2(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
If is_png_eps eq 1 Then Begin
image_tvrd  = TVRD(true=1)
Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
EndIf Else Begin
If is_png_eps eq 2 Then Begin
;;;--
Device,/Close 
EndIf
EndElse


Return
End