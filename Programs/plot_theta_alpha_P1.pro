;pro plot_theta_alpha_P1



sub_dir_date  = 'new\19950720-29\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;;--
Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'alpha_P1_theta.eps', $   ;
    XSize=22,YSize=8,/Color,Bits=10,/Encapsul
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


Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'extpmodel_theta_alpha_P1.sav'
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
;  re_A  ,re_sigma
re_A_o = re_A
re_sigma_o = re_sigma  

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'extpmodel_theta_alpha_P1_recon.sav'
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
;  re_A  ,re_sigma
re_A_r = re_A
re_sigma_r = re_sigma 

for i_s = 0,1 do begin
  if i_s eq 0 then begin
    re_A = re_A_o
    re_sigma = re_sigma_o
    i_x_SubImg  = 0
    i_y_SubImg  = 0
    title = '(c)original'
  endif
  if i_s eq 1 then begin
    re_A = re_A_r
    re_sigma = re_sigma_r
    i_x_SubImg  = 1
    i_y_SubImg  = 0
    title = '(d)reconstruction'
  endif
 position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

step2:

;ConfidenceLevel = 95./100
;Degreefreedom = 22
;get_ConfidenceInterval_for_T_Test, DegreeFreedom, ConfidenceLevel, $
;    ConfidenceInterval
;rere_sigma = re_sigma/(0.5*ConfidenceInterval)




NN = size(re_A)


thetafen = findgen(nn(2))*2.0+1.0
sub = where(re_A(0,*)*10.0-round(re_A(0,*)*10.0) ne 0.0 )
plot,thetafen(sub),re_A(0,sub),yrange=[0.0,2.5], $
Position=position_SubImg,xtitle=textoidl('\theta'),ytitle=textoidl('\alpha'),ystyle=8,color=color_black,title=title,charthick=1.5,thick=1.5,/noerase
ErrPlot, thetafen(sub), re_A(0,sub)-re_sigma(0,sub), re_A(0,sub)+re_sigma(0,sub), $
    Thick=1.5
    
plot,thetafen(sub),re_A(1,sub),psym=-1,yrange=[0.5,1.0], $
Position=position_SubImg,ytitle=textoidl('P_1'),color=color_blue,xstyle=4,ystyle=4,thick=1.5,charthick=1.5,/noerase
axis,yaxis=1,yrange=[0.5,1.0],color=color_blue,ytitle=textoidl('P_1')

endfor
;oplot,thetafen(sub),re_A(1,sub)
;ErrPlot, thetafen(sub), re_A(1,sub)-re_sigma(1,sub), re_A(1,sub)+re_sigma(1,sub), $
;    Thick=1.5, Color='ff0000'XL
device,/close

;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;file_version= '(v1)'
;file_fig  = 'alpha_P1_theta'+$
;        '_recon.eps'
;Write_PNG, dir_fig+file_fig, image_tvrd

end














