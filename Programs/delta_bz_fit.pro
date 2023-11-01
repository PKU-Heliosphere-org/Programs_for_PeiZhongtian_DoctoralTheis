;pro delta_Bz_fit

sub_dir_date  = 'wind\fast\case7\'
;sub_dir_date1  = 'wind\fast\case1\'

step1:


read,'original(0) or remove background(1):',is_remove
if is_remove eq 0 then begin
dBz = Diff_Bz_arr
str_remove = 'ori'
endif  
if is_remove eq 1 then begin
dBz = dBz_new
str_remove = 'remove'
endif  

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'delta_Bz_theta_'+str_remove+'.sav'
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
;  PVI, Flat,PVI_theta(1,0:num-1,i_period), Flat_theta


is_log = 1
num_periods = 12

time_lag = 0.1;time_vect_LBG(1)-time_vect_LBG(0)
print,time_lag
period_min = 4*time_lag;耗散0.4，惯性20
period_max = 1000*time_lag;耗散2，惯性100
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

dt_pix    = 0.1;time_vect(1)-time_vect(0)
PixLag_vect = (Round(period_vect/dt_pix)/2)*2
deltaBz = fltarr(6,num_periods)

for i_period = 0,num_periods-1 do begin
  deltaBz(0,i_period) = min(PVI_theta(0,*,i_period),/nan)
  deltaBz(1,i_period) = max(PVI_theta(0,*,i_period),/nan)
  deltaBz(2,i_period) = min(PVI_theta(1,*,i_period),/nan)
  deltaBz(3,i_period) = max(PVI_theta(1,*,i_period),/nan)
  deltaBz(4,i_period) = min(PVI(*,i_period),/nan)
  deltaBz(5,i_period) = max(PVI(*,i_period),/nan)  
endfor

;;;;;;;;;;;
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 900.0
ysize = 900.0
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
num_x_SubImgs = 2
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

;;;
i_x_SubImg = 0
i_y_SubImg = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result4 = linfit(deltaBz(4,*),alog10(period_vect),sigma=sigma4)
plot, deltaBz(4,*),period_vect,yrange=[0.4,100],position = position_SubImg,color = color_black,/noerase,/ylog
y = result4(0)+result4(1)*deltaBz(4,*)
oplot,deltaBz(4,*),10^y,color = color_red
xyouts,-25,40,'k='+string(result4(1))+'+-'+string(sigma4(1)),color = color_blue
;;;
;;;
i_x_SubImg = 1
i_y_SubImg = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result5 = linfit(deltaBz(5,*),alog10(period_vect),sigma=sigma5)
plot, deltaBz(5,*),period_vect,yrange=[0.4,100],position = position_SubImg,color = color_black,/noerase,/ylog
y = result5(0)+result5(1)*deltaBz(5,*)
oplot,deltaBz(5,*),10^y,color = color_red
xyouts,10,40,'k='+string(result5(1))+'+-'+string(sigma5(1)),color = color_blue
;;;
;;;
i_x_SubImg = 0
i_y_SubImg = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result0 = linfit(deltaBz(0,*),alog10(period_vect),sigma=sigma0)
plot, deltaBz(0,*),period_vect,yrange=[0.4,100],position = position_SubImg,color = color_black,/noerase,/ylog
y = result0(0)+result0(1)*deltaBz(0,*)
oplot,deltaBz(0,*),10^y,color = color_red
xyouts,-25,40,'k='+string(result0(1))+'+-'+string(sigma0(1)),color = color_blue
;;;
;;;
i_x_SubImg = 1
i_y_SubImg = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result1 = linfit(deltaBz(1,*),alog10(period_vect),sigma=sigma1)
plot, deltaBz(1,*),period_vect,yrange=[0.4,100],position = position_SubImg,color = color_black,/noerase,/ylog
y = result1(0)+result1(1)*deltaBz(1,*)
oplot,deltaBz(1,*),10^y,color = color_red
xyouts,10,40,'k='+string(result1(1))+'+-'+string(sigma1(1)),color = color_blue
;;;
;;;
i_x_SubImg = 0
i_y_SubImg = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result2 = linfit(deltaBz(2,*),alog10(period_vect),sigma=sigma2)
plot, deltaBz(2,*),period_vect,yrange=[0.4,100],position = position_SubImg,color = color_black,/noerase,/ylog
y = result2(0)+result2(1)*deltaBz(2,*)
oplot,deltaBz(2,*),10^y,color = color_red
xyouts,-25,40,'k='+string(result2(1))+'+-'+string(sigma2(1)),color = color_blue
;;;
;;;
i_x_SubImg = 1
i_y_SubImg = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]

result3 = linfit(deltaBz(3,*),alog10(period_vect),sigma=sigma3)
plot, deltaBz(3,*),period_vect,yrange=[0.4,100],position = position_SubImg,color = color_black,/noerase,/ylog
y = result3(0)+result3(1)*deltaBz(3,*)
oplot,deltaBz(3,*),10^y,color = color_red
xyouts,10,40,'k='+string(result3(1))+'+-'+string(sigma3(1)),color = color_blue
;;;


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_deltaBz_linfit_'+str_remove+'.png';;;;;;;;;;;;;;;选全角度all还是不选
Write_PNG, dir_fig+file_fig, image_tvrd    



end_program:
end