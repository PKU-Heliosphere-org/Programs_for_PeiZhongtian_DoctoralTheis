;Pro Read_pm_3dp_WIND_CDF_19950131

;sub_dir_date  = '3DP/2002/' ; 2002-12/';'1995-01--1995-02/';'1995-12-23/'
;sub_dir_date  = '2005-03/'
;sub_dir_name  = ''
WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\He\3dp_WangLH\' ;+TimeRange_str
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\He\' ;+TimeRange_str
SetEnv, WIND_Data_Dir
SetEnv, WIND_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_read	= GetEnv('WIND_Data_Dir')
file_read	= 'wi_pm_3dp_2002????_v0?.cdf'
file_array	= File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_file_beg	= 0
i_file_end	= num_files-1
Print, 'i_file_beg/end: ', i_file_beg, i_file_end
Read, 'i_file_beg, i_file_end: ', i_file_beg, i_file_end

;;--
For i_file=i_file_beg,i_file_end Do Begin

i_select	= i_file
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
CDF_VarGet, cdf_id, 'P_DENS', NumDens_p_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'A_DENS', NumDens_a_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_TEMP', Temper_p_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'A_TEMP', Temper_a_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_VELS', Vxyz_GSE_p_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'A_VELS', Vxyz_GSE_a_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_TENS', Tensor_p_arr, Rec_Count=num_records   ;Residual Variance in Proton Velocity (6 components in instrument coords)
CDF_VarGet, cdf_id, 'A_TENS', Tensor_a_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'VALID', DataValid_vect, Rec_Count=num_records
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


Step2:
;===========================
;Step2:

;;--
dir_save	= GetEnv('WIND_Data_Dir')
file_save	= StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Read_pm_3dp_WIND_CDF_20000608.pro"'
data_descrip_v2 = 'unit: velocity [km/s in SC coordinate similar to GSE coordinate]; number density [cm^-3]; '+$
                  'temperature [10^4 K]; tensor [(km/s)^2, in SC coordinate]'
Print, 'file_read: ', file_read
Print, 'data_descrip: '
Print, data_descrip
Save, FileName=dir_save+file_save, $
	data_descrip, $
	data_descrip_v2, $
	JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
	NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
	Tensor_p_arr, Tensor_a_arr

; Note: sequence order stored in the tensor 
; vv_uniq  = [0,4,8,1,2,5]           ; => Uniq elements of a symmetric 3x3 matrix
; vv_trace = [0,4,8]                 ; => diagonal elements of a 3x3 matrix	


Goto, Another_i_file		
Step3:
;===========================
;Step3:

;;--
JulDay_vect_plot  = JulDay_vect
Vx_GSE_p_vect_plot  = Reform(Vxyz_GSE_p_arr(0,*))
Vy_GSE_p_vect_plot  = Reform(Vxyz_GSE_p_arr(1,*))
Vz_GSE_p_vect_plot  = Reform(Vxyz_GSE_p_arr(2,*))
Vx_GSE_a_vect_plot  = Reform(Vxyz_GSE_a_arr(0,*))
Vy_GSE_a_vect_plot  = Reform(Vxyz_GSE_a_arr(1,*))
Vz_GSE_a_vect_plot  = Reform(Vxyz_GSE_a_arr(2,*))
n_p_vect_plot   = NumDens_p_vect
n_a_vect_plot   = NumDens_a_vect
T_p_vect_plot   = Temper_p_vect
T_a_vect_plot   = Temper_a_vect


;;--
num_times = N_Elements(JulDay_vect_plot)
dJulDay_vect  = JulDay_vect_plot(1:num_times-1) - JulDay_vect_plot(0:num_times-2)
dTime_vect    = dJulDay_vect * (24.*60.*60)

