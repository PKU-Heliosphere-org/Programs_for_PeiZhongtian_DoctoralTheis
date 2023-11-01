;pro plot_figure0_new



dir_path     = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'


position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs

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


Set_Plot,'PS'
file_fig= 'Figure0'+$
        '_new'+$
        '.eps'
xsize = 24.0
ysize = 24.0
Device, FileName=dir_path+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul


step1:;pro pfss_plot_hu_v3

    i_x_SubImg  = 0
    i_y_SubImg  = 1

position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)] 
           
num_x_SubsubImgs = 2
num_y_SubsubImgs = 1
dx_pos_SubsubImg = (position_subimg(2)-position_subimg(0))/num_x_SubsubImgs
dy_pos_SubsubImg = (position_subimg(3)-position_subimg(1))/num_y_SubsubImgs


    i_x_SubsubImg  = 0
    i_y_SubsubImg  = 0

position_SubsubImg = [position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.05),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.05),$
           position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.95),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.95)]



file_jpg='2002_05_22_00_26_30_EIT_195__LASCO_C2.png'
dir_fig = dir_path
filename = dir_fig+file_jpg


image_C2 = read_image(filename)

;Device, decomposed=0
;loadct,0
;tVimage,BYTSCL(image_C2)
image_size = size(image_C2)
print,image_size

image_C2 = image_C2(*,round(1/3.*image_size(2)):round(2/3.*image_size(2)),46:(round(1/3.*image_size(2))+47))

print,size(image_C2)

;Set_Plot,'PS'
;filename= dir_fig+'eit.eps'
;xsize = 20.0
;ysize = 20.0
;Device, decomposed=0;FileName=filename, XSize=xsize,YSize=ysize ,decomposed=0;,/color

;loadct,0

TVimage,BYTSCL(image_C2),position = position_SubsubImg
;Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,position = position_SubsubImg/NoData
xyouts,0.125,0.91,'(a)',charsize=1.2,charthick = 4;,color = 0
xyouts,0.175,0.61,'EIT 195:2002-5-22 00:24:10',charsize=0.8,charthick = 2,color = color_white
xyouts,0.175,0.59,'LASCO-C2:2002-5-22 00:26:05',charsize=0.8,charthick = 2,color = color_white




    i_x_SubsubImg  = 1
    i_y_SubsubImg  = 0

position_SubsubImg = [position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.05),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.05),$
           position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.95),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.95)]



file_jpg='2002_05_22_04_00_30_EIT_195__LASCO_C2.png'
dir_fig = dir_path
filename = dir_fig+file_jpg


image_C2 = read_image(filename)

;Device, decomposed=0
;loadct,0
;tVimage,BYTSCL(image_C2)
image_size = size(image_C2)
print,image_size

image_C2 = image_C2(*,round(1/3.*image_size(2)):round(2/3.*image_size(2)),46:(round(1/3.*image_size(2))+47))

print,size(image_C2)

;Set_Plot,'PS'
;filename= dir_fig+'eit.eps'
;xsize = 20.0
;ysize = 20.0
;Device, decomposed=0;FileName=filename, XSize=xsize,YSize=ysize ,decomposed=0;,/color

;loadct,0

TVimage,BYTSCL(image_C2),position = position_SubsubImg
;Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,position = position_SubsubImg/NoData
xyouts,0.51,0.91,'(b)',charsize=1.2,charthick = 4;,color = 0
xyouts,0.56,0.61,'EIT 195:2002-5-22 04:00:11',charsize=0.8,charthick = 2,color = color_white
xyouts,0.56,0.59,'LASCO-C2:2002-5-22 04:06:05',charsize=0.8,charthick = 2,color = color_white



;step3:



;COMPILE_OPT IDL2

;***** ***** You can change input file designation here and the field_name to use in the example

;file_path = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
file_name = dir_path + 'g10_xrs_1m_20020501_20020531.nc'

;file_url = "http://satdat.ngdc.noaa.gov/sem/goes/data/new_full/2011/05/goes15/netcdf/g15_xrs_2s_20110509_20110509.nc"

field_name1 = 'xs';'xl'
field_name2 = 'xl';'xl'
;***** *****

print
print, '***** ReadGOESNetCDF says '
print, '***** file_name =', file_name
print, '***** field_name = ', field_name1
print, '***** field_name = ', field_name2
print

;***** Open the NetCDF file

fileId = NCDF_OPEN(file_name)


;***** get an array containing all time_tag values

NCDF_VARGET, fileId, 'time_tag', time_tag_array

;help, time_tag_array



;***** convert time_tag_array to julian day

time_tag_array = JULDAY(1, 1, 1970, 0, 0, time_tag_array/1000.0)
help, time_tag_array

;print, 'time_tag_array[0] =', convertJulianToString(time_tag_array[0])
;print, 'time_tag_array[', max_dim-1, '] =', convertJulianToString(time_tag_array[max_dim-1])
;print

