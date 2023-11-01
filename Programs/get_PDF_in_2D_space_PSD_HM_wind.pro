;Pro get_PDF_in_2D_space_PSD_Hm_WIND
; period_min/max_for_Hm != period_min/max_for_PVI

sub_dir_date  = '2002/2002-06/';'2005-03/';'1995-12-25/'
sub_dir_date  = '1995-01--1995-02/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=/Work/Data Analysis/MFI data process/Data/';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=/Work/Data Analysis/MFI data process/Figures/';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'LocalBG_of_MagField(time=*-*)(period=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min_v2, time_vect_v2, period_vect, $
;  Bxyz_LBG_GSE_arr


;;;--
;dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
;file_restore= 'PVI_NoNorm(time=*-*)(period=*-*)*.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "get_PVI_of_BComp_time_scale_arr_STEREO.pro"'
;;Save, FileName=dir_save+file_save, $
;;  data_descrip, $
;;  JulDay_min, time_vect, period_vect, $
;;  PVI_NoNorm_arr
;

;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'PSD_Bt_time_scale_arr(time=*-*)(period=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose            
;data_descrip  = 'got from "get_PSD_wavlet_time_scale_arr_WIND_MFI_199502.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_vect, period_vect, time_vect, $
;  PSD_Bt_time_scale_arr  


;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'ImSyz(time=*-*)(period=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose  
;data_descrip= 'got from "get_ImSyz_for_MagHelicity_time_scale_arr_STEREO.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  ImSyz_time_scale_arr, $
;  Hm_yz_time_scale_arr, NormHm_yz_time_scale_arr   


Step2:
;===========================
;Step2:

;;--
num_times   = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_GSE_arr  = Reform(Bxyz_LBG_GSE_arr(0,*,*))
Bt_LBG_GSE_arr  = Reform(Sqrt(Bxyz_LBG_GSE_arr(0,*,*)^2+Bxyz_LBG_GSE_arr(1,*,*)^2+Bxyz_LBG_GSE_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_GSE_arr/Bt_LBG_GSE_arr)*180/!pi

;;--
period_min_for_Hm = 1.0
period_max_for_Hm = 10.0
sub_tmp = Where(period_vect ge period_min_for_Hm and period_vect le period_max_for_Hm)
sub_min_period_Hm = Min(sub_tmp)
sub_max_period_Hm = Max(sub_tmp)
num_periods_Hm  = sub_max_period_Hm-sub_min_period_Hm+1
;;;---
period_vect_Hm  = period_vect(sub_min_period_Hm:sub_max_period_Hm)
theta_arr_Hm    = theta_arr(*,sub_min_period_Hm:sub_max_period_Hm)

;;;---
period_min_for_PSD  = period_min_for_Hm
period_max_for_PSD  = period_max_for_Hm
sub_tmp = Where(period_vect ge period_min_for_PSD and period_vect le period_max_for_PSD)
sub_min_period_PSD = Min(sub_tmp)
sub_max_period_PSD = Max(sub_tmp)
num_periods_PSD = sub_max_period_PSD-sub_min_period_PSD+1
;;;---
period_vect_PSD = period_vect(sub_min_period_PSD:sub_max_period_PSD)
theta_arr_PSD   = theta_arr(*,sub_min_period_PSD:sub_max_period_PSD)

;;;---
PSD_NoNorm_arr_v2 = PSD_Bt_time_scale_arr(*,sub_min_period_PSD:sub_max_period_PSD)
;;;---
PSD_aver_vect   = Total(PSD_NoNorm_arr_v2, 1, /NaN)/num_times
PSD_aver_arr    = (Fltarr(num_times)+1.0) # PSD_aver_vect
PSD_Norm_arr_v2 = PSD_NoNorm_arr_v2 / PSD_aver_arr
;a PSD_Norm_arr_v2 = Sqrt(PSD_NoNorm_arr_v2) / Sqrt(PSD_aver_arr)    ;|dB|/<dB^2>
PSD_Norm_vect = Total(PSD_Norm_arr_v2, 2, /NaN) / num_periods_PSD 

;;;---
ImSyz_arr_v2    = ImSyz_time_scale_arr(*,sub_min_period_Hm:sub_max_period_Hm)
AbsImSyz_aver_vect  = Total(Abs(ImSyz_arr_v2), 1, /NaN)/num_times
AbsImSyz_aver_arr   = (Fltarr(num_times)+1.0) # AbsImSyz_aver_vect
ImSyz_Norm_arr_v2   = ImSyz_arr_v2 / AbsImSyz_aver_arr
ImSyz_Norm_vect = Total(ImSyz_Norm_arr_v2, 2, /NaN) / num_periods_Hm
;;;---
NormHm_arr_v2   = NormHm_yz_time_scale_arr(*,sub_min_period_Hm:sub_max_period_Hm)
NormHm_vect = Total(NormHm_arr_v2, 2, /NaN) / num_periods_Hm

;;--
theta_vect  = Total(theta_arr_Hm, 2, /NaN) / num_periods_Hm


;;--
image_TV  = PSD_Norm_vect
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 1.e10
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
PSD_norm_min=min_image & PSD_norm_max=max_image
num_bins_PSD  = 50L
PSD_norm_BinCent_vect  = PSD_norm_min + Findgen(num_bins_PSD)*(PSD_norm_max-PSD_norm_min)/(num_bins_PSD-1)

;;--
image_TV  = ImSyz_Norm_vect
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 1.e10
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
ImSyz_norm_min=min_image & ImSyz_norm_max=max_image
num_bins_ImSyz  = 50L
ImSyz_norm_BinCent_vect  = ImSyz_norm_min + Findgen(num_bins_ImSyz)*(ImSyz_norm_max-ImSyz_norm_min)/(num_bins_ImSyz-1)

;;--
image_TV  = NormHm_vect
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 1.e10
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
Hm_norm_min=min_image & Hm_norm_max=max_image
num_bins_Hm  = 50L
Hm_norm_BinCent_vect  = Hm_norm_min + Findgen(num_bins_Hm)*(Hm_norm_max-Hm_norm_min)/(num_bins_Hm-1)


;Goto,Step4
Step3:
;===========================
;Step3:

;;--
theta_min_2D_PDF  = 0.0
theta_max_2D_PDF  = 30.0
sub_tmp = Where(theta_vect ge theta_min_2D_PDF and theta_vect le theta_max_2D_PDF)
PSD_norm_vect_2D_PDF  = PSD_norm_vect(sub_tmp)
ImSyz_norm_vect_2D_PDF= ImSyz_norm_vect(sub_tmp)
Hm_norm_vect_2D_PDF   = NormHm_vect(sub_tmp)

;;--
PDF_in_PSD_ImSyz_arr  = Fltarr(num_bins_PSD, num_bins_ImSyz)
PDF_in_PSD_Hm_arr     = Fltarr(num_bins_PSD, num_bins_Hm)
PDF_in_ImSyz_Hm_arr   = Fltarr(num_bins_ImSyz, num_bins_Hm)

;;--
dPSD_bin    = PSD_norm_BinCent_vect(1) - PSD_norm_BinCent_vect(0)
dImSyz_bin  = ImSyz_norm_BinCent_vect(1) - ImSyz_norm_BinCent_vect(0)
dHm_bin     = Hm_norm_BinCent_vect(1) - Hm_norm_BinCent_vect(0)

;;--
For i_bin_PSD=0,num_bins_PSD-1 Do Begin
  print, 'i_bin_PSD: ', i_bin_PSD
For i_bin_ImSyz=0,num_bins_ImSyz-1 Do Begin
  PSD_min_bin = PSD_norm_BinCent_vect(i_bin_PSD) - 0.5*dPSD_bin
  PSD_max_bin = PSD_norm_BinCent_vect(i_bin_PSD) + 0.5*dPSD_bin
  ImSyz_min_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) - 0.5*dImSyz_bin
  ImSyz_max_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) + 0.5*dImSyz_bin
  sub_tmp = Where(PSD_norm_vect_2D_PDF ge PSD_min_bin and PSD_Norm_vect_2D_PDF le PSD_max_bin and $
                  ImSyz_norm_vect_2D_PDF ge ImSyz_min_bin and ImSyz_norm_vect_2D_PDF le ImSyz_max_bin)
  If (sub_tmp(0) ne -1) Then Begin
    PDF_tmp = N_Elements(sub_tmp)
    PDF_in_PSD_ImSyz_arr(i_bin_PSD,i_bin_ImSyz) = PDF_tmp
  EndIf
