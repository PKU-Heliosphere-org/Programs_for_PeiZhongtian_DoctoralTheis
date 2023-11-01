;pro get_v_vect_end_change_in_LMN
;sub_dir_date  = '1997-11-23/'
;sub_dir_date  = '1997-11-23/'

WIND_MFI_Data_Dir = 'WIND_MFI_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
WIND_3DP_Data_Dir = 'WIND_3dp_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'
SetEnv, WIND_MFI_Data_Dir
SetEnv, WIND_3DP_Data_Dir
SetEnv, WIND_Figure_Dir



Step1:
;===========================
;Step1:calculate the LMN e_vect

Step1_1:
;;--
dir_restore   = GetEnv('WIND_MFI_Data_Dir')
file_restore  = 'wi_h0_mfi_20020523_v05.sav'
file_version  = StrMid(file_restore,3,2)
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip  = 'got from "Read_WIND_MFI_H0_CDF_19971123.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr


Step1_2:
;;--
;TIMERANGE_STR_plot = '(time=123001-132958)'
JulDay_min_plot  = JulDay(5,23,2002,10,40,0)
JulDay_max_plot  = JulDay(5,23,2002,18,40,0)

sub_times_plot = Where(JulDay_vect ge JulDay_min_plot and JulDay_vect le JulDay_max_plot)

sub_beg_plot = Min(sub_times_plot)
sub_end_plot = Max(sub_times_plot)
JulDay_vect_plot = JulDay_vect(sub_beg_plot:sub_end_plot)
JulDay_vect_MFI_plot = JulDay_vect_plot

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
                  
                  
Step1_3:
;;--
num_times = N_Elements(JulDay_vect)
dJulDay_bin = Mean(JulDay_vect(1:num_times-1) - JulDay_vect(0:num_times-2))
dJulDay_interp  = dJulDay_bin
num_times_interp  = Floor((Max(JulDay_vect)-Min(JulDay_vect))/dJulDay_interp)+1
JulDay_vect_interp= Min(JulDay_vect)+Dindgen(num_times_interp)*dJulDay_interp
Bx_GSE_vect = Transpose(Bxyz_GSE_arr(0,*))
By_GSE_vect = Transpose(Bxyz_GSE_arr(1,*))
Bz_GSE_vect = Transpose(Bxyz_GSE_arr(2,*))
sub_tmp = Where(Finite(Bx_GSE_vect) eq 1)
Bx_GSE_vect_interp= Interpol_NearBy_MacOS(Bx_GSE_vect(sub_tmp), JulDay_vect(sub_tmp), JulDay_vect_interp, NearBy=1)
sub_tmp = Where(Finite(By_GSE_vect) eq 1)
By_GSE_vect_interp= Interpol_NearBy_MacOS(By_GSE_vect(sub_tmp), JulDay_vect(sub_tmp), JulDay_vect_interp, NearBy=1)
sub_tmp = Where(Finite(Bz_GSE_vect) eq 1)
Bz_GSE_vect_interp= Interpol_NearBy_MacOS(Bz_GSE_vect(sub_tmp), JulDay_vect(sub_tmp), JulDay_vect_interp, NearBy=1)




;;--
JulDay_vect = JulDay_vect_interp
Bxyz_GSE_arr  = [[Bx_GSE_vect_interp],[By_GSE_vect_interp],[Bz_GSE_vect_interp]]
Bxyz_GSE_arr  = Transpose(Bxyz_GSE_arr)
Bxyz_GSE_arr_WholeMR  = Transpose(Bxyz_GSE_arr(*,sub_beg_plot:sub_end_plot))





get_LMN_from_MVA, Bxyz_GSE_arr_WholeMR, $
      l_vect=l_vect_WholeMR, m_vect=m_vect_WholeMR, n_vect=n_vect_WholeMR, $
      lambda_l=lambda_l_WholeMR, lambda_m=lambda_m_WholeMR, lambda_n=lambda_n_WholeMR


