;pro start_time


;change background
device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


;路径
file_start = 'C:\Users\pzt\course\Research\CDF_wind\start\'   ;path of start_time
file_h2_mif = 'C:\Users\pzt\course\Research\CDF_wind\start\'
file_pm_3dp = 'C:\Users\pzt\course\Research\3dp_WangLH\'
file_all_sav = 'C:\Users\pzt\course\Research\CDF_wind\start\'   ;path of save


step1:  ;read date,time format:**-**-**/**:**:**

dir_restore = file_start
file_restore= 'start_time.dat'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
; start_time                  

nums = n_elements(start_time)



step2:             ;read magnetic field


;保存的量平均磁场，平均速度，斜率和power level
Bmag_average = fltarr(nums)
Velo_average = fltarr(nums)
B_slope = fltarr(nums)
power_level = fltarr(nums)
f_min = fltarr(nums)
f_max = fltarr(nums)
;

i_num=506    ;检验某个例子是否有问题
;for i_num = 0,nums-1 do begin
  
  ;读取年月日时分秒，注意了千年问题
  if strmid(start_time(i_num),0,1) eq '9' then begin
  year = '19'+strmid(start_time(i_num),0,2)
  month = strmid(start_time(i_num),3,2)
  day = strmid(start_time(i_num),6,2)
  hour = strmid(start_time(i_num),9,2)
  minut = strmid(start_time(i_num),12,2)
  second = strmid(start_time(i_num),15,2)
  endif else begin
  year = '20'+strmid(start_time(i_num),0,2)
  month = strmid(start_time(i_num),3,2)
  day = strmid(start_time(i_num),6,2)
  hour = strmid(start_time(i_num),9,2)
  minut = strmid(start_time(i_num),12,2)
  second = strmid(start_time(i_num),15,2)
  endelse
  
  ; befor 12:00  
  
  second_num = long(hour)*3600+long(minut)*60+long(minut)
  if second_num le 43200 then begin



;    
dir_read  = file_h2_mif
file_read = 'wi_h2_mfi_'+year+month+day+'_v*.cdf'
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
;;;---

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
Bxyz_GSE_arr(0,*)  = Transpose(Bx_GSE_vect)
Bxyz_GSE_arr(1,*)  = Transpose(By_GSE_vect)
Bxyz_GSE_arr(2,*)  = Transpose(Bz_GSE_vect)
    


;;--
year_beg_plot=long(year) & mon_beg_plot=long(month) & day_beg_plot=long(day)
hour_beg_plot=long(hour) & min_beg_plot=long(minut) & sec_beg_plot=long(second)
JulDay_beg_plot = JulDay(mon_beg_plot,day_beg_plot,year_beg_plot, hour_beg_plot,min_beg_plot,sec_beg_plot)
JulDay_end_plot = JulDay_beg_plot+0.5
caldat, JulDay_end_plot, month1, day1, year1, hour1, minut1, second1
year_end_plot=long(year1) & mon_end_plot=long(month1) & day_end_plot=long(day1)
hour_end_plot=long(hour1) & min_end_plot=long(minut1) & sec_end_plot=long(second1)

JulDay_end_plot = JulDay(mon_end_plot,day_end_plot,year_end_plot, hour_end_plot,min_end_plot,sec_end_plot)
;;;---
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
dJulDay_interp    = Median(dJulDay_vect)
num_times_interp  = Floor((Max(JulDay_vect_plot)-Min(JulDay_vect_plot))/dJulDay_interp)+1
JulDay_vect_interp= Min(JulDay_vect_plot)+Dindgen(num_times_interp)*dJulDay_interp
Bx_GSE_vect_interp= Interpol_NearBy_MacOS(Bx_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
By_GSE_vect_interp= Interpol_NearBy_MacOS(By_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
Bz_GSE_vect_interp= Interpol_NearBy_MacOS(Bz_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)

;;--

JulDay_2s_vect = JulDay_vect_interp
Bx_GSE_2s_vect = Bx_GSE_vect_interp
By_GSE_2s_vect = By_GSE_vect_interp
Bz_GSE_2s_vect = Bz_GSE_vect_interp

 ;保存第i_num个例子的磁场数据   
dir_save  = file_all_sav
file_save = 'B_'+string(i_num+1)+'.sav'
data_descrip= 'got from "start_time.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect
 
 
 
;read velocity

;;--
dir_read  = file_pm_3dp
file_read = 'wi_pm_3dp_'+year+month+day+'_v*.cdf'
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

;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_2s_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_DENS', P_DEN_3s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_VELS', P_VEL_3s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_TEMP', P_TEMP_3s_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_2s_vect = Reform(Epoch_2s_vect)
epoch_beg   = Epoch_2s_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_2s_vect  = JulDay_beg+(Epoch_2s_vect-Epoch_beg)/(1.e3*24.*60.*60.)


;;--
BadVal  = -1.e31
;;;---
Px_VEL_3s_vect  = Reform(P_VEL_3s_arr(0,*))

Px_VEL_3s_vect_v2 = Px_VEL_3s_vect(where(finite(Px_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Px_VEL_3s_vect)))
Px_VEL_3s_vect  = Interpol(Px_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值



;;;---
Py_VEL_3s_vect  = Reform(P_VEL_3s_arr(1,*))

Py_VEL_3s_vect_v2 = Py_VEL_3s_vect(where(finite(Py_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Py_VEL_3s_vect)))
Py_VEL_3s_vect  = Interpol(Py_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
Pz_VEL_3s_vect  = Reform(P_VEL_3s_arr(2,*))

Pz_VEL_3s_vect_v2 = Pz_VEL_3s_vect(where(finite(Pz_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Pz_VEL_3s_vect)))
Pz_VEL_3s_vect  = Interpol(Pz_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
P_DEN_3s_vect  = Reform(P_DEN_3s_arr(0,*))

P_DEN_3s_vect_v2 = P_DEN_3s_vect(where(finite(P_DEN_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_DEN_3s_vect)))
P_DEN_3s_vect  = Interpol(P_DEN_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值


P_TEMP_3s_vect  = Reform(P_TEMP_3s_arr(0,*))

P_TEMP_3s_vect_v2 = P_TEMP_3s_vect(where(finite(P_TEMP_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_TEMP_3s_vect)))
P_TEMP_3s_vect  = Interpol(P_TEMP_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值

;;;---
P_VEL_3s_arr(0,*)  = Transpose(Px_VEL_3s_vect)
P_VEL_3s_arr(1,*)  = Transpose(Py_VEL_3s_vect)
P_VEL_3s_arr(2,*)  = Transpose(Pz_VEL_3s_vect)
P_DEN_3s_arr(0,*)  = Transpose(P_DEN_3s_vect)
P_TEMP_3s_arr(0,*)  = Transpose(P_TEMP_3s_vect)

;;--

num_times = Floor((Max(JulDay_2s_vect)-Min(JulDay_2s_vect))/(3.0/(24.*60*60)))   ;3s是分辨率

JulDay_beg  = Min(JulDay_2s_vect)
JulDay_end  = Max(JulDay_2s_vect)
JulDay_2s_vect_v3 = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)
;;;---
Px_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
Py_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(1,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
Pz_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(2,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_DEN_3s_vect_v3 = Interpol(Reform(P_DEN_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_TEMP_3s_vect_v3 = Interpol(Reform(P_TEMP_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_VEL_3s_arr_v3  = Fltarr(3,num_times)
P_DEN_3s_arr_v3  = Fltarr(1,num_times)
P_TEMP_3s_arr_v3  = Fltarr(1,num_times) 
P_VEL_3s_arr_v3(0,*) = Transpose(Px_VEL_3s_vect_v3)
P_VEL_3s_arr_v3(1,*) = Transpose(Py_VEL_3s_vect_v3)
P_VEL_3s_arr_v3(2,*) = Transpose(Pz_VEL_3s_vect_v3)
P_DEN_3s_arr_v3(0,*) = Transpose(P_DEN_3s_vect_v3)
P_TEMP_3s_arr_v3(0,*) = Transpose(P_TEMP_3s_vect_v3)

Px_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(0,*))
Py_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(1,*))
Pz_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(2,*))
P_DEN_3s_vect = Reform(P_DEN_3s_arr_v3(0,*))
P_TEMP_3s_vect = Reform(P_TEMP_3s_arr_v3(0,*))
;;;---
JulDay_2s_vect  = JulDay_2s_vect_v3
P_VEL_3s_arr = P_VEL_3s_arr_v3
P_DEN_3s_arr = P_DEN_3s_vect_v3
P_TEMP_3s_arr = P_TEMP_3s_vect_v3


;读取所要的一段时间

JulDay_beg = JulDay(month,day,year,hour,minut,second)
JulDay_end = JulDay_beg + 0.5
Caldat, JulDay_end, monthe, daye, yeare, houre, minute, seconde
sub_yao = where(JulDay_2s_vect ge Julday_beg and JulDay_2s_vect le Julday_end)


Px_VEL_3s_vect = Px_VEL_3s_vect(sub_yao)
Py_VEL_3s_vect = Py_VEL_3s_vect(sub_yao)
Pz_VEL_3s_vect = Pz_VEL_3s_vect(sub_yao)
JulDay_2s_vect = JulDay_2s_vect(sub_yao)


 ;保存第i_num个例子的速度数据 ，速度数据用来计算平均太阳风 
dir_save  = file_all_sav
file_save = 'V_'+string(i_num+1)+'.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, $
  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect
 


;做磁场的傅里叶变换，并计算功率谱

Vtotal = sqrt(Px_VEL_3s_vect^2.0+Py_VEL_3s_vect^2.0+Pz_VEL_3s_vect^2.0)
Vave = mean(Vtotal,/nan)

Btotal = sqrt(Bx_GSE_2s_vect^2.0+By_GSE_2s_vect^2.0+Bz_GSE_2s_vect^2.0)
Bave = mean(Btotal,/nan)


i_BComp = 0
for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = Bx_GSE_2s_vect
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = By_GSE_2s_vect
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = Bz_GSE_2s_vect
EndIf
wave_vect = BComp_RTN_vect

num_times = N_Elements(JulDay_vect_interp)
time_vect = (JulDay_vect_interp(0:num_times-1)-JulDay_vect_interp(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times


;;;
num_sets  = 1
type_window = 1

get_PSD_from_FFT_Method, time_vect, wave_vect, $
    num_sets=num_sets, type_window=type_window, $
    freq_vect_FFT, PSD_vect_FFT
    
    

If i_BComp eq 1 Then Begin
  PSD_Bx_FFt  = PSD_vect_FFT
EndIf
If i_BComp eq 2 Then Begin
  PSD_By_FFT  = PSD_vect_FFT
EndIf
If i_BComp eq 3 Then Begin
  PSD_Bz_FFT  = PSD_vect_FFT
EndIf


endfor

PSD_Bt_FFT = PSD_Bx_FFT+PSD_By_FFT+PSD_Bz_FFT



;计算拟合范围,考虑相对论效应
;step3_1:


r_min = (3.2/9.1/9.0+1.0)*9.1*3*1.e2/Bave/1.6*sqrt(1.-1./(3.2/9.1/9.0+1.0)^2.0)
r_max = (32./9.1/9.0+1.0)*9.1*3*1.e2/Bave/1.6*sqrt(1.-1./(32./9.1/9.0+1.0)^2.0)


f_max(i_num) = Vave/2/!pi/r_min
f_min(i_num) = Vave/2/!pi/r_max

;step3_2:做对数线性拟合

PSD_Bt = PSD_Bt_FFT

xrange=[0.001,10.0]
yrange=[1.0e-5,1.0e4]    
window,1,title='PSD-frequency'    
Plot,freq_vect_FFT, PSD_Bt,xtitle='frequency(Hz)',ytitle='PSD(nT^2/HZ)',xrange=xrange,yrange=yrange,/XLOG,/YLOG    



 sm_PSD_vect_FFT = lsmth(PSD_Bt,0.1)
 
 window,2,title='PSD-frequency after smooth'
 Plot,freq_vect_FFT, sm_PSD_vect_FFT,xtitle='frequency(Hz)',ytitle='PSD(nT^2/Hz)',xrange=xrange,yrange=yrange,/XLOG,/YLOG  

 
m=0L
n=0L
while  freq_vect_FFT(n) le f_min(i_num) do begin  ;拟合范围
  n=n+1
endwhile
while  freq_vect_FFT(m) le f_max(i_num) do begin
  m=m+1
endwhile
result = linfit(alog10(freq_vect_FFT(n:(m-1))),alog10(sm_PSD_vect_FFT(n:(m-1))),sigma=sigma)
print,result 
x=freq_vect_FFT(n:(m-1))
y=10.^(result(0)+result(1)*alog10(x))
;window,2
plot,x,y,xrange=xrange,yrange=yrange,color='0000ff'XL,xstyle=4,ystyle=4,/XLOG,/YLOG,/noerase

xyouts,300,330,'k='+strtrim(string(round(result(1)*1000.)/1000.,format='(A11)'),2)+textoIDL('\pm')  $
      +strtrim(string(round(sigma(1)*1000.)/1000.,format='(A8)'),2),charsize=1.0,charthick=1,/DEvice 
xyouts,300,310,'log(PSD_0)='+strtrim(string(round(result(0)*1000.)/1000.,format='(A11)'),2)+textoIDL('\pm')  $
      +strtrim(string(round(sigma(0)*1000.)/1000.,format='(A8)'),2),charsize=1.0,charthick=1,/DEvice
xyouts,300,290,'Date:'+year+'/'+month+'/'+day+'/'+hour+':'+minut+':'+second,charsize=1.0,charthick=1,/DEvice
xyouts,320,270,'---'+strtrim(string(yeare),2)+'/'+strtrim(string(monthe),2)+'/'+strtrim(string(daye),2)+'/'+strtrim(string(houre),2)+':'+strtrim(string(minute),2)+':'+strtrim(string(round(seconde)),2),charsize=1.0,charthick=1,/DEvice
xyouts,300,250,'fitting frequecy range:'+strtrim(string(round(f_min(i_num)*1000.)/1000.,format='(A10)'),2)+'---'+strtrim(string(round(f_max(i_num)*1000.)/1000.,format='(A10)'),2)+'Hz',charsize=1.0,charthick=1,/DEvice 


image_tvrd = TVRD(true=1)
dir_fig   = file_all_sav
file_version= '(v1)'
file_fig  = 'Bmag'+string(i_num+1)+'_PSD_FFT_smooth'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd





endif



;for after 12:00
  if second_num gt 43200 then begin 

julday_f = julday(long(month),long(day),long(year),long(hour),long(minut),long(second))
julday_a = julday_f+1.0
caldat, julday_a, month1, day1, year1, hour1, minut1, second1



;    读磁场数据
dir_read  = file_h2_mif
file_read = 'wi_h2_mfi_'+year+month+day+'_v*.cdf'
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
;;;---

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
Bxyz_GSE_arr(0,*)  = Transpose(Bx_GSE_vect)
Bxyz_GSE_arr(1,*)  = Transpose(By_GSE_vect)
Bxyz_GSE_arr(2,*)  = Transpose(Bz_GSE_vect)
    


;;--
year_beg_plot=long(year) & mon_beg_plot=long(month) & day_beg_plot=long(day)
hour_beg_plot=0 & min_beg_plot=0 & sec_beg_plot=0
JulDay_beg_plot = JulDay(mon_beg_plot,day_beg_plot,year_beg_plot, hour_beg_plot,min_beg_plot,sec_beg_plot)
JulDay_end_plot = JulDay_beg_plot+1.0
caldat, JulDay_end_plot, monthh, dayh, yearh, hourh, minuth, secondh
year_end_plot=long(yearh) & mon_end_plot=long(monthh) & day_end_plot=long(dayh)
hour_end_plot=0 & min_end_plot=0 & sec_end_plot=0

JulDay_end_plot = JulDay(mon_end_plot,day_end_plot,year_end_plot, hour_end_plot,min_end_plot,sec_end_plot)
;;;---
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
dJulDay_interp    = Median(dJulDay_vect)
num_times_interp  = Floor((Max(JulDay_vect_plot)-Min(JulDay_vect_plot))/dJulDay_interp)+1
JulDay_vect_interp= Min(JulDay_vect_plot)+Dindgen(num_times_interp)*dJulDay_interp
Bx_GSE_vect_interp= Interpol_NearBy_MacOS(Bx_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
By_GSE_vect_interp= Interpol_NearBy_MacOS(By_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
Bz_GSE_vect_interp= Interpol_NearBy_MacOS(Bz_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)

;;--
dir_save  = file_all_sav
file_save = 'Bxyz_GSE_arr'+'_'+year+month+day+'.sav'
TimeRange_str = TimeRange_plot_str
data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    TimeRange_str, $
    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp
    


;读第二天的磁场数据
year1 = strtrim(string(year1),2)
month1 = strtrim(string(month1),2)
day1 = strtrim(string(day1),2)
hour1 = strtrim(string(hour1),2)
minut1 = strtrim(string(minut1),2)
second1 = strtrim(string(second1),2)
if strlen(month1) eq 1 then month1 = '0'+month1
if strlen(day1) eq 1 then day1 = '0'+day1
if strlen(hour1) eq 1 then hour1 = '0'+hour1
if strlen(minut1) eq 1 then minut1 = '0'+minut1
if strlen(second1) eq 1 then second1 = '0'+second1



;    
dir_read  = file_h2_mif
file_read = 'wi_h2_mfi_'+year1+month1+day1+'_v*.cdf'
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
;;;---

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
Bxyz_GSE_arr(0,*)  = Transpose(Bx_GSE_vect)
Bxyz_GSE_arr(1,*)  = Transpose(By_GSE_vect)
Bxyz_GSE_arr(2,*)  = Transpose(Bz_GSE_vect)
    



;;--
year_beg_plot=long(year1) & mon_beg_plot=long(month1) & day_beg_plot=long(day1)
hour_beg_plot=0 & min_beg_plot=0 & sec_beg_plot=0
JulDay_beg_plot = JulDay(mon_beg_plot,day_beg_plot,year_beg_plot, hour_beg_plot,min_beg_plot,sec_beg_plot)
JulDay_end_plot = JulDay_beg_plot+1.0
caldat, JulDay_end_plot, monthh, dayh, yearh, hourh, minuth, secondh
year_end_plot=long(yearh) & mon_end_plot=long(monthh) & day_end_plot=long(dayh)
hour_end_plot=0 & min_end_plot=0 & sec_end_plot=0

JulDay_end_plot = JulDay(mon_end_plot,day_end_plot,year_end_plot, hour_end_plot,min_end_plot,sec_end_plot)
;;;---
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
dJulDay_interp    = Median(dJulDay_vect)
num_times_interp  = Floor((Max(JulDay_vect_plot)-Min(JulDay_vect_plot))/dJulDay_interp)+1
JulDay_vect_interp= Min(JulDay_vect_plot)+Dindgen(num_times_interp)*dJulDay_interp
Bx_GSE_vect_interp= Interpol_NearBy_MacOS(Bx_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
By_GSE_vect_interp= Interpol_NearBy_MacOS(By_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)
Bz_GSE_vect_interp= Interpol_NearBy_MacOS(Bz_GSE_vect_plot, JulDay_vect_plot, JulDay_vect_interp, NearBy=1)

;;--
dir_save  = file_all_sav
file_save = 'Bxyz_GSE_arr'+'_'+year1+month1+day1+'.sav'
TimeRange_str = TimeRange_plot_str
data_descrip  = 'got from "Read_WIND_MFI_H2_CDF_199502.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip, $
    TimeRange_str, $
    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp
    


;连接两天的数据

JulDay_2s_vect1 = JulDay_vect_interp
Bx_GSE_2s_vect1 = Bx_GSE_vect_interp
By_GSE_2s_vect1 = By_GSE_vect_interp
Bz_GSE_2s_vect1 = Bz_GSE_vect_interp

;;--

dir_restore = file_all_sav
file_restore= 'Bxyz_GSE_arr'+'_'+year+month+day+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp

JulDay_2s_vect0 = JulDay_vect_interp
Bx_GSE_2s_vect0 = Bx_GSE_vect_interp
By_GSE_2s_vect0 = By_GSE_vect_interp
Bz_GSE_2s_vect0 = Bz_GSE_vect_interp



a1=N_elements(JulDay_2s_vect0)
a2=N_elements(JulDay_2s_vect1)
JulDay_2s_vect = dblarr(a1+a2)
JulDay_2s_vect(0:a1-1)=JulDay_2s_vect0
JulDay_2s_vect(a1:a1+a2-1)=JulDay_2s_vect1



b1=N_elements(Bx_GSE_2s_vect0)
b2=N_elements(Bx_GSE_2s_vect1)
Bx_GSE_2s_vect = dblarr(b1+b2)
Bx_GSE_2s_vect(0:b1-1)=Bx_GSE_2s_vect0
Bx_GSE_2s_vect(b1:b1+b2-1)=Bx_GSE_2s_vect1

c1=N_elements(By_GSE_2s_vect0)
c2=N_elements(By_GSE_2s_vect1)
By_GSE_2s_vect = dblarr(c1+c2)
By_GSE_2s_vect(0:c1-1)=By_GSE_2s_vect0
By_GSE_2s_vect(c1:c1+c2-1)=By_GSE_2s_vect1

d1=N_elements(Bz_GSE_2s_vect0)
d2=N_elements(Bz_GSE_2s_vect1)
Bz_GSE_2s_vect = dblarr(d1+d2)
Bz_GSE_2s_vect(0:d1-1)=Bz_GSE_2s_vect0
Bz_GSE_2s_vect(d1:d1+d2-1)=Bz_GSE_2s_vect1


;截取我们需要的时间段,并插值
JulDay_beg = JulDay(month,day,year,hour,minut,second)
JulDay_end = JulDay_beg + 0.5
sub_yao = where(JulDay_2s_vect ge Julday_beg and JulDay_2s_vect le Julday_end)

Bx_GSE_2s_vect = Bx_GSE_2s_vect(sub_yao)
By_GSE_2s_vect = By_GSE_2s_vect(sub_yao)
Bz_GSE_2s_vect = Bz_GSE_2s_vect(sub_yao)
JulDay_2s_vect = JulDay_2s_vect(sub_yao)

num_v2 = n_elements(Bx_GSE_2s_vect)
dt_v2 = JulDay_2s_vect(1)-JulDay_2s_vect(0)
JulDay_beg_v2  = Min(JulDay_2s_vect)
JulDay_2s_vect_v2 = JulDay_beg_v2+findgen(num_v2)*dt_v2
Bx_GSE_2s_vect_v2 = Interpol(Bx_GSE_2s_vect, JulDay_2s_vect, JulDay_2s_vect_v2)
By_GSE_2s_vect_v2 = Interpol(By_GSE_2s_vect, JulDay_2s_vect, JulDay_2s_vect_v2)
Bz_GSE_2s_vect_v2 = Interpol(Bz_GSE_2s_vect, JulDay_2s_vect, JulDay_2s_vect_v2)

JulDay_2s_vect = JulDay_2s_vect_v2
Bx_GSE_2s_vect = Bx_GSE_2s_vect_v2
By_GSE_2s_vect = By_GSE_2s_vect_v2
Bz_GSE_2s_vect = Bz_GSE_2s_vect_v2

dir_save  = file_all_sav
file_save = 'B_'+string(i_num+1)+'.sav'
data_descrip= 'got from "start_time.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect
  
JulDay_Byao = JulDay_2s_vect

  
 ;读速度数据
 ;
;;--
dir_read  = file_pm_3dp
file_read = 'wi_pm_3dp_'+year+month+day+'_v*.cdf'
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

;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_2s_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_DENS', P_DEN_3s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_VELS', P_VEL_3s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_TEMP', P_TEMP_3s_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_2s_vect = Reform(Epoch_2s_vect)
epoch_beg   = Epoch_2s_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_2s_vect  = JulDay_beg+(Epoch_2s_vect-Epoch_beg)/(1.e3*24.*60.*60.)


;;--
BadVal  = -1.e31
;;;---
Px_VEL_3s_vect  = Reform(P_VEL_3s_arr(0,*))

Px_VEL_3s_vect_v2 = Px_VEL_3s_vect(where(finite(Px_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Px_VEL_3s_vect)))
Px_VEL_3s_vect  = Interpol(Px_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值



;;;---
Py_VEL_3s_vect  = Reform(P_VEL_3s_arr(1,*))

Py_VEL_3s_vect_v2 = Py_VEL_3s_vect(where(finite(Py_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Py_VEL_3s_vect)))
Py_VEL_3s_vect  = Interpol(Py_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
Pz_VEL_3s_vect  = Reform(P_VEL_3s_arr(2,*))

Pz_VEL_3s_vect_v2 = Pz_VEL_3s_vect(where(finite(Pz_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Pz_VEL_3s_vect)))
Pz_VEL_3s_vect  = Interpol(Pz_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
P_DEN_3s_vect  = Reform(P_DEN_3s_arr(0,*))

P_DEN_3s_vect_v2 = P_DEN_3s_vect(where(finite(P_DEN_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_DEN_3s_vect)))
P_DEN_3s_vect  = Interpol(P_DEN_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值


P_TEMP_3s_vect  = Reform(P_TEMP_3s_arr(0,*))

P_TEMP_3s_vect_v2 = P_TEMP_3s_vect(where(finite(P_TEMP_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_TEMP_3s_vect)))
P_TEMP_3s_vect  = Interpol(P_TEMP_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值

;;;---
P_VEL_3s_arr(0,*)  = Transpose(Px_VEL_3s_vect)
P_VEL_3s_arr(1,*)  = Transpose(Py_VEL_3s_vect)
P_VEL_3s_arr(2,*)  = Transpose(Pz_VEL_3s_vect)
P_DEN_3s_arr(0,*)  = Transpose(P_DEN_3s_vect)
P_TEMP_3s_arr(0,*)  = Transpose(P_TEMP_3s_vect)



num_times = Floor((Max(JulDay_2s_vect)-Min(JulDay_2s_vect))/(3.0/(24.*60*60)))   ;3s是分辨率

JulDay_beg  = Min(JulDay_2s_vect)
JulDay_end  = Max(JulDay_2s_vect)
JulDay_2s_vect_v3 = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)

Px_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
Py_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(1,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
Pz_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(2,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_DEN_3s_vect_v3 = Interpol(Reform(P_DEN_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_TEMP_3s_vect_v3 = Interpol(Reform(P_TEMP_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_VEL_3s_arr_v3  = Fltarr(3,num_times)
P_DEN_3s_arr_v3  = Fltarr(1,num_times)
P_TEMP_3s_arr_v3  = Fltarr(1,num_times) 
P_VEL_3s_arr_v3(0,*) = Transpose(Px_VEL_3s_vect_v3)
P_VEL_3s_arr_v3(1,*) = Transpose(Py_VEL_3s_vect_v3)
P_VEL_3s_arr_v3(2,*) = Transpose(Pz_VEL_3s_vect_v3)
P_DEN_3s_arr_v3(0,*) = Transpose(P_DEN_3s_vect_v3)
P_TEMP_3s_arr_v3(0,*) = Transpose(P_TEMP_3s_vect_v3)

Px_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(0,*))
Py_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(1,*))
Pz_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(2,*))
P_DEN_3s_vect = Reform(P_DEN_3s_arr_v3(0,*))
P_TEMP_3s_vect = Reform(P_TEMP_3s_arr_v3(0,*))

JulDay_2s_vect  = JulDay_2s_vect_v3
P_VEL_3s_arr = P_VEL_3s_arr_v3
P_DEN_3s_arr = P_DEN_3s_vect_v3
P_TEMP_3s_arr = P_TEMP_3s_vect_v3


dir_save  = file_all_sav
file_save = 'wi_pm_3dp_'+year+month+day+'_v'+'.sav'
data_descrip= 'got from "Read_proton_velocity.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
  P_TEMP_3s_vect
  
  
  
;;;
;读取第二天速度
year1 = strtrim(string(year1),2)
month1 = strtrim(string(month1),2)
day1 = strtrim(string(day1),2)
hour1 = strtrim(string(hour1),2)
minut1 = strtrim(string(minut1),2)
second1 = strtrim(string(second1),2)
if strlen(month1) eq 1 then month1 = '0'+month1
if strlen(day1) eq 1 then day1 = '0'+day1
if strlen(hour1) eq 1 then hour1 = '0'+hour1
if strlen(minut1) eq 1 then minut1 = '0'+minut1
if strlen(second1) eq 1 then second1 = '0'+second1


;;;---
dir_read  = file_pm_3dp
file_read = 'wi_pm_3dp_'+year1+month1+day1+'_v*.cdf'
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

;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_2s_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_DENS', P_DEN_3s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_VELS', P_VEL_3s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'P_TEMP', P_TEMP_3s_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_2s_vect = Reform(Epoch_2s_vect)
epoch_beg   = Epoch_2s_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_2s_vect  = JulDay_beg+(Epoch_2s_vect-Epoch_beg)/(1.e3*24.*60.*60.)


;;--
BadVal  = -1.e31
;;;---
Px_VEL_3s_vect  = Reform(P_VEL_3s_arr(0,*))

Px_VEL_3s_vect_v2 = Px_VEL_3s_vect(where(finite(Px_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Px_VEL_3s_vect)))
Px_VEL_3s_vect  = Interpol(Px_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值



;;;---
Py_VEL_3s_vect  = Reform(P_VEL_3s_arr(1,*))

Py_VEL_3s_vect_v2 = Py_VEL_3s_vect(where(finite(Py_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Py_VEL_3s_vect)))
Py_VEL_3s_vect  = Interpol(Py_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
Pz_VEL_3s_vect  = Reform(P_VEL_3s_arr(2,*))

Pz_VEL_3s_vect_v2 = Pz_VEL_3s_vect(where(finite(Pz_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Pz_VEL_3s_vect)))
Pz_VEL_3s_vect  = Interpol(Pz_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
P_DEN_3s_vect  = Reform(P_DEN_3s_arr(0,*))

P_DEN_3s_vect_v2 = P_DEN_3s_vect(where(finite(P_DEN_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_DEN_3s_vect)))
P_DEN_3s_vect  = Interpol(P_DEN_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值


P_TEMP_3s_vect  = Reform(P_TEMP_3s_arr(0,*))

P_TEMP_3s_vect_v2 = P_TEMP_3s_vect(where(finite(P_TEMP_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_TEMP_3s_vect)))
P_TEMP_3s_vect  = Interpol(P_TEMP_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值

;;;---
P_VEL_3s_arr(0,*)  = Transpose(Px_VEL_3s_vect)
P_VEL_3s_arr(1,*)  = Transpose(Py_VEL_3s_vect)
P_VEL_3s_arr(2,*)  = Transpose(Pz_VEL_3s_vect)
P_DEN_3s_arr(0,*)  = Transpose(P_DEN_3s_vect)
P_TEMP_3s_arr(0,*)  = Transpose(P_TEMP_3s_vect)



num_times = Floor((Max(JulDay_2s_vect)-Min(JulDay_2s_vect))/(3.0/(24.*60*60)))   ;3s是分辨率

JulDay_beg  = Min(JulDay_2s_vect)
JulDay_end  = Max(JulDay_2s_vect)
JulDay_2s_vect_v3 = JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)

Px_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
Py_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(1,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
Pz_VEL_3s_vect_v3 = Interpol(Reform(P_VEL_3s_arr(2,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_DEN_3s_vect_v3 = Interpol(Reform(P_DEN_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_TEMP_3s_vect_v3 = Interpol(Reform(P_TEMP_3s_arr(0,*)), JulDay_2s_vect, JulDay_2s_vect_v3)
P_VEL_3s_arr_v3  = Fltarr(3,num_times)
P_DEN_3s_arr_v3  = Fltarr(1,num_times)
P_TEMP_3s_arr_v3  = Fltarr(1,num_times) 
P_VEL_3s_arr_v3(0,*) = Transpose(Px_VEL_3s_vect_v3)
P_VEL_3s_arr_v3(1,*) = Transpose(Py_VEL_3s_vect_v3)
P_VEL_3s_arr_v3(2,*) = Transpose(Pz_VEL_3s_vect_v3)
P_DEN_3s_arr_v3(0,*) = Transpose(P_DEN_3s_vect_v3)
P_TEMP_3s_arr_v3(0,*) = Transpose(P_TEMP_3s_vect_v3)

Px_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(0,*))
Py_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(1,*))
Pz_VEL_3s_vect = Reform(P_VEL_3s_arr_v3(2,*))
P_DEN_3s_vect = Reform(P_DEN_3s_arr_v3(0,*))
P_TEMP_3s_vect = Reform(P_TEMP_3s_arr_v3(0,*))

JulDay_2s_vect  = JulDay_2s_vect_v3
P_VEL_3s_arr = P_VEL_3s_arr_v3
P_DEN_3s_arr = P_DEN_3s_vect_v3
P_TEMP_3s_arr = P_TEMP_3s_vect_v3


;连接两天速度数据

JulDay_2s_vect1 = JulDay_2s_vect
Px_VEL_3s_vect1 = Px_VEL_3s_vect
Py_VEL_3s_vect1 = Py_VEL_3s_vect
Pz_VEL_3s_vect1 = Pz_VEL_3s_vect

;;--

dir_restore = file_all_sav
file_restore= 'wi_pm_3dp_'+year+month+day+'_v'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp

JulDay_2s_vect0 = JulDay_2s_vect
Px_VEL_3s_vect0 = Px_VEL_3s_vect
Py_VEL_3s_vect0 = Py_VEL_3s_vect
Pz_VEL_3s_vect0 = Pz_VEL_3s_vect



a1=N_elements(JulDay_2s_vect0)
a2=N_elements(JulDay_2s_vect1)
JulDay_2s_vect = dblarr(a1+a2)
JulDay_2s_vect(0:a1-1)=JulDay_2s_vect0
JulDay_2s_vect(a1:a1+a2-1)=JulDay_2s_vect1



b1=N_elements(Px_VEL_3s_vect0)
b2=N_elements(Px_VEL_3s_vect1)
Px_VEL_3s_vect = dblarr(b1+b2)
Px_VEL_3s_vect(0:b1-1)=Px_VEL_3s_vect0
Px_VEL_3s_vect(b1:b1+b2-1)=Px_VEL_3s_vect1

c1=N_elements(Py_VEL_3s_vect0)
c2=N_elements(Py_VEL_3s_vect1)
Py_VEL_3s_vect = dblarr(c1+c2)
Py_VEL_3s_vect(0:c1-1)=Py_VEL_3s_vect0
Py_VEL_3s_vect(c1:c1+c2-1)=Py_VEL_3s_vect1

d1=N_elements(Pz_VEL_3s_vect0)
d2=N_elements(Pz_VEL_3s_vect1)
Pz_VEL_3s_vect = dblarr(d1+d2)
Pz_VEL_3s_vect(0:d1-1)=Pz_VEL_3s_vect0
Pz_VEL_3s_vect(d1:d1+d2-1)=Pz_VEL_3s_vect1


;截取需要的时间段
JulDay_beg = JulDay(month,day,year,hour,minut,second)
JulDay_end = JulDay_beg + 0.5
Caldat, JulDay_end, monthe, daye, yeare, houre, minute, seconde
sub_yao = where(JulDay_2s_vect ge Julday_beg and JulDay_2s_vect le Julday_end)


Px_VEL_3s_vect = Px_VEL_3s_vect(sub_yao)
Py_VEL_3s_vect = Py_VEL_3s_vect(sub_yao)
Pz_VEL_3s_vect = Pz_VEL_3s_vect(sub_yao)

JulDay_2s_vect = JulDay_2s_vect(sub_yao)


dir_save  = file_all_sav
file_save = 'V_'+string(i_num+1)+'.sav'
data_descrip= 'got from "start_time.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect



;做磁场傅里叶变换并计算功率谱
Vtotal = sqrt(Px_VEL_3s_vect^2.0+Py_VEL_3s_vect^2.0+Pz_VEL_3s_vect^2.0)
Vave = mean(Vtotal,/nan)

Btotal = sqrt(Bx_GSE_2s_vect^2.0+By_GSE_2s_vect^2.0+Bz_GSE_2s_vect^2.0)
Bave = mean(Btotal,/nan)


i_BComp = 0
for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then FileName_BComp='Bx'
If i_BComp eq 2 Then FileName_BComp='By'
If i_Bcomp eq 3 Then FileName_BComp='Bz'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = Bx_GSE_2s_vect
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = By_GSE_2s_vect
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = Bz_GSE_2s_vect
EndIf
wave_vect = BComp_RTN_vect

num_times = N_Elements(JulDay_Byao)
time_vect = (JulDay_Byao(0:num_times-1)-JulDay_Byao(0))*(24.*60.*60.)
dtime = Mean(time_vect(1:num_times-1)-time_vect(0:num_times-2))
ntime = num_times


;;;
num_sets  = 1
type_window = 1

get_PSD_from_FFT_Method, time_vect, wave_vect, $
    num_sets=num_sets, type_window=type_window, $
    freq_vect_FFT, PSD_vect_FFT
    
    

If i_BComp eq 1 Then Begin
  PSD_Bx_FFt  = PSD_vect_FFT
EndIf
If i_BComp eq 2 Then Begin
  PSD_By_FFT  = PSD_vect_FFT
EndIf
If i_BComp eq 3 Then Begin
  PSD_Bz_FFT  = PSD_vect_FFT
EndIf


endfor

PSD_Bt_FFT = PSD_Bx_FFT+PSD_By_FFT+PSD_Bz_FFT



;计算拟合范围,考虑相对论效应
;step3_1:


r_min = (3.2/9.1/9.0+1.0)*9.1*3*1.e2/Bave/1.6*sqrt(1.-1./(3.2/9.1/9.0+1.0)^2.0)
r_max = (32./9.1/9.0+1.0)*9.1*3*1.e2/Bave/1.6*sqrt(1.-1./(32./9.1/9.0+1.0)^2.0)


f_max(i_num) = Vave/2/!pi/r_min
f_min(i_num) = Vave/2/!pi/r_max

;step3_2:做对数线性拟合

PSD_Bt = PSD_Bt_FFT

xrange=[0.001,10.0]
yrange=[1.0e-5,1.0e4]    
window,1,title='PSD-frequency'    
Plot,freq_vect_FFT, PSD_Bt,xtitle='frequency(Hz)',ytitle='PSD(nT^2/HZ)',xrange=xrange,yrange=yrange,/XLOG,/YLOG    



 sm_PSD_vect_FFT = lsmth(PSD_Bt,0.1)
 
 window,2,title='PSD-frequency after smooth'
 Plot,freq_vect_FFT, sm_PSD_vect_FFT,xtitle='frequency(Hz)',ytitle='PSD(nT^2/Hz)',xrange=xrange,yrange=yrange,/XLOG,/YLOG  

 
m=0L
n=0L
while  freq_vect_FFT(n) le f_min(i_num) do begin  ;拟合范围
  n=n+1
endwhile
while  freq_vect_FFT(m) le f_max(i_num) do begin
  m=m+1
endwhile
result = linfit(alog10(freq_vect_FFT(n:(m-1))),alog10(sm_PSD_vect_FFT(n:(m-1))),sigma=sigma)
print,result 
x=freq_vect_FFT(n:(m-1))
y=10.^(result(0)+result(1)*alog10(x))
;window,2
plot,x,y,xrange=xrange,yrange=yrange,color='0000ff'XL,xstyle=4,ystyle=4,/XLOG,/YLOG,/noerase

xyouts,300,330,'k='+strtrim(string(round(result(1)*1000.)/1000.,format='(A11)'),2)+textoIDL('\pm')  $
      +strtrim(string(round(sigma(1)*1000.)/1000.,format='(A8)'),2),charsize=1.0,charthick=1,/DEvice 
xyouts,300,310,'log(PSD_0)='+strtrim(string(round(result(0)*1000.)/1000.,format='(A11)'),2)+textoIDL('\pm')  $
      +strtrim(string(round(sigma(0)*1000.)/1000.,format='(A8)'),2),charsize=1.0,charthick=1,/DEvice
xyouts,300,290,'Date:'+year+'/'+month+'/'+day+'/'+hour+':'+minut+':'+second,charsize=1.0,charthick=1,/DEvice
xyouts,320,270,'---'+strtrim(string(yeare),2)+'/'+strtrim(string(monthe),2)+'/'+strtrim(string(daye),2)+'/'  $
    +strtrim(string(houre),2)+':'+strtrim(string(minute),2)+':'+strtrim(string(round(seconde)),2),charsize=1.0,charthick=1,/DEvice
xyouts,300,250,'fitting frequecy range:'+strtrim(string(round(f_min(i_num)*1000.)/1000.,format='(A10)'),2)+  $
    '---'+strtrim(string(round(f_max(i_num)*1000.)/1000.,format='(A10)'),2)+'Hz',charsize=1.0,charthick=1,/DEvice 
 
image_tvrd = TVRD(true=1)
dir_fig   = file_all_sav
file_version= '(v1)'
file_fig  = 'Bmag'+string(i_num+1)+'_PSD_FFT_smooth'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd





endif


Bmag_average(i_num) = Bave
Velo_average(i_num) = Vave
B_slope(i_num) = result(1)
power_level(i_num) = result(0)



;最终保存的结果
dir_save = file_all_sav
file_save = 'Fit_log_PSD_frequency_Bmag_from_FFT.sav'
data_descrip='got from "start_time.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
    Bmag_average, Velo_average, B_slope, power_level,  $
    f_min, f_max                                                ;power_level:log(PSD(nT^2/Hz)) when f=1Hz on the fitting line
  ;f_min: the minimun of frequency     f_max: the maxima of frequency



;endfor







end_program:
end