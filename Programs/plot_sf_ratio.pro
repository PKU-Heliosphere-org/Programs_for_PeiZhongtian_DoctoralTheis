;pro plot_SF_ratio



sub_dir_date  = 'new\19950720-29-1\'

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

Step1:
;===========================
;Step1:
n_jie = 10
jie = findgen(n_jie)+1

;Set_Plot, 'Win'
;Device,DeComposed=0
;xsize = 1000.0
;ysize = 1000.0
;Window,1,XSize=xsize,YSize=ysize
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;;--
Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'StructFunct_VS_SF4.eps', $   ;
    XSize=21,YSize=7,/Color,Bits=10,/Encapsul
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
num_x_SubImgs = 3
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;slope = fltarr(45,n_jie);num_theta_bins_plot=46
;num_theta_bins_plot = 45
;sigmaslope = fltarr(n_jie,num_theta_bins_plot)

step2:




;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      3.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_o3 = StructFunct_Bt_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      4.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_o4 = StructFunct_Bt_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      5.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_o5 = StructFunct_Bt_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      7.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_o7 = StructFunct_Bt_time_scale_arr


;;;----
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      3.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '_recon.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_r3 = StructFunct_Bt_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      4.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '_recon.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_r4 = StructFunct_Bt_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      5.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '_recon.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_r5 = StructFunct_Bt_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'StructFunct      7.00000_Bperp_Bpara_theta_period_arr(time=19950720-19950729)(period=6.0-1999)'+$
        '_recon.sav'
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
;  StructFunct_Bt_time_scale_arr, $
;  StructFunct_Bperp_theta_scale_arr, $
;  StructFunct_Bpara_theta_scale_arr, $
;  StructFunct_Bt_theta_scale_arr, $
;  num_DataNum_theta_scale_arr
StructFunct_Bt_time_scale_arr_r7 = StructFunct_Bt_time_scale_arr


n_scale = n_elements(period_vect)
sf_scale3 = fltarr(n_scale)
sfr_scale3 = fltarr(n_scale)
for i_s = 0,n_scale-1 do begin
  sf_scale3(i_s) = mean(StructFunct_Bt_time_scale_arr_o3(*,i_s),/nan)
  sfr_scale3(i_s) = mean(StructFunct_Bt_time_scale_arr_r3(*,i_s),/nan)
endfor

sf_scale4 = fltarr(n_scale)
sfr_scale4 = fltarr(n_scale)
for i_s = 0,n_scale-1 do begin
  sf_scale4(i_s) = mean(StructFunct_Bt_time_scale_arr_o4(*,i_s),/nan)
  sfr_scale4(i_s) = mean(StructFunct_Bt_time_scale_arr_r4(*,i_s),/nan)
endfor

sf_scale5 = fltarr(n_scale)
sfr_scale5 = fltarr(n_scale)
for i_s = 0,n_scale-1 do begin
  sf_scale5(i_s) = mean(StructFunct_Bt_time_scale_arr_o5(*,i_s),/nan)
  sfr_scale5(i_s) = mean(StructFunct_Bt_time_scale_arr_r5(*,i_s),/nan)
endfor

sf_scale7 = fltarr(n_scale)
sfr_scale7 = fltarr(n_scale)
for i_s = 0,n_scale-1 do begin
  sf_scale7(i_s) = mean(StructFunct_Bt_time_scale_arr_o7(*,i_s),/nan)
  sfr_scale7(i_s) = mean(StructFunct_Bt_time_scale_arr_r7(*,i_s),/nan)
endfor


step3:

for i_c = 0,2 do begin

if i_c eq 0 then begin
i_x_SubImg  = 0
i_y_SubImg  = 0
sf_scale = sf_scale4
sfr_scale = sfr_scale4
tou = '(a) S!d4!n/S!d3!n '

endif
if i_c eq 1 then begin
i_x_SubImg  = 1
i_y_SubImg  = 0
sf_scale = sf_scale5
sfr_scale = sfr_scale5
tou = '(b) S!d5!n/S!d3!n '

endif
if i_c eq 2 then begin
i_x_SubImg  = 2
i_y_SubImg  = 0
sf_scale = sf_scale7
sfr_scale  = sfr_scale7
tou = '(c) S!d7!n/S!d3!n '

endif


position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.2),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.2),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.8)]


x1 = sf_scale3
x2 = sfr_scale3
y1 = sf_scale
y2 = sfr_scale

parao = linfit(alog10(x1),alog10(y1),sigma = sigmao)
print,i_c,parao,sigmao
parar = linfit(alog10(x2),alog10(y2),sigma = sigmar)
print,i_c,parar,sigmar

py1 = 10.^parao(0)*x1^parao(1)
py2 = 10.^parar(0)*x2^parar(1)

xrange = [0.01,10.] 
yrange = [0.01,100.]
plot,xrange,yrange, $
  color=color_black, position=position_SubImg, xtitle = 'SF of Btotal(nT!u3!n)',ytitle='SF of Btotal(nT!up!n)', $
 charsize = 0.86, charthick=4,thick=4,xthick=4,ythick=4,yrange=yrange, $
; ytickname=tickname , $
 /NoErase,/xlog,/ylog ,title=tou,/nodata
 
oplot,x1,py1,color = color_red,linestyle = 2, thick=5
oplot,x2,py2,color = color_red,linestyle = 2, thick=5 
 
oplot,x1,y1,color = color_black,thick=4
oplot,x2,y2,color = color_blue,thick=4


;
period_p = [0.3,0.8]
liang_cha = alog10(yrange(1))-alog10(yrange(0))
y_otuli = [0.1,0.1]
y_rtuli = [0.025,0.025]
oplot,period_p,y_otuli,color = color_black,thick=4
oplot,period_p,y_rtuli,color = color_blue,thick=4

xyouts,[1,1],[0.1,0.025],['original','LIM'],charsize=0.75,charthick=4


endfor


Device,/close

end_program:
end


















