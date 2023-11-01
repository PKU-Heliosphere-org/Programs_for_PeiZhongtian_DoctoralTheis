;pro draw_fengdu_of_Btotal


step1:

date = '19950720-29'

sub_dir_date  = 'new\'+date+'-1\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;;--
Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'Btotal_kurtosis_v1.eps', $   ;
    XSize=16,YSize=20,/Color,Bits=10,/Encapsul
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
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs



step2:

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_'+date+'_v01_v.sav'
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
;  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
;  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect
Bxyz_GSE_2s_arr_o = B_RTN_1s_arr
JulDay_2s_vect = JulDay_1s_vect


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=*-*)(period=*-*).sav'
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
Bxyz_LBG_RTN_arr_o = Bxyz_LBG_RTN_arr
time_vect_LBG_o = time_vect
period_vect_LBG_o = period_vect


dir_restore  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'EffDataNum_theta_scale_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr
EffDataNum_scale_theta_arr_o = EffDataNum_scale_theta_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_'+date+'_v01_recon.sav'
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
;  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
;  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect
Bxyz_GSE_2s_arr_r = B_RTN_1s_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=*-*)(period=*-*)_recon.sav'
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
Bxyz_LBG_RTN_arr_r = Bxyz_LBG_RTN_arr
time_vect_LBG_r = time_vect
period_vect_LBG_r = period_vect


dir_restore  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'EffDataNum_theta_scale_arr(time=*-*)_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr
EffDataNum_scale_theta_arr_r = EffDataNum_scale_theta_arr
  
for i_s = 0,1 do begin
  if i_s eq 0 then begin
    Bxyz_GSE_2s_arr = Bxyz_GSE_2s_arr_o
    EffDataNum_scale_theta_arr = EffDataNum_scale_theta_arr_o
    Bxyz_LBG_RTN_arr = Bxyz_LBG_RTN_arr_o
    time_vect_LBG = time_vect_LBG_o
    period_vect_LBG = period_vect_LBG_o
    i_x_SubImg  = 0
    i_y_SubImg  = 1
    title = '(a) Flatness of '+textoidl('\delta')+'!5B!3'+' (original)'
  endif
  if i_s eq 1 then begin
    Bxyz_GSE_2s_arr = Bxyz_GSE_2s_arr_r
    EffDataNum_scale_theta_arr = EffDataNum_scale_theta_arr_r
    Bxyz_LBG_RTN_arr = Bxyz_LBG_RTN_arr_r
    time_vect_LBG = time_vect_LBG_r
    period_vect_LBG = period_vect_LBG_r        
    i_x_SubImg  = 0
    i_y_SubImg  = 0
    title = '(b) Flatness of '+textoidl('\delta')+'!5B!3'+' (LIM)'
  endif
 position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.07),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.85)] 

step3:

