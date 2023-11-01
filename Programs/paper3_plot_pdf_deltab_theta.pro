;pro paper3_plot_PDF_deltaB_theta



sub_dir_date  = 'wind\slow\case2_v\'
;sub_dir_date1  = 'wind\fast\case1\'

step1:
;;;原始时间序列
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= '1-3.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;;Save, FileName=dir_save+file_save, $
;;    data_descrip, $
;;    TimeRange_str, $
;;  JulDay_vect, time_vect, Bx_vect, By_vect, Bz_vect
;;;;
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= '1-5quan_SF.sav'
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
;  period_vect, $
;  Bt_o,Bt_SF,Bt_SF_bg, dBx_new, dBy_new, dBz_new, Diff_Bx_arr, Diff_By_arr, Diff_Bz_arr


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_'+'1-5'+'(time=*-*)(period=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect, period_vect, $
; Bxyz_LBG_RTN_arr
;;;---
time_vect_LBG = time_vect
period_vect_LBG = period_vect


Bt_LBG_RTN_arr  = Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr

num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi

;period_range = [0.4,2];;;;惯性区[20,100]60耗散区[0.4,2]1.2
;is_log = 1
;num_periods = 12
;
;time_lag = time_vect_LBG(1)-time_vect_LBG(0)
;print,time_lag
;period_min = 4*time_lag;耗散0.4，惯性20
;period_max = 1000*time_lag;耗散2，惯性100
;period_range = [period_min,period_max]
;
;
;;;;---
;J_wavlet  = num_periods
;If (is_log eq 1) Then Begin
;  dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
;  period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)
;EndIf Else Begin
;  dperiod   = (period_max-period_min)/(num_periods-1)
;  period_vect = period_min + Findgen(num_periods)*dperiod
;EndElse
;
;dt_pix    = time_vect(1)-time_vect(0)
;PixLag_vect = (Round(period_vect/dt_pix)/2)*2
;
;;;--
;
;num_periods = J_wavlet
;num_times = N_Elements(time_vect)
;window_vect = 5.*period_vect
;
;
;Bx_new_arr = Fltarr(num_times, num_periods)
;By_new_arr = Fltarr(num_times, num_periods)
;Bz_new_arr = Fltarr(num_times, num_periods)
;
;Bcomp_vect = Bz_vect
;
;jieshu=1
;Diff_BComp_arr  = Fltarr(num_times, num_periods)
;For i_period=0,num_periods-1 Do Begin
;  pix_shift = PixLag_vect(i_period)/2
;  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
;  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
;  If (pix_shift ge 1) Then Begin
;    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
;    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
;  EndIf
;
;  ;;;---get 'diff_BComp_vect/arr' and transfer to the uppper level for calculating 'SF_para/perp_vect'
;  Diff_BComp_vect = BComp_vect_backward-BComp_vect_forward;;;;
;  Diff_BComp_arr(*,i_period)  = Diff_BComp_vect
;EndFor
;
;BComp_new_arr = Fltarr(num_times, num_periods)+!values.f_nan
;BComp_bg_arr  = Fltarr(num_times, num_periods)+!values.f_nan
;dBComp_bg  = Fltarr(num_times, num_periods)+!values.f_nan
;dBComp_new  = Fltarr(num_times, num_periods)+!values.f_nan
;
;For i_period=0,num_periods-1 Do Begin
;  pix_shift = PixLag_vect(i_period)/2
;
;  If (pix_shift ge 1) Then Begin
;  for i_time = 5*pix_shift,num_times-5*pix_shift-1 do begin
;    BComp_bg_arr(i_time,i_period) = mean(BComp_vect(i_time-5*pix_shift:i_time+5*pix_shift),/nan)
;    BComp_new_arr(i_time,i_period) = BComp_vect(i_time)-BComp_bg_arr(i_time,i_period)  
;  EndFor
;  for i_time = 6*pix_shift,num_times-6*pix_shift-1 do begin
;    dBComp_bg(i_time,i_period) = BComp_bg_arr(i_time-pix_shift,i_period) - BComp_bg_arr(i_time+pix_shift,i_period)
;    dBComp_new(i_time,i_period) = BComp_new_arr(i_time-pix_shift,i_period) - BComp_new_arr(i_time+pix_shift,i_period)
;  endfor
;  endif
;endfor
;Diff_Bz_arr = Diff_BComp_arr
;Bz_new_arr = BComp_new_arr
;Bz_bg_arr = BComp_bg_arr
;dBz_new = dBComp_new
;dBz_bg = dBComp_bg

