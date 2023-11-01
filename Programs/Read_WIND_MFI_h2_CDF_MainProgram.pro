;Pro Read_WIND_MFI_H2_CDF_MainProgram

;year_str= '1995'
;mon_str = '02'
;day_str = '24'
sub_dir_date= 'wind\Alfven_v\';'1995-01--1995-02/';'1995-'+mon_str+'-'+day_str+'/'
;sub_dir_date= year_str+'/'+year_str+'-'+mon_str+'/'
sub_dir_name= ''

dir_data_v1 = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''
dir_data = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+''
dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_name+sub_dir_date+''

Step1:
;===========================
;Step1:

;;--
;a dir_read  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
dir_read  = dir_data
file_read = 'wi_h2_mfi_20020525_v05.cdf'
file_array  = File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
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
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch  ;one data per 0.18s 
;a num_records  = Info_Epoch.MaxAllocRec
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'BGSE', Bxyz_GSE_arr, Rec_Count=num_records
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
;  Bx_GSE_vect(sub_nan)  = !values.f_nan
EndIf
sub_nan_Bx  = sub_nan

;;;---
By_GSE_vect  = Reform(Bxyz_GSE_arr(1,*))
sub_nan = Where((By_GSE_vect eq BadVal) or (Abs(By_GSE_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((By_GSE_vect ne BadVal) and (Abs(By_GSE_vect) lt 200))
  JulDay_vect_v2 = JulDay_vect(sub_val)
  By_GSE_vect_v2 = By_GSE_vect(sub_val)
  By_GSE_vect  = Interpol(By_GSE_vect_v2, JulDay_vect_v2, JulDay_vect)
;  By_GSE_vect(sub_nan)  = !values.f_nan  
EndIf
sub_nan_By  = sub_nan

;;;---
Bz_GSE_vect  = Reform(Bxyz_GSE_arr(2,*))
sub_nan = Where((Bz_GSE_vect eq BadVal) or (Abs(Bz_GSE_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Bz_GSE_vect ne BadVal) and (Abs(Bz_GSE_vect) lt 200))
  JulDay_vect_v2 = JulDay_vect(sub_val)
  Bz_GSE_vect_v2 = Bz_GSE_vect(sub_val)
  Bz_GSE_vect  = Interpol(Bz_GSE_vect_v2, JulDay_vect_v2, JulDay_vect)
;  Bz_GSE_vect(sub_nan)  = !values.f_nan
EndIf
sub_nan_Bz  = sub_nan

;;;---
Bxyz_GSE_arr(0,*)  = Transpose(Bx_GSE_vect)
Bxyz_GSE_arr(1,*)  = Transpose(By_GSE_vect)
Bxyz_GSE_arr(2,*)  = Transpose(Bz_GSE_vect)

;;;---
num_times = N_Elements(JulDay_vect)
flag_GoodVal_vect = Fltarr(num_times)+1.0
If (sub_nan_Bx(0) ne -1) Then flag_GoodVal_vect(sub_nan_Bx)=0.0
If (sub_nan_By(0) ne -1) Then flag_GoodVal_vect(sub_nan_By)=0.0
If (sub_nan_Bz(0) ne -1) Then flag_GoodVal_vect(sub_nan_Bz)=0.0
flag_GoodVal_vect = [1.0, flag_GoodVal_vect]
diff_flag_vect = flag_GoodVal_vect(1:num_times) - flag_GoodVal_vect(0:num_times-1)
;;;;----
sub_diff_eq_m1  = Where(diff_flag_vect eq -1)
sub_diff_eq_p1  = Where(diff_flag_vect eq +1)
If (sub_diff_eq_m1(0) ne -1 and sub_diff_eq_p1(0) ne -1) Then Begin
  num_BadBins = N_Elements(sub_diff_eq_m1)
  sub_beg_BadBins_vect  = Lonarr(num_BadBins)
  sub_end_BadBins_vect  = Lonarr(num_BadBins)
  sub_beg_BadBins_vect  = sub_diff_eq_m1
  sub_end_BadBins_vect  = sub_diff_eq_p1
  JulDay_beg_BadBins_vect = JulDay_vect(sub_beg_BadBins_vect)
  JulDay_end_BadBins_vect = JulDay_vect(sub_end_BadBins_vect)
EndIf Else Begin
  sub_beg_BadBins_vect  = -1
  sub_end_BadBins_vect  = -1
  JulDay_beg_BadBins_vect = -1.0
  JulDay_end_BadBins_vect = -1.0
EndElse
    

Step3:
;===========================
;Step3:

;;--
year_beg_plot=2002 & mon_beg_plot=5 & day_beg_plot=24
hour_beg_plot=0 & min_beg_plot=0 & sec_beg_plot=0
year_end_plot=2002 & mon_end_plot=5 & day_end_plot=24
hour_end_plot=18 & min_end_plot=0 & sec_end_plot=0
Print, 'year/mon/day/hour/min/sec_beg_plot: '
Print, year_beg_plot, mon_beg_plot, day_beg_plot, hour_beg_plot, min_beg_plot, sec_beg_plot
Print, 'year/mon/day/hour/min/sec_end_plot: '
Print, year_end_plot, mon_end_plot, day_end_plot, hour_end_plot, min_end_plot, sec_end_plot
is_continue = ' '
;Read, 'is_continue: ', is_continue

JulDay_beg_plot = JulDay(mon_beg_plot,day_beg_plot,year_beg_plot, hour_beg_plot,min_beg_plot,sec_beg_plot)
JulDay_end_plot = JulDay(mon_end_plot,day_end_plot,year_end_plot, hour_end_plot,min_end_plot,sec_end_plot)
;;;---
date_plot_str = '(date='+$
                String(year_beg_plot,format='(I4.4)')+String(mon_beg_plot,format='(I2.2)')+String(day_beg_plot,format='(I2.2)')+$
                ')'
TimeRange_plot_str  = '(time='+$
                      String(hour_beg_plot,format='(I2.2)')+String(min_beg_plot,format='(I2.2)')+String(sec_beg_plot,format='(I2.2)')+'-'+$
                      String(hour_end_plot,format='(I2.2)')+String(min_end_plot,format='(I2.2)')+String(sec_end_plot,format='(I2.2)')+')'

;;--
sub_beg_plot  = Where(JulDay_vect ge JulDay_beg_plot)
sub_end_plot  = Where(JulDay_vect le JulDay_end_plot)
sub_beg_plot  = sub_beg_plot(0)
sub_end_plot  = sub_end_plot(N_Elements(sub_end_plot)-1)

;;--
JulDay_vect_plot  = JulDay_vect(sub_beg_plot:sub_end_plot)
Bx_GSE_vect_plot  = Bx_GSE_vect(sub_beg_plot:sub_end_plot)
By_GSE_vect_plot  = By_GSE_vect(sub_beg_plot:sub_end_plot)
Bz_GSE_vect_plot  = Bz_GSE_vect(sub_beg_plot:sub_end_plot)

;;--
num_times     = N_Elements(JulDay_vect_plot)
dJulDay_vect  = JulDay_vect_plot(1:num_times-1) - JulDay_vect_plot(0:num_times-2)
dJulDay_interp    = 0.1/(24.*60.*60.);Median(dJulDay_vect);固定时间间隔0.1还是取datagap的中值
num_times_interp  = Floor((Max(JulDay_vect_plot)-Min(JulDay_vect_plot))/dJulDay_interp)+1
JulDay_vect_interp= Min(JulDay_vect_plot)+Dindgen(num_times_interp)*dJulDay_interp
Bx_GSE_vect_interp= Interpol_NearBy_MacOS(Bx_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
By_GSE_vect_interp= Interpol_NearBy_MacOS(By_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
Bz_GSE_vect_interp= Interpol_NearBy_MacOS(Bz_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)

print,dJulDay_vect(0),dJulDay_vect(123)

;;--
dJulDay_vect  = JulDay_vect_plot(1:num_times-1) - JulDay_vect_plot(0:num_times-2)
dTime_vect    = dJulDay_vect * (24.*60.*60)
dTime_median  = 0.15;2.*dJulDay_interp*(24.*60.*60.);Median(dTime_vect);间隔大于0.15s认为是datagap
sub_DataGaps  = where(dTime_vect ge dTime_median);Where(dTime_vect ge 4*dTime_median)
If (sub_DataGaps(0) ne -1) Then Begin
  num_DataGaps  = N_Elements(sub_DataGaps)
  JulDay_beg_DataGap_vect = Dblarr(num_DataGaps)
  JulDay_end_DataGap_vect = Dblarr(num_DataGaps)
  num_gappoints = dblarr(num_dataGaps)
  For i_DataGap=0,num_DataGaps-1 Do Begin
    JulDay_beg_DataGap_vect(i_DataGap)  = JulDay_vect_plot(sub_DataGaps(i_DataGap))
    JulDay_end_DataGap_vect(i_DataGap)  = JulDay_vect_plot(sub_DataGaps(i_DataGap)+1)
    num_gappoints(i_DataGap) = round((JulDay_end_DataGap_vect(i_DataGap)-JulDay_beg_DataGap_vect(i_DataGap))/dJulDay_interp) - 1
  EndFor
  num_gapData = mean(num_gappoints,/nan)*num_Datagaps
EndIf Else Begin
  num_DataGaps  = 0L
  num_gapData = 0L
  JulDay_beg_DataGap_vect = -1.0
  JulDay_end_DataGap_vect = -1.0


endelse
num_times_total = N_Elements(JulDay_vect_interp)
perce_gapData = num_gapData/num_times_total
Bt = mean(sqrt(Bx_GSE_vect_interp^2+By_GSE_vect_interp^2+Bz_GSE_vect_interp^2),/nan)
print,   num_gapData,perce_gapData, Bt
is_date = 2    
;read,'number(1) or date(2)',is_date
if is_date eq 2 then begin
;;--
dir_save  = dir_data
;a dir_save  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
;a file_save = 'Bxyz_GSE_arr'+TimeRange_plot_str+'.sav'
file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'_17301800p5.sav'
TimeRange_str = TimeRange_plot_str
data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_MainProgram.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    TimeRange_str, $
    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
    sub_beg_BadBins_vect, sub_end_BadBins_vect, Bt, $
    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, num_gapData, perce_gapData
endif
if is_date eq 1 then begin
  
 dir_save  = dir_data
;a dir_save  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
;a file_save = 'Bxyz_GSE_arr'+TimeRange_plot_str+'.sav'
file_save = '1'+'.sav'
TimeRange_str = TimeRange_plot_str
data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_MainProgram.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    TimeRange_str, $
    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
    sub_beg_BadBins_vect, sub_end_BadBins_vect, Bt, $
    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, num_gapData, perce_gapData
endif
;;;;---
;dir_save  = dir_data_v2    
;;a dir_save  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
;file_save = 'Bins_BadVal_DataGap'+TimeRange_plot_str+'.sav'
;TimeRange_str = TimeRange_plot_str
;data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_MainProgram.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_beg_BadBins_vect, JulDay_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect    
    
    

Step4:
;===========================
;Step4:

;;;--
;JulDay_vect_plot  = JulDay_vect_interp
;Bx_GSE_vect_plot  = Bx_GSE_vect_interp
;By_GSE_vect_plot  = By_GSE_vect_interp
;Bz_GSE_vect_plot  = Bz_GSE_vect_interp

;;--
num_times = N_Elements(JulDay_vect_plot)
dJulDay_vect  = JulDay_vect_plot(1:num_times-1) - JulDay_vect_plot(0:num_times-2)
dTime_vect    = dJulDay_vect * (24.*60.*60)

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
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor  = xminor_time
;xminor    = 6
yrange    = [Min(yplot_vect)-0.1,Max(yplot_vect)+0.1]
yrange    = [0.,0.05*20]
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
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
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
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
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
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
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
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
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
AnnotStr_tmp  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
AnnotStr_arr  = [AnnotStr_tmp]
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
file_version= ''
file_fig  = 'Bx&By&Bz_GSE'+$
        date_plot_str+$
        TimeRange_plot_str+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b



;Step3:
;;===========================
;;Step3:
;
;;;--
;num_times = Round(24.*3600./3.1)
;;a num_times  = Floor((Max(JulDay_vect)-Min(JulDay_vect))/(3.1/(24.*60*60)))
;CalDat, JulDay_vect(0), mon_beg, day_beg, year_beg, hour_beg, min_beg, sec_beg
;JulDay_beg  = JulDay(mon_beg, day_beg, year_beg, 0.0, 0.0, 0.0)
;JulDay_end  = JulDay(mon_beg, day_beg, year_beg, 23.0, 59.0, 59.0)
;JulDay_beg  = Min(JulDay_vect)
;JulDay_end  = Max(JulDay_vect)
;JulDay_vect_v3 = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)
;;;;---
;Bx_GSE_vect_v3 = Interpol(Reform(Bxyz_GSE_arr(0,*)), JulDay_vect, JulDay_vect_v3)
;By_GSE_vect_v3 = Interpol(Reform(Bxyz_GSE_arr(1,*)), JulDay_vect, JulDay_vect_v3)
;Bz_GSE_vect_v3 = Interpol(Reform(Bxyz_GSE_arr(2,*)), JulDay_vect, JulDay_vect_v3)
;Bxyz_GSE_arr_v3  = Fltarr(3,num_times)
;Bxyz_GSE_arr_v3(0,*) = Transpose(Bx_GSE_vect_v3)
;Bxyz_GSE_arr_v3(1,*) = Transpose(By_GSE_vect_v3)
;Bxyz_GSE_arr_v3(2,*) = Transpose(Bz_GSE_vect_v3)
;
;
;Step4:
;;===========================
;;Step4:
;
;;;--
;JulDay_vect_v3  = JulDay_vect
;num_times_v3  = N_Elements(JulDay_vect_v3)
;dJulDay_pix   = JulDay_vect_v3(1)-JulDay_vect_v3(0)
;num_DataGap   = 0
;For i_time=0,num_times_v3-1 Do Begin
;  JulDay_tmp  = JulDay_vect_v3(i_time)
;  dJulDay_vect  = Abs(JulDay_vect_v2-JulDay_tmp)
;;d  dJulDay_vect  = Abs(JulDay_vect-JulDay_tmp)
;  min_dJulDay = Min(dJulDay_vect)
;  If (min_dJulDay gt dJulDay_pix/2) Then Begin
;    If (num_DataGap eq 0) Then Begin
;      sub_DataGap_vect  = [i_time]
;    EndIf Else Begin
;      sub_DataGap_vect  = [sub_DataGap_vect, i_time]
;    EndElse
;    num_DataGap = num_DataGap+1
;  EndIf
;EndFor
;;;;---
;If (num_DataGap ge 1) Then Begin
;  JulDay_DataGap_vect = JulDay_vect_v3(sub_DataGap_vect)
;  TimeStr_DataGap_vect= StrArr(num_DataGap)
;  For i_time=0,num_DataGap-1 Do Begin
;    JulDay_tmp  = JulDay_DataGap_vect(i_time)
;    CalDat, JulDay_tmp, month_tmp, day_tmp, year_tmp, hour_tmp, min_tmp, sec_tmp
;    month_str = String(month_tmp,format='(I2.2)')
;    day_str   = String(day_tmp,format='(I2.2)')
;    year_str  = String(year_tmp,format='(I4.4)')
;    hour_str  = String(hour_tmp,format='(I2.2)')
;    min_str   = String(min_tmp,format='(I2.2)')
;    sec_str   = String(sec_tmp,format='(I2.2)')
;    TimeStr_tmp = year_str+month_str+day_str+'-'+hour_str+min_str+sec_str
;    TimeStr_DataGap_vect(i_time)  = TimeStr_tmp
;  EndFor
;EndIf Else Begin
;  Goto, End_Program
;EndElse
;;;;---
;flag_DataGap_vect = Fltarr(num_times_v3)
;If (num_DataGap ge 1) Then Begin
;  flag_DataGap_vect(sub_DataGap_vect) = 1.0
;EndIf
;is_in_seg = 0
;sub_segbeg_vect = [0L]
;sub_segend_vect = [0L]
;For i_time=0,num_times_v3-1 Do Begin
;  flag_tmp  = flag_DataGap_vect(i_time)
;  If (flag_tmp eq 1 and is_in_seg eq 0) Then Begin
;    sub_segbeg_vect = [sub_SegBeg_vect, i_time]
;    is_in_seg = 1
;  EndIf Else Begin
;  If ((flag_tmp eq 0 or i_time eq num_times_v3-1) and is_in_seg eq 1) Then Begin
;    sub_segend_vect = [sub_segend_vect, i_time-1]
;    is_in_seg = 0
;  EndIf
;  EndElse
;EndFor
;num_segments_DataGap  = N_Elements(sub_segbeg_vect)-1
;sub_segbeg_vect = sub_segbeg_vect(1:num_segments_DataGap-1)
;sub_segend_vect = sub_segend_vect(1:num_segments_DataGap-1)
;
;
;Step4_2:
;;===========================
;;Step4_2:
;
;;;;---
;JulDay_vect  = JulDay_vect_v3
;Bxyz_GSE_arr = Bxyz_GSE_arr_v3
;
;;;--
;dir_save  = GetEnv('WIND_Data_Dir')+sub_dir_date+'MFI\'
;file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_vect, Bxyz_GSE_arr, $
;  JulDay_1min_vect, Bxyz_GSE_1min_arr, xyz_GSE_1min_arr
;
;;;--
;dir_save  = GetEnv('WIND_Data_Dir')+sub_dir_date+'MFI\'
;date_str  = StrMid(file_save, StrLen(file_save)-8-8, 8)
;file_save = 'JulDay_DataGap_vect'+'(time='+date_str+').sav'
;data_descrip= 'got from "Read_pm_3dp_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_DataGap_vect, TimeStr_DataGap_vect, flag_DataGap_vect, $
;  sub_segbeg_vect, sub_segend_vect


End_Program:
End