num_times = N_Elements(JulDay_2s_vect)
time_vect = (JulDay_2s_vect(0:num_times-1)-JulDay_2s_vect(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times

period_min  = 6.0
period_max  = 2.e3
period_range= [period_min, period_max]
num_periods = 32L
J_wavlet  = num_periods
dj_wavlet = ALog10(period_max/period_min)/ALog10(2)/(J_wavlet-1)
period_vect = period_min*2.^(Lindgen(J_wavlet)*dj_wavlet)

Diff_BComp_arr = fltarr(3,num_times,num_periods)

for i = 0,2 do begin
  if i eq 0 then begin
    Bcomp_vect = Bxyz_GSE_2s_arr(0,*)
  ;  Sstr = 'Vx'
  endif
  if i eq 1 then begin
    Bcomp_vect = Bxyz_GSE_2s_arr(1,*)
  ;  Sstr = 'Vy'
  endif    
  if i eq 2 then begin
    Bcomp_vect = Bxyz_GSE_2s_arr(2,*)
  ;  Sstr = 'Vz'
  endif

dt_pix    = time_vect(1)-time_vect(0)
PixLag_vect = period_vect/dt_pix;(Round(period_vect/dt_pix)/2)*2
period_vect_exact = PixLag_vect*dt_pix
For i_period=0,num_periods-1 Do Begin
  pix_shift = PixLag_vect(i_period)/2
  BComp_vect_backward = Shift(BComp_vect, +pix_shift)
  BComp_vect_forward  = Shift(BComp_vect, -pix_shift)
  If (pix_shift ge 1) Then Begin
    BComp_vect_backward(0:pix_shift-1)  = !values.f_nan
    BComp_vect_forward(num_times-pix_shift:num_times-1) = !values.f_nan
  EndIf
  Diff_BComp_vect = (BComp_vect_backward-BComp_vect_forward)
  Diff_BComp_arr(i,*,i_period)  = Diff_BComp_vect
EndFor

endfor

;;--
num_times = N_Elements(time_vect_LBG)
num_periods = N_Elements(period_vect_LBG)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


;;--define 'theta_bin_min/max_vect'
num_theta_bins  = 90L
num_theta_halfbins = num_theta_bins/2
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin
theta_vect_TV = theta_bin_min_vect
period_vect_TV = period_vect



is_aver = 1
;read,'whether use average kurtosis (1 for average):',is_aver

if is_aver eq 0 then begin
Btot_kur = fltarr(num_theta_halfbins,num_periods)
Bt_zi = fltarr(num_theta_halfbins,num_periods)
Bt_mu = fltarr(num_theta_halfbins,num_periods)
;Bx_sig = fltarr(num_theta_bins,num_periods)
;Bx_piandu = fltarr(num_theta_bins,num_periods)
;Bx_peak = fltarr(num_theta_bins,num_periods)
;;--get 'StructFunct_Bpara_theta_scale_arr'
;StructFunct_Bpara_theta_scale_arr = Fltarr(num_theta_bins, num_periods)


For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)); or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
         ; theta_arr(*,i_period) lt (180-theta_min_bin)))
  dbxyz_tmp = diff_Bcomp_arr(*,sub_tmp,i_period)
  Bt_zi(i_theta,i_period) = mean(dbxyz_tmp(0,*)^4+dbxyz_tmp(1,*)^4+dbxyz_tmp(2,*)^4,/nan)
  Bt_mu(i_theta,i_period) = mean(dbxyz_tmp(0,*)^2+dbxyz_tmp(1,*)^2+dbxyz_tmp(2,*)^2,/nan)^2
  Btot_kur(i_theta,i_period) = Bt_zi(i_theta,i_period)/Bt_mu(i_theta,i_period)
;  Bx_av4(i_theta,i_period) = mean((dbx_tmp-dBx_ave)^4.0,/nan)
;  Bx_sig(i_theta,i_period) = stddev(dbx_tmp,/nan)
;  Bx_piandu(i_theta,i_period) = Bx_av3(i_theta,i_period)/Bx_sig(i_theta,i_period)^3.0
;  Bx_peak(i_theta,i_period) = Bx_av4(i_theta,i_period)/Bx_sig(i_theta,i_period)^4.0
EndFor
EndFor
endif

if is_aver eq 1 then begin
  
Btot_kur = fltarr(num_theta_halfbins,num_periods)
Br_kur = fltarr(num_theta_halfbins,num_periods)
Bt_kur = fltarr(num_theta_halfbins,num_periods)
Bn_kur = fltarr(num_theta_halfbins,num_periods)
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where((theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)); or (theta_arr(*,i_period) ge (180-theta_max_bin) and $
         ; theta_arr(*,i_period) lt (180-theta_min_bin)))
  dbxyz_tmp = diff_Bcomp_arr(*,sub_tmp,i_period)
  Br_kur(i_theta,i_period) = mean(dbxyz_tmp(0,*)^4,/nan)/(mean(dbxyz_tmp(0,*)^2,/nan))^2
  Bt_kur(i_theta,i_period) = mean(dbxyz_tmp(1,*)^4,/nan)/(mean(dbxyz_tmp(1,*)^2,/nan))^2
  Bn_kur(i_theta,i_period) = mean(dbxyz_tmp(2,*)^4,/nan)/(mean(dbxyz_tmp(2,*)^2,/nan))^2  

  Btot_kur(i_theta,i_period) = (Br_kur(i_theta,i_period)+Bt_kur(i_theta,i_period)+Bn_kur(i_theta,i_period))/3.
