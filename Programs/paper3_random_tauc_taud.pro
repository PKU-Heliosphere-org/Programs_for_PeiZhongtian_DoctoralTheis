;pro paper3_random_tauc_taud

sub_dir_date = 'model\'

alpha = 0.7
step1:

read,'pmodel(0) or beta(1):',is_q
if is_q eq 0 then begin
  strfang = 'pmodel'
endif


if is_q eq 1 then begin
strfang = 'beta'  
n_q = 500
endif

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'random_deltaB_'+strfang+'_'+string(alpha)+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "paper3_random_deltaB.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  deltaV1, deltaV2, deltaV3, deltaV4, deltaV5, deltaV6, deltaV7, deltaV8, deltaV9, deltaV10, deltaV11, deltaV12


if is_q eq 0 then begin
J_wavlet  = 12L;24;32  ;number of scales
period_min = 0.1
period_max = 0.1*2^11
dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
period_vect  = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
endif
if is_q eq 1 then begin
J_wavlet  = 12L;24;32  ;number of scales
period_min = 0.1
period_max = 0.1*exp(11)
dj_wavlet = ALog(period_max/period_min)/(J_wavlet-1)
period_vect  = period_min*exp(1)^(Lindgen(J_wavlet)*dj_wavlet)
endif

sigma_lamda = stddev(period_vect(0:2))

mean_V10 = mean(abs(deltaV10))
mean_v11 = mean(abs(deltaV11))
mean_v12 = mean(abs(deltaV12))

i_v = 0;;;i_v代表不同的耗散公式
if i_v eq 0 then begin
s_v = ''   
tauc_d10 = exp(1-mean_v10/abs(deltaV10))*exp(-(period_vect(2)-period_vect(0))^2/(2.*sigma_lamda^2))
tauc_d11 = exp(1-mean_v11/abs(deltaV11))*exp(-(period_vect(1)-period_vect(0))^2/(2.*sigma_lamda^2))
tauc_d12 = exp(1-mean_v12/abs(deltaV12))
endif
if i_v eq 1 then begin
s_v = 'v'  
if is_q eq 0 then begin
tauc_d10 = exp(-(period_vect(2)-period_vect(0))/(sigma_lamda))*(fltarr(50L*2^9*20)+1)
tauc_d11 = exp(-(period_vect(1)-period_vect(0))/(sigma_lamda))*(fltarr(50L*2^10*20)+1)
tauc_d12 = 1*(fltarr(50L*2^11*20)+1)
endif
if is_q eq 1 then begin
tauc_d10 = exp(-(period_vect(2)-period_vect(0))/(sigma_lamda))*(fltarr(100L*50*n_q)+1)
tauc_d11 = exp(-(period_vect(1)-period_vect(0))/(sigma_lamda))*(fltarr(100L*50*n_q)+1)
tauc_d12 = 1*(fltarr(100L*50*n_q)+1)
endif
endif

step2:

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 800.0
ysize = 800.0
Window,2,XSize=xsize,YSize=ysize

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

color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background



position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;;--

;;;;;;;;;;;;;;;;;;;;;;;;;
   i_x_SubImg  = 0
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

min_v = fltarr(12)
max_v = fltarr(12)


std1 = stddev(deltaV1)
std2 = stddev(deltaV2)
std3 = stddev(deltaV3)
std4 = stddev(deltaV4)
std5 = stddev(deltaV5)
std6 = stddev(deltaV6)
std7 = stddev(deltaV7)
std8 = stddev(deltaV8)
std9 = stddev(deltaV9)
std10 = stddev(deltaV10)
std11 = stddev(deltaV11)
std12 = stddev(deltaV12)


if is_q eq 0 then begin
nPDF1 = reform(deltaV1/std1,50L*20)
nPDF2 = reform(deltaV2/std2,50L*2*20)
nPDF3 = reform(deltaV3/std3,50L*2^2*20)
nPDF4 = reform(deltaV4/std4,50L*2^3*20)
nPDF5 = reform(deltaV5/std5,50L*2^4*20)
nPDF6 = reform(deltaV6/std6,50L*2^5*20)
nPDF7 = reform(deltaV7/std7,50L*2^6*20)
nPDF8 = reform(deltaV8/std8,50L*2^7*20)
nPDF9 = reform(deltaV9/std9,50L*2^8*20)
nPDF10 = reform(deltaV10/std10,50L*2^9*20)
nPDF11 = reform(deltaV11/std11,50L*2^10*20)
nPDF12 = reform(deltaV12/std12,50L*2^11*20)
tauc_d10 = reform(tauc_d10,50L*2^9*20)
tauc_d11 = reform(tauc_d11,50L*2^10*20)
tauc_d12 = reform(tauc_d12,50L*2^11*20)
endif
if is_q eq 1 then begin
nPDF1 = reform(deltaV1/std1,100L*50*n_q)
nPDF2 = reform(deltaV2/std2,100L*50*n_q)
nPDF3 = reform(deltaV3/std3,100L*50*n_q)
nPDF4 = reform(deltaV4/std4,100L*50*n_q)
nPDF5 = reform(deltaV5/std5,100L*50*n_q)
nPDF6 = reform(deltaV6/std6,100L*50*n_q)
nPDF7 = reform(deltaV7/std7,100L*50*n_q)
nPDF8 = reform(deltaV8/std8,100L*50*n_q)
nPDF9 = reform(deltaV9/std9,100L*50*n_q)
nPDF10 = reform(deltaV10/std10,100L*50*n_q)
nPDF11 = reform(deltaV11/std11,100L*50*n_q)
nPDF12 = reform(deltaV12/std12,100L*50*n_q)
tauc_d10 = reform(tauc_d10,100L*50*n_q)
tauc_d11 = reform(tauc_d11,100L*50*n_q)
tauc_d12 = reform(tauc_d12,100L*50*n_q)
endif  

