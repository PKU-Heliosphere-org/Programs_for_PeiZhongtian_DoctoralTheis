;Pro Read_elpd_3dp_WIND_CDF_19950131

year_str  = '2005'
mon_str   = '12'
day_str1   = '24'
sub_dir_date= $
;              year_str+'/'+$
              year_str+'-'+mon_str+'-'+day_str1+'\'
WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\He\' + sub_dir_date  ;+TimeRange_str
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\He\' + sub_dir_date ;+TimeRange_str
SetEnv, WIND_Data_Dir
SetEnv, WIND_Figure_Dir


Step1:
;===========================
;Step1:
day_str = '23'
;;--
dir_read	= GetEnv('WIND_Data_Dir')
file_read	= 'wi_elpd_3dp_200512'+day_str+'_v0?.cdf'
file_array	= File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
Read, 'i_select: ', i_select
file_read	= file_array(i_select)
file_read	= StrMid(file_read, StrLen(dir_read), StrLen(file_read)-StrLen(dir_read))

;;--
CD, Current=wk_dir
CD, dir_read
cdf_id	= CDF_Open(file_read)
;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch	;as r-variable
;a num_records	= Info_Epoch.MaxAllocRec
num_records		= Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'ENERGY', Ener_arr, Rec_Count=num_records ;, /ZVariable ;unit: eV
CDF_VarGet, cdf_id, 'PANGLE', PitchAng_arr, Rec_Count=num_records ;unit: degree
CDF_VarGet, cdf_id, 'FLUX', Flux_arr, Rec_Count=num_records ;, /ZVariable ;unit: 1/cm^2/sr/s/eV


;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_vect	= Reform(Epoch_vect)
epoch_beg	= Epoch_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
			/Breakdown_Epoch
JulDay_beg	= JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_vect	= JulDay_beg+(Epoch_vect-Epoch_beg)/(1.e3*24.*60.*60.)

;;--
Flux_arr  = Transpose(Flux_arr, [1,0,2])  ;from [ener,ang,time] to [ang,ener,time]


Step2:
;===========================
;Step2:

;;--
num_times = N_Elements(JulDay_vect)
dJulDay_mean  = Mean(JulDay_vect(1:num_times-1) - JulDay_vect(0:num_times-2), /Double, /NaN)
JulDay_min_plot = Min(JulDay_vect,/NaN) - 0.5*dJulDay_mean
JulDay_max_plot = Max(JulDay_vect,/NaN) + 0.5*dJulDay_mean
dJulDay_plot  = dJulDay_mean / 5
num_times_plot= Round((JulDay_max_plot - JulDay_min_plot) / dJulDay_plot, /L64)
JulDay_vect_plot  = (JulDay_min_plot + 0.5*dJulDay_plot) + Dindgen(num_times_plot)*dJulDay_plot

;;--
num_angles  = (Size(PitchAng_arr))[1]
dPitchAng_mean  = 180. / num_angles
dPitchAng_plot  = dPitchAng_mean / 5
num_angles_plot = Round(180./dPitchAng_plot, /L64)
PitchAng_vect_plot  = (0.0+0.5*dPitchAng_plot) + Dindgen(num_angles_plot)*dPitchAng_plot
num_eners_plot= (Size(Ener_arr))[1]
Flux_arr_plot = Fltarr(num_angles_plot,num_eners_plot,num_times_plot)

;;--
For i_time=0,num_times_plot-1 Do Begin
For i_ang=0,num_angles_plot-1 Do Begin
  JulDay_tmp    = JulDay_vect_plot(i_time)
  PitchAng_tmp  = PitchAng_vect_plot(i_ang)
  dJulDay_tmp   = Min(Abs(JulDay_vect-JulDay_tmp), sub_JulDay)
  If (dJulDay_tmp gt dJulDay_mean) Then Begin
    Flux_arr_plot(*,*,i_time) = !values.f_nan
  EndIf Else Begin  
    dPitchAng_tmp = Min(Abs(Reform(PitchAng_arr(*,sub_JulDay))-PitchAng_tmp), sub_PitchAng)
    Flux_arr_plot(i_ang,*,i_time) = Flux_arr(sub_PitchAng,*,sub_JulDay)
  EndElse     
EndFor
EndFor


Step3:
;===========================
;Step3:

