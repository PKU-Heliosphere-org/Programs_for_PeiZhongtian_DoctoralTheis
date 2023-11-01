;Pro Section_for_Compare_FFT_and_Wavelet_Result

;Note:
;	it is not a complete program,
;	just to show how to compare the results from FFT and wavelet

;========
Step6:
;Step6

;;--
dtime		= (JulDay_vect_TV(1)-JulDay_vect_TV(0))*24.*60.
time_vect	= (JulDay_vect_TV-JulDay_vect_TV(0))*24.*60.
ntime		= N_Elements(time_vect)
For i_ypos=0,num_ypos-1 Do Begin
	ypos_tmp	= ypos_vect(i_ypos)
;a	wave_vect	= dVelo_ypos_arr(*,i_ypos)
	wave_vect	= dLI_ypos_arr(*,i_ypos)
	ypos_str	= String(ypos_tmp,Format='(F5.1)')
;a	wave_str	= 'dVelo'
	wave_str	= 'dLI'

;;--
num_sets	= 1
type_window	= 1
get_PSD_from_FFT_Method, time_vect, wave_vect, $
		num_sets=num_sets, type_window=type_window, $
		freq_vect_FFT, PSD_vect_FFT

;;--compute the confidence interval of PSD of defined confidence level
num_times_PerSet= num_times/num_sets
DegreeFreedom	= num_sets;num_sets
ConfidenceLevel	= 0.60
get_ConfidenceInterval_of_PSD, DegreeFreedom, ConfidenceLevel, dlg_PSD

;;--
WaveLetCoeff_arr 	= WAVELET(wave_vect,dtime,PERIOD=period_vect,Scale=scale_vect,COI=coi_vect,/PAD,SIGNIF=signif_arr)
nscale  = N_ELEMENTS(period_vect)
WaveLetPSD_arr  	= Abs(WaveLetCoeff_arr)^2						;unit: nT^2
WaveLetPSD_arr		= WaveLetPSD_arr*dtime							;unit: nT^2/Hz
PSD_vect_wavlet		= 1*Total(WaveLetPSD_arr,1)/ntime				;unit: nT^2/Hz
freq_vect_wavlet	= 1./period_vect
period_vect_wavlet	= period_vect

;;--
dof = ntime - scale_vect   ; the -scale corrects for padding at edges
sig_test	= 1
sig_level	= 0.95
global_signif 	= WAVE_SIGNIF(wave_vect,dtime,scale_vect,sig_test, $
					SIGLVL=sig_level, LAG1=0.0,DOF=dof,MOTHER='Morlet',$
					CDELTA=Cdelta,PSI0=psi0)
global_signif	= global_signif*dtime

;;--
PSD_vect_FFT_v2	= Interpol(PSD_vect_FFT, freq_vect_FFT, freq_vect_wavlet)

;;--
Set_Plot,'WIN'
Device,DeComposed=0
Window,1,XSize=900,YSize=600

LOADCT,39
TVLCT,R,G,B,/Get
num_CB_color    = 256L-2
R(0:num_CB_color-1) = Congrid(R(0:254),num_CB_color)
G(0:num_CB_color-1) = Congrid(G(0:254),num_CB_color)
B(0:num_CB_color-1) = Congrid(B(0:254),num_CB_color)
TVLCT,R,G,B
color_black   	= 255L
color_white     = 254L
TVLCT,0L,0L,0L,color_black
TVLCT,255L,255L,255L,color_white

color_bg		= color_white
!p.background	= color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData	;change the background

;;--
position_plot   = [0.15,0.65,0.65,0.95]
xrange  = [Min(JulDay_vect_TV),Max(JulDay_vect_TV)]
yrange  = [Min(wave_vect),Max(wave_vect)]
;;;---
xrange_time	= xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv		= xtickv_time
xticks		= N_Elements(xtickv)-1
xticknames	= Replicate(' ', xticks+1)
xminor		= xminor_time
;;;---
;a Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1+4,YStyle=1+4,$
;a	XTick_Get=xtickv_vect, /NoData
Plot,JulDay_vect_TV,wave_vect,Thick=2.0,XTitle=' ',YTitle=' ',Title=wave_str+'(y='+ypos_str+')', $
    Position=position_plot,$
	XTicks=xticks, XTickName=xticknames, XTickV=xtickv_time, XMinor=xminor, $
    XRange=xrange,XStyle=1,YRange=yrange,YStyle=1,$
    Color=color_black,/NoErase

