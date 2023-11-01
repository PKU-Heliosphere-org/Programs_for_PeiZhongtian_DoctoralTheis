;pro paper3_fit_sp_p



sub_dir_date  = 'wind\slow\case2\'

n_jie = 10;;;
jie = (findgen(n_jie)+1)/2.0


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'sp_p_for_diff_days_'+'original_'+'haosan'+'_S.sav';;;original or new
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  slope_vect, $
;  SigmaSlope_vect

slope_s_hao = slope_vect
SigmaSlope_s_hao = SigmaSlope_vect


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'sp_p_for_diff_days_'+'original_'+'guanxing'+'_S.sav';;;
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  slope_vect, $
;  SigmaSlope_vect

slope_s_guan = slope_vect
SigmaSlope_s_guan = SigmaSlope_vect


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'sp_p_for_diff_days_'+'original_'+'haosan'+'_F.sav';;;;;;;
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  slope_vect, $
;  SigmaSlope_vect

slope_f_hao = slope_vect
SigmaSlope_f_hao = SigmaSlope_vect

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'sp_p_for_diff_days_'+'original_'+'guanxing'+'_F.sav';;;;;;;
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  slope_vect, $
;  SigmaSlope_vect

slope_f_guan = slope_vect
SigmaSlope_f_guan = SigmaSlope_vect


step2:

;slope_mid_f_guan = fltarr(n_jie)
;slope_mid_s_guan = fltarr(n_jie)
;slope_mid_f_hao = fltarr(n_jie)
;slope_mid_s_hao = fltarr(n_jie)
;Sigmaslope_mid_f_guan = fltarr(n_jie)
;Sigmaslope_mid_s_guan = fltarr(n_jie)
;Sigmaslope_mid_f_hao = fltarr(n_jie)
;Sigmaslope_mid_s_hao = fltarr(n_jie)
;for i=0,n_jie-1 do begin
;  slope_mid_f_guan(i) = median(slope_f_guan(*,i),/even)
;  slope_mid_s_guan(i) = median(slope_s_guan(*,i),/even)
;  slope_mid_f_hao(i) = median(slope_f_hao(*,i),/even)
;  slope_mid_s_hao(i) = median(slope_s_hao(*,i),/even)
;  Sigmaslope_mid_f_guan(i) = median(Sigmaslope_f_guan(*,i),/even)
;  Sigmaslope_mid_s_guan(i) = median(Sigmaslope_s_guan(*,i),/even)
;  Sigmaslope_mid_f_hao(i) = median(Sigmaslope_f_hao(*,i),/even)
;  Sigmaslope_mid_s_hao(i) = median(Sigmaslope_s_hao(*,i),/even)
;endfor
slope_mid_f_guan = slope_f_guan
slope_mid_s_guan = slope_s_guan
slope_mid_f_hao = slope_f_hao
slope_mid_s_hao = slope_s_hao
Sigmaslope_mid_f_guan = Sigmaslope_f_guan
Sigmaslope_mid_s_guan = Sigmaslope_s_guan
Sigmaslope_mid_f_hao = Sigmaslope_f_hao
Sigmaslope_mid_s_hao = Sigmaslope_s_hao


    Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=1000.0 & ysize=800.0
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


position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

    i_x_SubImg  = 0
    i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  
X = jie           
Y = X/3.
weights = 1.0/slope_mid_f_guan
A = [1.8,0.8]
yfit = CURVEFIT(X, slope_mid_f_guan, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='extpmodel')

plot,X,slope_mid_f_guan,xrange=[0,9],yrange=[0.0,6],xtitle='p',ytitle=textoidl('\zeta')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1, title='fast sream inertial', $
  color=color_black,position=position_SubImg,charsize=2,charthick = 2,thick=2,/noerase  
