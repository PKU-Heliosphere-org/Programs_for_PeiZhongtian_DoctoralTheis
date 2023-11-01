;pro plot_pdf_for_theta

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL
;Pro fanwavelet
Date = '19950720-29'
sub_dir_date  = 'new\'+date+'\'
;;--
n_jie = 10
jie = findgen(n_jie)+1
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date



;position_img  = [0.10,0.15,0.90,0.98]
;num_x_SubImgs = 2
;num_y_SubImgs = 4
;dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
;dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

;;

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=19950720-19950729)(period=4.0-1000).sav'
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
time_vect_LBG_o = time_vect
period_vect_LBG_o = period_vect


;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=19950720-19950729)(period=4.0-1000)_recon.sav'
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
time_vect_LBG_r = time_vect
period_vect_LBG_r = period_vect



  max_re = float(1)
  min_re = float(1)
i_jie = 0
Step1:
;===========================
;Step1:
jieshu = jie(i_jie)

;;--
step1_1:
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=4.5-1000)(v3).sav'
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
time_vect_StructFunct_o = time_vect
period_vect_StructFunct_o = period_vect
Bx_StructFunct_arr_o  = BComp_StructFunct_arr
Diff_Bx_arr_o = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=4.5-1000)(v3).sav'
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
By_StructFunct_arr_o  = BComp_StructFunct_arr
Diff_By_arr_o = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=4.5-1000)(v3).sav'
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
Bz_StructFunct_arr_o  = BComp_StructFunct_arr
Diff_Bz_arr_o = Diff_BComp_arr




;;--
diff_time   = time_vect_StructFunct_o(0)-time_vect_LBG_o(0)
diff_num_times  = N_Elements(time_vect_StructFunct_o)-N_Elements(time_vect_LBG_o)
diff_period   = period_vect_StructFunct_o(0)-period_vect_LBG_o(0)
diff_num_periods= N_Elements(period_vect_StructFunct_o)-N_Elements(period_vect_LBG_o)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf


step1_2:
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=4.5-1000)(v3)_recon.sav'
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
time_vect_StructFunct_r = time_vect
period_vect_StructFunct_r= period_vect
Bx_StructFunct_arr_r  = BComp_StructFunct_arr
Diff_Bx_arr_r = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=4.5-1000)(v3)_recon.sav'
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
By_StructFunct_arr_r  = BComp_StructFunct_arr
Diff_By_arr_r = Diff_BComp_arr

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_StructFunct'+string(jieshu)+'_arr(time=*-*)(period=4.5-1000)(v3)_recon.sav'
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
Bz_StructFunct_arr_r  = BComp_StructFunct_arr
Diff_Bz_arr_r = Diff_BComp_arr




;;--
diff_time   = time_vect_StructFunct_r(0)-time_vect_LBG_r(0)
diff_num_times  = N_Elements(time_vect_StructFunct_r)-N_Elements(time_vect_LBG_r)
diff_period   = period_vect_StructFunct_r(0)-period_vect_LBG_r(0)
diff_num_periods= N_Elements(period_vect_StructFunct_r)-N_Elements(period_vect_LBG_r)
If diff_time ne 0.0 or diff_num_times ne 0L or $
  Abs(diff_period) ge 1.e-5 or diff_num_periods ne 0L Then Begin
  Print, 'StructFunct and LBG has different time_vect and period_vect!!!'
  Stop
EndIf


for i_recon = 0,1 do begin
  if i_recon eq 0 then begin
    time_vect_StructFunct = time_vect_StructFunct_o
    period_vect_StructFunct = period_vect_StructFunct_o
    Bx_StructFunct_arr  = Bx_StructFunct_arr_o
    Diff_Bx_arr = Diff_Bx_arr_o
    By_StructFunct_arr  = By_StructFunct_arr_o
    Diff_By_arr = Diff_By_arr_o
    Bz_StructFunct_arr  = Bz_StructFunct_arr_o
    Diff_Bz_arr = Diff_Bz_arr_o
    time_vect_LBG = time_vect_LBG_o
    period_vect_LBG = period_vect_LBG_o
    strre = 'original'
  endif
  if i_recon eq 1 then begin
    time_vect_StructFunct = time_vect_StructFunct_r
    period_vect_StructFunct = period_vect_StructFunct_r
    Bx_StructFunct_arr  = Bx_StructFunct_arr_r
    Diff_Bx_arr = Diff_Bx_arr_r
    By_StructFunct_arr  = By_StructFunct_arr_r
    Diff_By_arr = Diff_By_arr_r
    Bz_StructFunct_arr  = Bz_StructFunct_arr_r
    Diff_Bz_arr = Diff_Bz_arr_r
    time_vect_LBG = time_vect_LBG_r
    period_vect_LBG = period_vect_LBG_r
    strre = 'reconstruction'
  endif  