time_min = time_tag_array(0)
sub_time = where(time_tag_array le (time_min+2.0+20.0) and time_tag_array ge (time_min+20.0))
time_tag_array = time_tag_array(sub_time)

;***** determine the size of the time_tag_array
size_array = SIZE(time_tag_array)

max_dim = size_array(1)
print, 'Record count =', max_dim
print

;***** get an array containing all data for this field

NCDF_VARGET, fileId, field_name1, xs
NCDF_VARGET, fileId, field_name2, xl


data_array1 = xs
 
data_array2 = xl

;help, "help says ", data_array
data_array1 = data_array1(sub_time)
data_array2 = data_array2(sub_time)

;print, 'data_array[0] =', data_array[0]
;print, 'data_array[', max_dim-1, '] =', data_array[max_dim-1]
;print

;***** get a few attributes for this variable

NCDF_ATTGET, fileId, field_name1, 'description', description1
NCDF_ATTGET, fileId, field_name1, 'plot_label', plot_label1
NCDF_ATTGET, fileId, field_name1, 'units', units1
NCDF_ATTGET, fileId, field_name1, 'nominal_min', nominal_min1
NCDF_ATTGET, fileId, field_name1, 'nominal_max', nominal_max1
NCDF_ATTGET, fileId, field_name1, 'lin_log', lin_log1
NCDF_ATTGET, fileId, field_name1, 'missing_value', missing_value1

NCDF_ATTGET, fileId, field_name2, 'description', description2
NCDF_ATTGET, fileId, field_name2, 'plot_label', plot_label2
NCDF_ATTGET, fileId, field_name2, 'units', units2
;NCDF_ATTGET, fileId, field_name2, 'nominal_min', nominal_min2
;NCDF_ATTGET, fileId, field_name2, 'nominal_max', nominal_max2
NCDF_ATTGET, fileId, field_name2, 'lin_log', lin_log2
NCDF_ATTGET, fileId, field_name2, 'missing_value', missing_value2

;print, field_name, '.description=', string(description)
plot_label1 = string(plot_label1)
units1 = string(units1)
nominal_min1 = float( string(nominal_min1) )
nominal_max1 = float( string(nominal_max1) )
missing_value1 = long( string(missing_value1) )
yMinValue1 = missing_value1 + 1

plot_label2 = string(plot_label2)
units2 = string(units2)
;nominal_min2 = float( string(nominal_min2) )
;nominal_max2 = float( string(nominal_max2) )
missing_value2 = long( string(missing_value2) )
yMinValue2 = missing_value2 + 1



    i_x_SubImg  = 0
    i_y_SubImg  = 0


 position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.05),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.05),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.95),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.95)]
           
num_x_SubsubImgs = 1
num_y_SubsubImgs = 2
dx_pos_SubsubImg = (position_subimg(2)-position_subimg(0))/num_x_SubsubImgs
dy_pos_SubsubImg = (position_subimg(3)-position_subimg(1))/num_y_SubsubImgs           

           
    i_x_SubsubImg  = 0
    i_y_SubsubImg  = 0

position_SubsubImg = [position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.05),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg-0.05),$
           position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.95),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.85)]           
           
  

ylog=0
if( strcmp(lin_log1, 'log') ) then begin
  ylog=1
endif
;print, field_name, '.lin_log=', lin_log
;print

;***** generate a plot

date_label = LABEL_DATE(DATE_FORMAT =   ['%Y %M %D %Hh'])

time_tag_array =  time_tag_array
xrange = [ time_tag_array(0), time_tag_array(max_dim-1) ]
yrange = [ nominal_min1, nominal_max1 ]

;read,'png(1) eps(2)',is_pe

;if is_pe eq 1 then begin
;set_plot,'win'
;Device,DeComposed=0;, /Retain
;  xsize=1200.0 & ysize=720.0
;window,1,xsize=xsize,ysize=ysize,Retain=2
;endif
;if is_pe eq 2 then begin
;Set_Plot,'PS'
;file_fig= 'Figure0_'+$
;        'CME_Height_and_X_ray'+$
;        '.eps'
;xsize = 24.0
;ysize = 14.4
;Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
;endif


;Device, decomposed=1
;!p.background = 'FFFFFF'XL
;!p.color = '000000'XL

LoadCT,13
;;;;