;;--
image_CONT      = WaveLetPSD_arr
image_CONT_v2   = image_CONT(Sort(image_CONT))
min_image       = image_CONT_v2(Long(0.01*(N_Elements(image_CONT))))
max_image       = image_CONT_v2(Long(0.99*(N_Elements(image_CONT))))
byt_image_CONT  = BytSCL(image_CONT,min=min_image,max=max_image,Top=num_CB_color-1)
level_vect      = Bindgen(num_CB_color)
c_color_vect    = Bindgen(num_CB_color)

xrange  = [Min(JulDay_vect_TV),Max(JulDay_vect_TV)]
yrange  = [Min(period_vect),Max(period_vect)]
position_contour    = [0.15,0.2,0.65,0.55]

title	= wave_str+'(y='+ypos_str+')'
CONTOUR,byt_image_CONT,JulDay_vect_TV,period_vect, $
    Position=position_contour,/NoErase,$
    XRange=xrange,XSTYLE=1,XTITLE='Time',YTITLE='Period [min]',TITLE=' ', $
    YRANGE=[Min(period_vect),Max(period_vect)],YStyle=1, $   ;*** Large-->Small period
    /YLog, $                             ;*** make y-axis logarithmic
    Levels=level_vect,C_Colors=c_color_vect,/FILL,$
    XTickLen=-0.02,YTickLen=-0.02, $
	XTicks=xticks, XTickName=xticknames_time, XTickV=xtickv_time, XMinor=xminor

signif_arr = REBIN(TRANSPOSE(signif_arr),ntime,nscale)
CONTOUR,ABS(WaveLetCoeff_arr)^2/signif_arr,JulDay_vect_TV,period_vect, $
           /OVERPLOT,LEVEL=1.0,C_ANNOT='95%',C_Colors=color_white

PLOTS,JulDay_vect_TV,coi_vect,NOCLIP=0,$   ;*** anything "below" this line is dubious
		Color=color_white
PolyFill,[JulDay_vect_TV,Max(JulDay_vect_TV),Min(JulDay_vect_TV)],$
       	[coi_vect,Max(period_vect),Max(period_vect)],/Line_Fill,Orientation=60,$
       	Color=color_white

;;;---TV colorbar
position_CB = [position_contour(0),$
                position_contour(3)+0.01,$
                position_contour(2),$
                position_contour(3)+0.01+0.015]
num_ticks       = 5
num_divisions   = num_ticks-1
val_min_CB      = min_image
val_max_CB      = max_image
tickv_CB        = val_min_CB+(val_max_CB-val_min_CB)/(num_ticks-1)*Findgen(num_ticks)
tickn_CB       	= String(tickv_CB,format='(f8.3)')
titleCB         = 'WaveLetPSD'
ColorBar,Position=position_CB,NColors=num_CB_color,/Horizontal,$
    Title=titleCB,$
    CharSize=0.9,Top=1,Font=-1,$
    Color=color_black,$
    divisions=num_divisions,TickNames=tickn_CB

position_plot   = [0.67,0.20,0.95,0.55]
xrange	= [Min([ALog10(Reverse(PSD_vect_wavlet)), ALog10(Reverse(PSD_vect_FFT))]), $
		   Max([ALog10(Reverse(PSD_vect_wavlet)), ALog10(Reverse(PSD_vect_FFT))])]
Plot,ALog10(Reverse(PSD_vect_wavlet)),Reverse(period_vect_wavlet),$
	YRange=yrange,XRange=xrange, XStyle=1+4,YStyle=1+4,XLog=0,/YLog,$
	XTick_Get=XTickV_vect,YTick_Get=YTickV_vect,$
    Position=position_plot,/NoErase,Color=color_black, Thick=2.0
Plot,ALog10(Reverse(PSD_vect_FFT_v2)),Reverse(period_vect_wavlet),$
	YRange=yrange,XRange=xrange, XStyle=1+4,YStyle=1+4,XLog=0,/YLog,$
	XTick_Get=XTickV_vect,YTick_Get=YTickV_vect,$
    Position=position_plot,/NoErase,LineStyle=2,Color=color_black, Thick=2.0
