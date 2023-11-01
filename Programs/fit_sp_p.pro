;pro fit_sp_p
;



pro extpmodel, X,A,F,pder
bx = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F = (-2.5+1.5*A(0))*(X/3)+1-bx
pder = [[X/2],[-(X/3)*(A(1)^(X/3-1)-(1-A(1))^(X/3-1))/(Alog(2)*(A(1)^(X/3)+(1-A(1))^(X/3)))]]
end


sub_dir_date  = 'new\19950720-29-1\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;;--
Read, 'choice(1/2 for no angle/angle): ', choice

If choice eq 1 Then begin

Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'sp_p_no_theta.eps', $   ;
    XSize=20,YSize=10,/Color,Bits=10,/Encapsul
Device,DeComposed=0

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

;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs





;for i_BComp = 1,3 do begin





Step1:
;===========================
;Step1:
n_jie = 14;;20个阶数
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_no_angle_sp_p.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;s, sigma_notheta
s_o = s
sigma_o = sigma_notheta

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_no_angle_sp_p.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;s, sigma_notheta
s_r = s
sigma_r = sigma_notheta


for i_s = 0,1 do begin
  if i_s eq 0 then begin
    s = s_o
    ssigma = sigma_o
    i_x_SubImg  = 0
    i_y_SubImg  = 0
    title = '(a) original'
  endif
  if i_s eq 1 then begin
    s = s_r
    ssigma = sigma_r
    i_x_SubImg  = 1
    i_y_SubImg  = 0
    title = '(b) LIM'
  endif
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

X = (findgen(n_jie)+1)/2.0   ;0.5-10.0阶
Y = X/3.
weights = 1.0/s
A = [1.6,0.7]
;we = fltarr(n_jie)+1.0
yfit = CURVEFIT(X, s, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='extpmodel')
plot,X,s,xrange=[0,9],yrange=[0.0,3.5],xtitle='p',ytitle=textoidl('\xi')+'(p)', $
  xthick=4,ythick=4, xstyle = 1,ystyle = 1, $
  color=color_black,position=position_SubImg,charsize=1.25,charthick = 4,thick=8,/noerase
oplot, X,Y, color = color_red, linestyle =2,thick=8  
ErrPlot, X , s - ssigma, s + ssigma, color=color_black,Thick=4, width = 0.04

xyouts,3.5,3.7,title,charsize=1.25,charthick=4
print,'Function parameters: ',A

bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = (-2.5+1.5*A(0))*(X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=4
A = float(round(100.0*A))/100.0
sigma = float(round(100.0*sigma))/100.0
xyouts,1,3.0,textoidl('\alpha')+' = '+string(A(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma(0),format='(F4.2)'),charsize=1.0,charthick=4
xyouts,1,2.7,textoidl('P_1')+' = '+string(A(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma(1),format='(F4.2)'),charsize=1.0,charthick=4

;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
;file_fig  = 'noangle_sp_p_fit'+ $
;        '.png'
;Write_PNG, dir_fig+file_fig, image_tvrd


endfor

device,/close



endif


If choice eq 2 Then begin
  

;read,'get 180(1) or 90(2):',is_fold
;if is_fold eq 1 then begin
;theta_str = '180'
;endif 
;if is_fold eq 2 then begin
;thata_str = ''
;endif 
file_v = '(v3)'
;===========================
;Step1:
n_jie = 14
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_theta_tao'+file_v+'_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "plot_sp_freq.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;theta_bin_cen_vect_plot, slope
;  
 n_theta = (Size(theta_bin_cen_vect_plot))[1]
 re_A = fltarr(2,n_theta) 
 re_sigma = fltarr(2,n_theta)
 X = (findgen(n_jie)+1)/2.0
 ;plot,[0],[0],xrange=[0,10],yrange=[0.0,5.0]
 for i_theta = 0,n_theta-1 do begin
 ; i_theta = 13
  
 ; i_theta = 23   ;只能手动改变了0-23
  
   weights = reform(1.0/slope(i_theta,*),n_jie)
   
A = [1.6,0.8]
tep_s = reform(slope(i_theta,*),n_jie)
   Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=600.0 & ysize=500.0
    Window,1,XSize=xsize,YSize=ysize,Retain=2
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


plot,X,slope(i_theta,*),xrange=[0,10],yrange=[0.0,5.0],color=color_black,/noerase
yfit = CURVEFIT(X, tep_s, weights, A, SIGMA, FUNCTION_NAME='extpmodel')
  print,'Function parameters: ',A
  
 ; endfor
  
bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = (-2.5+1.5*A(0))*(X/3)+1-bx1
plot,X,F1,color=color_blue,xstyle=4,ystyle=4,xrange=[0,10],yrange=[0.0,5.0],linestyle=2,/noerase
xyouts,1,4.5,'theta = '+string(2*(i_theta+1)),color=color_black
wait,0.5

    image_tvrd  = TVRD(true=1)
    dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
    file_version= '(v1)'
    file_fig  = 'theta'+string(2*(i_theta+1))+'_fit_sp_p'+  $
            '_recon.png'
    Write_PNG, dir_fig+file_fig, image_tvrd


re_A(0,i_theta) = A(0)
re_A(1,i_theta) = A(1) 
re_sigma(0,i_theta) = SIGMA(0)
re_sigma(1,i_theta) = Sigma(1)
endfor
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'extpmodel_theta_alpha_P1'+file_v+'_recon.sav'
data_descrip= 'got from "fit_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  re_A ,re_sigma
  

  
endif



end