EndFor
EndFor  

;;--
For i_bin_PSD=0,num_bins_PSD-1 Do Begin
  print, 'i_bin_PSD: ', i_bin_PSD
For i_bin_Hm=0,num_bins_Hm-1 Do Begin
  PSD_min_bin = PSD_norm_BinCent_vect(i_bin_PSD) - 0.5*dPSD_bin
  PSD_max_bin = PSD_norm_BinCent_vect(i_bin_PSD) + 0.5*dPSD_bin
  Hm_min_bin = Hm_norm_BinCent_vect(i_bin_Hm) - 0.5*dHm_bin
  Hm_max_bin = Hm_norm_BinCent_vect(i_bin_Hm) + 0.5*dHm_bin
  sub_tmp = Where(PSD_norm_vect_2D_PDF ge PSD_min_bin and PSD_Norm_vect_2D_PDF le PSD_max_bin and $
                  Hm_norm_vect_2D_PDF ge Hm_min_bin and Hm_norm_vect_2D_PDF le Hm_max_bin)
  If (sub_tmp(0) ne -1) Then Begin
    PDF_tmp = N_Elements(sub_tmp)
    PDF_in_PSD_Hm_arr(i_bin_PSD,i_bin_Hm) = PDF_tmp
  EndIf
EndFor
EndFor  

