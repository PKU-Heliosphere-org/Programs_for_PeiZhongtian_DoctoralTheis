Pro Read_Calib_FitsFile_20070114

;Purpose:
;	readout index_before & data_before from level-0 .fits file
;	apply calibration to index_before & data_before, and then get index_after & data_after

;Note:
;	keyword 'XCen/YCen' vary from time to time, which may result in jittering of the movie
;	since the x/y-coordinate of the region are equivalent among the data-files

;a Environment_Setting
setenv,'sot_data_dir=E:\sot_data\'
setenv,'sot_figure_dir=E:\sot_figure\'


Step1:
;=============================
;Step1
;-read out keyword-index & data-array from level-0 .fits file
;-make calibration of the data & keyword by using 'FG_Prep' function
;-supported functions in 'FG_Prep' are as follows:
;-	(1) Dark subtraction
;-		* Bias and dark currents subtraction are applied by taking into account the dependece of CCD and CEB temperatues and exposure duration.
;-	(2) Flat fielding (only for BFI)
;-    	* Wavelength dependence is taken into account (for BFI).
;-    	* Temperature dependence is also taken into account for Red continuum (6683).
;-	(3) CCD readout & bad pixel correction
;-    	* Correction of missing central columns in partial readout
;-		* Correction of the pixel shift from the bottom to the top in full readout
;-    	* Interpolation from surrounding pixels is applied for bad pixels.
;-	(4) Cosmic-ray removal (optional)
;-    	* Despike by a median filtering
;-    	* The procedure tries to fix not only bright spikes but dark spikes.

sub_dir_date= '2007-01-14\'
dir_fits 	= GetEnv('SOT_Data_dir')+sub_dir_date
file_fits	= 'FG*.fits'
file_arr	= File_Search(dir_fits+file_fits,count=num_files)
file_arr	= file_arr(Sort(file_arr))
For i_file=0,num_files-1 Do Begin
	file_fits_tmp	= file_arr(i_file)
	file_fits_tmp	= StrMid(file_fits_tmp, StrLen(dir_fits), StrLen(file_fits_tmp)-StrLen(dir_fits))
	Print, 'i_file, file_name: ', String(i_file), ', ', file_fits_tmp
EndFor
i_file_beg	= 0
i_file_end	= 0
Read, 'i_file_beg: ', i_file_beg
Read, 'i_file_end: ', i_file_end
For i_file=i_file_beg,i_file_end Do Begin

;;--disregard the files of small-size
file_fits_tmp	= file_arr(i_file)
file_info_tmp	= File_Info(file_fits_tmp)
file_size_tmp	= file_info_tmp.size
If file_size_tmp le 2.e6 Then Begin
	Print,'file_size_tmp < 2.e6 bytes !!'
	Goto, Step4
EndIf

Read_SOT, file_fits_tmp, index_before, data_before
FG_Prep, index_before, data_before, index_after, data_after

head_struct	= index_after
data_arr	= data_after


Step2:
;=============================
;Step2
;-retrieve some important keywords from head_struct
;-get 'xaxis/yaxis_vect'
;-save 'head_struct', 'data_arr', 'xaxis/yaxis_vect'

CRPix1	= head_struct.CRPIX1	;x-coordinate of reference pixel in the data
CRPix2	= head_struct.CRPIX2	;y-coordinate of reference pixel in the data
CRVal1	= head_struct.CRVAL1	;x-coordinate of the reference pixel in the heliocentric reference frame
CRVal2	= head_struct.CRVAL2
CDelt1	= head_struct.CDELT1	;pixel-size in the x-direction
CDelt2	= head_struct.CDELT2	;pixel-size in the y-direction
XCen	= head_struct.XCEN		;the heliocentric coordinate of the center of the image
YCen	= head_struct.YCEN
Date_Obs= head_struct.DATE_OBS	;the date and time of image capture for a single filtergram
Wave	= head_struct.WAVE

xpixels	= head_struct.NAXIS1
ypixels	= head_struct.NAXIS2
xaxis_vect	= Findgen(xpixels)*CDelt1 + (CRVal1 - (CRPix1-1)*CDelt1)
yaxis_vect	= Findgen(ypixels)*CDelt2 + (CRVal2 - (CRPix2-1)*CDelt2)
Print, 'xaxis_vect(xpixels/2)-xcen VS. 0.5*cdelt1 (must be equivalent)'
Print, xaxis_vect(xpixels/2)-XCen, 0.5*CDelt1
Print, 'yaxis_vect(ypixels/2)-ycen VS. 0.5*cdelt2 (must be equivalent)'
Print, yaxis_vect(ypixels/2)-YCen, 0.5*CDelt2

