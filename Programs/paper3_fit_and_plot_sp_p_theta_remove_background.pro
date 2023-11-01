;pro paper3_fit_and_plot_sp_p_theta_remove_background

day = 'slow'
sub_dir_date  = 'wind\'+day+'\case2_v\'


n_jie = 10
;n_d = 15
n_theta = 30;;;;;
;;--
step1:

for i_recon = 0,1 do begin
  if i_recon eq 0 then begin
    strre = 'hao'
  endif
  if i_recon eq 1 then begin
    strre = 'guan'
  endif  

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_tao_jie_theta_'+strre+'_or_v1.sav';;;;;;;;
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
;    theta_bin_min_vect, slope, sigma(n_jie,num_theta_bins_plot)
sigmaslope = sigma
 
 re_A = fltarr(2,n_theta) 
 re_sigma = fltarr(2,n_theta)

 X = (findgen(n_jie)+1)/2.0
 ;plot,[0],[0],xrange=[0,10],yrange=[0.0,5.0]



;;;
 for i_theta = 0,n_theta-1 do begin

  
   weights = reform(1.0/slope(*,i_theta),n_jie)
   if i_recon eq 0 then begin
A = [2.0,0.6];;;;;;;;;;
   endif
   if i_recon eq 1 then begin
A = [1.6,0.8];;;;;;;;;;
   endif
tep_s = reform(slope(*,i_theta),n_jie)
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


plot,X,slope(*,i_theta),xrange=[0,10],yrange=[0.0,5.0],color=color_black,/noerase
  if i_recon eq 1 then begin
yfit = CURVEFIT(X, tep_s, weights, A, SIGMA, FUNCTION_NAME='extpmodel');惯性区extpmodel;耗散区dispmodel
  print,'Function parameters: ',A
  
 ; endfor
  
bx1 = Alog10(A(1)^(1*X/3)+(1-A(1))^(1*X/3))/alog10(2) ;惯性区X；耗散区2X
F1 = (-2.5+1.5*A(0))*(1*X/3)+1-bx1;;guan-2.5,hao-3.5
plot,X,F1,color=color_blue,xstyle=4,ystyle=4,xrange=[0,10],yrange=[0.0,5.0],linestyle=2,/noerase
xyouts,1,4.5,'theta = '+string((i_theta+1)*2),color=color_black;;;;
;wait,0.5
  endif
  if i_recon eq 0 then begin
yfit = CURVEFIT(X, tep_s, weights, A, SIGMA, FUNCTION_NAME='dispmodel');惯性区extpmodel;耗散区dispmodel
  print,'Function parameters: ',A
  
 ; endfor
  
bx1 = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2) ;惯性区X；耗散区2X
F1 = (-3.5+1.5*A(0))*(2*X/3)+1-bx1;;guan-2.5,hao-3.5
plot,X,F1,color=color_blue,xstyle=4,ystyle=4,xrange=[0,10],yrange=[0.0,5.0],linestyle=2,/noerase
xyouts,1,4.5,'theta = '+string((i_theta+1)*5),color=color_black;;;;
;wait,0.5
  endif

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'theta'+'_'+'1-5'+'_'+strcompress(string(3*(i_theta+1)),/remove_all)+'_fit_sp_p'+  $
       '_'+strre+'_or_v1.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd



re_A(0,i_theta) = A(0)
re_A(1,i_theta) = A(1) 
re_sigma(0,i_theta) = SIGMA(0)
re_sigma(1,i_theta) = Sigma(1)


endfor

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'pmodel_theta_alpha_P1'+strre+'_or_v1.sav';;;;;;
data_descrip= 'got from "fit_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  re_A ,re_sigma
  
endfor

step2:


Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1000.0
ysize = 1200.0
Window,2,XSize=xsize,YSize=ysize

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
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg1 = (position_img(3)-position_img(1))*0.65
dy_pos_SubImg2 = (position_img(3)-position_img(1))*0.35

for i_recon = 0,1 do begin
  if i_recon eq 0 then begin
    strre = 'hao'
    i_x_SubImg1  = 0
    i_y_SubImg1  = 1
    i_x_SubImg2  = 0
    i_y_SubImg2  = 0    
    title1 = '(a) '+day+' stream'+' dissipation'
    title2 = '(c) '+day+' stream'+' dissipation'    
  endif
  if i_recon eq 1 then begin
    strre = 'guan'
    i_x_SubImg1  = 1
    i_y_SubImg1  = 1
    i_x_SubImg2  = 1
    i_y_SubImg2  = 0
    title1 = '(b) '+day+' stream'+' inertial'
    title2 = '(d) '+day+' stream'+' inertial'   
  endif  

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'pmodel_theta_alpha_P1'+strre+'_or_v1.sav';;;;;;
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
;  re_A ,re_sigma

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_tao_jie_theta_'+strre+'_or_v1.sav';;;;;;;;
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
;    theta_bin_min_vect, slope, sigma(n_jie,num_theta_bins_plot)
sigmaslope = sigma

 position_SubImg1 = [position_img(0)+dx_pos_SubImg*(i_x_SubImg1+0.10),$  ;position_img  = [0.10,0.10,0.95,0.98]
           position_img(1)+dy_pos_SubImg1*(i_y_SubImg1-0.30),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg1+0.81),$
           position_img(1)+dy_pos_SubImg1*(i_y_SubImg1+0.50)]  
           
  position_SubImg2 = [position_img(0)+dx_pos_SubImg*(i_x_SubImg2+0.10),$
           position_img(1)+dy_pos_SubImg2*(i_y_SubImg2+0.30),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg2+0.75),$
           position_img(1)+dy_pos_SubImg2*(i_y_SubImg2+0.90)]  
 
