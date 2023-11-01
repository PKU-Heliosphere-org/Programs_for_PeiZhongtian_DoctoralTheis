;Called by plot_Figure4567_for_paper_200206
Pro subroutine_plot_Figure4_for_paper_200206, $
  JulDay_vect_plot, period_vect, $
  SigmaC_x_arr, SigmaC_y_arr, SigmaC_z_arr, SigmaC_t_arr, $
  SigmaA_x_arr, SigmaA_y_arr, SigmaA_z_arr, SigmaA_t_arr, $
  CC_x_arr, CC_y_arr, CC_z_arr, CC_t_arr, $
  FileName=FileName, is_png_eps=is_png_eps

;;--
If is_png_eps eq 2 Then Begin
  Set_Plot,'PS'
  xsize = 34.0
  ysize = 18.0
  Device, FileName=FileName, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
EndIf Else Begin
If is_png_eps eq 1 Then Begin
  Set_Plot,'win'
  Device,DeComposed=0;, /Retain
  xsize=1400.0 & ysize=850.0
  Window,4,XSize=xsize,YSize=ysize,Retain=2
EndIf
EndElse

;;--
;LoadCT,13
;TVLCT,R,G,B,/Get
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
CharSize=1.0 & CharThick=1.5
Thick=2.0

;;--
position_img  = [0.03,0.08,0.97,0.99]

;;--
num_subimgs_x = 3
num_subimgs_y = 3
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
x_margin_left = 0.08
x_margin_right= 0.92
y_margin_bot  = 0.08
y_margin_top  = 0.92

is_contour_or_TV  = 1

;;--
For i_subimg_x=0,2 Do Begin
For i_subimg_y=0,2 Do Begin
  If (i_subimg_x eq 0 and i_subimg_y eq 2) Then Begin
    image_TV  = SigmaC_x_arr
    title = TexToIDL('\sigma_{C,X}')
    PanelMark_str = '(a1)'
      xtitle  = ''
  EndIf  
  If (i_subimg_x eq 0 and i_subimg_y eq 1) Then Begin
    image_TV  = SigmaC_y_arr
    title = TexToIDL('\sigma_{C,Y}')
    PanelMark_str = '(b1)'
      xtitle  = ''
  EndIf  
  If (i_subimg_x eq 0 and i_subimg_y eq 0) Then Begin
    image_TV  = SigmaC_z_arr
    title = TexToIDL('\sigma_{C,Z}')
    PanelMark_str = '(c1)'
      xtitle  = 'time'
  EndIf   

  If (i_subimg_x eq 1 and i_subimg_y eq 2) Then Begin
    image_TV  = SigmaA_x_arr
    title = TexToIDL('\sigma_{R,X}')
    PanelMark_str = '(a2)'
      xtitle  = ''
  EndIf  
  If (i_subimg_x eq 1 and i_subimg_y eq 1) Then Begin
    image_TV  = SigmaA_y_arr
    title = TexToIDL('\sigma_{R,Y}')
    PanelMark_str = '(b2)'
      xtitle  = ''
  EndIf  
  If (i_subimg_x eq 1 and i_subimg_y eq 0) Then Begin
    image_TV  = SigmaA_z_arr
    title = TexToIDL('\sigma_{R,Z}')
    PanelMark_str = '(c2)'
      xtitle  = 'time'
  EndIf  

  If (i_subimg_x eq 2 and i_subimg_y eq 2) Then Begin
    image_TV  = CC_x_arr
    title = TexToIDL('CC_{Vx,Vax}')
    PanelMark_str = '(a3)'
      xtitle  = ''
  EndIf  
  If (i_subimg_x eq 2 and i_subimg_y eq 1) Then Begin
    image_TV  = CC_y_arr
    title = TexToIDL('CC_{Vy,Vay}')
    PanelMark_str = '(b3)'
      xtitle  = ''
  EndIf  
  If (i_subimg_x eq 2 and i_subimg_y eq 0) Then Begin
    image_TV  = CC_z_arr
    title = TexToIDL('CC_{Vz,Vaz}')
    PanelMark_str = '(c3)'
      xtitle  = 'time'
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
;a yrange    = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
lg_yplot_vect = ALog10(yplot_vect)
yrange    = 10^[Min(lg_yplot_vect)-0.5*(lg_yplot_vect(1)-lg_yplot_vect(0)),$
                Max(lg_yplot_vect)+0.5*(lg_yplot_vect(1)-lg_yplot_vect(0))]
If (i_subimg_y eq 0) Then Begin
  xtitle  = 'time'
EndIf Else Begin
  xtitle  = ''
EndElse                  

If (i_subimg_x eq 0) Then Begin
  ytitle  = 'period [s]'
EndIf Else Begin
  ytitle  = ''
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
min_image=-1.0 & max_image=+1.0
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
contour_arr = rebin(contour_arr,100,16)
xplot_vect = rebin(xplot_vect,100)
Contour, contour_arr, xplot_vect, yplot_vect, $
  XRange=xrange, YRange=yrange, Position=position_SubPlot, XStyle=1+4, YStyle=1+4, $
  /Cell_Fill, /NoErase, YLog=1, $
  Levels=levels_vect, C_Colors=color_vect, NoClip=0;, /OverPlot 
EndIf Else Begin

TVImage, byt_image_TV,Position=position_SubPlot, NOINTERPOLATION=1 
EndElse
  
Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, CharSize=CharSize, $
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
  YTick_Get=ytickv, $
  XTickLen=-0.02,YTickLen=-0.02, $
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1, $
;a  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick
EndIf Else Begin
yticknames  = Replicate(' ', N_Elements(ytickv))
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,$
  YTickV=ytickv, YTickName=yticknames, $
  XTickLen=-0.02,YTickLen=-0.02, $
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  Color=color_black,$
  /NoErase,/NoData, Font=-1, YLog=1, $
;a  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5  
  XThick=xthick,YThick=ythick,CharSize=charsize,CharThick=charthick,Thick=thick
EndElse  

;;;---
xpos_tmp  = position_subplot(0)-0.02
ypos_tmp  = position_SubPlot(3)+0.01
xyouts_str= PanelMark_str
XYOuts, xpos_tmp,ypos_tmp, xyouts_str, Color=color_black,CharSize=charsize*1.2,CharThick=charthick,/Normal 


;;;---
if i_subimg_x eq 2 then begin
position_CB   = [position_SubImg(2)+0.04,position_SubImg(1),$
          position_SubImg(2)+0.05,position_SubImg(3)]
num_ticks   = 3
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
  XTicks=1,XTickName=[' ',' '],YTicks=num_ticks-1,YTickName=tickn_CB,Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, $
  XThick=xthick,YThick=ythick,CharSize=0.8*charsize,CharThick=charthick,Thick=thick
endif else begin
endelse
   
EndFor
EndFor


;;--
AnnotStr_tmp  = ' ';'got from "SubRoutine_plot_Figure4_for_Paper_200206.pro"'
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
Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
EndIf Else Begin
If is_png_eps eq 2 Then Begin
;;;--
Device,/Close 
EndIf
EndElse


Return
End