Bl_vect_WholeMR  = Bxyz_GSE_arr_WholeMR # l_vect_WholeMR
Bm_vect_WholeMR  = Bxyz_GSE_arr_WholeMR # m_vect_WholeMR
Bn_vect_WholeMR  = Bxyz_GSE_arr_WholeMR # n_vect_WholeMR
Bx_vect_WholeMR = Bxyz_GSE_arr_WholeMR(*,0)
By_vect_WholeMR = Bxyz_GSE_arr_WholeMR(*,1)
Bz_vect_WholeMR = Bxyz_GSE_arr_WholeMR(*,2)
  
print,l_vect_WholeMR
print,m_vect_WholeMR
print,n_vect_WholeMR

;;;----
time_mean = 5 * (20 * dTime_vect(0))
time_beg = JulDay_min_plot * (24.*60.*60)
time_end = JulDay_max_plot * (24.*60.*60)
n_mean = (time_end-time_beg)/time_mean
Bl_mean = fltarr(n_mean)
Bm_mean = fltarr(n_mean)
Bn_mean = fltarr(n_mean)
JulDay_mean = fltarr(n_mean)
for i_mean = 0,n_mean-2 do begin
  Bl_mean(i_mean) = mean(Bl_vect_WholeMR(i_mean*5*20:(i_mean+1)*100),/nan)
  Bm_mean(i_mean) = mean(Bm_vect_WholeMR(i_mean*100:(i_mean+1)*100),/nan)  
  Bn_mean(i_mean) = mean(Bn_vect_WholeMR(i_mean*100:(i_mean+1)*100),/nan)
;  JulDay_mean(i_mean) = mean(JulDay_vect_plot(i_mean*100:(i_mean+1)*100),/nan)
endfor  
JulDay_mean = JulDay_beg_plot + indgen(n_mean)*5*60./(24*60.*60.)
Bl_vect_WholeMR = Bl_mean
Bm_vect_WholeMR = Bm_mean
Bn_vect_WholeMR = Bn_mean
;;;

Step2:
;===========================
;Step2:


Step2_1:
;;--
;read the data from pm_3dp
dir_restore   = GetEnv('WIND_3DP_Data_Dir');+sub_dir_date+''
file_restore  = 'wi_pm_3dp_20020523_v0*.sav'
file_version  = StrMid(file_restore,3,2)
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_pm_3dp_WIND_CDF_19971123.pro"'
;data_descrip_v2 = 'unit: velocity [km/s in SC coordinate similar to GSE coordinate]; number density [cm^-3]; '+$
;                  'temperature [10^4 K]; tensor [(km/s)^2, in SC coordinate]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr


Step2_2:
;--
JulDay_min_plot  = JulDay(5,23,2002,10,40,0)
JulDay_max_plot  = JulDay(5,23,2002,18,40,0)
sub_times_plot = Where(JulDay_vect ge JulDay_min_plot and JulDay_vect le JulDay_max_plot)

sub_beg_plot = Min(sub_times_plot)
sub_end_plot = Max(sub_times_plot)

JulDay_vect_plot = JulDay_vect(sub_beg_plot:sub_end_plot)
JulDay_vect_3DP_plot = JulDay_vect_plot

Vxyz_GSE_p_arr = Vxyz_GSE_p_arr(*,sub_beg_plot:sub_end_plot)


Vxyz_GSE_p_arr_WholeMR = Transpose(Vxyz_GSE_p_arr)
  
Vl_vect_WholeMR = Vxyz_GSE_p_arr_WholeMR # l_vect_WholeMR
Vm_vect_WholeMR = Vxyz_GSE_p_arr_WholeMR # m_vect_WholeMR
Vn_vect_WholeMR = Vxyz_GSE_p_arr_WholeMR # n_vect_WholeMR