read,'original(0) or remove background(1):',is_remove
if is_remove eq 0 then begin
dBz = Diff_Bz_arr
str_remove = 'ori'
endif  
if is_remove eq 1 then begin
dBz = dBz_new
str_remove = 'remove'
endif  

PVI = fltarr(num_times,num_periods)+!values.f_nan
Flat_time = fltarr(num_times,num_periods)+!values.f_nan
Flat = fltarr(num_periods)+!values.f_nan
PVI_theta = fltarr(2,num_times,num_periods)+!values.f_nan
PVI_theta_all = fltarr(2,num_times,num_periods)+!values.f_nan
Flat_theta_time = fltarr(2,num_times,num_periods)+!values.f_nan
Flat_theta = fltarr(2,num_periods)+!values.f_nan
Flat_theta_time_all = fltarr(2,num_times,num_periods)+!values.f_nan
Flat_theta_all = fltarr(2,num_periods)+!values.f_nan

for i_period = 0,num_periods-1 do begin
PVI(*,i_period) = dBz(*,i_period)/sqrt(mean(abs(dBz(*,i_period))^2,/nan));;;;;;;;;;;;
endfor

step2:

for i_period = 0,num_periods-1 do begin
     Flat_time(*,i_period) = PVI(*,i_period)^4        
     Flat(i_period) = mean(PVI(*,i_period)^4,/nan)    
endfor

for i_period = 0,num_periods-1 do begin
  sub_tmp = Where((theta_arr(*,i_period) ge 0 and $
          theta_arr(*,i_period) lt 30) or (theta_arr(*,i_period) ge 150 and $
          theta_arr(*,i_period) lt 180))
  num = n_elements(sub_tmp)
  If sub_tmp(0) ne -1 Then Begin
     PVI_theta(0,0:num-1,i_period) = dBz(sub_tmp,i_period)/sqrt(mean(abs(dBz(sub_tmp,i_period))^2,/nan));全角度sqrt(mean(abs(dBz(*,i_period))^2,/nan))对应sqrt(mean(abs(dBz(sub_tmp,i_period))^2,/nan))
     PVI_theta_all(0,0:num-1,i_period) = PVI(sub_tmp,i_period)
     Flat_theta_time(1,0:num-1,i_period) = PVI_theta(1,0:num-1,i_period)^4        
     Flat_theta(0,i_period) = mean(PVI_theta(0,0:num-1,i_period)^4,/nan)
     Flat_theta_time_all(1,0:num-1,i_period) = PVI_theta_all(1,0:num-1,i_period)^4        
     Flat_theta_all(0,i_period) = mean(PVI_theta_all(0,0:num-1,i_period)^4,/nan)     
  EndIf
endfor

for i_period = 0,num_periods-1 do begin
  sub_tmp = Where((theta_arr(*,i_period) ge 60 and $
          theta_arr(*,i_period) lt 120))
  num = n_elements(sub_tmp)
  If sub_tmp(0) ne -1 Then Begin
     PVI_theta(1,0:num-1,i_period) = dBz(sub_tmp,i_period)/sqrt(mean(abs(dBz(sub_tmp,i_period))^2,/nan));PVI(sub_tmp,i_period)
     PVI_theta_all(1,0:num-1,i_period) = PVI(sub_tmp,i_period)     
     Flat_theta_time(1,0:num-1,i_period) = PVI_theta(1,0:num-1,i_period)^4
     Flat_theta(1,i_period) = mean(PVI_theta(1,0:num-1,i_period)^4,/nan)     
     Flat_theta_time_all(1,0:num-1,i_period) = PVI_theta_all(1,0:num-1,i_period)^4
     Flat_theta_all(1,i_period) = mean(PVI_theta_all(1,0:num-1,i_period)^4,/nan)         
  EndIf
endfor
      

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'delta_Bz_theta_'+str_remove+'_wai1.sav';;改
data_descrip= 'got from "paper3_plot_PDF_deltaB_theta.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  PVI, Flat, PVI_theta, Flat_theta



