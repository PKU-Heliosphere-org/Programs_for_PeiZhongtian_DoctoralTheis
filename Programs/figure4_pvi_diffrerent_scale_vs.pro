;pro figure4_PVI_diffrerent_scale_vs

sub_dir_date = 'wind\slow\case2\'
;sub_dir_date1 = 'wind\fast\case1\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1-5.sav'
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



;period_range = [0.4,2];;;;惯性区[20,100]60耗散区[0.4,2]1.2
is_log = 0
num_periods = 3

period_min = 20;4*time_lag;耗散0.4，惯性20
period_max = 100;20*time_lag;耗散2，惯性100
period_range = [period_min,period_max]


;;;---
J_wavlet  = num_periods
If (is_log eq 1) Then Begin
  dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
  period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
EndIf Else Begin
  dperiod   = (period_max-period_min)/(num_periods-1)
  period_vect = period_min + Findgen(num_periods)*dperiod
EndElse

num_times = n_elements(JulDay_vect)
time_vect = (JulDay_vect(0:num_times-1)-JulDay_vect(0))*(24.*60.*60.)
dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = (Round(period_vect/dt_pix)/2)*2

;;--

;num_periods = J_wavlet
num_times = N_Elements(time_vect)
;window_vect = 5.*period_vect


Bx_new_arr = Fltarr(num_times, num_periods)
By_new_arr = Fltarr(num_times, num_periods)
Bz_new_arr = Fltarr(num_times, num_periods)

Bcomp_vect = Bz_vect

jieshu=1
Diff_BComp_arr  = Fltarr(num_times, num_periods)
For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf

  ;;;---get 'diff_BComp_vect/arr' and transfer to the uppper level for calculating 'SF_para/perp_vect'
  Diff_BComp_vect = BComp_vect_backward-BComp_vect_forward;;;;
  Diff_BComp_arr(*,i_period)  = Diff_BComp_vect
EndFor


BComp_new_arr = Fltarr(num_times, num_periods)+!values.f_nan
BComp_bg_arr  = Fltarr(num_times, num_periods)+!values.f_nan
dBComp_bg  = Fltarr(num_times, num_periods)+!values.f_nan
dBComp_new  = Fltarr(num_times, num_periods)+!values.f_nan

For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2

  If (pix_shift ge 1) Then Begin
  for i_time = 5*pix_shift,num_times-5*pix_shift-1 do begin
    BComp_bg_arr(i_time,i_period) = mean(BComp_vect(i_time-5*pix_shift:i_time+5*pix_shift),/nan)
    BComp_new_arr(i_time,i_period) = BComp_vect(i_time)-BComp_bg_arr(i_time,i_period)  
  EndFor
  for i_time = 6*pix_shift,num_times-6*pix_shift-1 do begin
    dBComp_bg(i_time,i_period) = BComp_bg_arr(i_time-pix_shift,i_period) - BComp_bg_arr(i_time+pix_shift,i_period)
    dBComp_new(i_time,i_period) = BComp_new_arr(i_time-pix_shift,i_period) - BComp_new_arr(i_time+pix_shift,i_period)
  endfor
  endif
endfor
Diff_Bz_arr = Diff_BComp_arr
Bz_new_arr = BComp_new_arr
Bz_bg_arr = BComp_bg_arr
dBz_new = dBComp_new
dBz_bg = dBComp_bg

;;;;
PVI = fltarr(num_times,num_periods)
for i_period = 0,num_periods-1 do begin
PVI(*,i_period) = dBz_new(*,i_period)/sqrt(mean(abs(dBz_new(*,i_period))^2,/nan));;;;;;;;;;;;
endfor



step2:

x = PVI(*,0)
y = PVI(*,1)

Set_Plot, 'Win'
Device,DeComposed=0
;xsize = 500.0
;ysize = 500.0
;Window,1,XSize=xsize,YSize=ysize
;
;plot,x,y,psym=3




xsize = 500.0
ysize = 500.0
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

n_cell = 70
;;先分成均匀网格
x_min_vect = (dindgen(n_cell)-n_cell/2)/5.
x_max_vect = (dindgen(n_cell)-n_cell/2+1)/5.
y_min_vect = x_min_vect
y_max_vect = x_max_vect

PDF = fltarr(n_cell,n_cell)
for i = 0,n_cell-1 do begin
  for j = 0,n_cell-1 do begin
    sub_tmp = where(x ge x_min_vect(i) and x lt x_max_vect(i) and y ge y_min_vect(j) and y lt y_max_vect(j))
    if sub_tmp(0) eq (-1) then begin
    PDF(i,j) = !values.f_nan;n_elements(sub_tmp)
    endif else begin
    PDF(i,j) = n_elements(sub_tmp)
    endelse
  endfor
endfor
num = fltarr(n_cell)
;PDF_perce = fltarr(40,40)
;for j_cell = 0,n_cell-1 do begin
;  
;  PDF_plot_s(j_cell,*) = PDF(j_cell,*)/(mean(PDF(j_cell,*))*n_cell)
;  sub_zero = where(PDF_plot_s(j_cell,*) eq 0)
;  if sub_zero(0) ne -1 then begin
;    PDF_plot_s(j_cell,sub_zero) = !values.f_nan
;  endif
;endfor
;for i = 0,39 do begin
;  PDF_perce(i,*) = PDF(i,*)/(mean(PDF(i,*),/nan)*20.)
;  sub_zero = where(PDF_perce(i,*) eq 0)
;  if sub_zero(0) ne -1 then begin
;    PDF_perce(i,sub_zero) = !values.f_nan
;  endif
;endfor

;PDF_perce = PDF/num_times

;;--
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


JulDay_vect_TV = x_min_vect
period_vect_TV = y_min_vect


;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = alog10(PDF)
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
xtitle  = textoIDL('\delta')+'Bz/'+textoidl('\sigma')+' at 20s';haosan0.4s guanxing20s
ytitle  = textoIDL('\delta')+'Bz/'+textoidl('\sigma')+' at 60s';haosan1.2s guanxing60s
title = 'PDF'
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
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
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
titleCB     = TexToIDL('log(PDF)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
  
;;;去掉nan  
x_test = x-x
y_test = y-y
x_cc = x(where(x_test eq 0 and y_test eq 0))
y_cc = y(where(x_test eq 0 and y_test eq 0))
;;;
cc = correlate(x_cc,y_cc)


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+'wind\slow\case2\'
file_save = 'PVI_scale_ralative_guan_log_slow.sav';;改
data_descrip= 'got from "get_no_angle_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  cc, PVI, PDF, n_cell


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+'wind\slow\case2\';;;;
file_fig  = 'PVI_scale_ralative_guan_log'+string(cc)+'_slow.png';;
Write_PNG, dir_fig+file_fig, image_tvrd

end_program:
end