;;--
dir_save	= GetEnv('WIND_Data_Dir')
file_save	= StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Read_elpd_3dp_WIND_CDF_20000608.pro"'
data_descrip_v2 = 'unit: Flux [1/cm^2/s/sr/eV], Energy [eV]'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	data_descrip_v2, $
	JulDay_vect, Ener_arr, PitchAng_arr, Flux_arr, $
	JulDay_vect_plot, PitchAng_vect_plot, Flux_arr_plot

; Note: sequence order stored in the tensor 
; vv_uniq  = [0,4,8,1,2,5]           ; => Uniq elements of a symmetric 3x3 matrix
; vv_trace = [0,4,8]                 ; => diagonal elements of a 3x3 matrix	


		
Step4:
;===========================
;Step4:

;;--
num_times_plot = N_Elements(JulDay_vect_plot)
Ener_vect = Reform(Ener_arr(*,0))
num_eners = N_Elements(Ener_vect)

;;--
year=Float(year_str) & month=Float(mon_str) & day=Float(day_str)
JulDay_beg_plot = JulDay(month, day, year, 0.0, 0.0, 0.0)
JulDay_end_plot = JulDay(month, day, year, 23.0, 59.0, 0.0)
sub_beg = Where(JulDay_vect_plot ge JulDay_beg_plot)
sub_beg = sub_beg(0)
sub_end = Where(JulDay_vect_plot le JulDay_end_plot)
sub_end = sub_end(N_Elements(sub_end)-1)
sub_time_beg=sub_beg & sub_time_end=sub_end
JulDay_vect_plot_v2   = JulDay_vect_plot(sub_time_beg:sub_time_end)

ener_min_plot = 20.0 ;unit: eV
ener_max_plot = 1200.0 ;unit: eV
ener_ascend_vect  = Ener_vect(Sort(Ener_vect))
sub_ener_min  = Where(ener_ascend_vect ge ener_min_plot)
sub_ener_min  = sub_ener_min(0)
sub_ener_max  = Where(ener_ascend_vect le ener_max_plot)
sub_ener_max  = sub_ener_max(N_Elements(sub_ener_max)-1)
num_eners_plot_v2 = sub_ener_max - sub_ener_min + 1
ener_vect_plot_v2 = ener_ascend_vect(sub_ener_min:sub_ener_max)


Flux_arr_plot_v2  = Flux_arr_plot(*,Sort(Ener_vect),*)
Flux_arr_plot_v2  = Flux_arr_plot_v2(*,sub_ener_min:sub_ener_max,sub_time_beg:sub_time_end)


;;--
num_times_plot_v2 = N_Elements(JulDay_vect_plot_v2)
dJulDay_vect_v2  = JulDay_vect_plot_v2(1:num_times_plot_v2-1) - JulDay_vect_plot_v2(0:num_times_plot_v2-2)
dTime_vect_v2    = dJulDay_vect_v2 * (24.*60.*60)

;;--
JulDay_beg_plot_v2 = Min(JulDay_vect_plot_v2)
JulDay_end_plot_v2 = Max(JulDay_vect_plot_v2)
CalDat, JulDay_beg_plot_v2, mon_beg_plot, day_beg_plot, year_beg_plot, hour_beg_plot, min_beg_plot, sec_beg_plot
CalDat, JulDay_end_plot_v2, mon_end_plot, day_end_plot, year_end_plot, hour_end_plot, min_end_plot, sec_end_plot
TimeRange_plot_str  = '(time='+$
                      String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')+'-'+$
                      String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')+')'
date_str  = '(day='+$
              String(year_beg_plot,format='(I4.4)')+String(mon_beg_plot,format='(I2.2)')+String(day_beg_plot,format='(I2.2)')+')'


Step5:
;===========================
;Step5:
;
;;--
Set_Plot, 'win'
Device,DeComposed=0;, /Retain
xsize=1000.0 & ysize=800.0
Window,2,XSize=xsize,YSize=ysize,Retain=2

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

thick   = 1.5
xthick  = 1.5
ythick  = 1.5
charthick = 1.5
charsize  = 1.2

;;--
position_img  = [0.05,0.05,0.95,0.95]
num_subimgs_x = 1
num_eners_plot_v2 = N_Elements(ener_vect_plot_v2)
num_subimgs_y = num_eners_plot_v2
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
For i_ener=0,num_eners_plot_v2-1 Do Begin

