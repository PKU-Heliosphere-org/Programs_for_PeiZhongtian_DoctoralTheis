;pro ReadGoesNetCDF


step1:


COMPILE_OPT IDL2

;***** ***** You can change input file designation here and the field_name to use in the example

file_path = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
file_name = file_path + 'g10_xrs_1m_20020501_20020531.nc'

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

time_min = time_tag_array[0]
sub_time = where(time_tag_array le (time_min+2.0+20.0) and time_tag_array ge (time_min+20.0))
time_tag_array = time_tag_array[sub_time]

;***** determine the size of the time_tag_array
size_array = SIZE(time_tag_array)

max_dim = size_array[1]
print, 'Record count =', max_dim
print

;***** get an array containing all data for this field

NCDF_VARGET, fileId, field_name1, xs
NCDF_VARGET, fileId, field_name2, xl


data_array1 = xs
 
data_array2 = xl

;help, "help says ", data_array
data_array1 = data_array1[sub_time]
data_array2 = data_array2[sub_time]

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


position_img  = [0.10,0.10,0.95,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 2
dx_pos_SubImg = (position_img[2]-position_img[0])/num_x_SubImgs
dy_pos_SubImg = (position_img[3]-position_img[1])/num_y_SubImgs

step2:


    i_x_SubImg  = 0
    i_y_SubImg  = 0


 position_SubImg = [position_img[0]+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img[1]+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img[0]+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img[1]+dy_pos_SubImg*(i_y_SubImg+0.85)]

ylog=0
if( strcmp(lin_log1, 'log') ) then begin
  ylog=1
endif
;print, field_name, '.lin_log=', lin_log
;print

;***** generate a plot

date_label = LABEL_DATE(DATE_FORMAT =   ['%Y %M %D %Hh'])

time_tag_array =  time_tag_array
xrange = [ time_tag_array[0], time_tag_array[max_dim-1] ]
yrange = [ nominal_min1, nominal_max1 ]

read,'png(1) eps(2)',is_pe

if is_pe eq 1 then begin
set_plot,'win'
Device,DeComposed=0;, /Retain
  xsize=1200.0 & ysize=720.0
window,1,xsize=xsize,ysize=ysize,Retain=2
endif
if is_pe eq 2 then begin
Set_Plot,'PS'
file_fig= 'Figure0_'+$
        'CME_Height_and_X_ray'+$
        '.eps'
xsize = 24.0
ysize = 14.4
Device, FileName=dir_fig+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
endif


Device, decomposed=1
!p.background = 'FFFFFF'XL
!p.color = '000000'XL

LoadCT,13


plot, time_tag_array, data_array1, /nodata, $
  xrange=xrange, yrange=yrange, xstyle=1, $
  ylog=ylog, charsize = 1, charthick = 1.5, thick = 1.5, $
  MIN_VALUE=yMinValue, $
 ; title = file_name, $
 position =  position_SubImg, $
  xtitle = "UT", $
  ymargin = [9,4], $
 ; ytitle = plot_label1 + "   " + units1, $
  ytitle = 'X-ray'+'  '+'['+units1+']', $
  XTICKFORMAT=['LABEL_DATE'], $
  XTICKUNITS=  ['time']

xyouts,time_tag_array[100],0.001,plot_label1,color = 200,charthick = 1.5
xyouts,time_tag_array[100],0.0001,plot_label2,color = 0,charthick = 1.5
oplot, time_tag_array, data_array1, color = 200,thick = 1.5
oplot, time_tag_array, data_array2, color = 0,thick = 1.5

step3:

    i_x_SubImg  = 0
    i_y_SubImg  = 1


 position_SubImg = [position_img[0]+dx_pos_SubImg*(i_x_SubImg+0.15),$
           position_img[1]+dy_pos_SubImg*(i_y_SubImg+0.15),$
           position_img[0]+dx_pos_SubImg*(i_x_SubImg+0.85),$
           position_img[1]+dy_pos_SubImg*(i_y_SubImg+0.85)]
           
           
yrange = [0.0,30.0]


plot, time_tag_array, data_array1, /nodata, $
  xrange=xrange, yrange=yrange, xstyle=1, $
 ; ylog=ylog, $
  MIN_VALUE=yMinValue, charthick = 1.5, thick = 1.5, $
 ; title = file_name, $
 position =  position_SubImg, $
  xtitle = "UT", $
  ymargin = [9,4], $
 ; ytitle = plot_label1 + "   " + units1, $
  ytitle = 'Heigut'+'  '+'[Rs]', $
  XTICKFORMAT=['LABEL_DATE'], $
  XTICKUNITS=  ['time'],/noerase
oplot,[time_tag_array[0]+0.88,time_tag_array[0]+1.15],[0,30], linestyle = 2, color = 0,thick = 1.5
oplot,[time_tag_array[0]+0.98,time_tag_array[0]+1.17],[0,30], linestyle = 2, color = 200,thick = 1.5
oplot,[time_tag_array[0]+1.13,time_tag_array[0]+1.29],[0,30], linestyle = 0, color = 200,thick = 1.5
xyouts,time_tag_array[100],26,'EAST',color = 0,charthick = 1.5
xyouts,time_tag_array[100],23,'WEST',color = 200,charthick = 1.5
oplot,[time_tag_array[0]+1.4,time_tag_array[0]+1.6],[10,10], linestyle = 0, color = 0,thick = 1.5
oplot,[time_tag_array[0]+1.4,time_tag_array[0]+1.6],[5,5], linestyle = 2, color = 0,thick = 1.5
xyouts,time_tag_array[0]+1.64,10,'HALO',charthick = 1.5
xyouts,time_tag_array[0]+1.64,5,'W'+textoidl('\geq')+'120',charthick = 1.5

if is_pe eq 1 then begin
file_fig= 'Figure0_'+$
        'CME_Height_and_X_ray'+$
;        file_version+$
        '.png'
FileName=file_path+file_fig
image_tvrd  = TVRD(true=1)
Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
endif
if is_pe eq 2 then begin
Device,/Close 
endif
NCDF_CLOSE, fileId



END
