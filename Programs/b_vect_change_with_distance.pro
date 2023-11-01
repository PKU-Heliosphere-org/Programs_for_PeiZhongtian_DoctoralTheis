;pro B_vect_change_with_distance

;a change with distance
;b change without moving


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


;;--
;TIMERANGE_STR_plot = '(time=125001-131501)'
JulDay_min_plot = JulDay(5,23,2002,10,40,0)
JulDay_max_plot = JulDay(5,23,2002,18,40,0)
sub_min_plot  = Where(JulDay_vect ge JulDay_min_plot)
sub_min_plot  = sub_min_plot(0)
sub_max_plot  = Where(JulDay_vect ge JulDay_max_plot)
sub_max_plot  = sub_max_plot(0)-1

BXYZ_GSE_ARR_plot  = BXYZ_GSE_ARR(*,sub_min_plot:sub_max_plot)
JULDAY_VECT_plot   = JULDAY_VECT(sub_min_plot:sub_max_plot)

Bx_GSE_vect_plot  = Reform(Bxyz_GSE_arr_plot(0,*))
By_GSE_vect_plot  = Reform(Bxyz_GSE_arr_plot(1,*))
Bz_GSE_vect_plot  = Reform(Bxyz_GSE_arr_plot(2,*))

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
;;;----
time_mean = 5 * (20 * dTime_vect(0))
time_beg = JulDay_beg_plot * (24.*60.*60)
time_end = JulDay_end_plot * (24.*60.*60)
n_mean = (time_end-time_beg)/time_mean
Bx_mean = fltarr(n_mean)
By_mean = fltarr(n_mean)
Bz_mean = fltarr(n_mean)
for i_mean = 0,n_mean-2 do begin
  Bx_mean(i_mean) = mean(Bx_GSE_vect_plot(i_mean*5*20:(i_mean+1)*100),/nan)
  By_mean(i_mean) = mean(By_GSE_vect_plot(i_mean*100:(i_mean+1)*100),/nan)  
  Bz_mean(i_mean) = mean(Bz_GSE_vect_plot(i_mean*100:(i_mean+1)*100),/nan)
endfor  
  
  
;;--
;Set_Plot, 'win'
;Device,DeComposed=0;, /Retain
;xsize=1200.0 & ysize=900.0
;Window,2,XSize=xsize,YSize=ysize,Retain=2                  
;;--
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
                  
x_vect=indgen(n_mean);/50.
y_vect=intarr(n_mean)
z_vect=intarr(n_mean)
B_vect_start=dblarr(n_mean,3)
B_vect_end=dblarr(n_mean,3)

;;a01 
;iplot,x_vect,y_vect,z_vect

;;a02 
iplot,[0,0],[0,0],[0,0]

for count = 0,n_mean-1 do begin
  B_vect_start[count,0]=x_vect[count]
  B_vect_start[count,1]=y_vect[count]
  B_vect_start[count,2]=z_vect[count]

  B_vect_end[count,0]=x_vect[count]+Bx_mean[count]
  B_vect_end[count,1]=y_vect[count]+By_mean[count]
  B_vect_end[count,2]=z_vect[count]+Bz_mean[count]
  
  ;iplot,[x_vect[count],B_vect_end[count,0]],[y_vect[count],B_vect_end[count,1]],[z_vect[count],B_vect_end[count,2]],/overplot

  COLOR_TEMP=[R_1[100*count],G_1[100*count],B_1[100*count]]
 
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
  xtitle='Bx(nT)',ytitle='By(nT)',ztitle='Bz(nT)'

end