;;--
JulDay_beg_plot = Min(JulDay_vect_plot)
JulDay_end_plot = Max(JulDay_vect_plot)
CalDat, JulDay_beg_plot, mon_beg_plot, day_beg_plot, year_beg_plot, hour_beg_plot, min_beg_plot, sec_beg_plot
CalDat, JulDay_end_plot, mon_end_plot, day_end_plot, year_end_plot, hour_end_plot, min_end_plot, sec_end_plot
TimeRange_plot_str  = '(time='+$
                      String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')+'-'+$
                      String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')+')'
Date_plot_str = '(date='+$
                  String(year_beg_plot,format='(I4.4)')+String(mon_beg_plot,format='(I2.2)')+String(day_beg_plot,format='(I2.2)')+$
                  ')'

;;--
Set_Plot, 'win'
Device,DeComposed=0;, /Retain
xsize=1000.0 & ysize=900.0
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

;;--
position_img  = [0.05,0.05,0.95,0.95]
num_subimgs_x = 1
num_subimgs_y = 6
dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y

;;--
i_subimg_x  = 0
i_subimg_y  = 0
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subplot  = win_position
xplot_vect  = 0.5*(JulDay_vect_plot(0:num_times-2) + JulDay_vect_plot(1:num_times-1))
yplot_vect  = dTime_vect
xrange  = [Min(JulDay_vect_plot), Max(JulDay_vect_plot)]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
xtitle    = 'Time'
ytitle    = 'dTime [s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1

;;--
i_subimg_x  = 0
i_subimg_y  = 1
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_plot
yplot_vect  = T_p_vect_plot
xrange  = [Min(JulDay_vect_plot), Max(JulDay_vect_plot)]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
xticknames  = Replicate(' ', xticks+1)
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
xtitle    = ' '
ytitle    = 'Tp [10^4 K]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1

;;--
i_subimg_x  = 0
i_subimg_y  = 2
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_plot
yplot_vect  = n_p_vect_plot
xrange  = [Min(JulDay_vect_plot), Max(JulDay_vect_plot)]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
xticknames  = Replicate(' ', xticks+1)
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
xtitle    = ' '
ytitle    = 'Np (cm^-3)'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1

;;--
i_subimg_x  = 0
i_subimg_y  = 3
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_plot
yplot_vect  = Vz_GSE_p_vect_plot
xrange  = [Min(JulDay_vect_plot), Max(JulDay_vect_plot)]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
xticknames  = Replicate(' ', xticks+1)
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
xtitle    = ' '
ytitle    = 'Vz_p [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1

;;--
i_subimg_x  = 0
i_subimg_y  = 4
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_plot
yplot_vect  = Vy_GSE_p_vect_plot
xrange  = [Min(JulDay_vect_plot), Max(JulDay_vect_plot)]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
xticknames  = Replicate(' ', xticks+1)
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
xtitle    = ' '
ytitle    = 'Vy_p [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1
  
 
;;--
i_subimg_x  = 0
i_subimg_y  = 5
win_position= [position_img(0)+dx_subimg*i_subimg_x+0.10*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.10*dy_subimg,$
        position_img(0)+dx_subimg*i_subimg_x+0.90*dx_subimg,$
        position_img(1)+dy_subimg*i_subimg_y+0.90*dy_subimg]
position_subplot  = win_position
xplot_vect  = JulDay_vect_plot
yplot_vect  = Vx_GSE_p_vect_plot
xrange  = [Min(JulDay_vect_plot), Max(JulDay_vect_plot)]
xrange_time = xrange
get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
xticknames  = Replicate(' ', xticks+1)
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
xtitle    = ' '
ytitle    = 'Vx_p [km/s]'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1 
  

;;--
AnnotStr_tmp  = 'got from "Read_pm_3dp_WIND_CDF_20000608.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
AnnotStr_tmp  = Date_plot_str+';  '+sub_dir_date
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
file_version= '(pm)'
dir_fig   = GetEnv('WIND_Figure_Dir')+''
file_fig  = 'n&V_GSE&T'+$
            Date_plot_str+$
            TimeRange_plot_str+$
            '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b


Another_i_file:
EndFor ;For i_file=i_file_beg,i_file_end Do Begin


End_Program:
End
