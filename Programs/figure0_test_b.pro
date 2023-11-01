;pro figure0_test_B

sub_dir_date = 'wind\slow\case1\'
sub_dir_date1 = 'wind\fast\case1\'

dir_fig = 'wind\fig\'


goto,step3
step1:

n_d = 15
N_aver = fltarr(n_d)
T_aver = fltarr(n_d)
B_aver = fltarr(n_d)
V_aver = fltarr(n_d)

for i = 1,n_d    do begin

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i),/remove_all)+'_v.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

;Bxyz_GSE_2s_arr = B_RTN_1s_arr
JulDay_vect = JulDay_vect_interp


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= strcompress(string(i),/remove_all)+'_3dp.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr


Bt_vect = sqrt(Bx_GSE_vect_interp^2+By_GSE_vect_interp^2+Bz_GSE_vect_interp^2)
B_aver(i-1) = mean(Bt_vect,/nan)
V_vect = sqrt(Vxyz_GSE_p_arr(0,*)^2+Vxyz_GSE_p_arr(1,*)^2+Vxyz_GSE_p_arr(2,*)^2)
V_aver(i-1) = mean(V_vect,/nan)
T_aver(i-1) = mean(Temper_p_vect,/nan)
N_aver(i-1) = mean(NumDens_p_vect,/nan)

Bt_std = stddev(Bt_vect,/nan)

print,Bt_std





endfor


step2:

day = uindgen(15)+1

;;--
Set_Plot, 'win'
Device,DeComposed=0;, /Retain
xsize=1000.0 & ysize=900.0
Window,2,XSize=xsize,YSize=ysize,Retain=2

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

;;--
position_img  = [0.05,0.05,0.95,0.95]
num_subimgs_x = 1
num_subimgs_y = 4
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
i_subimg_x  = 0
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
        
Plot,day, B_aver,XStyle=1,YStyle=1,$
  Position=win_position,$
  XTitle='Day',YTitle='B_aver(nT)',$
  Color=color_black,$
  /NoErase,Font=-1
  
;;--
i_subimg_x  = 0
i_subimg_y  = 1
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
        
Plot,day, V_aver,XStyle=1,YStyle=1,$
  Position=win_position,$
  XTitle='Day',YTitle='V_aver(km/s)',$
  Color=color_black,$
  /NoErase,Font=-1

;;--
i_subimg_x  = 0
i_subimg_y  = 2
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
        
Plot,day, T_aver,XStyle=1,YStyle=1,$
  Position=win_position,$
  XTitle='Day',YTitle='T_aver(eV)',$
  Color=color_black,$
  /NoErase,Font=-1
  
  
;;--
i_subimg_x  = 0
i_subimg_y  = 3
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
        
Plot,day, N_aver,XStyle=1,YStyle=1,$
  Position=win_position,$
  XTitle='Day',YTitle='N_aver(cm^-3)',$
  Color=color_black,$
  /NoErase,Font=-1
  

image_tvrd  = TVRD(true=1)
file_version= '(pm)'
dir_fig   = GetEnv('WIND_Figure_Dir')+dir_fig
file_fig  = 'figure0_test_slow'+$
            '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

step3:;;;;验证2阶结构函数分角度

n_jie = 14L;;;
jie = (findgen(n_jie)+1)/2.0
num_theta = 9L
i_jie = 3
jieshu = jie(i_jie)
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct_'+strcompress(string(jieshu),/remove_all)+'_guan_'+'day10-12_theta_period_arr'+$
        'V2.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  theta_bin_min_vect, theta_bin_max_vect, $
;  period_vect, $
;  StructFunct_Bt_theta_scale_arr


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


plot,period_vect,StructFunct_Bt_theta_scale_arr(8,*),/xlog,/ylog,color = color_black,yrange=[0.01,10]
oplot,period_vect,StructFunct_Bt_theta_scale_arr(0,*),color = color_red
oplot,period_vect,StructFunct_Bt_theta_scale_arr(17,*),color = color_green

result1 = linfit(Alog10(period_vect),alog10(StructFunct_Bt_theta_scale_arr(8,*)))
result2 = linfit(Alog10(period_vect),alog10(StructFunct_Bt_theta_scale_arr(0,*)))

print,result1,result2

end


























