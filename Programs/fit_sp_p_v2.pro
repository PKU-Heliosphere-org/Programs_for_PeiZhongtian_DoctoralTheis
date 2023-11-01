


pro pmodel_v1, X,A,F,pder;A(0)alpha;A(1)P1;A(2)beta
bx = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F = A(2)*((-2.5+1.5*A(0))*(X/3)+1-bx)
pder = [[A(2)*X/2],[-A(2)*(X/3)*(A(1)^(X/3-1)-(1-A(1))^(X/3-1))/(Alog(2)*(A(1)^(X/3)+(1-A(1))^(X/3)))],[(-2.5+1.5*A(0))*(X/3)+1-bx]]
end


sub_dir_date  = 'new\19950720-29\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;;--
Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'sp_p_no_theta_v2.eps', $   ;
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



i_BComp = 0
Read, 'choice(1/2 for no angle/angle): ', choice
;for i_BComp = 1,3 do begin
If choice eq 1 Then begin




Step1:
;===========================
;Step1:
n_jie = 20;;20个阶数
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
;s
s_o = s

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
;s
s_r = s


for i_s = 0,1 do begin
  if i_s eq 0 then begin
    s = s_o
    i_x_SubImg  = 0
    i_y_SubImg  = 0
    title = '(a) original'
  endif
  if i_s eq 1 then begin
    s = s_r
    i_x_SubImg  = 1
    i_y_SubImg  = 0
    title = '(b) LIMed'
  endif
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

X = (findgen(n_jie)+1)/2.0   ;0.5-10.0阶
weights = 1.0/s
A = [1.8,0.6,1]
;we = fltarr(n_jie)+1.0
yfit = CURVEFIT(X, s, weights, A, SIGMA, chisq=chisq, FUNCTION_NAME='pmodel_v1')
plot,X,s,xrange=[0,11],yrange=[0.0,4.0],xtitle='p',ytitle=textoidl('\xi')+'(p)', xthick=4,ythick=4, $
  color=color_black,position=position_SubImg,charsize=1.25,charthick = 4,thick=4,/noerase
xyouts,3.5,4.2,title,charsize=1.25,charthick=4
print,'Function parameters: ',A

bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = A(2)*((-2.5+1.5*A(0))*(X/3)+1-bx1)
oplot,X,F1,color=color_blue,linestyle=2,thick=4
A = float(round(100.0*A))/100.0
sigma = float(round(100.0*sigma))/100.0
xyouts,1,3.5,textoidl('\alpha')+' = '+string(A(0),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma(0),format='(F4.2)'),charsize=1.0,charthick=4
xyouts,1,3.2,textoidl('P_1')+' = '+string(A(1),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma(1),format='(F4.2)'),charsize=1.0,charthick=4
xyouts,1,2.9,textoidl('\beta')+' = '+string(A(2),format='(F4.2)')+' '+textoIDL('\pm')+' '+string(sigma(2),format='(F4.2)'),charsize=1.0,charthick=4
;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
;file_fig  = 'noangle_sp_p_fit'+ $
;        '.png'
;Write_PNG, dir_fig+file_fig, image_tvrd


endfor

device,/close



endif


If choice eq 2 Then begin
  



;===========================
;Step1:
n_jie = 10
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_theta_tao_pviw_7-100s.sav'
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
 X = findgen(n_jie)+1
 ;plot,[0],[0],xrange=[0,10],yrange=[0.0,5.0]
 for i_theta = 0,n_theta-1 do begin
  
  
 ; i_theta = 23   ;只能手动改变了0-23
  
   weights = reform(1.0/slope(i_theta,*),n_jie)
   
A = [1.7,0.8]
tep_s = reform(slope(i_theta,*),n_jie)
plot,X,slope(i_theta,*),xrange=[0,10],yrange=[0.0,5.0]
yfit = CURVEFIT(X, tep_s, weights, A, SIGMA, FUNCTION_NAME='extpmodel')
  print,'Function parameters: ',A
  
 ; endfor
  
bx1 = Alog10(A(1)^(X/3)+(1-A(1))^(X/3))/alog10(2)
F1 = (-2.5+1.5*A(0))*(X/3)+1-bx1
plot,X,F1,color='FF0000'XL,xstyle=4,ystyle=4,xrange=[0,10],yrange=[0.0,5.0],/noerase
wait,0.5

re_A(0,i_theta) = A(0)
re_A(1,i_theta) = A(1) 
re_sigma(0,i_theta) = SIGMA(0)
re_sigma(1,i_theta) = Sigma(1)
endfor
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'extpmodel_theta_alpha_P1_pviw_7-100s.sav'
data_descrip= 'got from "fit_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  re_A ,re_sigma 
  

  
endif



end