i_subimg_x  = 0
i_subimg_y  = i_ener
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subimg  = win_position
;;;---
image_TV  = Alog10(Reform(Flux_arr_plot_v2(*,i_ener,*)))
image_TV  = Transpose(image_TV)
sub_BadVal  = Where(Finite(image_TV) eq 0)
If sub_BadVal(0) ne -1 Then Begin
  num_BadVal  = N_Elements(sub_BadVal)
  image_TV(sub_BadVal)  = 9999.0
EndIf Else Begin
  num_BadVal  = 0
EndElse
image_TV_v2 = image_TV(Sort(image_TV))
min_image = image_TV_v2(Long(0.01*(N_Elements(image_TV))))
max_image = image_TV_v2(Long(0.99*(N_Elements(image_TV)))-num_BadVal)
byt_image_TV= BytSCL(image_TV,min=min_image,max=max_image, Top=num_CB_color-1)
color_BadVal= color_white
If num_BadVal ge 1 Then Begin
  byt_image_TV(sub_BadVal)  = color_BadVal
EndIf
;;;---
xtitle  = ' '
ytitle  = 'PitchAng'
title = String(ener_vect_plot_v2(i_ener), format='(I)')
title = StrTrim(title, 1)
;;;---TV image
TVImage, byt_image_TV,Position=position_SubImg, NOINTERPOLATION=1
;;;---
dJulDay_pix = JulDay_vect_plot_v2(1)-JulDay_vect_plot_v2(0)
xrange  = [Min(JulDay_vect_plot_v2)-0.5*dJulDay_pix, Max(JulDay_vect_plot_v2)+0.5*dJulDay_pix]
yrange  = [0.0, 180.0]
xrange_time = xrange
;a get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
xminor    = xminor_time
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_SubImg,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,YTicks=4,$
  XTitle=xtitle,YTitle=ytitle,Title=title,$
  /NoData,Color=0L,$
  /NoErase,Font=-1,$
  CharThick=charthick,Thick=thick,XThick=xthick,YThick=ythick,CharSize=charsize,$
  YLog=0
;;;---
position_CB   = [position_SubImg(2)+0.08,position_SubImg(1),$
          position_SubImg(2)+0.10,position_SubImg(3)]
num_ticks   = 3
num_divisions = num_ticks-1
max_tickn   = max_image
min_tickn   = min_image
interv_ints   = (max_tickn-min_tickn)/(num_ticks-1)
tickn_CB    = String((Findgen(num_ticks)*interv_ints+min_tickn),format='(F5.1)');the tick-names of colorbar 15
titleCB     = TexToIDL('lg(Flux) [1/cm^2/s/sr/eV]')
bottom_color  = 0B
img_colorbar  = (Bytarr(20)+1B)#(Bindgen(num_CB_color)+bottom_color)
TVImage, img_colorbar,Position=position_CB, NOINTERPOLATION=1
;;;;----draw the outline of the color-bar
Plot,[1,2],[min_image,max_image],Position=position_CB,XStyle=1,YStyle=1,$
  XTicks=1,XTickName=[' ',' '],YTicks=2,YTickName=tickn_CB, Font=-1,$
  /NoData,/NoErase,Color=color_black,$
  TickLen=0.02,Title=' ',YTitle=titleCB, $
  CharThick=charthick,Thick=thick,XThick=xthick,YThick=ythick,CharSize=charsize


EndFor
  

;;--
AnnotStr_tmp  = 'got from "Read_elpd_3dp_WIND_CDF_20000608.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
AnnotStr_tmp  = 'Obs. date: '+date_str
AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
num_strings     = N_Elements(AnnotStr_arr)
For i_str=0,num_strings-1 Do Begin
  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
  CharSize    = 0.95
  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
      CharSize=charsize,color=color_black,Font=-1
EndFor

;;--
;WSet, 1
image_tvrd  = TVRD(true=1)
file_version= '(elpd)'
dir_fig   = GetEnv('WIND_Figure_Dir')+''
file_fig  = 'PitchAng_Spectrum_DiffFlux'+$
            file_version+$
            date_str+$
            TimeRange_plot_str+$
            '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b





End_Program:
End