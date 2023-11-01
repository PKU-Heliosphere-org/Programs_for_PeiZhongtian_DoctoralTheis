;pro paper3_plot_sp_p_theta_remove_background

day = 'fast'
sub_dir_date  = 'wind\'+day+'\case3\'
day1 = 'slow'
sub_dir_date1  = 'wind\'+day1+'\case3\'

n_jie = 10
;n_d = 15
n_theta = 30;;;;;
;;--
step1:


position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


 Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=800.0 & ysize=800.0
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
    color_gray = 250L
    TVLCT,127L,127L,127L,color_gray
    num_CB_color= 256-6
    R=Congrid(R,num_CB_color)
    G=Congrid(G,num_CB_color)
    B=Congrid(B,num_CB_color)
    TVLCT,R,G,B
    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 

for i_s = 0,1 do begin
for i_recon = 0,1 do begin
  if i_s eq 0 and i_recon eq 0 then begin
    strre = 'hao'
    i_x_SubImg  = 1
    i_y_SubImg  = 1
    sub_dir_date = sub_dir_date
    day = day
    title = ' '+day+' stream'+' dissipation'
  endif
  if i_s eq 0 and i_recon eq 1 then begin
    strre = 'guan'
    i_x_SubImg  = 0
    i_y_SubImg  = 1   
    sub_dir_date = sub_dir_date  
    day = day   
    title = ' '+day+' stream'+' inertial'
  endif  
  if i_s eq 1 and i_recon eq 0 then begin
    strre = 'hao'
    i_x_SubImg  = 1
    i_y_SubImg  = 0
    sub_dir_date = sub_dir_date1
    day = day1
    title = ' '+day+' stream'+' dissipation'
  endif
  if i_s eq 1 and i_recon eq 1 then begin
    strre = 'guan'
    i_x_SubImg  = 0
    i_y_SubImg  = 0   
    sub_dir_date = sub_dir_date1   
    day = day1  
    title = ' '+day+' stream'+' inertial'
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





position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)] 

for i_p = 0,4 do begin
n_theta = n_elements(theta_bin_min_vect)  
X = theta_bin_min_vect
plot,X,slope(i_p+1,*),xrange=[0,90],yrange=[0.0,3.0],color=color_black,position= position_SubImg,  $
  XTitle=textoidl('\theta'), YTitle=textoidl('\zeta')+'(p)',title=title,/noerase,/nodata
;  ErrPlot, X, slope(i_p+1,*)-sigmaslope(i_p+1,*), slope(i_p+1,*)+sigmaslope(i_p+1,*), $
;    Thick=1,Color=color_black
xyouts,x(29)+2,slope(i_p+1,29),strcompress(string(i_p/2.+1.,format='(F5.1)'),/remove_all),color=color_black

for i_duan = 0,n_theta-2 do begin
  if sigmaslope(i_p+1,i_duan) ge 0.05*(i_p/2.+1.) then begin
    oplot,x(i_duan:(i_duan+1)),slope(i_p+1,i_duan:(i_duan+1)),color = color_gray,thick=1
      ErrPlot, X(i_duan:i_duan), slope(i_p+1,i_duan:i_duan)-sigmaslope(i_p+1,i_duan:i_duan), slope(i_p+1,i_duan:i_duan)+sigmaslope(i_p+1,i_duan:i_duan), $
    Thick=1,Color=color_gray
  endif else begin
    oplot,x(i_duan:(i_duan+1)),slope(i_p+1,i_duan:(i_duan+1)),color = color_black,thick=2
      ErrPlot, X(i_duan:i_duan), slope(i_p+1,i_duan:i_duan)-sigmaslope(i_p+1,i_duan:i_duan), slope(i_p+1,i_duan:i_duan)+sigmaslope(i_p+1,i_duan:i_duan), $
    Thick=1,Color=color_black
  endelse
endfor  


endfor

endfor
endfor

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'Figure5_sp_p_theta_or_v1.png'
Write_PNG, dir_fig+file_fig, image_tvrd

end 