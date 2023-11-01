;pro figure3_fit_sp_freq_and_sp_p







sub_dir_date1  = 'wind\slow\case2\'

;goto,step2
Step1:


;n_d = 15L
n_jie = 10L;;;
jie = (findgen(n_jie)+1)/2.0
num_theta_bins_plot = 9L
slope_fast = fltarr(n_jie,num_theta_bins_plot)
sigmaslope_fast = fltarr(n_jie,num_theta_bins_plot)
slope_slow = fltarr(n_jie,num_theta_bins_plot)
sigmaslope_slow = fltarr(n_jie,num_theta_bins_plot)

for i_stream = 0,1 do begin
  if i_stream eq 0 then begin
  sub_dir_date  = 'wind\fast\case2\'
  endif
  if i_stream eq 1 then begin
  sub_dir_date  = 'wind\slow\case2\'
  endif
  
;for i_d = 0,n_d-1 do begin
  
  
;===========================
;Step1:


for i_jie = 0,n_jie-1 do begin

jieshu = jie(i_jie)
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct_'+'1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_guan_'+'Bperp_Bpara_theta_period_arr'+$
       '(time=*-*)'+$
       '(period=*-*)'+ $
        'V2.sav';strcompress(string(i_d+1),/remove_all)
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



;Step2:
;===========================
;Step2:

;;--
freq_vect_plot  = Reverse(1./period_vect)
PSD_BComp_arr_plot  = Reverse(StructFunct_Bt_theta_scale_arr,2)
LgPSD_BComp_arr_plot= ALog10(PSD_BComp_arr_plot)

;;--
num_theta_bins  = N_Elements(theta_bin_min_vect)
theta_bin_cen_vect_plot = findgen(num_theta_bins_plot)*10.0+5.0;;10度一点

freq_min_plot = Min(freq_vect_plot)
freq_max_plot = Max(freq_vect_plot)

freq_low = freq_min_plot;0.01
freq_high = freq_max_plot;1.0/7.0
sub_freq_in_seg = Where(freq_vect_plot ge freq_low and freq_vect_plot le freq_high)
slope_vect_plot = Fltarr(num_theta_bins_plot)
SigmaSlope_vect_plot  = Fltarr(num_theta_bins_plot)
num_points_LinFit   = N_Elements(sub_freq_in_seg)
For i_theta=0,num_theta_bins_plot-1 Do Begin
  LgPSD_vect_tmp  = Reform(LgPSD_BComp_arr_plot(i_theta,*))
;  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_theta)
  fit_para    = LinFit(ALog10(freq_vect_plot(sub_freq_in_seg)),LgPSD_vect_tmp(sub_freq_in_seg),$
              sigma=sigma_FitPara)
  slope_vect_plot(i_theta)    = fit_para(1)
  SigmaSlope_vect_plot(i_theta) = sigma_FitPara(1)
;  LgPSD_at_LowFreq  = fit_para(0)+fit_para(1)*ALog10(freq_low)
;  LgPSD_at_HighFreq = fit_para(0)+fit_para(1)*ALog10(freq_high)
;  Plots, [freq_low,freq_high],10.^[LgPSD_at_LowFreq,LgPSD_at_HighFreq], Color=color_red,LineStyle=2,Thick=1.5
EndFor



;Step3:
;===========================
;Step3:
if i_stream eq 0 then begin
slope_fast(i_jie,*) = -slope_vect_plot
sigmaslope_fast(i_jie,*) = SigmaSlope_vect_plot
endif
if i_stream eq 1 then begin
slope_slow(i_jie,*) = -slope_vect_plot
sigmaslope_slow(i_jie,*) = SigmaSlope_vect_plot
endif



endfor
endfor
;endfor


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1

file_save = 'slope_of_s(p)_vs_tao_theta_guanxing_V2'+'.sav';;;;;

data_descrip= 'got from "plot_sp_freq.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  theta_bin_cen_vect_plot, slope_fast, sigmaslope_fast, slope_slow, sigmaslope_slow


step2:

n_jie = 10
;n_d = 15