;;--
For i_bin_ImSyz=0,num_bins_ImSyz-1 Do Begin
  print, 'i_bin_ImSyz: ', i_bin_ImSyz
For i_bin_Hm=0,num_bins_Hm-1 Do Begin
  ImSyz_min_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) - 0.5*dHm_bin
  ImSyz_max_bin = ImSyz_norm_BinCent_vect(i_bin_ImSyz) + 0.5*dHm_bin
  Hm_min_bin = Hm_norm_BinCent_vect(i_bin_Hm) - 0.5*dHm_bin
  Hm_max_bin = Hm_norm_BinCent_vect(i_bin_Hm) + 0.5*dHm_bin
  sub_tmp = Where(Hm_norm_vect_2D_PDF ge Hm_min_bin and Hm_Norm_vect_2D_PDF le Hm_max_bin and $
                  ImSyz_norm_vect_2D_PDF ge ImSyz_min_bin and ImSyz_norm_vect_2D_PDF le ImSyz_max_bin)
  If (sub_tmp(0) ne -1) Then Begin
    PDF_tmp = N_Elements(sub_tmp)
    PDF_in_ImSyz_Hm_arr(i_bin_ImSyz,i_bin_Hm) = PDF_tmp
  EndIf
EndFor
EndFor 


;;--
JulDay_vect = JulDay_min+time_vect/(24.*60*60)
JulDay_min  = Min(JulDay_vect)
JulDay_max  = Max(JulDay_vect)
CalDat, JulDay_min, mon_min,day_min,year_min,hour_min,min_min,sec_min
CalDat, JulDay_max, mon_max,day_max,year_max,hour_max,min_max,sec_max
TimeRange_str = '(time='+$
    String(year_min,Format='(I4.4)')+String(mon_min,Format='(I2.2)')+String(day_min,Format='(I2.2)')+'-'+$
    String(year_max,Format='(I4.4)')+String(mon_max,Format='(I2.2)')+String(day_max,Format='(I2.2)')+')'

;;--
PeriodRange_Hm_str  = '(period_Hm='+$
      String(period_min_for_Hm,format='(F6.1)')+'-'+$
      String(period_max_for_Hm,format='(F6.1)')+')'
;;--
PeriodRange_PSD_str  = '(period_PSD='+$
      String(period_min_for_PSD,format='(F6.1)')+'-'+$
      String(period_max_for_PSD,format='(F6.1)')+')'
      
;;--
ThetaRange_2D_PDF_str = '(theta='+$
      String(theta_min_2D_PDF,format='(F6.1)')+'-'+$
      String(theta_max_2D_PDF,format='(F6.1)')+')'
  
;;--
dir_save  = dir_restore
file_save = 'PDF_in_2D_space_PSD_Hm'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        ThetaRange_2D_PDF_str+$
        '.sav'
data_descrip  = 'got from "get_PDF_in_2D_space_PSD_Hm_WIND.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_min_for_Hm, period_max_for_Hm, $
  period_min_for_PSD, period_max_for_PSD, $
  theta_min_2D_PDF, theta_max_2D_PDF, $
  JulDay_vect, theta_vect, PSD_norm_vect, ImSyz_norm_vect, NormHm_vect, $
  PSD_norm_BinCent_vect, ImSyz_norm_BinCent_vect, Hm_norm_BinCent_vect, $
  PDF_in_PSD_ImSyz_arr, PDF_in_PSD_Hm_arr, PDF_in_ImSyz_Hm_arr


Step4:
;===========================
;Step4:

Goto, Step4_1
;;--
dir_restore = GetEnv('WIND_MFI_Data_Dir')+''+sub_dir_date
file_restore= 'PDF_in_2D_space_PSD_Hm(time=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose  
;data_descrip  = 'got from "get_PDF_in_2D_space_PSD_Hm_STEREO.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_min_for_2D_PDF, period_max_for_2D_PDF, $
;  theta_min_2D_PDF, theta_max_2D_PDF, $
;  PSD_norm_BinCent_vect, ImSyz_norm_BinCent_vect, Hm_norm_BinCent_vect, $
;  PDF_in_PSD_ImSyz_arr, PDF_in_PSD_Hm_arr, PDF_in_ImSyz_Hm_arr

Step4_1:
;;--
is_plot_normPDF = 1
Read, 'is_plot_NormPDF (to maximum in y-distribution) (0 or 1): ', is_plot_NormPDF
;;--
Set_Plot,'x'
Device,DeComposed=0;, /Retain
xsize=1200.0 & ysize=600.0
Window,3,XSize=xsize,YSize=ysize,Retain=2

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
position_img  = [0.05,0.10,0.95,0.95]

;;--
num_subimgs_x = 3
num_subimgs_y = 1
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
i_subimg_x  = 0
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_SubImg = win_position
;;;---
xaxis_vect  = PSD_norm_BinCent_vect
yaxis_vect  = ImSyz_norm_BinCent_vect
half_dxaxis = 0.5*(xaxis_vect(1)-xaxis_vect(0))
half_dyaxis = 0.5*(yaxis_vect(1)-yaxis_vect(0))
xrange    = [Min(xaxis_vect)-half_dxaxis, Max(xaxis_vect)+half_dxaxis]
yrange    = [Min(yaxis_vect)-half_dyaxis, Max(yaxis_vect)+half_dyaxis]
xtitle  = 'PSD_norm'
ytitle  = 'ImSyz_norm'
;;;---TV image
If is_plot_NormPDF eq 1 Then Begin
num_xpixels = N_Elements(xaxis_vect)
image_TV  = PDF_in_PSD_ImSyz_arr / ((Fltarr(num_xpixels)+1.0)##Max(PDF_in_PSD_ImSyz_arr,Dimension=2,/NaN))
image_TV  = 10^(Alog10(image_TV))
title     = 'norm_PDF'
EndIf Else Begin
image_TV  = ALog10(PDF_in_PSD_ImSyz_arr)
title     = 'lg(PDF)'
EndElse

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
If (sub_BadVal(0) ne -1) Then $
byt_image_TV(sub_BadVal)  = color_BadVal
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
Plot, xrange,yrange,Position=position_SubImg,$
    XStyle=1,YStyle=1,$
    XTitle=xtitle,YTitle=ytitle,Title=title,$
    /NoData,/NoErase,$
    XCharSize=1.0,YCharSize=1.0,CharSize=1.0,$
    TickLen=-0.02, Color=color_black,$
    XThick=1.0, YThick=1.0, Thick=1.0, CharThick=1.0
      
;;;---
position_CB   = [position_SubImg(0),position_SubImg(3)+0.05,$
      position_SubImg(2),position_SubImg(3)+0.07]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.2)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = ' '
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)##(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
Plot,[min_image,max_image],[1,2],Position=position_CB,XStyle=1,YStyle=1,$
  YTicks=1,YTickName=[' ',' '],XTicks=2,XTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3  


;;--
i_subimg_x  = 1
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_SubImg = win_position
;;;---
xaxis_vect  = PSD_norm_BinCent_vect
yaxis_vect  = Hm_norm_BinCent_vect
half_dxaxis = 0.5*(xaxis_vect(1)-xaxis_vect(0))
half_dyaxis = 0.5*(yaxis_vect(1)-yaxis_vect(0))
xrange    = [Min(xaxis_vect)-half_dxaxis, Max(xaxis_vect)+half_dxaxis]
yrange    = [Min(yaxis_vect)-half_dyaxis, Max(yaxis_vect)+half_dyaxis]
;a yrange  = [-1.0,+1.0]
xtitle  = 'PSD_norm'
ytitle  = 'Hm_norm'

