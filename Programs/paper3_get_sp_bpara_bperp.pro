;pro paper3_get_sp_Bpara_Bperp




sub_dir_date  = 'wind\fast\case3\'

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
dir_fig = dir_restore


num_theta_bins  = 60L;18L
dtheta_bin    = 180./num_theta_bins
num_theta_halfbins = num_theta_bins/2
theta_bin_min_vect  = Findgen(num_theta_halfbins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_halfbins)+2)*dtheta_bin


;n_d = 15L
n_jie = 10L;;;
jie = (findgen(n_jie)+1)/2.0

;goto,step2
step1:

;for i_stream = 0,1 do begin
;  if i_stream eq 0 then begin
;  sub_dir_date  = 'wind\fast\case1\'
;  endif
;  if i_stream eq 1 then begin
;  sub_dir_date  = 'wind\slow\case1\'
;  endif
  
;for i_d = 0,n_d-1 do begin
  
  
;===========================
;Step1:




;;--
;is_eps_png = 0
;read,'eps(1) or png(2)',is_eps_png
;if is_eps_png eq 1 then begin
;Set_Plot, 'PS';'Win'
;Device,filename=dir_restore+'StructFunct_of_Btot_theta_scale_arr.eps', $   ;
;    XSize=17,YSize=24,/Color,Bits=10,/Encapsul
;Device,DeComposed=0
;endif
;if is_eps_png eq 2 then begin
;set_Plot, 'win'
;Device,DeComposed=0;, /Retain
;xsize=850.0 & ysize=1200.0
;Window,0,XSize=xsize,YSize=ysize,Retain=2
;endif

;;--
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
;
;
;position_img  = [0.10,0.15,0.90,0.98]
;num_x_SubImgs = 2
;num_y_SubImgs = 4
;dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
;dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

;;
;dir_restore  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore = 'EffDataNum_theta_scale_arr(time=*-*).sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_200802.pro"'
;;Save, FileName=dir_save+file_save, $
;;  data_descrip, $
;;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr
;EffDataNum_scale_theta_arr_o = EffDataNum_scale_theta_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  '1-4'+'haosan'+'_SF.sav';strcompress(string(i_slow),/remove_all)
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
;  Bt_SF,Bt_SF_bg,Bt_o, dBx_new, dBy_new, dBz_new
    period_vect_o = period_vect
dBx_new_o = dBx_new
dBy_new_o = dBy_new
dBz_new_o = dBz_new
dBx_or_o =  Diff_Bx_arr
dBy_or_o =  Diff_By_arr
dBz_or_o =  Diff_Bz_arr
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_1-4_hao_(time=*-*)(period=  0.4- 0001).sav'
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

;--

diff_period   = period_vect_o(0)-period_vect_LBG_o(0)
diff_num_periods= N_Elements(period_vect_o)-N_Elements(period_vect_LBG_o)
If  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf

;dir_restore  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore = 'EffDataNum_theta_scale_arr(time=*-*)_recon.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "get_EffectiveDataNumber_theta_scale_arr_200802.pro"'
;;Save, FileName=dir_save+file_save, $
;;  data_descrip, $
;;  period_vect_LBG, theta_bin_min_vect, theta_bin_max_vect, $
;;  DataNum_scale_theta_arr, EffDataNum_scale_theta_arr
;EffDataNum_scale_theta_arr_r = EffDataNum_scale_theta_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  '1-4'+'guanxing'+'_SF.sav';strcompress(string(i_slow),/remove_all)
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
;  Bt_SF,Bt_SF_bg,Bt_o
    period_vect_r = period_vect
dBx_new_r = dBx_new
dBy_new_r = dBy_new
dBz_new_r = dBz_new
dBx_or_r =  Diff_Bx_arr
dBy_or_r =  Diff_By_arr
dBz_or_r =  Diff_Bz_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr_1-4_guan_(time=*-*)(period= 10.0- 0100).sav'
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

diff_period   = period_vect_r(0)-period_vect_LBG_r(0)
diff_num_periods= N_Elements(period_vect_r)-N_Elements(period_vect_LBG_r)
If  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf

;;;;;;;