dir_save	= GetEnv('SOT_Data_dir')+sub_dir_date
file_save	= StrMid(file_fits_tmp, StrLen(dir_fits), StrLen(file_fits_tmp)-StrLen(dir_fits)-5) + '.sav'
data_descrip= 'got from "Read_Calib_FitsFile_20070319.pro"'
Save,FileName=dir_save+file_save,$
	data_descrip,$
	head_struct, data_arr,$
	xaxis_vect, yaxis_vect


Step3:
;=============================
;Step3
;-TV 'data_before' or 'data_after'

is_TV_after_Calib	= 1
;a Read,'TV filtergram of SOT after Calib (1 for yes, 0 for no)?', is_TV_after_Calib
If is_TV_after_Calib eq 1 Then Begin
	image_TV		= data_after
	have_Calib_str	= '(after_Calib)'
EndIf Else Begin
	image_TV		= data_before
	have_Calib_str	= '(before_Calib)'
EndElse

is_RotateXY			= 1
;a Read, 'Rotate image or not (1 for yes, 0 for no)?', is_RotateXY
If is_RotateXY eq 1 Then Begin
	image_TV		= Rotate(image_TV, 7)	;(x,y)->(x,-y)transpose & rotate counter-clockwise 270 degrees
	yaxis_vect		= Rotate(yaxis_vect,2)
EndIf

is_PS_or_JPEG	= 2
;a Read, 'is_PS_or_JPEG(1 for PS, 2 for JPEG): ', is_PS_or_JPEG
If is_PS_or_JPEG eq 1 Then Begin
	Goto, Step3_1
EndIf Else Begin
If is_PS_or_JPEG eq 2 Then Begin
	Goto, Step3_2
EndIf
EndElse

Step3_1:
Set_Plot,'PS'
dir_fig	= GetEnv('SOT_Figure_Dir')+sub_dir_date
file_fig= StrMid(file_fits_tmp, StrLen(dir_fits), StrLen(file_fits_tmp)-StrLen(dir_fits)-5) + $
			'.' + have_Calib_str+'.eps'
xsize	= 18.
ysize	= 18.
Device,Filename=dir_fig+file_fig,XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul

;;--set the color-table
LoadCT,0
TVLCT,R,G,B,/Get
color_outline	= 255L
TVLCT,0L,0L,0L,color_outline
color_red		= 254L
TVLCT,255L,0L,0L,color_red
num_CB_color= 256-2
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

;;--set position_img
xrange		= [xaxis_vect(0), xaxis_vect(N_Elements(xaxis_vect)-1)]
yrange		= [yaxis_vect(0), yaxis_vect(N_Elements(yaxis_vect)-1)]
half_width_max		= 0.40
winsize_xy_ratio	= xsize/ysize
is_ShiftUpward		= 1
ratio_ShiftUpward	= 0.5
position_img= Fig_Position(xrange,yrange,$
							half_width_max=half_width_max,$
							winsize_xy_ratio=winsize_xy_ratio,$
							is_ShiftUpward=is_ShiftUpWard,$
							ratio_ShiftUpward=ratio_ShiftUpward)

;;--get and TV 'byt_image_TV'
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV))))
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image,Top=num_CB_color-1)
TVImage, byt_image_TV, position=position_img

;;--plot the outline of the image
If is_RotateXY eq 0 Then Begin
	xtitle	= 'x [arcsec]'
	ytitle	= 'y [arcsec]'
EndIf Else Begin
If is_RotateXY eq 1 Then Begin
	xtitle	= 'x [arcsec]'
	ytitle	= 'y [arcsec]'
EndIf
EndElse
title	= 'FG_SOT'+have_Calib_str
Plot, xrange,yrange,Position=position_img,$
		XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
		XTitle=xtitle,YTitle=ytitle,Title=title,$
		/NoData,/NoErase,Color=color_outline

;;--plot the circle with radius equal to 960. radians
num_pnts	= 181
radi_sun	= 959.63
xplot_v1	= Fltarr(num_pnts)+radi_sun
yplot_v1	= Findgen(num_pnts)*(2*!pi/(num_pnts-1))
Plot,/NoErase,/Polar,xplot_v1,yplot_v1,$
	XRange=xrange,YRange=yrange,XStyle=1+4,YStyle=1+4,$
	Position=position_img,Color=color_red,NoClip=0

