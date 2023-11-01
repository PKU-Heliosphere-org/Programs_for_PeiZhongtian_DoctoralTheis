;pro figure4_plot_sp_p_theta



sub_dir_date  = 'wind\fig\'







n_jie = 14
n_d = 15
n_theta = 9
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'slope_of_s(p)_vs_tao_theta'+'_hao_day10-12_V2.sav';;;;;;;;
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
;  theta_bin_cen_vect_plot, slope_fast, sigmaslope_fast, slope_slow, sigmaslope_slow(n_d,n_jie,num_theta_bins_plot)

for i_the =0,n_theta-1 do begin
  slope_fast(*,i_the) = slope_fast(*,i_the)/slope_fast(3,i_the)
  slope_slow(*,i_the) = slope_slow(*,i_the)/slope_slow(3,i_the)
endfor


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'dispmodel_theta_alpha_P1'+'_over2_V2.sav';;;;;;
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "fit_sp_p.pro"'s
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  re_A_fast ,re_sigma_fast, re_A_slow ,re_sigma_slow(2,i_d,i_theta)




step1:


  
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1000.0
ysize = 1200.0
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
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg1 = (position_img(3)-position_img(1))*0.65
dy_pos_SubImg2 = (position_img(3)-position_img(1))*0.35
  
  for i_s = 0,1 do begin
  if i_s eq 0 then begin
    slope = slope_fast
    re_A = re_A_fast
    re_sigma = re_sigma_fast
    sigmaslope = sigmaslope_fast
    i_x_SubImg1  = 0
    i_y_SubImg1  = 1
    i_x_SubImg2  = 0
    i_y_SubImg2  = 0    
    title1 = '(a) fast stream'
    title2 = '(c) fast stream'    
  endif
  if i_s eq 1 then begin
    slope = slope_slow
    re_A = re_A_slow
    re_sigma = re_sigma_slow
    sigmaslope = sigmaslope_slow
    i_x_SubImg1  = 1
    i_y_SubImg1  = 1
    i_x_SubImg2  = 1
    i_y_SubImg2  = 0
    title1 = '(b) slow stream'
    title2 = '(d) slow stream'    
  endif
  
  


 position_SubImg1 = [position_img(0)+dx_pos_SubImg*(i_x_SubImg1+0.10),$  ;position_img  = [0.10,0.10,0.95,0.98]
           position_img(1)+dy_pos_SubImg1*(i_y_SubImg1-0.30),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg1+0.81),$
           position_img(1)+dy_pos_SubImg1*(i_y_SubImg1+0.50)]  
           
  position_SubImg2 = [position_img(0)+dx_pos_SubImg*(i_x_SubImg2+0.10),$
           position_img(1)+dy_pos_SubImg2*(i_y_SubImg2+0.30),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg2+0.75),$
           position_img(1)+dy_pos_SubImg2*(i_y_SubImg2+0.90)]  
 
;step3:
 
 num_theta_bins = 9L
n_jie = 14L ;阶数


;plot,[0],[0],xrange=[0,12],yrange=[0.0,8.0], xcharsize=2,ycharsize=2,charthick=2,position=position;,/isotropic
ds=findgen(num_theta_bins)*0.5   ;
p=(indgen(n_jie)+1)/2.0; 10阶不除以2
con=1
for i=0,num_theta_bins-1 do begin
  for j=0,n_jie-1 do begin
  if finite(slope(j,i)) eq 0 then begin
    con=0
  endif 
  endfor
  if con eq 1 then begin
 ; plot,p,slope(2*i,*)+ds(i),xrange=[0,11],yrange=[0.0,8.0],xtitle='p',ytitle='s',/noerase;,/isotropic
 if i eq 1 then begin
  XRange=[0,9]
 YRange=[0.0,8.0] 
  Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1,YStyle=1, xthick=4,ythick=4, color=color_black, $  ;range
    XTitle='p', YTitle=textoidl('\xi')+'(p)', charsize=1.25,charthick=4,position= position_SubImg1, $
    /NoErase, /NoData
 ; PlotSym, 0, 0.3, FILL=1,thick=0.5,Color=color_black
  Plots, p, slope(*,i)+ds(i),Thick=2,psym = 0,color = color_black

  bx1 = Alog10(re_A(1,i)^(2.*p/3)+(1-re_A(1,i))^(2.*p/3))/alog10(2) ;;;;;;;惯性p;耗散2p
F1 = (-3.5+1.5*re_A(0,i))*(2.*p/3)+1-bx1
oplot,p,F1+ds(i),color=color_red,linestyle=2,thick=2

;  ErrPlot, p, slope(*,i)+ds(i)-sigmaslope(*,i), slope(*,i)+ds(i)+sigmaslope(*,i), $
;    Thick=2,color = color_black
 endif else begin
  
 XRange=[0,9]
 YRange=[0.0,8.0] 
  Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1,YStyle=1, xthick=4,ythick=4, color=color_black,$  ;range
    XTitle='p', YTitle=textoidl('\xi')+'(p)', charsize=1.25,charthick=4,position= position_SubImg1, $
    /NoErase, /NoData
  xyouts,3.5,8.2,title1,charsize=1.25,charthick=4,Color=color_black
;  PlotSym, 0, 0.3, FILL=1,thick=0.5,Color=color_black
  Plots, p, slope(*,i)+ds(i),Thick=2,psym = 0 ,color = color_black

    bx1 = Alog10(re_A(1,i)^(2.*p/3)+(1-re_A(1,i))^(2.*p/3))/alog10(2);;;;;
F1 = (-3.5+1.5*re_A(0,i))*(2.*p/3)+1-bx1
oplot,p,F1+ds(i),color=color_red,linestyle=2,thick=2
;  ErrPlot, p, slope(*,i)+ds(i)-sigmaslope(*,i), slope(*,i)+ds(i)+sigmaslope(*,i), $
;    Thick=2,color = color_black
 endelse 
  
  endif
  con=1
endfor



;step4:


NN = size(re_A)

xrange=[0,90]
thetafen = findgen(nn(2))*10.0+5.0
sub = where(re_A(0,*)*10.0-round(re_A(0,*)*10.0) ne 0.0 )
plot,thetafen(sub),re_A(0,sub),xrange=xrange,yrange=[0.0,2.5], $
Position=position_SubImg2,xtitle=textoidl('\theta'),ytitle=textoidl('\alpha'),xstyle=1,ystyle=8,xthick=4,ythick=4,color=color_black,charsize=1.25,charthick=4,thick=4,/noerase
;ErrPlot, thetafen(sub), re_A(0,sub)-re_sigma(0,sub), re_A(0,sub)+re_sigma(0,sub), $
;    Thick=4,Color=color_black
xyouts,30,2.65,title2,charsize=1.25,charthick=4    
plot,thetafen(sub),re_A(1,sub),psym=-1,xrange=xrange,yrange=[0.5,1.0], $
Position=position_SubImg2,ytitle=textoidl('P_1'),color=color_blue,xstyle=1+4,ystyle=4,thick=4,/noerase
axis,yaxis=1,yrange=[0.5,1.0],color=color_blue,ytitle=textoidl('P_1'),charsize=1.25,charthick=4,ythick=4

endfor



image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure4_sp_p_and_alpha_p1_theta_haosan_over2_V2.png'
Write_PNG, dir_fig+file_fig, image_tvrd



end_program:
end



