for i_recon = 0,1 do begin
  if i_recon eq 0 then begin
    period_vect = period_vect_o
    dBx_new = dBx_new_o
    dBy_new = dBy_new_o    
    dBz_new = dBz_new_o    
    dBx_or = dBx_or_o
    dBy_or = dBy_or_o    
    dBz_or = dBz_or_o      
    Bxyz_LBG_RTN_arr = Bxyz_LBG_RTN_arr_o
    time_vect_LBG = time_vect_LBG_o
    period_vect_LBG = period_vect_LBG_o
;    EffDataNum_scale_theta_arr = EffDataNum_scale_theta_arr_o
    strre = 'hao'
  endif
  if i_recon eq 1 then begin
    period_vect = period_vect_r    
    dBx_new = dBx_new_r
    dBy_new = dBy_new_r    
    dBz_new = dBz_new_r  
    dBx_or = dBx_or_r
    dBy_or = dBy_or_r    
    dBz_or = dBz_or_r      
    Bxyz_LBG_RTN_arr = Bxyz_LBG_RTN_arr_r
    time_vect_LBG = time_vect_LBG_r
    period_vect_LBG = period_vect_LBG_r
 ;   EffDataNum_scale_theta_arr = EffDataNum_scale_theta_arr_r
    strre = 'guan'
  endif  
;;--
Bt_LBG_RTN_arr  = Reform(Sqrt(Total(Bxyz_LBG_RTN_arr^2,1)))
dbx_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(0,*,*)) / Bt_LBG_RTN_arr
dby_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(1,*,*)) / Bt_LBG_RTN_arr
dbz_LBG_RTN_arr = Reform(Bxyz_LBG_RTN_arr(2,*,*)) / Bt_LBG_RTN_arr




;;--
num_times = N_Elements(time_vect_LBG)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi




;;--define 'theta_bin_min/max_vect'




;;--get 'StructFunct_Bt_theta_scale_arr'
;Btot_StructFunct_arr  = Fltarr(n_jie,num_times, num_periods)
;Bpara_StructFunct_arr  = Fltarr(n_jie,num_times, num_periods)
;Bperp_StructFunct_arr  = Fltarr(n_jie,num_times, num_periods)
Btot_SF_vect = Fltarr(n_jie, num_periods)
Bpara_SF_vect = Fltarr(n_jie, num_periods)
Bperp_SF_vect = Fltarr(n_jie, num_periods)

for i_jie =0,n_jie-1 do begin
;Btot_StructFunct_arr(i_jie,*,*) = abs(dBx_or)^jie(i_jie)+abs(dBy_or)^jie(i_jie)+abs(dBz_or)^jie(i_jie);;;;;;original or new
;Bpara_StructFunct_arr(i_jie,*,*) = abs(dBx_or*dbx_LBG_RTN_arr + dBy_or*dby_LBG_RTN_arr + dBz_or*dbz_LBG_RTN_arr)^jie(i_jie)
;Bperp_StructFunct_arr(i_jie,*,*) = (Btot_StructFunct_arr(i_jie,*,*) - Bpara_StructFunct_arr(i_jie,*,*)) / 2
for i_period = 0,num_periods-1 do begin
Btot_SF_vect(i_jie,i_period) = mean((dBx_or(*,i_period)^2+dBy_or(*,i_period)^2+dBz_or(*,i_period)^2)^(jie(i_jie)/2.0),/nan);mean(abs(dBx_or(*,i_period))^jie(i_jie)+abs(dBy_or(*,i_period))^jie(i_jie)+abs(dBz_or(*,i_period))^jie(i_jie),/nan)
Bpara_SF_vect(i_jie,i_period) = mean(abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^jie(i_jie),/nan)
Bperp_SF_vect(i_jie,i_period) = mean(((dBx_or(*,i_period)-dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period))^2+(dBy_or(*,i_period)-dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period))^2+(dBz_or(*,i_period)-dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2)^(jie(i_jie)/2.0),/nan)
;mean((abs(dBx_or(*,i_period))^jie(i_jie)+abs(dBy_or(*,i_period))^jie(i_jie)+abs(dBz_or(*,i_period))^jie(i_jie)- $
  ;(abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^jie(i_jie))/2.0),/nan)
endfor

endfor


