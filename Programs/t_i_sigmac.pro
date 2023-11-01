;pro T_I_sigmaC



sub_dir_date = 'wind\slow\19950223\'


step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h0_mfi_19950223_v05.sav'
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
;    JulDay_vect, Bxyz_GSE_arr

JulDay_B = JulDay_vect


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_19950223_v03.sav'
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

JulDay_V = JulDay_vect

step2:;计算sigmaC
;速度和磁场插值成一样长
num_times = n_elements(JulDay_B)
;Julday_beg = min(JulDay_B)
;Julday_end = max(JulDay_B)
;JulDay_vect = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)
Vxyz_GSE_arr = fltarr(3,num_times)

Vx_vect = Interpol(Reform(Vxyz_GSE_p_arr(0,*)), JulDay_V, JulDay_B)
Vy_vect = Interpol(Reform(Vxyz_GSE_p_arr(1,*)), JulDay_V, JulDay_B)
Vz_vect = Interpol(Reform(Vxyz_GSE_p_arr(2,*)), JulDay_V, JulDay_B)
Vxyz_GSE_arr(0,*) = Transpose(Vx_vect)
Vxyz_GSE_arr(1,*) = Transpose(Vy_vect)
Vxyz_GSE_arr(2,*) = Transpose(Vz_vect)
;Vt_vect = sqrt(Vxyz_GSE_arr(0,*)^2+Vxyz_GSE_arr(1,*)^2+Vxyz_GSE_arr(2,*)^2))
;Bt_vect = sqrt(Bxyz_GSE_arr(0,*)^2+Bxyz_GSE_arr(1,*)^2+Bxyz_GSE_arr(2,*)^2))
N_vect = Interpol(NumDens_p_vect, JulDay_V, JulDay_B)
T_vect = Interpol(Temper_p_vect, JulDay_V, JulDay_B)
JulDay_vect = JulDay_B
get_Alfven_velocity_v2, N_vect, Bxyz_GSE_arr(0,*)*0.00001, VAx_vect
get_Alfven_velocity_v2, N_vect, Bxyz_GSE_arr(1,*)*0.00001, VAy_vect
get_Alfven_velocity_v2, N_vect, Bxyz_GSE_arr(2,*)*0.00001, VAz_vect

period_range = [6,204]
is_log = 0
num_periods = 34

jieshu = 1
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
Diff_BComp_arr = fltarr(num_times,num_periods)
diff_Bt_arr = fltarr(num_times,num_periods)
diff_Vx_arr = fltarr(num_times,num_periods)
diff_Vy_arr = fltarr(num_times,num_periods)
diff_Vz_arr = fltarr(num_times,num_periods)
get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, Vx_vect, Vy_vect, Vz_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    Bt_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_Bx_arr=Diff_Vx_arr,Diff_By_arr=Diff_Vy_arr,Diff_Bz_arr=Diff_Vz_arr, $  ;;
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr

diff_VAx_arr = fltarr(num_times,num_periods)
diff_VAy_arr = fltarr(num_times,num_periods)
diff_VAz_arr = fltarr(num_times,num_periods)
get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, VAx_vect, VAy_vect, VAz_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    Bt_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_Bx_arr=Diff_VAx_arr,Diff_By_arr=Diff_VAy_arr,Diff_Bz_arr=Diff_VAz_arr, $  ;;
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr


Zx_plus = fltarr(num_times,num_periods)
Zx_minus = fltarr(num_times,num_periods)
Zy_plus = fltarr(num_times,num_periods)
Zy_minus = fltarr(num_times,num_periods)
Zz_plus = fltarr(num_times,num_periods)
Zz_minus = fltarr(num_times,num_periods)
for i_period = 0,num_periods-1 do begin
  Zx_plus(*,i_period) = Diff_Vx_arr(*,i_period)+Diff_VAx_arr(*,i_period)
  Zx_minus(*,i_period) = Diff_Vx_arr(*,i_period)-Diff_VAx_arr(*,i_period)
  Zy_plus(*,i_period) = Diff_Vy_arr(*,i_period)+Diff_VAy_arr(*,i_period)
  Zy_minus(*,i_period) = Diff_Vy_arr(*,i_period)-Diff_VAy_arr(*,i_period)
  Zz_plus(*,i_period) = Diff_Vz_arr(*,i_period)+Diff_VAz_arr(*,i_period)
  Zz_minus(*,i_period) = Diff_Vz_arr(*,i_period)-Diff_VAz_arr(*,i_period)
endfor