;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= 'slope_of_s(p)_vs_tao_theta'+'_guanxing_V2.sav';;;;;;;;
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
;  theta_bin_cen_vect_plot, slope_fast, sigmaslope_fast, slope_slow, sigmaslope_slow



 n_theta = (Size(theta_bin_cen_vect_plot))[1]
 re_A_fast = fltarr(2,n_theta) 
 re_sigma_fast = fltarr(2,n_theta)
 re_A_slow = fltarr(2,n_theta) 
 re_sigma_slow = fltarr(2,n_theta)
 X = (findgen(n_jie)+1)/2.0
 ;plot,[0],[0],xrange=[0,10],yrange=[0.0,5.0]


;for i_d = 0,n_d-1 do begin 
;用2阶归一化
;for i_the =0,n_theta-1 do begin
;  slope_fast(*,i_the) = slope_fast(*,i_the);/slope_fast(3,i_the)
;  slope_slow(*,i_the) = slope_slow(*,i_the);/slope_slow(3,i_the)
;endfor
;;;
 for i_theta = 0,n_theta-1 do begin

  
   weights = reform(1.0/slope_fast(*,i_theta),n_jie)
   
A = [1.8,0.8];;;;;;;;;;
tep_s = reform(slope_fast(*,i_theta),n_jie)
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


plot,X,slope_fast(*,i_theta),xrange=[0,10],yrange=[0.0,5.0],color=color_black,/noerase
yfit = CURVEFIT(X, tep_s, weights, A, SIGMA, FUNCTION_NAME='extpmodel');惯性区extpmodel;耗散区dispmodel
  print,'Function parameters: ',A
  
 ; endfor
  
bx1 = Alog10(A(1)^(1*X/3)+(1-A(1))^(1*X/3))/alog10(2) ;惯性区X；耗散区2X
F1 = (-2.5+1.5*A(0))*(1*X/3)+1-bx1;;guan-2.5,hao-3.5
plot,X,F1,color=color_blue,xstyle=4,ystyle=4,xrange=[0,10],yrange=[0.0,5.0],linestyle=2,/noerase
xyouts,1,4.5,'theta = '+string(10*i_theta+5),color=color_black;;;;
;wait,0.5

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_version= '(v1)'
file_fig  = 'theta'+'_'+'1-5'+'_'+strcompress(string(2*(i_theta+1)),/remove_all)+'_fit_sp_p_fast'+  $
       '_guanxing_V2.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd


re_A_fast(0,i_theta) = A(0)
re_A_fast(1,i_theta) = A(1) 
re_sigma_fast(0,i_theta) = SIGMA(0)
re_sigma_fast(1,i_theta) = Sigma(1)


endfor
;endfor


;for i_d = 0,n_d-1 do begin 
 for i_theta = 0,n_theta-1 do begin

  
   weights = reform(1.0/slope_slow(*,i_theta),n_jie)
   
A = [1.8,0.8];;;;
tep_s = reform(slope_slow(*,i_theta),n_jie)
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


plot,X,slope_slow(*,i_theta),xrange=[0,10],yrange=[0.0,5.0],color=color_black,/noerase
yfit = CURVEFIT(X, tep_s, weights, A, SIGMA, FUNCTION_NAME='extpmodel');惯性区extpmodel;耗散区dispmodel
  print,'Function parameters: ',A
  
 ; endfor
  
bx1 = Alog10(A(1)^(1*X/3)+(1-A(1))^(1*X/3))/alog10(2) ;惯性区X；耗散区2X
F1 = (-2.5+1.5*A(0))*(1*X/3)+1-bx1;;;;;;;
plot,X,F1,color=color_blue,xstyle=4,ystyle=4,xrange=[0,10],yrange=[0.0,5.0],linestyle=2,/noerase
xyouts,1,4.5,'theta = '+string(10*i_theta+5),color=color_black
;wait,0.5

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_version= '(v1)'
file_fig  = 'theta'+'_'+'1-5'+'_'+strcompress(string(2*(i_theta+1)),/remove_all)+'_fit_sp_p_slow'+  $
       '_guanxing_V2.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd


re_A_slow(0,i_theta) = A(0)
re_A_slow(1,i_theta) = A(1) 
re_sigma_slow(0,i_theta) = SIGMA(0)
re_sigma_slow(1,i_theta) = Sigma(1)

endfor
;endfor


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_save = 'extpmodel_theta_alpha_P1'+'_V2.sav';;;;;;
data_descrip= 'got from "fit_sp_p.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  re_A_fast ,re_sigma_fast, re_A_slow ,re_sigma_slow
  







End_Program:
End

















