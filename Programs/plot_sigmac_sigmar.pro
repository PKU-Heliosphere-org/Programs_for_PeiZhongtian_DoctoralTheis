;pro plot_sigmac_sigmar


sub_dir_date  = 'wind\20071113-16\'


step1:

read,'use wavlet(0) or delta(1):',select

if select eq 0 then strsel = ''
if select eq 1 then strsel = '_from_delta'

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'sigmac_sigmar'+strsel+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "calculate_sigma_cr.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  sigmac,sigmar
;  period_vect

num_scale = n_elements(period_vect)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location_do.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "locate_sheet.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
;    CS_location2 ,$
;    width_real ,theta_real, temp_real, Btcha, time_mid


step2:

sele=0

for sele = 0,3 do begin
  if sele eq 0 then begin
    colorl = Btcha
    color_str = 'deltaB'
  endif
  if sele eq 1 then begin
    colorl = width_real
    color_str = 'width'
  endif  
  if sele eq 2 then begin
    colorl = Btcha/width_real
    color_str = 'deltaB_width'
  endif
  if sele eq 3 then begin
    colorl = temp_real
    color_str = 'temp'
  endif
  
for i=0,num_scale-1 do begin  ;i是尺度
;;--
Set_Plot,'WIN'
Device,DeComposed=0
xsize = 600.0
ysize = 600.0
Window,1,XSize=xsize,YSize=ysize

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


xrange  = [-1.0, 1.0] ;unit: km
yrange  = [-1.0, 1.0] ;unit: km
;win_position    = position_plot_SpaAutoCC
half_width_max    = 0.40
winsize_xy_ratio  = xsize/ysize
position_SubImg   = [0.15,0.1,0.8,0.8]
xtitle  = textoIDL('\sigma')+'c'
ytitle  = textoIDL('\sigma')+'r'
title = ''
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  Position=position_SubImg,/NoData,Color=color_black
  
  

;n_scale = 3
;for i=0,2 do begin  ;i是尺度
;;--
;r_para_vect     = [r_para_C12_vect,r_para_C13_vect,r_para_C14_vect,$        ;sigmac
;            r_para_C23_vect,r_para_C24_vect,r_para_C34_vect]
;r_perp_vect     = [r_perp_C12_vect,r_perp_C13_vect,r_perp_C14_vect,$        ;sigmar
;            r_perp_C23_vect,r_perp_C24_vect,r_perp_C34_vect]
;SpaAutoCorr_vect  = [SpaAutoCorr_C12_vect,SpaAutoCorr_C13_vect,SpaAutoCorr_C14_vect,$
;            SpaAutoCorr_C23_vect,SpaAutoCorr_C24_vect,SpaAutoCorr_C34_vect]
;sub_InArea  = Where(r_para_vect ge xrange(0) and r_para_vect le xrange(1) and $
;          r_perp_vect ge yrange(0) and r_perp_vect le yrange(1))
image_TV  = colorl
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.005*(N_Elements(image_TV))))
;a min_image= 0.70
max_image = image_TV_v2(Long(0.995*(N_Elements(image_TV))))
;a max_image= 0.95
;is_continue = ' '
;Read, 'is_continue: ', is_continue
byt_image_TV= BytSCL(colorl,min=min_image,max=max_image, Top=num_CB_color-1)
Color_Btcha  = byt_image_TV

;;--
num_points  = N_Elements(colorl)
For i_point=0,num_points-1 Do Begin
  sigmac_tmp  = sigmac(i_point,i)
  sigmar_tmp  = sigmar(i_point,i)
  color_tmp = Color_Btcha(i_point)
  PlotSym, 0, 1.8, FILL=1,thick=0.5,Color=color_tmp
  Plots, sigmac_tmp, sigmar_tmp, Psym=8, NoClip=0
EndFor









step3:

;;--
position_CB   = [position_SubImg(2)+0.10,position_SubImg(1),$
          position_SubImg(2)+0.11,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F6.2)');the tick-names of colorbar 15
;a tickn_CB   = Replicate(' ',num_ticks)
titleCB     = color_str
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB,CharSize=0.8, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, Thick=1.5, XThick=1.5, YThick=1.5,CharThick=1.3




;  plot,sigmac(*,i),sigmar(*,i),psym=1,xrange=[-1.0,1.0],yrange=[-1.0,1.0], $
;  /isotropic,xtitle='sigmac',ytitle='sigmar'

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'tu\'
file_version= '(v1)'
file_fig  = string(period_vect(i))+'s'+'_'+color_str+'_scale_sigmac_sigmar'+strsel+  $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endfor

endfor

END_program:  
end