;StructFunct_Bpara_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
;StructFunct_Bperp_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
;num_DataNum_Bpara_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
;num_DataNum_Bperp_second_theta_scale_arr = fltarr(num_theta_bins,num_periods)
;For i_period=0,num_periods-1 Do Begin
;For i_theta=0,num_theta_halfbins-1 Do Begin
;  theta_min_bin = theta_bin_min_vect(i_theta)
;  theta_max_bin = theta_bin_max_vect(i_theta)
;  sub_tmp = Where(((theta_arr(*,i_period) ge theta_min_bin and $
;          theta_arr(*,i_period) lt theta_max_bin)) or ((theta_arr(*,i_period) ge (180-theta_max_bin) and $
;          theta_arr(*,i_period) lt (180-theta_min_bin))))      ;;;对折
;  If sub_tmp(0) ne -1 Then Begin
;    StructFunct_vect_tmp  = abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2;Btot_StructFunct_arr(*,i_period)
;;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
;    StructFunct_tmp = Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
;    StructFunct_Bpara_second_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
;    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
;    num_DataNum_tmp = N_Elements(sub_tmp_v2)
;    num_DataNum_Bpara_second_theta_scale_arr(i_theta,i_period) = num_DataNum_tmp
;  EndIf
;EndFor
;EndFor
;
;For i_period=0,num_periods-1 Do Begin
;For i_theta=0,num_theta_halfbins-1 Do Begin
;  theta_min_bin = theta_bin_min_vect(i_theta)
;  theta_max_bin = theta_bin_max_vect(i_theta)
;  sub_tmp = Where(((theta_arr(*,i_period) ge theta_min_bin and $
;          theta_arr(*,i_period) lt theta_max_bin)) or ((theta_arr(*,i_period) ge (180-theta_max_bin) and $
;          theta_arr(*,i_period) lt (180-theta_min_bin))))      ;;;对折
;  If sub_tmp(0) ne -1 Then Begin
;    StructFunct_vect_tmp  = (abs(dBx_or(*,i_period))^2+abs(dBy_or(*,i_period))^2+abs(dBz_or(*,i_period))^2- $
;  (abs(dBx_or(*,i_period)*dbx_LBG_RTN_arr(*,i_period) + dBy_or(*,i_period)*dby_LBG_RTN_arr(*,i_period) + dBz_or(*,i_period)*dbz_LBG_RTN_arr(*,i_period))^2)/2.0);Btot_StructFunct_arr(*,i_period)
;;a    StructFunct_tmp = Median(StructFunct_vect_tmp(sub_tmp))
;    StructFunct_tmp = Mean(StructFunct_vect_tmp(sub_tmp), /NaN)   ;计算已除去坏点
;    StructFunct_Bperp_second_theta_scale_arr(i_theta,i_period)= StructFunct_tmp
;    sub_tmp_v2    = Where(Finite(StructFunct_vect_tmp(sub_tmp)) eq 1)
;    num_DataNum_tmp = N_Elements(sub_tmp_v2)
;    num_DataNum_Bperp_second_theta_scale_arr(i_theta,i_period) = num_DataNum_tmp
;  EndIf
;EndFor
;EndFor
;;save:jie,theta,period
;Btot_StructFunct_arr = Reverse(Btot_StructFunct_arr,3)
;Bpara_StructFunct_arr = Reverse(Bpara_StructFunct_arr,3)
;Bperp_StructFunct_arr = Reverse(Bperp_StructFunct_arr,3)
Btot_SF_vect = Reverse(Btot_SF_vect,2)
Btot_SF_vect = Reverse(Btot_SF_vect,2)
Btot_SF_vect = Reverse(Btot_SF_vect,2)
file_save = 'SF_of_'+strre+'_jie_Bperp_Bpara_period_or_v2.sav';;orginal or new
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;不改
data_descrip= 'got from "paper3_caculate_spy.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  period_vect,jie,Btot_SF_vect,Bpara_SF_vect,Bperp_SF_vect


endfor

;;;;;;;

step2:

slope_para = fltarr(n_jie)
sigma_para = fltarr(n_jie)
slope_perp = fltarr(n_jie)
sigma_perp = fltarr(n_jie)
;Step2:
;===========================
;Step2:
for i_recon = 0,1 do begin
  if i_recon eq 0 then begin
    strre = 'hao'
  endif
  if i_recon eq 1 then begin
    strre = 'guan'
  endif  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'SF_of_'+strre+'_jie_Bperp_Bpara_period_or_v2.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;  data_descrip, $