;  Bx_av4(i_theta,i_period) = mean((dbx_tmp-dBx_ave)^4.0,/nan)
;  Bx_sig(i_theta,i_period) = stddev(dbx_tmp,/nan)
;  Bx_piandu(i_theta,i_period) = Bx_av3(i_theta,i_period)/Bx_sig(i_theta,i_period)^3.0
;  Bx_peak(i_theta,i_period) = Bx_av4(i_theta,i_period)/Bx_sig(i_theta,i_period)^4.0
EndFor
EndFor
endif



step4:

theta_vect_TV = theta_vect_TV(0:44)

;;;---
image_TV  = Btot_kur
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = 0.0;image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = 24.0;image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = TexToIDL('\theta')
ytitle  = 'period (s)'
;title = TexToIDL(' ')
;;;---TV image
size_image = size(byt_image_TV)
byt_image_TV = rebin(byt_image_TV,5*size_image(1),5*size_image(2),/sample)
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
yrange  = [Min(period_vect_TV), Max(period_vect_TV)]
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,xticklen=-0.04,yticklen=-0.04,$
;a  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L, charsize=1.25, $
  /NoErase,Font=-1,CharThick=4,Thick=4,xthick=4,ythick=4,/YLog
xyouts,20,2500,title,charsize=1.25,charthick=4
  
;;;---
; ;;;----
;
for  i_period=0,num_periods-1 Do Begin
sub_data_bad = where(EffDataNum_scale_theta_arr(*,i_period) lt 0)
EffDataNum_scale_theta_arr(sub_data_bad,i_period) = 0
endfor
 

CI_BComp_theta_scale_arr  = Fltarr(num_theta_halfbins, num_periods)+!values.f_nan
For i_period=0,num_periods-1 Do Begin
For i_theta=0,num_theta_halfbins-1 Do Begin
num_Numerator_tmp   = EffDataNum_scale_theta_arr(i_theta,i_period)+EffDataNum_scale_theta_arr(89-i_theta,i_period)
if num_Numerator_tmp LT 10000.0 then begin   ;;2500
CI_BComp_theta_scale_arr(i_theta,i_period) = 1
endif else begin
CI_BComp_theta_scale_arr(i_theta,i_period) = 0
endelse
endfor
endfor
;;;;---
;color_white = 252L
;xrange  = [Min(theta_vect_TV), Max(theta_vect_TV)]
;yrange  = [Min(period_vect_TV), Max(period_vect_TV)]

CI_BComp_theta_scale_arr_TV= CI_BComp_theta_scale_arr(*,*)
num_xpixels_cont= (Size(CI_BComp_theta_scale_arr_TV))[1]*1
num_ypixels_cont= (Size(CI_BComp_theta_scale_arr_TV))[2]*5
image_cont    = Congrid(CI_BComp_theta_scale_arr_TV, num_xpixels_cont, num_ypixels_cont, Interp=0, /Minus_One)
sub_BadVal    = Where(Finite(image_cont) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  image_cont(sub_BadVal)  = -9999.0
EndIf
xaxis_vect_cont = xrange(0)+(xrange(1)-xrange(0))/(num_xpixels_cont)*(Findgen(num_xpixels_cont)+0.5)
yaxis_vect_cont = yrange(0)+(yrange(1)-yrange(0))/(num_ypixels_cont)*(Findgen(num_ypixels_cont)+0.5)
levels  = [0.3]
C_colors= [color_white]
C_LineStyle = [0]
C_Thick   = [3.5]
C_Orientation = [45.0]
position_con = [position_SubImg(0),position_SubImg(1),$
          position_SubImg(2),position_SubImg(3)]
Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange,  xstyle=1+4,ystyle=1+4,Position=position_con, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick, C_Orientation=C_Orientation,$
    /NoErase, /Fill, /Closed
Contour, image_cont, xaxis_vect_cont, yaxis_vect_cont, $
    XRange=xrange, YRange=yrange, XStyle=1+4, YStyle=1+4, Position=position_SubImg, $
    Levels=levels, C_Colors=C_colors, C_LineStyle=C_LineStyle, C_Thick=C_Thick,$
    /NoErase  


position_CB   = [position_SubImg(2)+0.12,position_SubImg(1),$
          position_SubImg(2)+0.135,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
;titleCB     = 'Btotal kurtosis'
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.25, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ', Thick=4, XThick=4, YThick=4,CharThick=4

endfor


device,/close


end





