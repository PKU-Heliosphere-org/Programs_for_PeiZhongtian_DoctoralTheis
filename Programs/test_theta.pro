;pro test_theta


sub_dir_date  = 'new\19950721\'



step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'sf_sp_p_k_theta_21sell.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  sf,n_jie,num_periods,km,period_vect,n_theta
; 



step2:

for i_theta = 0,n_theta-1 do begin

ksi_p = fltarr(n_jie,km)
sigmaksip = fltarr(n_jie,km)

;for i_jie = 0,n_jie-1 do begin
;  for i_k = 0,km-1 do begin
;    result = linfit(Alog10(period_vect),alog10(sf(i_jie,*,i_k)))
;    ksi_p(i_jie,i_k) = result(1)
;  endfor
;endfor
;print,ksi_p



for i_jie = 0,n_jie-1 do begin
  
  Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 1300.0
Window,1,XSize=xsize,YSize=ysize

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
  
  freq_vect_plot = 1.0/period_vect
  position_img  = [0.10,0.15,0.90,0.95]
freq_min_plot = Min(freq_vect_plot)
freq_max_plot = Max(freq_vect_plot)
xrange  = [ALog10(freq_min_plot)-0.1*(ALog10(freq_max_plot)-ALog10(freq_min_plot)),$
      ALog10(freq_max_plot)+0.1*(ALog10(freq_max_plot)-ALog10(freq_min_plot))]
LgPSD_min_tmp = Min(sf(i_theta,i_jie,*,*),/NaN)
LgPSD_max_tmp = Max(sf(i_theta,i_jie,*,*),/NaN)
dlgPSD_offset_plot  = 0.01*(LgPSD_max_tmp-LgPSD_min_tmp)
LgPSD_max_tmp = LgPSD_max_tmp + dLgPSD_offset_plot*(km-1)
;yrange  = [LgPSD_min_tmp-0.1*(LgPSD_max_tmp-LgPSD_min_tmp),$
;      LgPSD_max_tmp+0.05*(LgPSD_max_tmp-LgPSD_min_tmp)]
yrange = [-10.0,10.0]
xtitle  = 'lg(freq) [Hz]'
ytitle  = 's(p)'
title = 's(p) at various k'
Plot, 10^xrange, 10^yrange, XRange=10^xrange,YRange=10^yrange,XStyle=1,YStyle=1, $
  XLog=1,YLog=1,XTitle=xtitle,YTitle=ytitle,Title=title, $
  /NoErase,/NoData,Position=position_img, Color=color_black

;;--
For i_k=0,km-1 Do Begin
  LgPSD_vect_tmp  = Reform(alog10(sf(i_theta,i_jie,*,i_k)))
  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_k)
  PlotSym, 0, 1.0, FILL=1,thick=1.5,Color=color_black
  Plots, freq_vect_plot, 10^LgPSD_vect_plot_tmp, PSym=8
  Plots, freq_vect_plot, 10^LgPSD_vect_plot_tmp, LineStyle=1, Thick=1.5, Color=color_black
EndFor

;;--
;Print, 'set freq_low in seg for fit: '
;Cursor, x_cursor, y_cursor, /Up, /Data
;freq_low  = x_cursor
;Print, 'set freq_high in seg for fit: '
;Cursor, x_cursor, y_cursor, /Up, /Data
;freq_high = x_cursor
freq_low = freq_min_plot
freq_high = freq_max_plot
sub_freq_in_seg = Where(freq_vect_plot ge freq_low and freq_vect_plot le freq_high)
slope_vect_plot = Fltarr(km)
SigmaSlope_vect_plot  = Fltarr(km)
num_points_LinFit   = N_Elements(sub_freq_in_seg)
For i_k=0,km-1 Do Begin
  LgPSD_vect_tmp  = Reform(alog10(sf(i_theta,i_jie,*,i_k)))
  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_k)
  fit_para    = LinFit(ALog10(freq_vect_plot(sub_freq_in_seg)),LgPSD_vect_plot_tmp(sub_freq_in_seg),$
              sigma=sigma_FitPara)
  ksi_p(i_jie,i_k)    = fit_para(1)
  sigmaksip(i_jie,i_k) = sigma_FitPara(1)
  LgPSD_at_LowFreq  = fit_para(0)+fit_para(1)*ALog10(freq_low)
  LgPSD_at_HighFreq = fit_para(0)+fit_para(1)*ALog10(freq_high)
  Plots, [freq_low,freq_high],10.^[LgPSD_at_LowFreq,LgPSD_at_HighFreq], Color=color_red,LineStyle=2,Thick=1.5
EndFor

;;--
;theta_bin_cen_vect_plot_str = String(theta_bin_cen_vect_plot, Format='(F4.1)')
;slope_vect_plot_str = String(slope_vect_plot, Format='(F4.2)')

;;--
AnnotStr_tmp  = 'got from "test.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;file_version= '(v1)'
;file_fig  = 'SF_of_'+'Bt'+string(i_jie)+'_at_VariousK'+'sell=200'+$
;        '.png'
;Write_PNG, dir_fig+file_fig, image_tvrd
;
;;;--
;!p.background = color_bg

endfor


step3:


;;--
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 750.0
ysize = 1300.0
Window,1,XSize=xsize,YSize=ysize

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
position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs


step3_1:

;;--
i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
;;;---
image_TV  = ksi_p
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
xtitle  = 'p'
ytitle  = 'K'
title = TexToIDL(' ')
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [1, n_jie]
yrange  = [1, km]    ;
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0
  
  
  
    ;;;----
;num_theta_bins  = 45L

;;;---
position_CB   = [position_SubImg(2)+0.09,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('s(p)')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3

;;--
AnnotStr_tmp  = 'got from "test.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position_plot = position_img
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_plot(0),position_plot(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor


pos_beg = StrPos(file_restore, '(time=')
TimeRange_str = StrMid(file_restore, pos_beg, 24)
;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'K_sp_p_theta_21sell'+'_theta='+string(i_theta)+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--
!p.background = color_bg

endfor

end
    