min_v(0) = min(npdf1)
max_v(0) = max(npdf1)
min_v(1) = min(npdf2)
max_v(1) = max(npdf2)
min_v(2) = min(npdf3)
max_v(2) = max(npdf3)
min_v(3) = min(npdf4)
max_v(3) = max(npdf4)
min_v(4) = min(npdf5)
max_v(4) = max(npdf5)
min_v(5) = min(npdf6)
max_v(5) = max(npdf6)
min_v(6) = min(npdf7)
max_v(6) = max(npdf7)
min_v(7) = min(npdf8)
max_v(7) = max(npdf8)
min_v(8) = min(npdf9)
max_v(8) = max(npdf9)
min_v(9) = min(npdf10)
max_v(9) = max(npdf10)
min_v(10) = min(npdf11)
max_v(10) = max(npdf11)
min_v(11) = min(npdf12)
max_v(11) = max(npdf12)


n_cell = 100.   
num_periods = 12
min_vect = (findgen(n_cell)/n_cell-0.5)*40
max_vect = ((findgen(n_cell)+1)/n_cell-0.5)*40;;[-20,20]
taucd_PDF = fltarr(n_cell,num_periods)+!values.f_nan
  
  i_period = 9
  n_finite = n_elements(where(finite(npdf10)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf10 ge min_vect(i_cell) and npdf10 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  taucd_PDF(i_cell,i_period) = mean(tauc_d10(sub_cell),/nan)
    endif
  endfor
  
  i_period = 10
  n_finite = n_elements(where(finite(npdf11)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf11 ge min_vect(i_cell) and npdf11 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  taucd_PDF(i_cell,i_period) = mean(tauc_d11(sub_cell),/nan)
    endif
  endfor
  
  i_period = 11
  n_finite = n_elements(where(finite(npdf12)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf12 ge min_vect(i_cell) and npdf12 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  taucd_PDF(i_cell,i_period) = mean(tauc_d12(sub_cell),/nan)
    endif
  endfor  

max_taucd = max(taucd_PDF(*,num_periods-1),/nan)
JulDay_vect_TV = min_vect
period_vect_TV = period_vect;;;

tauc_taud = reverse(taucd_PDF/max_taucd,2)
image_TV  = tauc_taud
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan;0.;9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0.00;-image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 1.0;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = textoIDL('\delta')+'Bz/'+textoidl('\sigma')
ytitle  = 'period'
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;xrange_time = xrange
;get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;xminor    = 6
;;;---
title=''
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title, $
  /NoData,Color=0L,charsize=1.5, $
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/ylog
xyouts, 5,100 ,textoidl('\alpha')+'='+string(alpha,format='(F5.1)'), color = color_black,charsize=1.5

;;;---
;
;xaxis_vect_cont = JulDay_vect_TV;xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
;yaxis_vect_cont = period_vect_TV;yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
;levels  = [-6,-5,-4,-3,-2,-1,0]
;C_annotation = ['-6','-5','-4','-3','-2','-1','0']
;C_colors= [color_black,color_black,color_black,color_black,color_black,color_black,color_black]
;C_LineStyle = [0,0,0,0,0,0,0]
;C_labels = [0,0,0,0,0,0,0]
;C_Thick   = [2,2,2,2,2,2,2]
;;Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
;;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
;;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
;;    /NoErase, /Fill, /Closed
;Contour, image_TV, xaxis_vect_cont, yaxis_vect_cont, $
;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, C_annotation = C_annotation, $
;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,C_labels=C_labels,C_charthick = 1.2, $
;    /NoErase , ylog=1
;;;;;



position_CB   = [position_SubImg(2)+0.07,position_SubImg(1),$
          position_SubImg(2)+0.09,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('\tau')+'c/'+TexToIDL('\tau')+'d'
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=0.9, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'random_tauc_taud_'+strfang+'_'+string(alpha)+s_v+'.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd


file_save ='random_tauc_taud_'+strfang+'_'+string(alpha)+s_v+'.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
data_descrip= 'got from "paper3_random_deltaB.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  tauc_taud


end