;;;----
time_mean = 5*60;5 * (20 * (JulDay_vect(1)-JulDay_vect(0))*86400)
time_beg = JulDay_min_plot * (24.*60.*60)
time_end = JulDay_max_plot * (24.*60.*60)
n_mean = (time_end-time_beg)/time_mean
Vl_mean = fltarr(n_mean)
Vm_mean = fltarr(n_mean)
Vn_mean = fltarr(n_mean)
;JulDay_mean = fltarr(n_mean)
for i_mean = 0,n_mean-2 do begin
  sub_mean = where(JulDay_vect ge (JulDay_min_plot+i_mean*(5*60/86400.)) and JulDay_vect le (JulDay_min_plot+(i_mean+1)*(5*60/86400.)))
  Vl_mean(i_mean) = mean(Vl_vect_WholeMR(sub_mean),/nan)
  Vm_mean(i_mean) = mean(Vm_vect_WholeMR(sub_mean),/nan)  
  Vn_mean(i_mean) = mean(Vn_vect_WholeMR(sub_mean),/nan)
;  JulDay_mean(i_mean) = mean(JulDay_vect_plot(i_mean*100:(i_mean+1)*100),/nan)
endfor  
Vl_vect_WholeMR = Vl_mean
Vm_vect_WholeMR = Vm_mean
Vn_vect_WholeMR = Vn_mean
;;;

num_times = n_mean;N_Elements(JulDay_vect_plot)

Step3:
;--
;;--
Set_Plot, 'win'
Device,DeComposed=0;, /Retain
xsize=900.0 & ysize=450.0
Window,2,XSize=xsize,YSize=ysize,Retain=2

;--
LoadCT,13
TVLCT,R,G,B,/Get
R_1=congrid(R,num_times,/INTERP, /MINUS_ONE)
G_1=congrid(G,num_times,/INTERP, /MINUS_ONE)
B_1=congrid(B,num_times,/INTERP, /MINUS_ONE)
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

color_bg    = color_white
!p.background = color_bg

;;--
Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData

;iplot,[0,0],[0,0]
;for count = 0,num_times-1 do begin
;  COLOR_TEMP=[R_1[count],G_1[count],B_1[count]]
;  Vm_vect=[0,Vm_vect_WholeMR[count]]
;  Vl_vect=[0,Vl_vect_WholeMR[count]]
;  iplot,Vm_vect,Vl_vect,color=color_temp,/overplot,Sym_Index=-1,Sym_Thick=2,sym_color=color_temp
;endfor

cdn_m_vect=dblarr(num_times+1)
cdn_l_vect=dblarr(num_times+1)

Bm_vect_plot_start=dblarr(num_times)
Bl_vect_plot_start=dblarr(num_times)
Bm_vect_plot_end=dblarr(num_times)
Bl_vect_plot_end=dblarr(num_times)

for count = 0,num_times-1 do begin
  cdn_m_vect[count+1]=cdn_m_vect[count]+Vm_vect_WholeMR[count]*5*60/6371.;;;乘以分辨率
  cdn_l_vect[count+1]=cdn_l_vect[count]+Vl_vect_WholeMR[count]*5*60/6371.;;;;
  
  Bm_vect_plot_start[count]=cdn_m_vect[count]
  Bl_vect_plot_start[count]=cdn_l_vect[count]
  Bm_vect_plot_end[count]=cdn_m_vect[count]+Bm_vect_WholeMR[count]*10.
  Bl_vect_plot_end[count]=cdn_l_vect[count]+Bl_vect_WholeMR[count]*10.
  
endfor

position_img  = [0.10,0.15,0.90,0.98]
num_x_SubImgs = 1
num_y_SubImgs = 1
dx_pos_SubImg = (position_img(2)-position_img(0))/num_x_SubImgs
dy_pos_SubImg = (position_img(3)-position_img(1))/num_y_SubImgs
;;--
   i_x_SubImg  = 0
   i_y_SubImg  = 0
position_SubImg = [position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.1),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.1),$
           position_img(0)+dx_pos_SubImg*(i_x_SubImg+0.8),$
           position_img(1)+dy_pos_SubImg*(i_y_SubImg+0.9)]