Step2:
;===========================
;Step:

;;--
num_times = N_Elements(time_vect_StructFunct)
num_periods = N_Elements(period_vect_StructFunct)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


Step3:
;===========================
;Step4:

;;--define 'theta_bin_min/max_vect'
num_theta_bins  = 90L
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'StructFunct_Bpara_theta_scale_arr'
;Diff_Bx_theta_scale_tmp = Fltarr(num_theta_bins, num_periods)
;For i_period=0,num_periods-1 Do Begin
;For i_theta=0,num_theta_bins-1 Do Begin
;做PDF的对象
i_period=30
i_theta=44
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  If sub_tmp(0) ne -1 Then Begin
      Diff_Bx_theta_scale_tmp = Diff_Bx_arr(sub_tmp,i_period)

  EndIf
;EndFor
;EndFor

;;--get 'StructFunct_Bperp_theta_scale_arr'
;i_period=0
;i_theta=0
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  If sub_tmp(0) ne -1 Then Begin
      Diff_By_theta_scale_tmp = Diff_Bx_arr(sub_tmp,i_period)

  EndIf

;;--get 'StructFunct_Bt_theta_scale_arr'
;i_period=0
;i_theta=0
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  If sub_tmp(0) ne -1 Then Begin
      Diff_Bz_theta_scale_tmp = Diff_Bx_arr(sub_tmp,i_period)

  EndIf

d_x=diff_Bx_theta_scale_tmp
d_y=diff_By_theta_scale_tmp
d_z=diff_Bz_theta_scale_tmp

step4:

Set_Plot, 'win'
Device,DeComposed=0
Window,0,xsize=400,ysize = 800

LoadCT,13,/silent
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
!p.multi = [0,1,3]


i_BComp = 0

for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then begin
  FileName_BComp = 'Bx' 
  FileName_B = 'Br'
  d=d_x
  biao = FileName_BComp
endif
If i_BComp eq 2 Then begin
  FileName_BComp = 'By' 
  FileName_B = 'Bt'
  d=d_y
    biao = FileName_BComp
endif
If i_Bcomp eq 3 Then begin
  FileName_BComp = 'Bz' 
  FileName_B = 'Bn'
  d=d_z
    biao = FileName_BComp
endif

N= N_elements(d)
dmax = max(d,/nan)
dmin = min(d,/nan)
drange = dmax-dmin
sell = 40.0
dpart = drange/sell

count = lonarr(sell)
for j=0,N-1 do begin
  for k=0,sell-1 do begin
    if d(j) GE (dmin+k*dpart) and d(j) LT (dmin+(k+1)*dpart) then begin
      count(k) = count(k)+1
    endif else begin
    endelse
  endfor
endfor
count(sell-1)=count(sell-1)+1




c=indgen(sell)
d_plot = dmin+c*dpart
dstd = stddev(d,/nan)
d_plot = d_plot/dstd
;;;--
;for e=0,39 do begin
;  if count(e) eq 0 then begin
;    count(e)=1
;  endif
;endfor
;;;--

y_plot = float(count)/float(N)
y_plot = y_plot*dstd/dpart
plot,d_plot,y_plot,xtitle='d'+'/'+textoIDL('\sigma'),ytitle='PDF',$
psym=-1,color = color_black,charsize=1.5,charthick=1.5,thick=1.5,xrange=[-12.0,12.0],yrange=[10^(-6.0),1.0],/ylog
xyouts,-13.0,0.3,biao,charsize=0.8,charthick=1.5


;result = gaussfit(db_plot,alog10(y_plot))
result = gaussfit(d_plot,y_plot,para,nterms=3)
result = para(0)*exp(-((d_plot-para(1))/(1.*para(2)))^2/2.);+para(3)
print,para
oplot,d_plot,result,color=color_red,psym=-1,thick=1.5;,xrange=[-


endfor


image_tvrd  = TVRD(true=1)
dir_fig   = dir_restore
file_fig  = 'PDF_of_Mag_theta'+'_'+string(period_vect(i_period))+'_'+string(theta_bin_min_vect(i_theta))+ $
        strre+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd
;Device,/close

endfor

end_program:
end