;  Btot_StructFunct_arr, $
;  period_vect,jie,Btot_SF_vect,Bpara_SF_vect,Bperp_SF_vect
;;--
 Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=1000.0 & ysize=500.0
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
    color_gray = 250L
    TVLCT,127L,127L,127L,color_gray
    num_CB_color= 256-6
    R=Congrid(R,num_CB_color)
    G=Congrid(G,num_CB_color)
    B=Congrid(B,num_CB_color)
    TVLCT,R,G,B
    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 2
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

;ds = findgen(n_jie)
    i_x_SubImg  = 0
    i_y_SubImg  = 0  
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)] 
if i_recon eq 0 then begin
  xrange=[0.1,10]
  xout = 0.2
endif  
if i_recon eq 1 then begin
  xrange=[5,120]
  xout=2
endif  
    
for i_jie = 0,n_jie-1 do begin
plot, period_vect,Bpara_SF_vect(i_jie,*),/noerase,color = color_black,position=position_subImg, $
  xrange = xrange,yrange=[min(Bpara_SF_vect),max(Bpara_SF_vect)],title='Bpara',xtitle='period(s)',ytitle='SF',/xlog,/ylog
xyouts,xout,Bpara_SF_vect(i_jie,0),string(jie(i_jie),format='(F3.1)'),color=color_black
endfor

    i_x_SubImg  = 1
    i_y_SubImg  = 0  
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.9),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)] 
    
for i_jie = 0,n_jie-1 do begin
plot, period_vect,Bperp_SF_vect(i_jie,*),/noerase,color = color_black,position=position_subImg, $
    xrange = xrange,yrange=[min(Bperp_SF_vect),max(Bperp_SF_vect)],title='Bperp',xtitle='period(s)',ytitle='SF',/xlog,/ylog
xyouts,xout,Bperp_SF_vect(i_jie,0),string(jie(i_jie),format='(F3.1)'),color=color_black    
endfor

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'SF_Bpara_Bperp_'+strre+'_or_v2.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;;;;;;;
for i_jie = 0,n_jie-1 do begin
freq_vect_plot  = Reverse(1./period_vect)

LgPSD_Bpara_arr_plot= ALog10(abs(Bpara_SF_vect(i_jie,*)))
LgPSD_Bperp_arr_plot= ALog10(abs(Bperp_SF_vect(i_jie,*)))
;;--
;num_theta_bins  = N_Elements(theta_bin_min_vect)


freq_min_plot = Min(freq_vect_plot)
freq_max_plot = Max(freq_vect_plot)

freq_low = freq_min_plot;0.01
freq_high = freq_max_plot;1.0/7.0
sub_freq_in_seg = Where(freq_vect_plot ge freq_low and freq_vect_plot le freq_high)
num_points_LinFit   = N_Elements(sub_freq_in_seg)
  LgPSD_vect_tmp  = LgPSD_Bpara_arr_plot
;  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_theta)
  fit_para    = LinFit(ALog10(freq_vect_plot),LgPSD_vect_tmp,$
              sigma=sigma_FitPara)
  slope_vect_plot    = fit_para(1)
  SigmaSlope_vect_plot = sigma_FitPara(1)

slope_para(i_jie) = slope_vect_plot
sigma_para(i_jie) = SigmaSlope_vect_plot
;;;;;;;;;;;;;;;;;;;;;;;;
  LgPSD_vect_tmp  = LgPSD_Bperp_arr_plot
;  LgPSD_vect_plot_tmp = LgPSD_vect_tmp + dlgPSD_offset_plot*(i_theta)
  fit_para    = LinFit(ALog10(freq_vect_plot),LgPSD_vect_tmp,$
              sigma=sigma_FitPara)
  slope_vect_plot    = fit_para(1)
  SigmaSlope_vect_plot = sigma_FitPara(1)

slope_perp(i_jie) = slope_vect_plot
sigma_perp(i_jie) = SigmaSlope_vect_plot

endfor


dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'slope_of_s(p)_jie_Bpara_Bperp_'+strre+'_or_v2.sav';;;;;
data_descrip= 'got from "plot_sp_freq.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  slope_para, sigma_para,slope_perp, sigma_perp


endfor


End_Program:
End


