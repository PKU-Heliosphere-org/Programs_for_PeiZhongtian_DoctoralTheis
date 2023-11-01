;pro paper3_plot_line_SF_235jie_remove_background

sub_dir_date  = 'wind\slow\case3\'
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
dir_fig = dir_restore

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

Step1:
;===========================
;Step1:
n_jie = 5
jie = findgen(n_jie)+1

;Set_Plot, 'Win'
;Device,DeComposed=0
;xsize = 1000.0
;ysize = 1000.0
;Window,1,XSize=xsize,YSize=ysize
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;;;--
Set_Plot, 'PS';'Win'
Device,filename=dir_restore+'StructFunct_VS_tau_'+'new'+'_slow.eps', $   ;
    XSize=30,YSize=30,/Color,Bits=10,/Encapsul
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
num_x_SubImgs = 2
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;slope = fltarr(45,n_jie);num_theta_bins_plot=46
;num_theta_bins_plot = 45
;sigmaslope = fltarr(n_jie,num_theta_bins_plot)

step2:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  '1-3'+'haosan'+'_SF.sav';strcompress(string(i_slow),/remove_all)
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


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  '1-3'+'guodu'+'_SF.sav';strcompress(string(i_slow),/remove_all)
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
    period_vect_g = period_vect
dBx_new_g = dBx_new
dBy_new_g = dBy_new
dBz_new_g = dBz_new
dBx_or_g =  Diff_Bx_arr
dBy_or_g =  Diff_By_arr
dBz_or_g =  Diff_Bz_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  '1-3'+'guanxing'+'_SF.sav';strcompress(string(i_slow),/remove_all)
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
    period_vect_r = period_vect
dBx_new_r = dBx_new
dBy_new_r = dBy_new
dBz_new_r = dBz_new
dBx_or_r =  Diff_Bx_arr
dBy_or_r =  Diff_By_arr
dBz_or_r =  Diff_Bz_arr


for i_c = 0,2 do begin
;i_jie = 5
if i_c eq 0 then begin
  i_jie = 1
  jieshu = jie(i_jie)
endif
if i_c eq 1 then begin
  i_jie = 2
  jieshu = jie(i_jie)
endif
if i_c eq 2 then begin
  i_jie = 4
  jieshu = jie(i_jie)
endif
;if i_c eq 3 then begin
;  i_jie = 6
;  jieshu = jie(i_jie)
;endif
;;--
;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore=  'StructFunct_'+'1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_guan_'+'Bperp_Bpara_theta_period_arr'+$
;       '(time=*-*)'+$
;       '(period=*-*)V2'+$
;        '.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;;Save, FileName=dir_save+file_save, $
;;  data_descrip, $
;;  theta_bin_min_vect, theta_bin_max_vect, $
;;  period_vect, $
;;  StructFunct_Bt_time_scale_arr, $
;;  StructFunct_Bperp_theta_scale_arr, $
;;  StructFunct_Bpara_theta_scale_arr, $
;;  StructFunct_Bt_theta_scale_arr, $
;;  num_DataNum_theta_scale_arr
;period_vect_o = period_vect
;StructFunct_Bt_time_scale_arr_o = StructFunct_Bt_time_scale_arr


;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore=  'StructFunct_'+'1-5'+'_'+strcompress(string(jieshu),/remove_all)+'_guan_'+'Bperp_Bpara_theta_period_arr'+$
;       '(time=*-*)'+$
;       '(period=  5.0- 0100)V2'+$
;        '.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose
;;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;;Save, FileName=dir_save+file_save, $
;;  data_descrip, $
;;  theta_bin_min_vect, theta_bin_max_vect, $
;;  period_vect, $
;;  StructFunct_Bt_time_scale_arr, $
;;  StructFunct_Bperp_theta_scale_arr, $
;;  StructFunct_Bpara_theta_scale_arr, $
;;  StructFunct_Bt_theta_scale_arr, $
;;  num_DataNum_theta_scale_arr
;period_vect_r = period_vect
;StructFunct_Bt_time_scale_arr_r = StructFunct_Bt_time_scale_arr


step3:
if i_c eq 0 then begin
i_x_SubImg  = 0
i_y_SubImg  = 1
th = '2nd'
tou = '(a) '+th+' order'
;tickname=['10!u-2!n','10!u-1!n','10!u0!n','10!u1!n']
endif
if i_c eq 1 then begin
i_x_SubImg  = 1
i_y_SubImg  = 1
th = '3rd'
tou = '(b) '+th+' order'
;tickname=['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n']
endif
if i_c eq 2 then begin
i_x_SubImg  = 0
i_y_SubImg  = 0
th = '5th'
tou = '(c) '+th+' order'
;tickname=['10!u-4!n','10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n','10!u2!n']
endif
if i_c eq 3 then begin
i_x_SubImg  = 1
i_y_SubImg  = 0
th = '7th'
tou = '(d) '+th+' order'
;tickname=['10!u-6!n','10!u-4!n','10!u-2!n','10!u0!n','10!u2!n']
endif
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.2),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.2),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.8)]
           
