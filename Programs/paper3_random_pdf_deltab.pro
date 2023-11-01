;pro paper3_random_pdf_deltaB


sub_dir_date = 'model\'
alpha = 0.9
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
period_min = 10
period_max = 10*2^11
dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
period_vect  = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;;;;;;;;;;Howes,2008
period_vect = period_vect/period_vect(3)
;;;;;;;;;;
endif
if is_q eq 1 then begin
J_wavlet  = 12L;24;32  ;number of scales
period_min = 10.
period_max = 10.*exp(11)
dj_wavlet = ALog(period_max/period_min)/(J_wavlet-1)
period_vect  = period_min*exp(1)^(Lindgen(J_wavlet)*dj_wavlet)
;;;;;;;;;;Howes,2008
period_vect = period_vect/period_vect(3)
;;;;;;;;;;
endif

;;;;;;Howes,2008

;;;;;;

min_v = fltarr(12)
max_v = fltarr(12)
flatness = fltarr(12)

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
flatness(0) = mean(deltaV1^4)/std1^4
flatness(1) = mean(deltaV2^4)/std2^4
flatness(2) = mean(deltaV3^4)/std3^4
flatness(3) = mean(deltaV4^4)/std4^4
flatness(4) = mean(deltaV5^4)/std5^4
flatness(5) = mean(deltaV6^4)/std6^4
flatness(6) = mean(deltaV7^4)/std7^4
flatness(7) = mean(deltaV8^4)/std8^4
flatness(8) = mean(deltaV9^4)/std9^4
flatness(9) = mean(deltaV10^4)/std10^4
flatness(10) = mean(deltaV11^4)/std11^4
flatness(11) = mean(deltaV12^4)/std12^4

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
diff_Bz_PDF = fltarr(n_cell,num_periods)+!values.f_nan
diff_Bz_flat = fltarr(n_cell,num_periods)+!values.f_nan
  min_vect = (findgen(n_cell)/n_cell-0.5)*40
  max_vect = ((findgen(n_cell)+1)/n_cell-0.5)*40;;[-20,20]

  i_period = 0
  n_finite = n_elements(where(finite(npdf1)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf1 ge min_vect(i_cell) and npdf1 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf1(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor

  i_period = 1
  n_finite = n_elements(where(finite(npdf2)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf2 ge min_vect(i_cell) and npdf2 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf2(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 2  
  n_finite = n_elements(where(finite(npdf3)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf3 ge min_vect(i_cell) and npdf3 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf3(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 3
  n_finite = n_elements(where(finite(npdf4)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf4 ge min_vect(i_cell) and npdf4 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf4(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 4
  n_finite = n_elements(where(finite(npdf5)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf5 ge min_vect(i_cell) and npdf5 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf5(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 5
  n_finite = n_elements(where(finite(npdf6)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf6 ge min_vect(i_cell) and npdf6 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf6(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 6
  n_finite = n_elements(where(finite(npdf7)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf7 ge min_vect(i_cell) and npdf7 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf7(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 7
  n_finite = n_elements(where(finite(npdf8)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf8 ge min_vect(i_cell) and npdf8 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf8(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 8
  n_finite = n_elements(where(finite(npdf9)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf9 ge min_vect(i_cell) and npdf9 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf9(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 9
  n_finite = n_elements(where(finite(npdf10)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf10 ge min_vect(i_cell) and npdf10 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf10(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 10
  n_finite = n_elements(where(finite(npdf11)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf11 ge min_vect(i_cell) and npdf11 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(npdf11(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
  
  i_period = 11
  n_finite = n_elements(where(finite(npdf12)))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(npdf12 ge min_vect(i_cell) and npdf12 lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,11) = mean(npdf12(sub_cell)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor                    



JulDay_vect_TV = min_vect
period_vect_TV = period_vect;;;
diff_Bz_PDF = reverse(diff_Bz_PDF,2)
diff_Bz_flat = reverse(diff_Bz_flat,2)

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0
ysize = 1200.0
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
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;;--

;;;;;;;;;;;;;;;;;;;;;;;;;
   i_x_SubImg  = 0
   i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
image_TV  = alog10(diff_Bz_PDF)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan;0.;9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = -6.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = -0.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
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
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title, $
  /NoData,Color=0L,charsize = 1.5, $
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/ylog
if is_q eq 1 then begin
xyouts, 5,1000 ,textoidl('\beta')+'='+string(alpha,format='(F5.2)'), color = color_black,charsize = 1.5;;;;
endif
if is_q eq 0 then begin
xyouts, 5,100 ,textoidl('\alpha')+'='+string(alpha,format='(F5.1)'), color = color_black,charsize = 1.5;;;;
endif

;;;---

xaxis_vect_cont = JulDay_vect_TV;xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
yaxis_vect_cont = period_vect_TV;yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
levels  = [-6,-5,-4,-3,-2,-1,0]
C_annotation = ['-6','-5','-4','-3','-2','-1','0']
C_colors= [color_black,color_black,color_black,color_black,color_black,color_black,color_black]
C_LineStyle = [0,0,0,0,0,0,0]
C_labels = [0,0,0,0,0,0,0]
C_Thick   = [2,2,2,2,2,2,2]
;Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
;    /NoErase, /Fill, /Closed
Contour, image_TV, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, C_annotation = C_annotation, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,C_labels=C_labels,C_charthick = 1.2, $
    /NoErase , ylog=1
;;;;



position_CB   = [position_SubImg(2)+0.045,position_SubImg(1),$
          position_SubImg(2)+0.055,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('log(PDF)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=0.9, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



   i_x_SubImg  = 0
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
image_TV  = alog10(diff_Bz_flat)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan;9999.0
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
xtitle  = textoIDL('\delta')+'Bz/'+textoidl('\sigma')
ytitle  = 'period(s)'
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
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title, $
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/ylog
;;;---




position_CB   = [position_SubImg(2)+0.03,position_SubImg(1),$
          position_SubImg(2)+0.04,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('%flatness')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=0.7, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   i_x_SubImg  = 1
   i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
xtitle  = 'flatness'
ytitle  = '';'period'

x_plot = reverse(flatness)

yrange  = [Min(period_vect), Max(period_vect)]
  
Plot,x_plot,period_vect, YRange=yrange,$
  Position=position_SubImg,YStyle=1,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title, $
  Color=color_black,charsize=1.5,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/xlog,/ylog
             
           


step2:

min_v = reverse(min_v)
max_v = reverse(max_v)

   i_x_SubImg  = 1
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result1 = linfit(min_v,period_vect,sigma=sigma1)
plot, min_v,period_vect,xrange=[-20,20],yrange=[10,10*2^11],XStyle=1, YStyle=1,position = position_SubImg,color = color_black,/noerase,/ylog
y = result1(0)+result1(1)*min_v
oplot,min_v,y,color = color_red
xyouts,-15,10000,'k='+string(result1(1)),color = color_blue


result2 = linfit(max_v,period_vect,sigma=sigma2)
oplot, max_v,period_vect,color = color_black
y = result2(0)+result2(1)*max_v
oplot,max_v,y,color = color_red
xyouts,15,10000,'k='+string(result2(1)),color = color_blue


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'random_deltaB_PDF_alpha_'+strfang+'_'+string(alpha)+'.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd

step3:

;diff_Bz_PDF
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 600.0
ysize = 600.0
Window,1,XSize=xsize,YSize=ysize

color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;;--

   i_x_SubImg  = 0
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

yrange = [0.000001,0.4]


plot,JulDay_vect_TV,diff_Bz_PDF(*,0),yrange=yrange,color=color_black,/ylog
oplot,JulDay_vect_TV,diff_Bz_PDF(*,5),color=color_blue
oplot,JulDay_vect_TV,diff_Bz_PDF(*,11),color=color_red
xyouts,10,0.38,'the minimum scale',color=color_black
xyouts,10,0.3,'the middle scale',color=color_blue
xyouts,10,0.25,'the maximum scale',color=color_red
xyouts,7,0.2,textoidl('\alpha')+'='+string(alpha),color=color_black

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'random_min_mid_max_scale_deltaB_'+strfang+'_'+string(alpha)+'.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd

end


 
  