xplot_vect  = time_tag_array
yplot_vect  =  data_array1
JulDay_beg_plot = Min(time_tag_array)
JulDay_end_plot = Max(time_tag_array)
;xrange  = [JulDay_beg_plot, JulDay_end_plot]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
;xticknames  = Replicate(' ', N_Elements(xticknames))
xminor  = xminor_time
;xminor    = 6
;yrange    = [0,0.05];[Min(yplot_vect),Max(yplot_vect)]
;yrange    = [yrange(0)-0.5*(yrange(1)-yrange(0)), yrange(1)+0.7*(yrange(1)-yrange(0))]
xtitle    = ' '
ytitle    = 'X-ray'+'  '+'['+units1+']'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subsubimg,/nodata, $
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,ylog=ylog,$
  Color=0,$
  /NoErase,Font=-1, $
  XThick=2,YThick=2,CharSize=1,CharThick=2,Thick=2
  
  dypos_xyouts  = 0.05
  color_xyouts=0 & charsize_xyouts=1 & charthick_xyouts=2
 xyouts_DateStr_at_XAxis_Bottom, $
    xrange, position_subsubimg, $
    dypos_xyouts=dypos_xyouts, $
    color=color_xyouts, charsize=charsize_xyouts, charthick=charthick_xyouts
;;;;
;plot, time_tag_array, data_array1, /nodata, $
;  xrange=xrange, yrange=yrange, xstyle=1, $
;  ylog=ylog, charsize = 1, charthick = 1.5, thick = 1.5, $
;  MIN_VALUE=yMinValue, $
; ; title = file_name, $
; position =  position_SubsubImg, $
;  xtitle = "UT", $
;  ymargin = [9,4], $
; ; ytitle = plot_label1 + "   " + units1, $
;  ytitle = 'X-ray'+'  '+'['+units1+']', $
;  XTICKFORMAT=['LABEL_DATE'], $
;  XTICKUNITS=  ['time'],/noerase
xyouts,time_tag_array(0)-320*(time_tag_array(1)-time_tag_array(0)),0.0005,'(d)',color = 0,charsize=1.2,charthick = 4
xyouts,time_tag_array(100),0.0001,plot_label1,color = 256,charthick = 2
xyouts,time_tag_array(100),0.00001,plot_label2,color = 0,charthick = 2
oplot, time_tag_array, data_array1, color = 256,thick = 2
oplot, time_tag_array, data_array2, color = 0,thick = 2

;step3:

            
    i_x_SubsubImg  = 0
    i_y_SubsubImg  = 1

position_SubsubImg = [position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.05),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.05),$
           position_subimg(0)+dx_pos_SubsubImg*(i_x_SubsubImg+0.95),$
           position_subimg(1)+dy_pos_SubsubImg*(i_y_SubsubImg+0.95)]   
           
           
yrange = [0.0,30.0]


;plot, time_tag_array, data_array1, /nodata, $
;  xrange=xrange, yrange=yrange, xstyle=1, $
; ; ylog=ylog, $
;  MIN_VALUE=yMinValue, charthick = 1.5, thick = 1.5, $
; ; title = file_name, $
; position =  position_SubsubImg, $
;  xtitle = "UT", $
;  ymargin = [9,4], $
; ; ytitle = plot_label1 + "   " + units1, $
;  ytitle = 'Heigut'+'  '+'[Rs]', $
;  XTICKFORMAT=['LABEL_DATE'], $
;  XTICKUNITS=  ['time'],/noerase

Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subsubimg,/nodata, $
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  YTitle='Heigut'+'  '+'[Rs]',$
  Color=0,$
  /NoErase,Font=-1, $
  XThick=2,YThick=2,CharSize=1,CharThick=2,Thick=2
  
  
oplot,[time_tag_array(0)+0.88,time_tag_array(0)+1.15],[0,30], linestyle = 0, color = 0,thick = 1.5
oplot,[time_tag_array(0)+0.98,time_tag_array(0)+1.17],[0,30], linestyle = 0, color = 256,thick = 1.5
oplot,[time_tag_array(0)+1.13,time_tag_array(0)+1.29],[0,30], linestyle = 2, color = 256,thick = 1.5
xyouts,time_tag_array(100),26,'EAST',color = 0,charthick = 1.5
xyouts,time_tag_array(100),23,'WEST',color = 256,charthick = 1.5
oplot,[time_tag_array(0)+1.4,time_tag_array(0)+1.6],[10,10], linestyle = 2, color = 0,thick = 1.5
oplot,[time_tag_array(0)+1.4,time_tag_array(0)+1.6],[5,5], linestyle = 0, color = 0,thick = 1.5
xyouts,time_tag_array(0)+1.64,10,'HALO',charthick = 1.5
xyouts,time_tag_array(0)+1.64,5,'W'+textoidl('\geq')+'120',charthick = 1.5
xyouts,time_tag_array(0)-320*(time_tag_array(1)-time_tag_array(0)),26,'(c)',color = 0,charsize=1.2,charthick = 4

;if is_pe eq 1 then begin
;file_fig= 'Figure0_'+$
;        'CME_Height_and_X_ray'+$
;;        file_version+$
;        '.png'
;FileName=file_path+file_fig
;image_tvrd  = TVRD(true=1)
;Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
;endif
;if is_pe eq 2 then begin
;Device,/Close 
;endif
NCDF_CLOSE, fileId











Device,/close

end





