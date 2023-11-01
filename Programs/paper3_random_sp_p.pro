;pro paper3_random_sp_p


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

n_p = 14
n_period = 12
p = (indgen(n_p)+1.)/2.
V_SF = fltarr(n_p,n_period)

for i_p = 0,n_p-1 do begin
  V_SF(i_p,0) = mean(abs(deltaV1)^p(i_p),/nan)
  V_SF(i_p,1) = mean(abs(deltaV2)^p(i_p),/nan)
  V_SF(i_p,2) = mean(abs(deltaV3)^p(i_p),/nan)
  V_SF(i_p,3) = mean(abs(deltaV4)^p(i_p),/nan)
  V_SF(i_p,4) = mean(abs(deltaV5)^p(i_p),/nan)
  V_SF(i_p,5) = mean(abs(deltaV6)^p(i_p),/nan)
  V_SF(i_p,6) = mean(abs(deltaV7)^p(i_p),/nan)            
  V_SF(i_p,7) = mean(abs(deltaV8)^p(i_p),/nan)
  V_SF(i_p,8) = mean(abs(deltaV9)^p(i_p),/nan)
  V_SF(i_p,9) = mean(abs(deltaV10)^p(i_p),/nan)
  V_SF(i_p,10) = mean(abs(deltaV11)^p(i_p),/nan)
  V_SF(i_p,11) = mean(abs(deltaV12)^p(i_p),/nan)          
endfor

if is_q eq 0 then begin
J_wavlet  = 12L;24;32  ;number of scales
period_min = 10
period_max = 10*2^11
dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
period_vect  = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
endif
if is_q eq 1 then begin
J_wavlet  = 12L;24;32  ;number of scales
period_min = 10.
period_max = 10.*exp(11)
dj_wavlet = ALog(period_max/period_min)/(J_wavlet-1)
period_vect  = period_min*exp(1)^(Lindgen(J_wavlet)*dj_wavlet)
endif

slope = fltarr(n_p)
sigma_s = fltarr(n_p)

for i_p =0,n_p-1 do begin
  result = linfit(alog10(period_vect),alog10(V_SF(i_p,*)),sigma=sigma)
  slope(i_p) = -result(1)
  sigma_s(i_p) = sigma(1)
endfor


step2:

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0
ysize = 600.0
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
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;;--

;;;;;;;;;;;;;;;;;;;;;;;;;
   i_x_SubImg  = 0
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---  
plot,period_vect,V_SF(0,*),position=position_SubImg,color=color_black, $
  xrange=[5,1000000],yrange=[0.00001,10],/xlog,/ylog,xtitle='period',ytitle='SF',/noerase
xyouts, 100000, V_SF(0,11),string(p(0)),color=color_black
for i_p = 1,n_p-1 do begin
oplot,period_vect,V_SF(i_p,*),color=color_black
xyouts, 100000, V_SF(i_p,11),string(p(i_p)),color=color_black
endfor


   i_x_SubImg  = 1
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]


X = p          
Y = X/3.
weights = 1.0/slope
A = [1.8,0.8]
yfit = CURVEFIT(X, slope, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='extpmodel')

plot,X,slope,xrange=[0,9],yrange=[0.0,5],xtitle='p',ytitle=textoidl('\xi')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1, $
  color=color_black,position=position_SubImg,charsize=1.5,charthick = 2,thick=2,/noerase  
oplot, X,Y, color = color_red, linestyle =2,thick=2  
ErrPlot, X , slope - Sigma_s, slope + Sigma_s, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = (-2.5+1.5*A(0))*(X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

title = strfang
if is_q eq 0 then begin
xyouts,-5,5.3,title+'  '+textoidl('\alpha')+'='+string(alpha),charsize=2,charthick=2,color=color_black
endif
if is_q eq 1 then begin
xyouts,-5,5.3,title+'  '+textoidl('\beta')+'='+string(alpha),charsize=2,charthick=2,color=color_black
endif
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,4.5,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
xyouts,1,4.2,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
;xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
;xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'random_SF_Sp_'+strfang+'_'+string(alpha)+'.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd


end