Zt_plus = Zx_plus^2+Zy_plus^2+Zz_plus^2
Zt_minus = Zx_minus^2+Zy_minus^2+Zz_minus^2

sigmaC = (Zt_plus-Zt_minus)/(Zt_plus+Zt_minus)
print,min(sigmaC,/nan),max(sigmaC,/nan)



step3:  ;计算I
num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
Bx_vect  = reform(Bxyz_GSE_arr(0,*))
By_vect  = reform(Bxyz_GSE_arr(1,*))
Bz_vect  = reform(Bxyz_GSE_arr(2,*))



jieshu=1
Diff_BComp_arr = fltarr(num_times,num_periods)
diff_Bt_arr = fltarr(num_times,num_periods)
diff_Bx_arr = fltarr(num_times,num_periods)
diff_By_arr = fltarr(num_times,num_periods)
diff_Bz_arr = fltarr(num_times,num_periods)
get_StructFunct_of_Bt_time_scale_arr_Helios, $
    time_vect, Bx_vect, By_vect, Bz_vect, $    ;input
    jieshu,                   $       ;input
    period_range=period_range, $  ;input
    num_periods=num_periods, is_log=is_log, $ ;input
    Bt_StructFunct_arr, $      ;output
    period_vect=period_vect, $
    Diff_Bx_arr=Diff_Bx_arr,Diff_By_arr=Diff_By_arr,Diff_Bz_arr=Diff_Bz_arr, $  ;;
    Diff_Bt_arr=Diff_Bt_arr,Diff_Bcomp_arr=Diff_Bcomp_arr



reso = time_vect(1)-time_vect(0)
I = fltarr(num_times,num_periods)+!values.F_nan
I_up = I
I_dn = I

for i_period = 0,num_periods-1 do begin
 
n_lag = round(period_vect(i_period)/reso)


I_up(0:num_times-n_lag-1,i_period) = sqrt((Bxyz_GSE_arr(0,n_lag:num_times-1)-Bxyz_GSE_arr(0,0:num_times-n_lag-1))^2.+ $
  (Bxyz_GSE_arr(1,n_lag:num_times-1)-Bxyz_GSE_arr(1,0:num_times-n_lag-1))^2.+ $
  (Bxyz_GSE_arr(2,n_lag:num_times-1)-Bxyz_GSE_arr(2,0:num_times-n_lag-1))^2.)
I_dn(0:num_times-n_lag-1,i_period) = sqrt(mean(I_up(n_lag/2:num_times-n_lag/2-1,i_period)^2.,/nan))
I(0:num_times-n_lag-1,i_period) = I_up(0:num_times-n_lag-1,i_period)/I_dn(0:num_times-n_lag-1,i_period)

endfor


step4:

n_cell = 50
I_plot = I(*,1)
dev = stddev(I_plot,/nan)
N = n_elements(I_plot)
I_max = max(I_plot,/nan)
I_min = min(I_plot,/nan)
I_range = I_max-I_min
I_bin = I_range/n_cell

x = I_min + findgen(n_cell)*I_bin+I_bin/2.
print,I_range





C_plot = sigmaC(*,1)
dev_C = stddev(C_plot,/nan)
N = n_elements(C_plot)
C_max = max(C_plot,/nan)
C_min = min(C_plot,/nan)
C_range = C_max-C_min

print,C_range


C_bin = C_range/n_cell
C_vect = C_min+findgen(n_cell)*C_bin

T_fb = fltarr(n_cell,n_cell)
for i_I = 0,n_cell-1 do begin
  for i_C = 0,n_cell-1 do begin
    sub_time = where((I_plot ge (I_min+i_I*I_bin) and I_plot lt (I_min+(i_I+1)*I_bin)) $
    and (C_plot ge (C_min+i_c*C_bin) and C_plot lt (C_min+(i_c+1)*C_bin)))
     
    T_fb(i_I,i_C) = mean(T_vect(sub_time),/nan)
  endfor
endfor


step5:


Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 600.0
Window,2,XSize=xsize,YSize=ysize


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

color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]


JulDay_vect_TV = x
period_vect_TV = C_vect
;;;---
image_TV  = T_fb
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = 'I at 12s'
ytitle  = 'sigmaC at 12s'
title = TexToIDL('Num')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(JulDay_vect_TV), Max(JulDay_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;xrange_time = xrange
;get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
 ; XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0
;;;---
position_CB   = [position_SubImg(2)+0.08,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('T(10^4 K)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3



image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'T_I_sigmaC.png'
Write_PNG, dir_fig+file_fig, image_tvrd





end











