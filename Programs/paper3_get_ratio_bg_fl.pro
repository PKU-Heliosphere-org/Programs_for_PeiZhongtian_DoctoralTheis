;pro paper3_get_ratio_bg_fl

sub_dir_date  = 'wind\slow\case1\'
sub_dir_date1  = 'wind\fast\case1\'

num_periods = 5
ratio_fast_guan = fltarr(num_periods)
ratio_fast_hao = fltarr(num_periods)
ratio_slow_guan = fltarr(num_periods)
ratio_slow_hao = fltarr(num_periods)

step1:

i_qu = 0
for i_qu = 0,1 do begin

if i_qu eq 0 then quyu = 'haosan'
if i_qu eq 1 then quyu = 'guanxing'


ratio = fltarr(15,num_periods)


for i_slow = 1,15 do begin


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  strcompress(string(i_slow),/remove_all)+quyu+'_SF.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  period_vect, $
;  Bt_SF,Bt_SF_bg


ratio(i_slow-1,*) = Bt_SF_bg(3,*)/Bt_SF(3,*)

endfor

if i_qu eq 0 then begin
  period_hao = period_vect
for i_period = 0,num_periods-1 do begin
  ratio_slow_hao(i_period) = median(ratio(*,i_period))
endfor
endif
if i_qu eq 1 then begin
  period_guan = period_vect
for i_period = 0,num_periods-1 do begin
  ratio_slow_guan(i_period) = median(ratio(*,i_period))
endfor
endif
endfor

step2:

i_qu = 0
for i_qu = 0,1 do begin

if i_qu eq 0 then quyu = 'haosan'
if i_qu eq 1 then quyu = 'guanxing'


ratio = fltarr(15,num_periods)


for i_slow = 1,15 do begin


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore=  strcompress(string(i_slow),/remove_all)+quyu+'_SF.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  period_vect, $
;  Bt_SF,Bt_SF_bg

ratio(i_slow-1,*) = Bt_SF_bg(3,*)/Bt_SF(3,*)

endfor

if i_qu eq 0 then begin
for i_period = 0,num_periods-1 do begin
  ratio_fast_hao(i_period) = median(ratio(*,i_period))
endfor
endif
if i_qu eq 1 then begin
for i_period = 0,num_periods-1 do begin
  ratio_fast_guan(i_period) = median(ratio(*,i_period))
endfor
endif

endfor

step3:

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

plot,period_guan,ratio_fast_guan,position = position_SubImg,title = 'fast inertial',xtitle='period(s)',ytitle='ratio',color = color_black,/xlog,/Noerase


    i_x_SubImg  = 0
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,ratio_fast_hao,position = position_SubImg,title = 'fast dissipation',xtitle='period(s)',ytitle='ratio',color = color_black,/xlog,/Noerase


    i_x_SubImg  = 1
    i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_guan,ratio_slow_guan,position = position_SubImg,title = 'slow inertial',xtitle='period(s)',ytitle='ratio',color = color_black,/xlog,/Noerase


    i_x_SubImg  = 1
    i_y_SubImg  = 0

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)]  

plot,period_hao,ratio_slow_hao,position = position_SubImg,title = 'slow dissipation',xtitle='period(s)',ytitle='ratio',color = color_black,/xlog,/Noerase

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_ratio_bg_fl.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd


end

