;pro plot_w_vs_p_theta
device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

sub_dir_date  = 'new\19950509-13\'


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950509-13_v01.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR

;===========================
Step1:

;;--
i_BComp = 0
Read, 'i_BComp(1/2/3/4 for Bx/By/Bz/Bmag): ', i_BComp
If i_BComp eq 1 Then begin
FileName_BComp='Bx'
Bcomp_GSE_2s_arr = Bx_GSE_2s_vect
endif
If i_BComp eq 2 Then begin
FileName_BComp='By'
Bcomp_GSE_2s_arr = By_GSE_2s_vect
endif
If i_BComp eq 3 Then begin
FileName_BComp='Bz'
Bcomp_GSE_2s_arr = Bz_GSE_2s_vect
endif
If i_BComp eq 4 Then begin
FileName_BComp='Bmag'
Bcomp_GSE_2s_arr = Bmag_GSE_2s_arr
endif

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'Bz'+'_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;data_descrip= 'got from "get_PSD_from_WaveLet_of_MAG_RNT.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+FileName_BComp+'_time_scale_arr(time=*-*)'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
i_select  = 0
file_restore  = file_array(i_select)
Restore, file_restore
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_BComp_time_scale_arr,$
;  theta_arr


step2:
nmag = size(Bcomp_GSE_2s_arr)
n_period = size(period_vect)
n_jie = 4           ;结构函数阶数
p=indgen(n_jie)+1
;period_sub = fltarr(n_period(1))
period_sub = round(period_vect/2.0)
Bcomp_scale = fltarr(n_jie,nmag(1),n_period(1))
for k=0,n_jie-1 do begin
for i=0,n_period(1)-1 do begin
  for j=0,nmag(1)-period_vect(i)-1 do begin
    Bcomp_scale(k,j,i) = (abs(Bcomp_GSE_2s_arr(j+period_vect(i))-Bcomp_GSE_2s_arr(j)))^(k+1)  ;结构函数^1,^2,^3,^4
  endfor
endfor
endfor








num_periods = n_period(1)
num_theta_bins  = 90L
dtheta_bin    = 180./num_theta_bins
theta_bin_min_vect  = Findgen(num_theta_bins)*dtheta_bin
theta_bin_max_vect  = (Findgen(num_theta_bins)+1)*dtheta_bin

;;--get 'PSD_BComp_theta_scale_arr'
BComp_theta_scale = Fltarr(n_jie,num_theta_bins, num_periods)
for i_jie = 0,n_jie-1 do begin
For i_period=0,num_periods-1 Do Begin
;For i_period=0,7 Do Begin
For i_theta=0,num_theta_bins-1 Do Begin
  theta_min_bin = theta_bin_min_vect(i_theta)
  theta_max_bin = theta_bin_max_vect(i_theta)
  sub_tmp = Where(theta_arr(*,i_period) ge theta_min_bin and $
          theta_arr(*,i_period) lt theta_max_bin)
  If sub_tmp(0) ne -1 Then Begin
    PSD_vect_tmp  = Bcomp_scale(i_jie,*,i_period)
    PSD_tmp = Mean(PSD_vect_tmp(sub_tmp))
    BComp_theta_scale(i_jie,i_theta,i_period) = PSD_tmp
  EndIf
EndFor
EndFor
endfor


step3:
s = fltarr(n_jie,num_theta_bins)

for i_theta = 0,num_theta_bins-1 do begin
  for i_jie = 0,n_jie-1 do begin
    result = linfit(alog10(period_vect),alog10(BComp_theta_scale(i_jie,i_theta,*)))
    s(i_jie,i_theta) = result(1)
  endfor
endfor

;我们已经有阶数p，指数s(p)，角度0-180

step4:;如果像以前一样画颜色图趋势并不明显，还是画曲线图比较好，但是要按角度画90张图，或者也可以去一些代表的角度画10张图0,20等等
xsize = 750.0
ysize = 1300.0
Window,1,XSize=xsize,YSize=ysize
ds=findgen(num_theta_bins)*0.1
plot,[0],[0],xrange=[0,5],yrange=[0.0,10.0],/isotropic
con=1
for i=0,num_theta_bins-1 do begin
  for j=0,n_jie-1 do begin
  if finite(s(j,i)) eq 0 then begin
    con=0
  endif 
  endfor
  if con eq 1 then begin
  plot,p,s(*,i)+ds(i),xrange=[0,5],yrange=[0.0,10.0],xtitle='p',ytitle='s',/noerase,/isotropic
  endif
  con=1
endfor

;;--
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_version= '(v1)'
file_fig  = 'S(p)_'+FileName_BComp+'_theta_p_arr'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

end_program:
end




