;step3:
 
 num_theta_bins = n_theta
;n_jie = 14L ;阶数


;plot,[0],[0],xrange=[0,12],yrange=[0.0,8.0], xcharsize=2,ycharsize=2,charthick=2,position=position;,/isotropic
ds=findgen(num_theta_bins)*0.3   ;
p=(indgen(n_jie)+1)/2.0; 10阶不除以2
con=1
for i=1,num_theta_bins-1 do begin
  for j=0,n_jie-1 do begin
  if finite(slope(j,i)) eq 0 then begin
    con=0
  endif 
  endfor
  if con eq 1 then begin
 ; plot,p,slope(2*i,*)+ds(i),xrange=[0,11],yrange=[0.0,8.0],xtitle='p',ytitle='s',/noerase;,/isotropic
; if i eq 1 then begin
;  XRange=[0,9]
; YRange=[0.0,8.0] 
;  Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1,YStyle=1, xthick=4,ythick=4,Color=color_black, $  ;range
;    XTitle='p', YTitle=textoidl('\xi')+'(p)', charsize=1.25,charthick=4,position= position_SubImg1, $
;    /NoErase, /NoData
; ; PlotSym, 0, 0.3, FILL=1,thick=0.5,Color=color_black
;  Plots, p, slope(*,i)+ds(i),Thick=2,psym = 0,Color=color_black
;
;  bx1 = Alog10(re_A(1,i)^(1*p/3)+(1-re_A(1,i))^(1*p/3))/alog10(2) ;;;;;;;惯性p;耗散2p
;F1 = (-2.5+1.5*re_A(0,i))*(1*p/3)+1-bx1
;oplot,p,F1+ds(i),color=color_red,linestyle=2;,thick=2
;
;  ErrPlot, p, slope(*,i)+ds(i)-sigmaslope(*,i), slope(*,i)+ds(i)+sigmaslope(*,i), $
;    Thick=2,Color=color_black
; endif else begin
  
 XRange=[0,7]
 YRange=[0.0,16.0] 
  Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1,YStyle=1, xthick=4/2,ythick=4/2,Color=color_black, $  ;range
    XTitle='p', YTitle=textoidl('\xi')+'(p)', charsize=1.25,charthick=4/2,position= position_SubImg1, $
    /NoErase, /NoData
  xyouts,2,16.2,title1,charsize=1.25,charthick=4/2,Color=color_black
;  PlotSym, 0, 0.3, FILL=1,thick=0.5,Color=color_black

  if i_recon eq 0 then begin
  Plots, p, slope(*,i)+ds(i),Thick=2/2,psym = 0,Color=color_black    
  bx1 = Alog10(re_A(1,i)^(2*p/3)+(1-re_A(1,i))^(2*p/3))/alog10(2);;;;;;;惯性p;耗散2p
F1 = (-3.5+1.5*re_A(0,i))*(2*p/3)+1-bx1;;;;;;;
oplot,p,F1+ds(i),color=color_red,linestyle=2,thick=2
  ErrPlot, p, slope(*,i)+ds(i)-sigmaslope(*,i), slope(*,i)+ds(i)+sigmaslope(*,i), $
    Thick=2,Color=color_black
  endif
  if i_recon eq 1 then begin
  Plots, p, slope(*,i)+ds(i),Thick=2/2,psym = 0,Color=color_black    
  bx1 = Alog10(re_A(1,i)^(1*p/3)+(1-re_A(1,i))^(1*p/3))/alog10(2);;;;;;;惯性p;耗散2p
F1 = (-2.5+1.5*re_A(0,i))*(1*p/3)+1-bx1;;;;;;;
oplot,p,F1+ds(i),color=color_red,linestyle=2,thick=2
  ErrPlot, p, slope(*,i)+ds(i)-sigmaslope(*,i), slope(*,i)+ds(i)+sigmaslope(*,i), $
    Thick=2,Color=color_black
  endif  
  
 ;endelse 
  
  endif
  con=1
endfor



;step4:


NN = size(re_A)

xrange=[0,90]
thetafen = findgen(nn(2))*3+3;;;;;;;;;;;
sub = where(re_A(0,*)*10.0-round(re_A(0,*)*10.0) ne 0.0 )
plot,thetafen(sub),re_A(0,sub),xrange=xrange,yrange=[0.0,3], $
Position=position_SubImg2,xtitle=textoidl('\theta'),ytitle=textoidl('\alpha'),xstyle=1,ystyle=8,xthick=4/2,ythick=4/2,color=color_black,charsize=1.25,charthick=4/2,thick=4/2,/noerase
ErrPlot, thetafen(sub), re_A(0,sub)-re_sigma(0,sub), re_A(0,sub)+re_sigma(0,sub), $
    Thick=4/2,Color=color_black
xyouts,20,2.65,title2,charsize=1.25,charthick=4/2,color = color_black    
plot,thetafen(sub),re_A(1,sub),psym=-1,xrange=xrange,yrange=[0.5,1.0], $
Position=position_SubImg2,ytitle=textoidl('P_1'),color=color_blue,xstyle=1+4,ystyle=4,thick=4/2,/noerase
axis,yaxis=1,yrange=[0.5,1.0],color=color_blue,ytitle=textoidl('P_1'),charsize=1.25,charthick=4/2,ythick=4/2

endfor

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure4n_sp_p_and_alpha_p1_theta_'+day+'_or_v1.png'
Write_PNG, dir_fig+file_fig, image_tvrd



end_program:
end
