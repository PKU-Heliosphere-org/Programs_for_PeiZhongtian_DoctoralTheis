;pro figure4_pvi_vs_line_fiure


sub_dir_date = 'wind\slow\case2\'
sub_dir_date1 = 'wind\fast\case2\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'PVI_scale_ralative_guan_log_slow.sav'
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
;  cc, PVI, PDF, n_cell

PDF_sg = PDF

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'PVI_scale_ralative_hao_log_slow.sav'
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
;  cc, PVI, PDF, n_cell

PDF_sh = PDF


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'PVI_scale_ralative_guan_log_fast.sav'
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
;  cc, PVI, PDF, n_cell

PDF_fg = PDF

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'PVI_scale_ralative_hao_log_fast.sav'
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
;  cc, PVI, PDF, n_cell

PDF_fh = PDF

step2:

for slec = 0,3 do begin
if slec eq 0 then begin
PDF_fg = PDF_fg
endif
if slec eq 1 then begin
PDF_fg = PDF_fh
endif
if slec eq 2 then begin
PDF_fg = PDF_sg
endif
if slec eq 3 then begin
PDF_fg = PDF_sh
endif


PDF_fg_x = fltarr(n_cell/10,n_cell)
PDF_fg_y = fltarr(n_cell/10)

for i=0,n_cell/10-1 do begin
  for j=0,n_cell-1 do begin
    PDF_fg_x(i,j) = total(PDF_fg(10*i:(10*(i+1)-1),j),/nan)
  endfor
  PDF_fg_y(i) = total(PDF_fg(10*i:(10*(i+1)-1),*),/nan)
  PDF_fg_x(i,where(PDF_fg_x(i,*) eq 0.0)) = !values.f_nan
endfor



N = total(PDF_fg,/nan)
PDF_fg_1y = PDF_fg_y/float(N)
PDF_fg_1x_v1 = PDF_fg_x/float(N)

PDF_fg_1x_v2 = fltarr(n_cell/10,n_cell)
for i = 0,n_cell/10-1 do begin
  N_i = total(PDF_fg_x(i,*),/nan)
  PDF_fg_1x_v2(i,*) = PDF_fg_x(i,*)/(N_i/10.)
endfor

;;;;;;
 
Set_Plot, 'Win'
Device,DeComposed=0
xsize = 600.0
ysize = 1200.0
Window,1,XSize=xsize,YSize=ysize

LoadCT,13
TVLCT,R,G,B,/Get
color_num = fltarr(14)
color_num(0) = 255L
TVLCT,255L,0L,0L,color_num(0)
color_num(1) = 254L
TVLCT,0L,255L,0L,color_num(1)
color_num(2) = 253L
TVLCT,0L,0L,255L,color_num(2)
color_num(3) = 250L
TVLCT,255L,0L,255L,color_num(3)
color_num(4) = 249L
TVLCT,0L,255L,255L,color_num(4)
color_num(5) = 248L
TVLCT,255L,255L,0L,color_num(5)
color_num(6) = 247L
TVLCT,128L,128L,128L,color_num(6)
color_num(7) = 246L
TVLCT,200L,50L,0L,color_num(7)
color_num(8) = 245L
TVLCT,0L,128L,0L,color_num(8)
color_num(9) = 244L
TVLCT,0L,0L,128L,color_num(9)
color_num(10) = 243L
TVLCT,128L,128L,0L,color_num(10)
color_num(11) = 242L
TVLCT,128L,0L,128L,color_num(11)
color_num(12) = 241L
TVLCT,0L,128L,128L,color_num(12)
color_num(13) = 240L
TVLCT,200L,164L,64L,color_num(13)
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-16
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;--
color_bg    = color_white
!p.background = color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background


position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 3
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_subimgs

i_x_SubImg  = 0
i_y_SubImg  = 2
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]

plot_1x=dindgen(7)*2-6
plotsym,0,1,color=color_num(0),/fill
plot,[plot_1x(0)],[PDF_fg_1y(0)],xrange=[-7,7],yrange=[0.0001,1],position=position_subimg,color=color_num(0),psym=8,xstyle=1,/ylog
for i=1,6 do begin
plotsym,0,1,color=color_num(i),/fill
plot,[plot_1x(i)],[PDF_fg_1y(i)],color=color_num(i),xrange=[-7,7],yrange=[0.0001,1],position=position_subimg,psym=8,xstyle=1,/ylog,/noerase
endfor
Plot,[0,1],[0,1],xrange=[-7,7],yrange=[0.0001,1],position=position_subimg,color=color_black,xstyle=1,/ylog,/NoData,/noerase 

i_x_SubImg  = 0
i_y_SubImg  = 1
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]

plot_2x=(dindgen(70)-34.5)/5.
for i=0,6 do begin
plot,plot_2x,PDF_fg_1x_v1(i,*),xrange=[-7,7],yrange=[0.000001,0.1],position=position_subimg,color=color_num(i),xstyle=1,/ylog,/noerase
endfor
Plot,[0,1],[0,1],xrange=[-7,7],yrange=[0.000001,0.1],position=position_subimg,color=color_black,xstyle=1,/ylog,/NoData,/noerase 

i_x_SubImg  = 0
i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]

plot_2x=(dindgen(70)-34.5)/5.
for i=0,6 do begin
plot,plot_2x,PDF_fg_1x_v2(i,*),xrange=[-7,7],yrange=[0.0001,1],position=position_subimg,color=color_num(i),xstyle=1,/ylog,/noerase
endfor
Plot,[0,1],[0,1],xrange=[-7,7],yrange=[0.0001,1],position=position_subimg,color=color_black,xstyle=1,/ylog,/NoData,/noerase 

if slec eq 0 then begin
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_pvi_vs_PDF_line_fg.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif
if slec eq 1 then begin
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_pvi_vs_PDF_line_fh.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif
if slec eq 2 then begin
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_pvi_vs_PDF_line_sg.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif
if slec eq 3 then begin
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'paper3_pvi_vs_PDF_line_sh.png'
Write_PNG, dir_fig+file_fig, image_tvrd
endif

endfor

end