StructFunct_Bt_time_scale_arr_o = dBx_new_o^jieshu + dBy_new_o^jieshu + dBz_new_o^jieshu;;;;original or new
StructFunct_Bt_time_scale_arr_g = dBx_new_g^jieshu + dBy_new_g^jieshu + dBz_new_g^jieshu;;;;original or new
StructFunct_Bt_time_scale_arr_r = dBx_new_r^jieshu + dBy_new_r^jieshu + dBz_new_r^jieshu;;;;original or new

n_scale_o = n_elements(period_vect_o)
sf_scale_o = fltarr(n_scale_o)
for i_s = 0,n_scale_o-1 do begin
  sf_scale_o(i_s) = mean(StructFunct_Bt_time_scale_arr_o(*,i_s),/nan)
endfor


n_scale_g = n_elements(period_vect_g)
sf_scale_g = fltarr(n_scale_g)
for i_s = 0,n_scale_g-1 do begin
  sf_scale_g(i_s) = mean(StructFunct_Bt_time_scale_arr_g(*,i_s),/nan)
endfor

n_scale_r = n_elements(period_vect_r)
sf_scale_r = fltarr(n_scale_r)
for i_s = 0,n_scale_r-1 do begin
  sf_scale_r(i_s) = mean(StructFunct_Bt_time_scale_arr_r(*,i_s),/nan)
endfor


xrange = [min(period_vect_o),max(period_vect_r)]
;sub_fit = where(period_vect ge 20 and period_vect le 200)
;parao = linfit(alog10(period_vect(sub_fit)),alog10(sf_scale(sub_fit)),sigma = sigmao)
;print,i_c,parao,sigmao
;parar = linfit(alog10(period_vect(sub_fit)),alog10(sfr_scale(sub_fit)),sigma = sigmar)
;print,i_c,parar,sigmar
;y1 = 10.^parao(0)*period_vect(sub_fit)^parao(1)
;y2 = 10.^parar(0)*period_vect(sub_fit)^parar(1)
yrange = [min(sf_scale_o)/10.,max(sf_scale_r)*10.]
plot,xrange,yrange, xrange=xrange, yrange=yrange, $
  color=color_black, position=position_SubImg, xtitle = textoIDL('\tau')+'(s)',ytitle='SF of Btotal(nT!up!n)', $
 charsize = 1.5, charthick=4,thick=4,xthick=4,ythick=4,linestyle = 3,/NoErase,ystyle = 1, $
; ytickname=tickname , $
 /xlog,/ylog ,/nodata , title=tou;+''+th+' order'
;oplot, period_vect(sub_fit),y1,color = color_red,linestyle = 2, thick=7
;oplot,period_vect(sub_fit),y2,color = color_red,linestyle = 2, thick=7

oplot,period_vect_o,sf_scale_o,  color = color_black, thick=4
oplot,period_vect_g,sf_scale_g, linestyle=1, color = color_black, thick=4
oplot,period_vect_r,sf_scale_r,  color = color_black, thick=4
;oplot,period_vect,sfr_scale, color = color_blue, thick=4
 
;yrange = [min(sfr_scale)/10.,max(sf_scale)*10.]
;plot,period_vect,sf_scale,xrange=[1,10^4],yrange=yrange, $
;  color=color_black, position=position_SubImg, xtitle = textoIDL('\tau')+'(s)',ytitle='SF of Btotal(nT!up!n)', $
; charsize = 1.25, charthick=4,thick=4,xthick=4,ythick=4,/NoErase,ystyle = 1, $
; ytickname=tickname , $
; /xlog,/ylog  ; title=tou+''+th+' order',
;oplot,period_vect,sfr_scale,color = color_blue,thick=4
;
;sub_fit = where(period_vect ge 20 and period_vect le 200)
;parao = linfit(alog10(period_vect(sub_fit)),alog10(sf_scale(sub_fit)))
;parar = linfit(alog10(period_vect(sub_fit)),alog10(sfr_scale(sub_fit)))
;y1 = 10.^parao(0)*period_vect(sub_fit)^parao(1)
;y2 = 10.^parar(0)*period_vect(sub_fit)^parar(1)
;oplot,period_vect(sub_fit),y1, color = color_green, linestyle = 3,thick=3
;oplot,period_vect(sub_fit),y2, color = color_green, linestyle = 3,thick=3

;period_p = [300,800]
;liang_cha = alog10(yrange(1))-alog10(yrange(0))
;y_otuli = [min(sfr_scale)/3.*10^(liang_cha/8.),min(sfr_scale)/3.*10^(liang_cha/8.)]
;y_rtuli = [min(sfr_scale)/3.,min(sfr_scale)/3.]
;oplot,period_p,y_otuli,color = color_black,thick=4
;oplot,period_p,y_rtuli,color = color_blue,thick=4
;xfit1 = [20,20]
;xfit2 = [200,200]
;yfit = yrange
;oplot,xfit1,yfit,color=color_black,linestyle=2,thick=4
;oplot,xfit2,yfit,color=color_black,linestyle=2,thick=4
;xyouts,[1000,1000],[min(sfr_scale)/3.*10^(liang_cha/8.),min(sfr_scale)/3.],['original','LIM'],charsize=1.0,charthick=4
;xyouts,10,10*max(sf_scale)*10^(liang_cha/12.),tou,charsize=1.25,charthick=4

endfor

Device,/close

end_program:
end
