;pro figure3_plot_sp_p_haosan


;pro dispmodel, X,A,F,pder
;bx = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
;F = (-3.5+1.5*A(0))*(2*X/3)+1-bx
;pder = [[X],[-(2*X/3)*(A(1)^(2*X/3-1)-(1-A(1))^(2*X/3-1))/(Alog(2)*(A(1)^(2*X/3)+(1-A(1))^(2*X/3)))]]
;end


sub_dir_date = 'wind\slow\case2\'


step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)__hao_'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "figure3_get_no_angle_sp_p.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
;  slope_fast, sigma_fast, slope_slow, sigma_slow

n_jie = 10

X = (dindgen(n_jie)+1.)/2.
slope_mid_fast = fltarr(n_jie)
slope_mid_slow = fltarr(n_jie)
;for i=0,n_jie-1 do begin
;  a1 = sort(slope_fast(*,i))
;  a2 = sort(slope_slow(*,i))
  slope_mid_fast = slope_fast;median(slope_fast(*,i),/even)
  slope_mid_slow = slope_slow;median(slope_slow(*,i),/even)
;endfor

;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1000.0
ysize = 500.0
Window,1,XSize=xsize,YSize=ysize

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

    i_x_SubImg  = 0
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  
           
Y = 2.*X/3.
weights = 1.0/slope_mid_fast
A = [1.6,0.6]
yfit = CURVEFIT(X, slope_mid_fast, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='dispmodel')

plot,X,slope_mid_fast,xrange=[0,9],yrange=[0.0,4],xtitle='p',ytitle=textoidl('\xi')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1, $
  color=color_black,position=position_SubImg,charsize=1.5,charthick = 2,thick=2,/noerase  
oplot, X,Y, color = color_red, linestyle =2,thick=2  
;ErrPlot, X , slope_mid_fast - ssigma, s + ssigma, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

title = 'fast'
xyouts,4.5,4.3,title,charsize=1.25,charthick=1
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,3.0,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
xyouts,1,2.7,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope_mid_fast(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope_mid_fast(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
    i_x_SubImg  = 1
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

Y = 2.*X/3.
weights = 1.0/slope_mid_slow
A = [2.3,0.6]
yfit = CURVEFIT(X, slope_mid_slow, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='dispmodel')

plot,X,slope_mid_slow,xrange=[0,9],yrange=[0.0,4],xtitle='p',ytitle=textoidl('\xi')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1, $
  color=color_black,position=position_SubImg,charsize=1.5,charthick = 2,thick=2,/noerase
oplot, X,Y, color = color_red, linestyle =2,thick=2  
;ErrPlot, X , slope_mid_fast - ssigma, s + ssigma, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

title = 'slow'
xyouts,4.5,4.3,title,charsize=1.25,charthick=1
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,3.0,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),charsize=1.0,charthick=1,color = color_black
xyouts,1,2.7,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),charsize=1.0,charthick=1,color = color_black
xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope_mid_slow(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope_mid_slow(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure3_sp_p_haosan'+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;step2:
;
;
;for i_d = 0,14 do begin
;
;xsize = 1000.0
;ysize = 500.0
;Window,2,XSize=xsize,YSize=ysize
;
;
;;--
;color_bg    = color_white
;!p.background = color_bg
;Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
;
;
;X = (dindgen(n_jie)+1.)/2.
;
;position_img  = [0.10,0.10,0.95,0.98]
;num_x_SubImgs = 2
;num_y_SubImgs = 1
;dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
;dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;
;    i_x_SubImg  = 0
;    i_y_SubImg  = 0
;
;position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
;           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  
;Y = 2.*X/3.
;weights = 1.0/reform(slope_fast(i_d,*))
;A = [1.6,0.7]
;yfit = CURVEFIT(X, slope_fast(i_d,*), weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='dispmodel')
;
;plot,X,slope_fast(i_d,*),xrange=[0,9],yrange=[0.0,4],xtitle='p',ytitle=textoidl('\xi')+'(p)', $
;  xthick=2,ythick=2, xstyle = 1,ystyle = 1, $
;  color=color_black,position=position_SubImg,charsize=1.5,charthick = 2,thick=2,/noerase
;oplot, X,Y, color = color_red, linestyle =2,thick=2  
;;ErrPlot, X , slope_mid_fast - ssigma, s + ssigma, color=color_black,Thick=4, width = 0.04
;print,'Function parameters: ',A
;bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
;F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1
;oplot,X,F1,color=color_blue,linestyle=2,thick=2
;
;title = 'fast'
;xyouts,4.5,4.3,title,charsize=1.25,charthick=1
;A_write = float(round(100.0*A))/100.0
;sigma_write = float(round(100.0*sigma))/100.0
;xyouts,1,3.0,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),charsize=1.0,charthick=1
;xyouts,1,2.7,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),charsize=1.0,charthick=1
;
;
;    i_x_SubImg  = 1
;    i_y_SubImg  = 0
;
;position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
;           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  
;
;Y = 2.*X/3.
;weights = 1.0/reform(slope_slow(i_d,*))
;A = [1.6,0.7]
;yfit = CURVEFIT(X, slope_slow(i_d,*), weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='dispmodel')
;
;plot,X,slope_slow(i_d,*),xrange=[0,9],yrange=[0.0,4],xtitle='p',ytitle=textoidl('\xi')+'(p)', $
;  xthick=2,ythick=2, xstyle = 1,ystyle = 1, $
;  color=color_black,position=position_SubImg,charsize=1.5,charthick = 2,thick=2,/noerase
;oplot, X,Y, color = color_red, linestyle =2,thick=2  
;;ErrPlot, X , slope_mid_fast - ssigma, s + ssigma, color=color_black,Thick=4, width = 0.04
;print,'Function parameters: ',A
;bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
;F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1
;oplot,X,F1,color=color_blue,linestyle=2,thick=2
;
;title = 'slow'
;xyouts,4.5,4.3,title,charsize=1.25,charthick=1
;A_write = float(round(100.0*A))/100.0
;sigma_write = float(round(100.0*sigma))/100.0
;xyouts,1,3.0,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),charsize=1.0,charthick=1
;xyouts,1,2.7,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),charsize=1.0,charthick=1
;
;
;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_fig  = 'Figure3_sp_p_haosan_'+strcompress(string(i_d+1),/remove_all)+'_.png'
;Write_PNG, dir_fig+file_fig, image_tvrd
;
;endfor


end







