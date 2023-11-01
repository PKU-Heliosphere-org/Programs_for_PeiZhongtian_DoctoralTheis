;pro calculate_pvi
;

sub_dir_date  = 'new\19950720-29pvi\'


Step1:
;===========================
;Step1:
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect


step2:

n_jie = 10
jie = findgen(n_jie)+1

for i_jie = 0,n_jie-1 do begin
  
  jieshu = jie(i_jie)
  
i_BComp = 0
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
for i_BComp = 1,3 do begin
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= FileName_BComp+'_StructFunct'+string(jieshu)+'_arr(time=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_from_BComp_vect_Helios_19760307.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min, time_vect, period_vect, $
; BComp_StructFunct_arr, $
; Diff_BComp_arr
;;;---
  


reso = 2.0
num_period = N_elements(period_vect)
num = n_elements(Bxyz_GSE_2s_arr(0,*))
I = fltarr(num,num_period)+!values.F_nan

for i_period = 0,num_period-1 do begin
 
 
n_lag = round(period_vect(i_period)/reso)

I_up = I
I_dn = I
I_up(0:num-n_lag-1,i_period) = sqrt((Bxyz_GSE_2s_arr(0,n_lag:num-1)-Bxyz_GSE_2s_arr(0,0:num-n_lag-1))^2.+ $
  (Bxyz_GSE_2s_arr(1,n_lag:num-1)-Bxyz_GSE_2s_arr(1,0:num-n_lag-1))^2.+ $
  (Bxyz_GSE_2s_arr(2,n_lag:num-1)-Bxyz_GSE_2s_arr(2,0:num-n_lag-1))^2.)
I_dn(0:num-n_lag-1,i_period) = sqrt(mean(I_up(n_lag/2:num-n_lag/2-1,i_period)^2.,/nan))
I = I_up/I_dn

yuzhi = 2.0

BComp_StructFunct_arr(where(I(*,i_period) gt yuzhi),i_period) = !values.F_nan
Diff_BComp_arr(where(I(*,i_period) gt yuzhi),i_period) = !values.F_nan

endfor

dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = FileName_BComp+'_pvi2_StructFunct'+string(jieshu)+'_arr(time=0-0)7-100s.sav'
data_descrip= 'got from "calculate_pvi.pro"'
Save, FileName=dir_save+file_save, $
 data_descrip, $
 JulDay_min, time_vect, period_vect, $
 BComp_StructFunct_arr, $
 Diff_BComp_arr

endfor
;JulDay_vect = JulDay_2s_vect
;
;Step3:
;;===========================
;;Step5: plot the wavelet 2D figures for magnetic field trace & para & perp
;;;--
;;;--
;Set_Plot, 'Win'
;Device,DeComposed=0
;xsize = 750.0
;ysize = 1300.0
;Window,1,XSize=xsize,YSize=ysize
;
;;;--
;LoadCT,13
;TVLCT,R,G,B,/Get
;color_red = 255L
;TVLCT,255L,0L,0L,color_red
;color_green = 254L
;TVLCT,0L,255L,0L,color_green
;color_blue  = 253L
;TVLCT,0L,0L,255L,color_blue
;color_white = 252L
;TVLCT,255L,255L,255L,color_white
;color_black = 251L
;TVLCT,0L,0L,0L,color_black
;num_CB_color= 256-5
;R=Congrid(R,num_CB_color)
;G=Congrid(G,num_CB_color)
;B=Congrid(B,num_CB_color)
;TVLCT,R,G,B
;
;;;--
;color_bg    = color_white
;!p.background = color_bg
;Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
;position_img  = [0.10,0.15,0.90,0.98]
;num_x_SubImgs = 1
;num_y_SubImgs = 3
;dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
;dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;
;
;Step3_1:
;;;--
;i_x_SubImg  = 0
;i_y_SubImg  = 2
;position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
;           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
;           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
;;;;---
;image_TV  = ALog10(PSD_Bt_time_scale_arr)
;sub_BadVal  = Where(Finite(image_TV) eq 0)
;If sub_BadVal(0) ne -1 Then Begin
;  num_BadVal  = N_Elements(sub_BadVal)
;  image_TV(sub_BadVal)  = 9999.0
;EndIf Else Begin
;  num_BadVal  = 0
;EndElse
;image_TV_v2 = image_TV(Sort(image_TV))
;min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
;max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
;byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
;color_BadVal= color_white
;If num_BadVal ge 1 Then Begin
;  byt_image_TV(sub_BadVal)  = color_BadVal
;EndIf
;;;;---
;xtitle  = 'time'
;ytitle  = 'period (s)'
;title = 'B Wavelet Power Spectra Density'
;;;;---TV image
;TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;;---
;xrange  = [Min(JulDay_vect), Max(JulDay_vect)]
;yrange  = [Min(period_vect), Max(period_vect)]
;xrange_time = xrange
;get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;xminor    = 6
;if max(JulDay_vect)-min(JulDay_vect) ge 2.5 then begin
;xtitle_char = 'Date'
;dummy = LABEL_DATE(DATE_FORMAT=['%M-%D'])
;Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
;  Position=position_SubImg,$
;  XTICKFORMAT='LABEL_DATE', xtickunits = 'Time', $
;  XTitle=xtitle,YTitle=ytitle,title=title,$
;  /NoData,Color=0L,$
;  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,charsize=charsize,/YLog
;endif else begin
;xtitle_char = 'Time'+' '+sub_dir_date
;Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
;  Position=position_SubImg,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
;  XTitle=xtitle,YTitle=ytitle,title=title,$
;  /NoData,Color=0L,$
;  /NoErase,Font=-1,CharThick=1.0,Thick=1.0,charsize=charsize,/YLog
;endelse
;;;;---
;position_CB   = [position_SubImg(2)+0.1,position_SubImg(1),$
;          position_SubImg(2)+0.12,position_SubImg(3)]
;num_ticks   = 3
;num_divisions = num_ticks-1
;max_tickn   = max_image
;min_tickn   = min_image
;interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
;tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.1)');the tick-names of colorbar 15
;titleCB     = 'lg(PSD of '+'B'+'t) ((km/s)!U2!N/Hz)'
;bottom_color  = 0B
;img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
;TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;;----draw the outline of the color-bar
;Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
;  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=1.2, Font=-1,$
;  /NoData,/NoErase,Color=color_black,$
;  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3
;
;image_tvrd  = TVRD(true=1)
;file_fig  = 'B_'+'Trac_time_scale_arr'+'.png'
;Write_PNG, dir_save+file_fig, image_tvrd



endfor



end