Plot,ALog10(Reverse(PSD_vect_wavlet)),Reverse(period_vect_wavlet),$
	YRange=yrange,XRange=xrange, XStyle=1,YStyle=1,XLog=0,/YLog,$
	YTickName=Replicate(' ', N_Elements(YTickV_vect)),$
	Thick=2.0,XTitle='lg10(PSD)',YTitle=' ',$
	Title='',$
    Position=position_plot,/NoErase,/NoData,Color=color_black
Plots, ALog10(Reverse(global_signif)),Reverse(period_vect_wavlet), $
	LineStyle=1, Color=color_black, Thick=2.0
XYOuts_str	= String(sig_level*100, format='(I2.2)')+'%'
XYOuts, ALog10(global_signif(2)), period_vect_wavlet(2), XYOuts_str, CharSize=1.1, CharThick=1.5
;;;---
x_CI_min	= xrange(0) + 0.2*(xrange(1)-xrange(0))
x_CI_max	= x_CI_min + dlg_PSD
y_CI		= yrange(0) + 0.2*(yrange(1)-yrange(0))
Arrow, x_CI_min+0.5*(x_CI_max-x_CI_min), y_CI, x_CI_min, y_CI, Color=color_black, /Data
Arrow, x_CI_min+0.5*(x_CI_max-x_CI_min), y_CI, x_CI_max, y_CI, Color=color_black, /Data

;;--xyout some annotation
AnnotStr_tmp 	= "Got from 'get_LinePara_arr_after_Subtract_TimeAverage_20070201.pro'"
AnnotStr_arr	= [AnnotStr_tmp]
AnnotStr_tmp	= title
AnnotStr_arr	= [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position        = position
For i=0,num_strings-1 Do Begin
    position_tmp   = [position_contour(0),position_contour(1)/(num_strings+2)*(i+1)]
    XYOuts,position_tmp(0),position_tmp(1),AnnotStr_arr(i),/Normal,CharSize=0.8,Font=-1
EndFor

;;--
image_tvrd		= TVRD(true=1)
dir_fig			= GetEnv('EIS_Figure_Dir')+sub_dir_date
file_fig		= 'wavlet('+wave_str+')(y='+ypos_str+')'+$
					'('+line_name+')'+$
					file_version+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd
;;--
!p.background	= color_bg


;===============
Step6_2:
;Step6_2

;;--
Set_Plot,'WIN'
Device,DeComposed=0
Window,1,XSize=900,YSize=600

LOADCT,39
TVLCT,R,G,B,/Get
num_CB_color    = 256L-2
R(0:num_CB_color-1) = Congrid(R(0:254),num_CB_color)
G(0:num_CB_color-1) = Congrid(G(0:254),num_CB_color)
B(0:num_CB_color-1) = Congrid(B(0:254),num_CB_color)
TVLCT,R,G,B
color_black   	= 255L
color_white     = 254L
TVLCT,0L,0L,0L,color_black
TVLCT,255L,255L,255L,color_white

color_bg		= color_white
!p.background	= color_bg
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData	;change the background

;;--
position_plot	= [0.10,0.15,0.90,0.95]
xplot_vect	= freq_vect_FFT
yplot_vect	= PSD_vect_FFT
xrange	= [Min(xplot_vect), Max(xplot_vect)]
yrange	= [Min(yplot_vect), Max(yplot_vect)]
xtitle	= 'freq [Hz]'
ytitle	= 'PSD'
;;;---
Plot, xplot_vect, yplot_vect, Position=position_plot, $
	XRange=xrange, YRange=yrange, XStyle=1, YStyle=1, $
	XTitle=xtitle, YTitle=ytitle

;;--xyout some annotation
AnnotStr_tmp 	= "Got from 'get_LinePara_arr_after_Subtract_TimeAverage_20070201.pro'"
AnnotStr_arr	= [AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
position        = position
For i=0,num_strings-1 Do Begin
    position_tmp   = [position_contour(0),position_contour(1)/(num_strings+2)*(i+1)]
    XYOuts,position_tmp(0),position_tmp(1),AnnotStr_arr(i),/Normal,CharSize=0.8,Font=-1
EndFor

;;--
image_tvrd		= TVRD(true=1)
dir_fig			= GetEnv('EIS_Figure_Dir')+sub_dir_date
file_fig		= 'FFT('+wave_str+')(y='+ypos_str+')'+$
					'('+line_name+')'+$
					file_version+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd
;;--
!p.background	= color_bg


EndFor	;For i_ypos=0,num_ypos-1 Do Begin