;;--add annotation
AnnotStr_tmp	= 'got from "Read_Calib_FitsFile_20070319.pro"'
AnnotStr_arr	= [AnnotStr_tmp]
AnnotStr_tmp	= 'Time: '+Date_Obs
AnnotStr_arr	= [AnnotStr_arr,AnnotStr_tmp]
AnnotStr_tmp	= 'Wave: '+Wave
AnnotStr_arr	= [AnnotStr_arr,AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position        = position_img
For i=0,num_strings-1 Do Begin
    position_tmp   = [position(0),position(1)/(num_strings+2)*(i+1)]
    XYOuts,position_tmp(0),position_tmp(1),AnnotStr_arr(i),/Normal,CharSize=0.9,Font=-1
EndFor

Device,/Close

Goto,Step4
Step3_2:
Set_Plot,'Win'
Device,Decomposed=0
dir_fig	= GetEnv('SOT_Figure_Dir')+sub_dir_date
file_fig= StrMid(file_fits_tmp, StrLen(dir_fits), StrLen(file_fits_tmp)-StrLen(dir_fits)-5) + $
			'.'+have_Calib_str+'.png'

;;--set the color-table
LoadCT,0
TVLCT,R,G,B,/Get
color_outline	= 255L
TVLCT,0L,0L,0L,color_outline
color_white		= 254L
TVLCT,255L,255L,255L,color_white
color_red		= 253L
TVLCT,255L,0L,0L,color_red
num_CB_color= 256-3
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B

color_bg		= color_white
!p.background	= color_bg

;;--set window after re-set background-color
WinID	= 1
xsize	= 800.
ysize	= 600.
Window,	WinID, XSize=xsize, YSize=ysize
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData	;change the background


;;--set position_img
xrange		= [xaxis_vect(0), xaxis_vect(N_Elements(xaxis_vect)-1)]
yrange		= [yaxis_vect(0), yaxis_vect(N_Elements(yaxis_vect)-1)]
half_width_max		= 0.40
winsize_xy_ratio	= xsize/ysize
is_ShiftUpward		= 1
ratio_ShiftUpward	= 0.5
position_img= Fig_Position(xrange,yrange,$
							half_width_max=half_width_max,$
							winsize_xy_ratio=winsize_xy_ratio,$
							is_ShiftUpward=is_ShiftUpWard,$
							ratio_ShiftUpward=ratio_ShiftUpward)

;;--get and TV 'byt_image_TV'
image_TV_v2	= image_TV(Sort(image_TV))
min_image	= image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image	= image_TV_v2(Long(0.99*(N_Elements(image_TV))))
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image,Top=num_CB_color-1)
TVImage, byt_image_TV, position=position_img

;;--plot the outline of the image
If is_RotateXY eq 0 Then Begin
	xtitle	= 'x [arcsec]'
	ytitle	= 'y [arcsec]'
EndIf Else Begin
If is_RotateXY eq 1 Then Begin
	xtitle	= 'x [arcsec]'
	ytitle	= 'y [arcsec]'
EndIf
EndElse
title	= 'FG_SOT'+have_Calib_str
Plot, xrange,yrange,Position=position_img,$
		XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
		XTitle=xtitle,YTitle=ytitle,Title=title,$
		/NoData,/NoErase,Color=color_outline

;;--plot the circle with radius equal to 960. radians
num_pnts	= 181
radi_sun	= 959.63
xplot_v1	= Fltarr(num_pnts)+radi_sun
yplot_v1	= Findgen(num_pnts)*(2*!pi/(num_pnts-1))
Plot,/NoErase,/Polar,xplot_v1,yplot_v1,$
	XRange=xrange,YRange=yrange,XStyle=1+4,YStyle=1+4,$
	Position=position_img,Color=color_red,NoClip=0
radi_sun_v1	= 959.63+5.0
xplot_v1	= Fltarr(num_pnts)+radi_sun_v1
yplot_v1	= Findgen(num_pnts)*(2*!pi/(num_pnts-1))
Plot,/NoErase,/Polar,xplot_v1,yplot_v1,$
	XRange=xrange,YRange=yrange,XStyle=1+4,YStyle=1+4,$
	Position=position_img,Color=color_red,NoClip=0
radi_sun_v2	= 959.63+15.0
xplot_v1	= Fltarr(num_pnts)+radi_sun_v2
yplot_v1	= Findgen(num_pnts)*(2*!pi/(num_pnts-1))
Plot,/NoErase,/Polar,xplot_v1,yplot_v1,$
	XRange=xrange,YRange=yrange,XStyle=1+4,YStyle=1+4,$
	Position=position_img,Color=color_red,NoClip=0


;;--add annotation
AnnotStr_tmp	= 'got from "Read_Calib_FitsFile_20070319.pro"'
AnnotStr_arr	= [AnnotStr_tmp]
AnnotStr_tmp	= 'Time: '+Date_Obs
AnnotStr_arr	= [AnnotStr_arr,AnnotStr_tmp]
AnnotStr_tmp	= 'Wave: '+Wave
AnnotStr_arr	= [AnnotStr_arr,AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position        = position_img
For i=0,num_strings-1 Do Begin
    position_tmp   = [position(0),position(1)/(num_strings+2)*(i+1)]
    XYOuts,position_tmp(0),position_tmp(1),AnnotStr_arr(i),/Normal,CharSize=0.9,Font=-1
EndFor

image_tvrd	= TVRD(true=1)
Write_PNG,dir_fig+file_fig,image_tvrd;,True=1
!p.background	= 0




Step4:
;=============================
;Step4

EndFor



End_Program:
End

