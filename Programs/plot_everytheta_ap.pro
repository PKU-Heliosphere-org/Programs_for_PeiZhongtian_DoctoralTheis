;pro plot_everytheta_ap



device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

sub_dir_date  = 'new\19950720-29pvi\'


Step1:
;===========================
;Step1:

n_jie = 10
n_theta = 45

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'slope_of_s(p)_vs_theta_tao_pviw_7-100s.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "plot_sp_freq.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  theta_bin_cen_vect_plot, slope ,sigmaslope


ap = fltarr(n_theta,n_jie)
sigmaap = fltarr(n_jie,n_theta)
for i = 0,n_jie-1 do begin
  ap(*,i) = slope(*,i) - (i+1)/2.0*slope(*,1)
  sigmaap(i,*) = sigmaslope(i,*) - (i+1)/2.0*sigmaslope(1,*)
endfor




step2:
num_theta_bins = 45L
n_jie = 10L
xsize = 750.0
ysize = 1300.0
Window,1,XSize=xsize,YSize=ysize

plot,[0],[0],xrange=[0,12],yrange=[-6.0,6.0];,/isotropic
ds=findgen(num_theta_bins)*0.1   ;
p=indgen(n_jie)+1
con=1
for i=0,num_theta_bins-1 do begin
  for j=0,n_jie-1 do begin
  if finite(ap(i,j)) eq 0 then begin
    con=0
  endif 
  endfor
  if con eq 1 then begin
 ; plot,p,slope(2*i,*)+ds(i),xrange=[0,11],yrange=[0.0,8.0],xtitle='p',ytitle='s',/noerase;,/isotropic
 XRange=[0,12]
 YRange=[-6.0,6.0] 
  Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1,YStyle=1,  $  ;range
    XTitle='p', YTitle='a(p)',  $
    /NoErase, /NoData
  Plots, p, ap(i,*)+ds(i),Thick=1.5
  ErrPlot, p, ap(i,*)+ds(i)-sigmaap(*,i), ap(i,*)+ds(i)+sigmaap(*,i), $
    Thick=1.5
  
  endif
  con=1
endfor


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
file_fig  = 'slope_of_a(p)_vs_theta_tao'+$
        '_pviw_7-100s.png'
Write_PNG, dir_fig+file_fig, image_tvrd



step3:



;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 1300.0
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
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


step3_1:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = ap
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
xtitle  = TexToIDL('\theta')
ytitle  = 'p'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_bin_cen_vect_plot), Max(theta_bin_cen_vect_plot)]
yrange  = [0.5, 10]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0
  
  
  
    ;;;----
num_theta_bins  = 45L

;;;---
position_CB   = [position_SubImg(2)+0.09,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = 5.0
min_tickn   = 0.0
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('a(p)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[0.0,5.0],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "plot_everytheta_ap.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'everytheta_ap_p'+$
        '_pviw_7-100s.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg


end_program:
end