Set_Plot, 'Win'
Device,DeComposed=0
xsize = 1200.0
ysize = 1000.0
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
num_x_SubImgs = 3
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


for i_liang = 0,1 do begin
;i_theta = 2
for i_theta = 0,2 do begin
if i_theta eq 0 and i_liang eq 0 then begin
   PVI_v=reform(PVI_theta(0,*,*));;;;;;;;;选全角度all还是不选
   i_x_SubImg  = 1
   i_x_SubImg2  = 2   
   i_y_SubImg  = 1
   title = textoIDL('\delta')+'Bz/'+textoidl('\sigma')+' at 0-30 degree'
   title2 = '%flatness'+' at 0-30 degree'
endif
if i_theta eq 1 and i_liang eq 0 then begin
   PVI_v=reform(PVI_theta(1,*,*));;;;;;;;;选全角度all还是不选
   i_x_SubImg  = 1
   i_x_SubImg2  = 2   
   i_y_SubImg  = 0
   title = textoIDL('\delta')+'Bz/'+textoidl('\sigma')+' at 60-90 degree'  
   title2 = '%flatness'+' at 60-90 degree'    
endif   
;if i_theta eq 2 and i_liang eq 0 then begin
;   PVI_v=reform(PVI);;;;;;;;;选全角度all还是不选
;   i_x_SubImg  = 1
;   i_x_SubImg2  = 2   
;   i_y_SubImg  = 2
;   title = textoIDL('\delta')+'Bz/'+textoidl('\sigma')+' at all degree'
;   title2 = '%flatness'+' at all degree'
;endif
if i_theta eq 0 and i_liang eq 1 then begin
   PVI_v=reform(Flat_theta(0,*));;;;;;;;;选全角度all还是不选
   i_x_SubImg  = 0
   i_y_SubImg  = 1
   title = 'Flatness'+' at 0-30 degree'
endif
if i_theta eq 1 and i_liang eq 1 then begin
   PVI_v=reform(Flat_theta(1,*));;;;;;;;;选全角度all还是不选
   i_x_SubImg  = 0
   i_y_SubImg  = 0
   title = 'Flatness'+' at 60-90 degree'   
endif 
;if i_theta eq 2 and i_liang eq 1 then begin
;   PVI_v=reform(Flat);;;;;;;;;选全角度all还是不选
;   i_x_SubImg  = 0
;   i_y_SubImg  = 2
;   title = 'Flatness'+' at all degree'
;endif


   
if i_liang eq 0 then begin   
    
n_cell = 100.    
diff_Bz_period = fltarr(num_times,num_periods)+!values.f_nan
diff_Bz_PDF = fltarr(n_cell,num_periods)+!values.f_nan
diff_Bz_flat = fltarr(n_cell,num_periods)+!values.f_nan
  min_vect = (findgen(n_cell)/n_cell-0.5)*60
  max_vect = ((findgen(n_cell)+1)/n_cell-0.5)*60;;[-30,30]
for i_period = 0,num_periods-1 do begin
  diff_Bz_period(*,i_period) = PVI_v(*,i_period)
  n_finite = n_elements(where(finite(diff_Bz_period(*,i_period))))
  for i_cell = 0,n_cell-1 do begin
    sub_cell = where(diff_Bz_period(*,i_period) ge min_vect(i_cell) and diff_Bz_period(*,i_period) lt max_vect(i_cell))
    if sub_cell(0) ne (-1) then begin
  diff_Bz_PDF(i_cell,i_period) = n_elements(sub_cell)/float(n_finite)
  diff_Bz_flat(i_cell,i_period) = mean(diff_Bz_period(sub_cell,i_period)^4,/nan)*n_elements(sub_cell)/float(n_finite)
    endif
  endfor
endfor





JulDay_vect_TV = min_vect
period_vect_TV = period_vect


;;--

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
image_TV  = alog10(diff_Bz_PDF)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan;9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = -6.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = -0.5;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
if i_theta eq 0 then begin
xtitle = ''
endif
if i_theta eq 1 then begin  
xtitle  = textoIDL('\delta')+'Bz/'+textoidl('\sigma')
endif
ytitle  = '';'period(s)'
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
  XTitle=xtitle,YTitle=ytitle,title=title, $
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/ylog
;;;---

