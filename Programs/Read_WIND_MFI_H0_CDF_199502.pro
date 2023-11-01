;Pro Read_WIND_MFI_H0_CDF_199502

sub_dir_date  = 'wind\another\199509\fast\'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\';+sub_dir_date
WIND_MFI_Figure_Dir = 'WIND_MFI_Figure_Dir=C:\Users\pzt\course\Research\CDF_wind\';+sub_dir_date
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_MFI_Figure_Dir

Step1:
;===========================
;Step1:

;;--
dir_read  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
file_read = 'wi_h0_mfi_19950906_v05.cdf'
file_version= StrMid(file_read,3,2)
file_array  = File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_read = file_array(i_select)
file_read = StrMid(file_read, StrLen(dir_read), StrLen(file_read)-StrLen(dir_read))

;;--
CD, Current=wk_dir
CD, dir_read
cdf_id  = CDF_Open(file_read)
;a result  = CDF_Inquire(cdf_id)
;a CDF_Close, cdf_id
;a Goto, End_Program
;;;---
CDF_Control, cdf_id, Variable='Epoch3', Get_Var_Info=Info_Epoch  ;one data per 0.18s 
;a num_records  = Info_Epoch.MaxAllocRec
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch3', Epoch_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'B3GSE', Bxyz_GSE_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_vect = Reform(Epoch_vect)
epoch_beg   = Epoch_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_vect  = JulDay_beg+(Epoch_vect-Epoch_beg)/(1.e3*24.*60.*60.)


Step2:
;===========================
;Step2:

;;--
BadVal  = -1.e31
;;;---
Bx_GSE_vect  = Reform(Bxyz_GSE_arr(0,*))
sub_nan = Where((Bx_GSE_vect eq BadVal) or (Abs(Bx_GSE_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Bx_GSE_vect ne BadVal) and (Abs(Bx_GSE_vect) lt 200))
  JulDay_vect_v2 = JulDay_vect(sub_val)
  Bx_GSE_vect_v2 = Bx_GSE_vect(sub_val)
  Bx_GSE_vect  = Interpol(Bx_GSE_vect_v2, JulDay_vect_v2, JulDay_vect)
EndIf
;;;---
By_GSE_vect  = Reform(Bxyz_GSE_arr(1,*))
sub_nan = Where((By_GSE_vect eq BadVal) or (Abs(By_GSE_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((By_GSE_vect ne BadVal) and (Abs(By_GSE_vect) lt 200))
  JulDay_vect_v2 = JulDay_vect(sub_val)
  By_GSE_vect_v2 = By_GSE_vect(sub_val)
  By_GSE_vect  = Interpol(By_GSE_vect_v2, JulDay_vect_v2, JulDay_vect)
EndIf
;;;---
Bz_GSE_vect  = Reform(Bxyz_GSE_arr(2,*))
sub_nan = Where((Bz_GSE_vect eq BadVal) or (Abs(Bz_GSE_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Bz_GSE_vect ne BadVal) and (Abs(Bz_GSE_vect) lt 200))
  JulDay_vect_v2 = JulDay_vect(sub_val)
  Bz_GSE_vect_v2 = Bz_GSE_vect(sub_val)
  Bz_GSE_vect  = Interpol(Bz_GSE_vect_v2, JulDay_vect_v2, JulDay_vect)
EndIf
;;;---
;Bxyz_GSE_arr(0,*)  = Transpose(Bx_GSE_vect)
;Bxyz_GSE_arr(1,*)  = Transpose(By_GSE_vect)
;Bxyz_GSE_arr(2,*)  = Transpose(Bz_GSE_vect)

Step3:
;===========================
;Step2:

;;--
;sub_tmp = Where(Bxyz_GSE_arr eq -1.e31)
;If (sub_tmp(0) ne -1) Then Begin
;  Bxyz_GSE_arr(sub_tmp) = !values.f_nan
;EndIf

;;--
JulDay_end  = Max(JulDay_vect)
CalDat, JulDay_beg, mon_beg, day_beg, year_beg, hour_beg, min_beg, sec_beg
CalDat, JulDay_end, mon_end, day_end, year_end, hour_end, min_end, sec_end
TimeRange_str  = '(time='+$
                      String(hour_beg,format='(I2.2)')+String(min_beg,format='(I2.2)')+String(sec_beg,format='(I2.2)')+'-'+$
                      String(hour_end,format='(I2.2)')+String(min_end,format='(I2.2)')+String(sec_end,format='(I2.2)')+')'

;;--
num_times     = N_Elements(JulDay_vect)
dJulDay_vect  = JulDay_vect(1:num_times-1) - JulDay_vect(0:num_times-2)
dJulDay_interp    = Median(dJulDay_vect)
num_times_interp  = Floor((Max(JulDay_vect)-Min(JulDay_vect))/dJulDay_interp)+1
JulDay_vect_interp= Min(JulDay_vect)+Dindgen(num_times_interp)*dJulDay_interp
Bx_GSE_vect_interp= Interpol_NearBy_MacOS(Bx_GSE_vect, JulDay_vect, JulDay_vect_interp, NearBy=1)
By_GSE_vect_interp= Interpol_NearBy_MacOS(By_GSE_vect, JulDay_vect, JulDay_vect_interp, NearBy=1)
Bz_GSE_vect_interp= Interpol_NearBy_MacOS(Bz_GSE_vect, JulDay_vect, JulDay_vect_interp, NearBy=1)

Bxyz_GSE_arr(0,*)  = Transpose(Bx_GSE_vect_interp)
Bxyz_GSE_arr(1,*)  = Transpose(By_GSE_vect_interp)
Bxyz_GSE_arr(2,*)  = Transpose(Bz_GSE_vect_interp)
JulDay_vect = JulDay_vect_interp
;;--
dir_save  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date
file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
TimeRange_str = TimeRange_str
data_descrip  = 'got from "Read_WIND_MFI_H0_CDF_199502.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    TimeRange_str, $
    JulDay_vect, Bxyz_GSE_arr
    

Step4:
;===========================
;Step3:

;;--
JulDay_vect_plot  = JulDay_vect
Bx_GSE_vect_plot  = Reform(Bxyz_GSE_arr(0,*))
By_GSE_vect_plot  = Reform(Bxyz_GSE_arr(1,*))
Bz_GSE_vect_plot  = Reform(Bxyz_GSE_arr(2,*))


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


;;--
Set_Plot, 'win'
Device,DeComposed=0;, /Retain
xsize=1200.0 & ysize=900.0
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
num_subimgs_y = 5
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
yplot_vect  = Bz_GSE_vect_plot
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
ytitle    = 'Bz_GSE (nT)'
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
yplot_vect  = By_GSE_vect_plot
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
ytitle    = 'By_GSE (nT)'
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
yplot_vect  = Bx_GSE_vect_plot
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
ytitle    = 'Bx_GSE (nT)'
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
yplot_vect  = Sqrt(Bz_GSE_vect_plot^2+By_GSE_vect_plot^2+Bx_GSE_vect_plot^2)
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
ytitle    = '|B| (nT)'
Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=position_subplot,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  Color=color_black,$
  /NoErase,Font=-1

;;--
AnnotStr_tmp  = 'got from "Read_WIND_MFI_H0_CDF_199502.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
AnnotStr_tmp  = sub_dir_date
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
file_version= '(H0)'
dir_fig   = GetEnv('WIND_MFI_Figure_Dir')+sub_dir_date+''
file_fig  = 'Bx&By&Bz_GSE'+$
            TimeRange_plot_str+$
            '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b




End_Program:
End