oplot, X,Y, color = color_red, linestyle =2,thick=2  
xyouts,6,Y(n_jie-1),textoidl('\zeta')+'(p)=p/3',color = color_red,charsize=1.5,charthick = 2
ErrPlot, X , slope_mid_f_guan - Sigmaslope_mid_f_guan, slope_mid_f_guan + Sigmaslope_mid_f_guan, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = (-2.5+1.5*A(0))*(X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

;title = 'fast'
;xyouts,4.5,5.3,title,charsize=1.25,charthick=1,color=color_black
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,5.5,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),color = color_black,charsize=2,charthick=2
xyouts,1,5,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),color = color_black,charsize=2,charthick=2
;xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope_mid_f_guan(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
;xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope_mid_f_guan(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1

   i_x_SubImg  = 1
   i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  
X = jie           
Y = X/3.
weights = 1.0/slope_mid_s_guan
A = [1.8,0.8]
yfit = CURVEFIT(X, slope_mid_s_guan, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='extpmodel')

plot,X,slope_mid_s_guan,xrange=[0,9],yrange=[0.0,6],xtitle='p',ytitle=textoidl('\zeta')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1, title='slow sream inertial',$
  color=color_black,position=position_SubImg,charsize=2,charthick = 2,thick=2,/noerase  
oplot, X,Y, color = color_red, linestyle =2,thick=2  
xyouts,6,Y(n_jie-1),textoidl('\zeta')+'(p)=p/3',color = color_red,charsize=1.5,charthick = 2
ErrPlot, X , slope_mid_s_guan - Sigmaslope_mid_s_guan, slope_mid_s_guan + Sigmaslope_mid_s_guan, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = (-2.5+1.5*A(0))*(X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

;title = 'slow'
;xyouts,4.5,5.3,title,charsize=1.25,charthick=1,color=color_black
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,5.5,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F4.2)'),color = color_black,charsize=2,charthick=2
xyouts,1,5,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F4.2)'),color = color_black,charsize=2,charthick=2
;xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope_mid_s_guan(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
;xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope_mid_s_guan(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1




    i_x_SubImg  = 0
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

Y = 2.*X/3.
weights = 1.0/slope_mid_f_hao
A = [2.4,0.6]
yfit = CURVEFIT(X, slope_mid_f_hao, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='dispmodel')

plot,X,slope_mid_f_hao,xrange=[0,9],yrange=[0.0,6],xtitle='p',ytitle=textoidl('\zeta')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1, title='fast sream dissipation',$
  color=color_black,position=position_SubImg,charsize=2,charthick = 2,thick=2,/noerase
oplot, X,Y, color = color_red, linestyle =2,thick=2  
xyouts,6,Y(n_jie-1),textoidl('\zeta')+'(p)=2p/3',color = color_red,charsize=1.5,charthick = 2
ErrPlot, X , slope_mid_f_hao - Sigmaslope_mid_f_hao, slope_mid_f_hao + Sigmaslope_mid_f_hao, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

;title = 'fast'
;xyouts,4.5,5.3,title,charsize=1.25,charthick=1,color=color_black
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,5.5,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F5.2)'),charsize=2,charthick=2,color = color_black
xyouts,1,5,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F5.2)'),charsize=2,charthick=2,color = color_black
;xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope_mid_f_hao(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
;xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope_mid_f_hao(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1



   i_x_SubImg  = 1
   i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

Y = 2.*X/3.
weights = 1.0/slope_mid_s_hao
A = [2.4,0.6]
yfit = CURVEFIT(X, slope_mid_s_hao, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='dispmodel')

plot,X,slope_mid_s_hao,xrange=[0,9],yrange=[0.0,6],xtitle='p',ytitle=textoidl('\zeta')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1,title='slow sream dissipation', $
  color=color_black,position=position_SubImg,charsize=2,charthick = 2,thick=2,/noerase
oplot, X,Y, color = color_red, linestyle =2,thick=2 
xyouts,6,Y(n_jie-1),textoidl('\zeta')+'(p)=2p/3',color = color_red,charsize=1.5,charthick = 2
ErrPlot, X , slope_mid_s_hao - Sigmaslope_mid_s_hao, slope_mid_s_hao + Sigmaslope_mid_s_hao, color=color_black,Thick=4, width = 0.04
print,'Function parameters: ',A
bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1
oplot,X,F1,color=color_blue,linestyle=2,thick=2

;title = 'slow'
;xyouts,4.5,5.3,title,charsize=1.25,charthick=1,color=color_black
A_write = float(round(100.0*A))/100.0
sigma_write = float(round(100.0*sigma))/100.0
xyouts,1,5.5,textoidl('\alpha')+' = '+string(A_write(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(0),format='(F5.3)'),charsize=2,charthick=2,color = color_black
xyouts,1,5,textoidl('P_1')+' = '+string(A_write(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma_write(1),format='(F5.3)'),charsize=2,charthick=2,color = color_black
;xyouts,5,2,textoidl('\xi')+'(2)'+' = '+string(slope_mid_s_hao(3),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1
;xyouts,5,1.5,textoidl('\xi')+'(4)'+' = '+string(slope_mid_s_hao(7),format='(F4.2)'),color = color_black,charsize=1.0,charthick=1


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'paper3_fit_sp_p_original.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd

step3:

   Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=600.0 & ysize=900.0
    Window,2,XSize=xsize,YSize=ysize,Retain=2
;;--

    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 


position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

    i_x_SubImg  = 0
    i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  
X = jie           
Y = X/3.


plot,X,slope_mid_f_guan,xrange=[0,9],yrange=[0.0,6],xtitle='p',ytitle=textoidl('\zeta')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1,position=position_SubImg, $
  color=color_black,charsize=2,charthick = 2,thick=2,/noerase  


oplot,X,slope_mid_s_guan, color=color_red,thick=2
xyouts,6,5,'fast',color=color_black,charsize=2,charthick=2
xyouts,6,4.5,'slow',color=color_red,charsize=2,charthick=2



    i_x_SubImg  = 0
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,X,slope_mid_f_hao,xrange=[0,9],yrange=[0.0,6],xtitle='p',ytitle=textoidl('\zeta')+'(p)', $
  xthick=2,ythick=2, xstyle = 1,ystyle = 1,position=position_SubImg, $
  color=color_black,charsize=2,charthick = 2,thick=2,/noerase  

oplot,X,slope_mid_s_hao,color=color_red,thick=2
xyouts,6,5,'fast',color=color_black,charsize=2,charthick=2
xyouts,6,4.5,'slow',color=color_red,charsize=2,charthick=2


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'fig7_dissipation_poster.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd



end