xaxis_vect_cont = JulDay_vect_TV;xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
yaxis_vect_cont = period_vect_TV;yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
levels  = [-6,-5,-4,-3,-2,-1,0]
C_annotation = ['-6','-5','-4','-3','-2','-1','0']
C_colors= [color_black,color_black,color_black,color_black,color_black,color_black,color_black]
C_LineStyle = [0,0,0,0,0,0,0]
C_labels = [0,0,0,0,0,0,0]
C_Thick   = [3,3,3,3,3,3,3]
;Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
;    /NoErase, /Fill, /Closed
Contour, image_TV, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, C_annotation = C_annotation, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,C_labels=C_labels,charthick = 2.0, $
    /NoErase , ylog=1
;;;;



position_CB   = [position_SubImg(2)+0.05,position_SubImg(1),$
          position_SubImg(2)+0.06,position_SubImg(3)]
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

;;--

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg2+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg2+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;---
image_TV  = alog10(diff_Bz_flat)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = !values.f_nan;9999.0
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
if i_theta eq 0 then begin
xtitle = ''
endif
if i_theta eq 1 then begin  
xtitle  = textoIDL('\delta')+'Bz/'+textoidl('\sigma')
endif
ytitle  = '';'period(s)'
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
  XTitle=xtitle,YTitle=ytitle,title=title, $
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/ylog
;;;---

;xaxis_vect_cont = JulDay_vect_TV;xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
;yaxis_vect_cont = period_vect_TV;yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
;levels  = [-6,-5,-4,-3,-2,-1,0]
;C_annotation = ['-6','-5','-4','-3','-2','-1','0']
;C_colors= [color_black,color_black,color_black,color_black,color_black,color_black,color_black]
;C_LineStyle = [0,0,0,0,0,0,0]
;C_labels = [0,0,0,0,0,0,0]
;C_Thick   = [3,3,3,3,3,3,3]
;;Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
;;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
;;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
;;    /NoErase, /Fill, /Closed
;Contour, image_TV, xaxis_vect_cont, yaxis_vect_cont, $
;    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, C_annotation = C_annotation, $
;    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,C_labels=C_labels,charthick = 2.0, $
;    /NoErase , ylog=1
;;;;



position_CB   = [position_SubImg(2)+0.05,position_SubImg(1),$
          position_SubImg(2)+0.06,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('log(flatness)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3


endif


if i_liang eq 1 then begin


position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

if i_theta eq 0 then begin
xtitle = ''
endif
if i_theta eq 1 then begin  
xtitle  = 'flatness'
endif
ytitle  = 'period(s)'

x_plot = PVI_v

xrange = [1,100]
yrange  = [Min(period_vect), Max(period_vect)]
  
Plot,x_plot,period_vect, xrange=xrange,YRange=yrange,$
  Position=position_SubImg,YStyle=1,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title, $
  Color=color_black,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,/xlog,/ylog
  
endif



 
endfor
endfor;i_theta
  
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_PDF_dB_over_sigma_and_flatness_theta_'+str_remove+'_wai1.png';;;;;;;;;;;;;;;选全角度all还是不选
Write_PNG, dir_fig+file_fig, image_tvrd    

step3:

;diff_Bz_PDF
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 600.0
ysize = 600.0
Window,1,XSize=xsize,YSize=ysize

color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;;--

   i_x_SubImg  = 0
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

yrange = [0.000001,0.4]


plot,JulDay_vect_TV,diff_Bz_PDF(*,0),yrange=yrange,color=color_black,/ylog
oplot,JulDay_vect_TV,diff_Bz_PDF(*,5),color=color_blue
oplot,JulDay_vect_TV,diff_Bz_PDF(*,11),color=color_red
xyouts,10,0.38,'the minimum scale',color=color_black
xyouts,10,0.3,'the middle scale',color=color_blue
xyouts,10,0.23,'the maximum scale',color=color_red
;xyouts,7,0.25,textoidl('\alpha')+'='+string(alpha),color=color_black

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'random_min_mid_max_scale_deltaB'+'_wai1.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd



end_program:
end