xtitle  = 'time'
ytitle  = 'B(nT)';'period'
x_plot = JulDay_mean
xrange = [min(JulDay_vect_plot),max(JulDay_vect_plot)]
get_xtick_for_time_MacOS, xrange, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
y_plot1 = Bm_vect_WholeMR
y_plot2 = Bl_vect_WholeMR

yrange  = [-100, 100]
  
Plot,x_plot,y_plot1, YRange=yrange,$
  Position=position_SubImg,YStyle=1,$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,title=title, $
  Color=color_black,charsize=1.5,$
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0;,/xlog,/ylog
oPlot,x_plot,y_plot2, Color=color_red
xyouts,JulDay_mean(80),70,'Bm',color=color_black
xyouts,JulDay_mean(80),50,'Bl',color=color_red
;     

image_tvrd  = TVRD(true=1)
dir_fig   = GetEnv('WIND_MFI_Data_Dir')
file_version= '(v1)'
file_fig  = 'Bl_Bm_time_vect'+'.png';;;;;;
Write_PNG, dir_fig+file_fig, image_tvrd

;
;step4:
;
iplot,cdn_l_vect,cdn_m_vect,xtitle='L(Re)',ytitle='M(Re)'
for count = 0,num_times-1 do begin
  Bm_vect_plot=[Bm_vect_plot_start[count],Bm_vect_plot_end[count]]
  Bl_vect_plot=[Bl_vect_plot_start[count],Bl_vect_plot_end[count]]

  
  COLOR_TEMP=[R_1[count],G_1[count],B_1[count]]
  iplot,Bl_vect_plot,Bm_vect_plot,color=color_temp,FILL_TRANSPARENCY=50,/overplot
  print,count
endfor

  iplot,Bl_vect_plot_end,Bm_vect_plot_end,/overplot,thick=2.0
;  

read,'continue?Yes(1) or not(2):',is_conti
if is_conti eq 1 then begin
x_vect=indgen(n_mean);/50.
y_vect=intarr(n_mean)
z_vect=intarr(n_mean)
B_vect_start=dblarr(n_mean,3)
B_vect_end=dblarr(n_mean,3)
iplot,[0,0],[0,0],[0,0]
for count = 0,n_mean-1 do begin
  B_vect_start[count,0]=x_vect[count]
  B_vect_start[count,1]=y_vect[count]
  B_vect_start[count,2]=z_vect[count]

  B_vect_end[count,0]=x_vect[count]+Bn_vect_WholeMR[count]
  B_vect_end[count,1]=y_vect[count]+Bl_vect_WholeMR[count]
  B_vect_end[count,2]=z_vect[count]+Bm_vect_WholeMR[count]
  
  ;iplot,[x_vect[count],B_vect_end[count,0]],[y_vect[count],B_vect_end[count,1]],[z_vect[count],B_vect_end[count,2]],/overplot

  COLOR_TEMP=[R_1[count],G_1[count],B_1[count]]
 
;;--a1
;  Bx_end_vect = [B_vect_end[count,0],B_vect_end[count,0]]
;  By_end_vect = [B_vect_end[count,1],B_vect_end[count,1]]
;  Bz_end_vect = [B_vect_end[count,2],B_vect_end[count,2]]

;--a2
  Bx_vect = [B_vect_start[count,0],B_vect_end[count,0]]
  By_vect = [B_vect_start[count,1],B_vect_end[count,1]]
  Bz_vect = [B_vect_start[count,2],B_vect_end[count,2]]
  
iplot,Bx_vect,By_vect,Bz_vect,Sym_Index=1,Sym_Thick=2,sym_color=color_temp,color=color_temp,/overplot
 print,count
endfor 

iplot,B_vect_end[*,0],B_vect_end[*,1],B_vect_end[*,2],/overplot,$;
  xtitle='Bn(nT)',ytitle='Bl(nT)',ztitle='Bm(nT)'
endif
if is_conti eq 2 then begin
endif
 

end