;;;---TV image
If is_plot_NormPDF eq 1 Then Begin
num_xpixels = N_Elements(xaxis_vect)
image_TV  = PDF_in_PSD_Hm_arr / ((Fltarr(num_xpixels)+1.0)##Max(PDF_in_PSD_Hm_arr,Dimension=2,/NaN))
image_TV  = 10^(Alog10(image_TV))
title     = 'norm_PDF'
EndIf Else Begin
image_TV  = ALog10(PDF_in_PSD_Hm_arr)
title     = 'lg(PDF)'
EndElse

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
If (sub_BadVal(0) ne -1) Then $
byt_image_TV(sub_BadVal)  = color_BadVal
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
Plot, xrange,yrange,Position=position_SubImg,$
    XStyle=1,YStyle=1,$
    XTitle=xtitle,YTitle=ytitle,Title=title,$
    /NoData,/NoErase,$
    XCharSize=1.0,YCharSize=1.0,CharSize=1.0,$
    TickLen=-0.02, Color=color_black,$
    XThick=1.0, YThick=1.0, Thick=1.0, CharThick=1.0
      
;;;---
position_CB   = [position_SubImg(0),position_SubImg(3)+0.05,$
      position_SubImg(2),position_SubImg(3)+0.07]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.2)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = ' '
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)##(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
Plot,[min_image,max_image],[1,2],Position=position_CB,XStyle=1,YStyle=1,$
  YTicks=1,YTickName=[' ',' '],XTicks=2,XTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3  


;;--
i_subimg_x  = 2
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_SubImg = win_position
;;;---
xaxis_vect  = ImSyz_norm_BinCent_vect
yaxis_vect  = Hm_norm_BinCent_vect
half_dxaxis = 0.5*(xaxis_vect(1)-xaxis_vect(0))
half_dyaxis = 0.5*(yaxis_vect(1)-yaxis_vect(0))
xrange    = [Min(xaxis_vect)-half_dxaxis, Max(xaxis_vect)+half_dxaxis]
yrange    = [Min(yaxis_vect)-half_dyaxis, Max(yaxis_vect)+half_dyaxis]
;a yrange  = [-1.0,+1.0]
xtitle  = 'ImSyz_norm'
ytitle  = 'Hm_norm'
title   = 'lg(PDF)'
;;;---TV image
image_TV  = ALog10(PDF_in_ImSyz_Hm_arr)
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
If (sub_BadVal(0) ne -1) Then $
byt_image_TV(sub_BadVal)  = color_BadVal
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
Plot, xrange,yrange,Position=position_SubImg,$
    XStyle=1,YStyle=1,$
    XTitle=xtitle,YTitle=ytitle,Title=title,$
    /NoData,/NoErase,$
    XCharSize=1.0,YCharSize=1.0,CharSize=1.0,$
    TickLen=-0.02, Color=color_black,$
    XThick=1.0, YThick=1.0, Thick=1.0, CharThick=1.0
      
;;;---
position_CB   = [position_SubImg(0),position_SubImg(3)+0.05,$
      position_SubImg(2),position_SubImg(3)+0.07]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F4.2)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = ' '
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)##(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
Plot,[min_image,max_image],[1,2],Position=position_CB,XStyle=1,YStyle=1,$
  YTicks=1,YTickName=[' ',' '],XTicks=2,XTickName=tickn_CB,CharSize=1.0, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3  
      
;;--
AnnotStr_tmp  = 'got from "get_PDF_in_2D_space_PSD_Hm_WIND.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
AnnotStr_tmp  = 'theta_min/max: '+String(theta_min_2D_PDF,format='(F6.1)')+', '+String(theta_max_2D_PDF,format='(F6.1)')+';'
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
AnnotStr_tmp  = 'period_min/max_Hm: '+String(period_min_for_Hm,format='(F6.1)')+', '+String(period_max_for_Hm,format='(F6.1)')+';'
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
AnnotStr_tmp  = 'period_min/max_PSD: '+String(period_min_for_PSD,format='(F6.1)')+', '+String(period_max_for_PSD,format='(F6.1)')+';'
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
AnnotStr_tmp  = TimeRange_str
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
;WSet, 1
image_tvrd  = TVRD(true=1)
file_version= ''
If is_plot_NormPDF eq 0 Then Begin
file_fig  = 'PDF_in_2D_space_PSD_Hm'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        ThetaRange_2D_PDF_str+$        
        '.png'
EndIf Else Begin
file_fig  = 'NormPDF_in_2D_space_PSD_Hm'+$
        TimeRange_str+$
        PeriodRange_Hm_str+$
        PeriodRange_PSD_str+$
        ThetaRange_2D_PDF_str+$        
        '.png'
EndElse        
dir_fig = GetEnv('WIND_MFI_Figure_Dir')+''+sub_dir_date        
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b

;;--
;!p.background = color_bg



End_Program:
End
 