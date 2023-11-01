;pro get_CorrCoeffs_B_V_Components_EveryTimeInterval(v2)

;wk_dir  = '/Work/Data Analysis/Helios data process/Program/VDF_interpolate/VDF_interpolate/'
;wk_dir  = '/Work/Data Analysis/WIND data process/Programs/2000-06/VDF_interpolate/';/VDF_interpolate/'
;CD, wk_dir

year_str= '2002'
;d mon_str = '12'
;d day_str = '31'
;d sub_dir_date= '2005-03/';'1995-01--1995-02/';'1995-'+mon_str+'-'+day_str+'/'
;d sub_dir_date= year_str+'/'+year_str+'-'+mon_str+'/'
;d sub_dir_name= ''

;d dir_data_v1 = '/Work/Data Analysis/WIND data process/Data/'+sub_dir_name+sub_dir_date+''
;d dir_data_v2 = '/Work/Data Analysis/MFI data process/Data/'+sub_dir_date+''
;d dir_fig     = '/Work/Data Analysis/WIND data process/Figures/'+sub_dir_name+sub_dir_date+''

dir_data_3DP	= 'C:\Users\pzt\course\Research\He\3dp_WangLH\'
dir_data_MFI	= 'C:\Users\pzt\course\Research\He\mfi_WangLH\'
dir_data_ORB	= 'C:\Users\pzt\course\Research\or_pre\'
dir_data_CC	= 'C:\Users\pzt\course\Research\He\' 


Step1:
;=====================
;Step1

;;--
dir_read	= dir_data_3DP 
file_read	= 'wi_pm_3dp_2002????_v0?.sav';file_read = 'wi_pm_3dp_20021126_v0?.sav'
file_array	= File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_file_beg	= 0
i_file_end	= num_files-1
Print, 'i_file_beg/end: ', i_file_beg, i_file_end
Read, 'i_file_beg, i_file_end: ', i_file_beg, i_file_end
file_write  = dir_data_CC + $
              'TimeStr_CC_CounterProp'+$
;              '(EveryTimeInterval='+TimeInterval_str+'min)'+$
;              '('+year_str+mon_str+day_str+')'+$              
              'v1'+'_'+year_str+'.txt'

OpenW, lun_tmp, file_write, /Get_Lun
PrintF, lun_tmp, '| TimeBeg_CounterProp | TimeEnd_CounterProp | CC_BxVx | CC_ByVy | CC_BzVz | Np | Tp | Vp | x_GSE(Re) | theta(B0,x) | theta(B0,y) | theta(B0,z) | Bx |'

;;--
For i_file=i_file_beg,i_file_end Do Begin


;;;---
file_read	= file_array(i_file)
file_restore	= file_read
file_read	= StrMid(file_read, StrLen(dir_read), StrLen(file_read)-StrLen(dir_read))

strlen_tmp	= StrLen('wi_pm_3dp_')
year_str	= StrMid(file_read, strlen_tmp, 4)
mon_str		= StrMid(file_read, strlen_tmp+4, 2)
day_str		= StrMid(file_read, strlen_tmp+4+2, 2)


file_restore_3DP  = file_restore ; 'wi_pm_3dp_'+year_str+mon_str+day_str+'_v03.sav'
;data_descrip= 'got from "Read_pm_3dp_WIND_CDF_20000608.pro"'
;data_descrip_v2 = 'unit: velocity [km/s in SC coordinate similar to GSE coordinate]; number density [cm^-3]; '+$
;                  'temperature [10^4 K]; tensor [(km/s)^2, in SC coordinate]'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  data_descrip_v2, $
;  JulDay_vect, Vxyz_GSE_p_arr, Vxyz_GSE_a_arr, $
;  NumDens_p_vect, NumDens_a_vect, Temper_p_vect, Temper_a_vect, $
;  Tensor_p_arr, Tensor_a_arr
;Note: sequence order stored in the tensor 
; vv_uniq  = [0,4,8,1,2,5]           ; => Uniq elements of a symmetric 3x3 matrix
; vv_trace = [0,4,8]                 ; => diagonal elements of a 3x3 matrix 
Restore, file_restore_3DP   ;dir_data_3DP + file_restore, /Verbose


;;;寻找长于3分钟没有数据的时间段
ntime = n_elements(JulDay_vect)
beg_gaplabel = dblarr(ntime)
end_gaplabel = dblarr(ntime)
if JulDay_vect(0)-round(JulDay_vect(0))+0.5 ge 3.0/(60.*24.) then begin
  beg_gaplabel(0) = round(JulDay_vect(0))-0.5
  end_gaplabel(0) = JulDay_vect(0)
endif
for i_t = 1,ntime-2 do begin
 ; i_t = 13914
  if JulDay_vect(i_t+1)-JulDay_vect(i_t) ge 3.0/(60.*24.) then begin
    beg_gaplabel(i_t) = JulDay_vect(i_t)
    end_gaplabel(i_t) = JulDay_vect(i_t+1)
  endif else begin
  endelse
endfor
if 0.5-(JulDay_vect(ntime-1)-round(JulDay_vect(ntime-1))) ge 3.0/(60.*24.) then begin
  end_gaplabel(ntime-1) = round(JulDay_vect(ntime-1))+0.5
  beg_gaplabel(ntime-1) = JulDay_vect(ntime-1)
endif

sub_gaplabel = where(beg_gaplabel ne 0)
beg_gaplabel = beg_gaplabel(sub_gaplabel)
end_gaplabel = end_gaplabel(sub_gaplabel)
ngap = n_elements(beg_gaplabel)



;;;;----
JulDay_3DP_vect = JulDay_vect

sub_tmp = Where(Vxyz_GSE_p_arr eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  Vxyz_GSE_p_arr(sub_tmp) = !values.f_nan
EndIf
sub_tmp = Where(NumDens_p_vect eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  NumDens_p_vect(sub_tmp) = !values.f_nan
EndIf
sub_tmp = Where(Temper_p_vect eq -1.e31)
If (sub_tmp(0) ne -1) Then Begin
  Temper_p_vect(sub_tmp) = !values.f_nan
EndIf


;;;---
file_read_MFI = 'wi_h0_mfi_'+year_str+mon_str+day_str+'_v0?.sav'	
file_array_v2	= File_Search(dir_data_MFI+file_read_MFI, count=num_files)
If num_files eq 1 Then Begin
	file_restore_MFI = file_array_v2(0)
EndIf
;a file_restore_MFI = 'wi_h0_mfi_'+year_str+mon_str+day_str+'_v05.sav'
;data_descrip  = 'got from "Read_WIND_MFI_H0_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect, Bxyz_GSE_arr
Restore, file_restore_MFI   ; dir_data_MFI + file_restore, /Verbose
;;;---
JulDay_MFI_vect = JulDay_vect


;;;---
file_read_ORB = 'wi_or_pre_'+year_str+mon_str+day_str+'_v0?.sav'	
file_array_v2	= File_Search(dir_data_ORB+file_read_ORB, count=num_files)
If num_files eq 1 Then Begin
	file_restore_ORB = file_array_v2(0)
EndIf
Restore, file_restore_ORB, /Verbose 
;data_descrip= 'got from "Read_OR_PRE_WIND_CDF_20000608.pro"'
;Save, FileName=dir_save+file_save, $
;	data_descrip, $
;	JulDay_vect_OR, Epoch_vect, $
;	xyz_GSE_arr
;;;---
JulDay_ORB_vect = JulDay_vect_OR



Step2:
;=====================
;Step2

;;--
year_val= Double(year_str)
mon_val = Double(mon_str)
day_val = Double(day_str)
JulDay_min  = JulDay(mon_val, day_val, year_val, 0.0, 0.0, 0.0)
JulDay_max  = JulDay(mon_val, day_val, year_val, 23., 59., 59.)
;JulDay_min = min(JulDay_3DP_vect)
;JulDay_max = max(JulDay_3DP_vect)

dJulDay_pix_interp  = 3.0/(24.*60*60)
num_times_interp    = Floor((JulDay_max-JulDay_min)/dJulDay_pix_interp,/L64) + 1L
JulDay_vect_interp  = JulDay_min + Dindgen(num_times_interp)*dJulDay_pix_interp

Vx_vect = Reform(Vxyz_GSE_p_arr(0,*))
Vy_vect = Reform(Vxyz_GSE_p_arr(1,*))
Vz_vect = Reform(Vxyz_GSE_p_arr(2,*))
Np_vect = NumDens_p_vect
Tp_vect = Temper_p_vect
Vx_vect_intp  = Interpol(Vx_vect, JulDay_3DP_vect, JulDay_vect_interp)
Vy_vect_intp  = Interpol(Vy_vect, JulDay_3DP_vect, JulDay_vect_interp)
Vz_vect_intp  = Interpol(Vz_vect, JulDay_3DP_vect, JulDay_vect_interp)
Np_vect_intp  = Interpol(Np_vect, JulDay_3DP_vect, JulDay_vect_interp)
Tp_vect_intp  = Interpol(Tp_vect, JulDay_3DP_vect, JulDay_vect_interp)

Bx_vect = Reform(Bxyz_GSE_arr(0,*))
By_vect = Reform(Bxyz_GSE_arr(1,*))
Bz_vect = Reform(Bxyz_GSE_arr(2,*))
Bx_vect_intp  = Interpol(Bx_vect, JulDay_MFI_vect, JulDay_vect_interp)
By_vect_intp  = Interpol(By_vect, JulDay_MFI_vect, JulDay_vect_interp)
Bz_vect_intp  = Interpol(Bz_vect, JulDay_MFI_vect, JulDay_vect_interp)
AbsB_vect_intp= Sqrt(Bx_vect_intp^2+By_vect_intp^2+Bz_vect_intp^2)


;;--
x_vect 	= Reform(xyz_GSE_arr(0,*))
y_vect	= Reform(xyz_GSE_arr(1,*))
z_vect	= Reform(xyz_GSE_arr(2,*))
x_vect_intp = Interpol(x_vect, JulDay_ORB_vect, JulDay_vect_interp)					
y_vect_intp = Interpol(y_vect, JulDay_ORB_vect, JulDay_vect_interp)					
z_vect_intp = Interpol(z_vect, JulDay_ORB_vect, JulDay_vect_interp)					



Step3:
;=====================
;Step3
;
;;--
dJulDay_seg_minute = 10.0
If i_file eq i_file_beg Then Begin
	Print, 'dJulDay_seg_minute: ', dJulDay_seg_minute
	Read, 'dJulDay_seg_minute reset to be: ', dJulDay_seg_minute
EndIf
dJulDay_seg = dJulDay_seg_minute*60./(24.*60*60)
TimeInterval_str  = String(dJulDay_seg*(24.*60*60)/60,format='(I2.2)')
num_segments= Floor((JulDay_max-JulDay_min)/dJulDay_seg,/L64) 
JulDay_min_seg_vect = JulDay_min + dJulDay_seg*Dindgen(num_segments)
JulDay_max_seg_vect = JulDay_min + dJulDay_seg*(Dindgen(num_segments)+1)
JulDay_cent_seg_vect= 0.5*(JulDay_min_seg_vect + JulDay_max_seg_vect)

CC_BxVx_seg_vect  = Dblarr(num_segments)
CC_ByVy_seg_vect  = Dblarr(num_segments)
CC_BzVz_seg_vect  = Dblarr(num_segments)
CC_nB_seg_vect    = Dblarr(num_segments)
Bx_bg_seg_vect = Dblarr(num_segments)
By_bg_seg_vect = Dblarr(num_segments)
Bz_bg_seg_vect = Dblarr(num_segments)
B0_bg_seg_vect = Dblarr(num_segments)
theta_Bx       = Dblarr(num_segments)
theta_By       = Dblarr(num_segments)
theta_Bz       = Dblarr(num_segments)
Vx_bg_seg_vect  = Dblarr(num_segments)
Vy_bg_seg_vect  = Dblarr(num_segments)
Vz_bg_seg_vect  = Dblarr(num_segments) 
Np_bg_seg_vect  = Dblarr(num_segments)
Tp_bg_seg_vect  = Dblarr(num_segments)
x_bg_seg_vect	= Dblarr(num_segments)
y_bg_seg_vect	= Dblarr(num_segments)
z_bg_seg_vect	= Dblarr(num_segments)


For i_seg=0,num_segments-1 Do Begin
  sub_in_seg  = Where(JulDay_vect_interp ge JulDay_min_seg_vect(i_seg) and JulDay_vect_interp lt JulDay_max_seg_vect(i_seg))
  If (sub_in_seg(0)) ne -1 Then Begin
    Bx_bg_seg_vect(i_seg)  = Mean(Bx_vect_intp(sub_in_seg),/nan)
    By_bg_seg_vect(i_seg)  = Mean(By_vect_intp(sub_in_seg),/nan)
    Bz_bg_seg_vect(i_seg)  = Mean(Bz_vect_intp(sub_in_seg),/nan)
    B0_bg_seg_vect(i_seg)  = Mean(absB_vect_intp(sub_in_seg),/nan)
    theta_Bx(i_seg)        = mean(acos(Bx_vect_intp(sub_in_seg)/absB_vect_intp(sub_in_seg)),/nan)*180/!pi
    theta_By(i_seg)        = mean(acos(By_vect_intp(sub_in_seg)/absB_vect_intp(sub_in_seg)),/nan)*180/!pi
    theta_Bz(i_seg)        = mean(acos(Bz_vect_intp(sub_in_seg)/absB_vect_intp(sub_in_seg)),/nan)*180/!pi        
    Vx_bg_seg_vect(i_seg)   = Mean(Vx_vect_intp(sub_in_seg),/nan)
    Vy_bg_seg_vect(i_seg)   = Mean(Vy_vect_intp(sub_in_seg),/nan)
    Vz_bg_seg_vect(i_seg)   = Mean(Vz_vect_intp(sub_in_seg),/nan)
    Np_bg_seg_vect(i_seg)  = Mean(Np_vect_intp(sub_in_seg),/nan)
    Tp_bg_seg_vect(i_seg)  = Mean(Tp_vect_intp(sub_in_seg),/nan)
    x_bg_seg_vect(i_seg)	= Mean(x_vect_intp(sub_in_seg),/nan)
    y_bg_seg_vect(i_seg)	= Mean(y_vect_intp(sub_in_seg),/nan)
    z_bg_seg_vect(i_seg)	= Mean(z_vect_intp(sub_in_seg),/nan)
    CC_BxVx_seg_vect(i_seg) = Correlate(Bx_vect_intp(sub_in_seg), Vx_vect_intp(sub_in_seg))
    CC_ByVy_seg_vect(i_seg) = Correlate(By_vect_intp(sub_in_seg), Vy_vect_intp(sub_in_seg))
    CC_BzVz_seg_vect(i_seg) = Correlate(Bz_vect_intp(sub_in_seg), Vz_vect_intp(sub_in_seg))
    CC_nB_seg_vect(i_seg)   = Correlate(Np_vect_intp(sub_in_seg), AbsB_vect_intp(sub_in_seg))
  EndIf  
EndFor



Step4:
;=====================
;Step4
;
;;--
; 'SWP': sunward-propagating; 'ASWMS': anti-sunward magnetic sector
BComp_bg_seg_threshold  = 1.0
CC_BV_seg_threshold     = 0.6
B_ts  = BComp_bg_seg_threshold
CC_ts = CC_BV_seg_threshold

sub_SWP_ASWMS_seg_vect  = Where(Bx_bg_seg_vect le -B_ts and By_bg_seg_vect ge +B_ts and $
                                  (CC_BxVx_seg_vect ge +CC_ts or CC_ByVy_seg_vect ge +CC_ts or CC_BzVz_seg_vect ge +CC_ts))
sub_SWP_SWMS_seg_vect   = Where(Bx_bg_seg_vect ge +B_ts and By_bg_seg_vect le -B_ts and $
                                  (CC_BxVx_seg_vect le -CC_ts or CC_ByVy_seg_vect le -CC_ts or CC_BzVz_seg_vect le -CC_ts))

sub_SWP_ASWMS_seg_vect  = Where(Bx_bg_seg_vect le -B_ts and By_bg_seg_vect ge -B_ts and $
                                  (CC_BxVx_seg_vect ge +CC_ts or CC_ByVy_seg_vect ge +CC_ts or CC_BzVz_seg_vect ge +CC_ts))
sub_SWP_SWMS_seg_vect   = Where(Bx_bg_seg_vect ge +B_ts  and By_bg_seg_vect le +B_ts and $
                                  (CC_BxVx_seg_vect le -CC_ts or CC_ByVy_seg_vect le -CC_ts or CC_BzVz_seg_vect le -CC_ts))

sub_SWP_ASWMS_seg_vect  = Where(Bx_bg_seg_vect le -B_ts and By_bg_seg_vect ge -100*B_ts and $
                                  (CC_BxVx_seg_vect ge +CC_ts or CC_ByVy_seg_vect ge +CC_ts or CC_BzVz_seg_vect ge +CC_ts))
sub_SWP_SWMS_seg_vect   = Where(Bx_bg_seg_vect ge +B_ts  and By_bg_seg_vect le +100*B_ts and $
                                  (CC_BxVx_seg_vect le -CC_ts or CC_ByVy_seg_vect le -CC_ts or CC_BzVz_seg_vect le -CC_ts))

;sub_CounterProp_seg_vect	= Where((CC_BxVx_seg_vect ge +CC_ts or CC_ByVy_seg_vect ge +CC_ts or CC_BzVz_seg_vect ge +CC_ts) $
;					(CC_BxVx_seg_vect le -CC_ts or CC_ByVy_seg_vect le -CC_ts or CC_BzVz_seg_vect le -CC_ts))				  

fuhao = CC_BxVx_seg_vect/abs(CC_BxVx_seg_vect)+CC_ByVy_seg_vect/abs(CC_ByVy_seg_vect)+CC_BzVz_seg_vect/abs(CC_BzVz_seg_vect)
sub_CounterProp_seg_vect  = Where((abs(CC_BxVx_seg_vect) ge +CC_ts and abs(CC_ByVy_seg_vect) ge +CC_ts and abs(CC_BzVz_seg_vect) ge +CC_ts) and  $
          (fuhao eq -1 or fuhao eq 1) and (x_bg_seg_vect gt 50.*6371.) ) 


ntime = n_elements(JulDay_vect)
JulDay_beg_ji = fltarr(ntime)
JulDay_end_ji = fltarr(ntime)
;;--
For i=0,2 Do Begin
  If i eq 0 Then sub_seg_vect = sub_SWP_ASWMS_seg_vect
  If i eq 1 Then sub_seg_vect = sub_SWP_SWMS_seg_vect
  If i eq 2 Then sub_seg_vect = sub_CounterProp_seg_vect
If (sub_seg_vect(0) ne -1) Then Begin
  num_segs  = N_Elements(sub_seg_vect)
  TimeStr_beg_vect  = Strarr(num_segs)
  TimeStr_end_vect  = Strarr(num_segs)
  If num_segs eq 1 Then Begin
    sub_tmp     = sub_seg_vect(0)
    JulDay_beg  = JulDay_min_seg_vect(sub_tmp)
    JulDay_end  = JulDay_max_seg_vect(sub_tmp)
    CalDat, JulDay_beg, mon_beg, day_beg, year_beg, hour_beg, min_beg, sec_beg
    CalDat, JulDay_end, mon_end, day_end, year_end, hour_end, min_end, sec_end
      TimeStr_beg = String(mon_beg, format='(I2.2)')+'/'+String(day_beg, format='(I2.2)')+'/'+String(hour_beg, format='(I2.2)')+':'+String(min_beg,format='(I2.2)')+':'+String(sec_beg,format='(I2.2)')
      TimeStr_end = String(mon_end, format='(I2.2)')+'/'+String(day_end, format='(I2.2)')+'/'+String(hour_end, format='(I2.2)')+':'+String(min_end,format='(I2.2)')+':'+String(sec_end,format='(I2.2)')
    TimeStr_beg_vect(0) = TimeStr_beg
    TimeStr_end_vect(0) = TimeStr_end
    JulDay_beg_ji(0) = JulDay_beg
    JulDay_end_ji(0) = JulDay_end
  EndIf Else Begin
    For i_seg=0,num_segs-1 Do Begin
      sub_tmp     = sub_seg_vect(i_seg)
      JulDay_beg  = JulDay_min_seg_vect(sub_tmp)
      JulDay_end  = JulDay_max_seg_vect(sub_tmp)
      CalDat, JulDay_beg, mon_beg, day_beg, year_beg, hour_beg, min_beg, sec_beg
      CalDat, JulDay_end, mon_end, day_end, year_end, hour_end, min_end, sec_end
      TimeStr_beg = String(mon_beg, format='(I2.2)')+'/'+String(day_beg, format='(I2.2)')+'/'+String(hour_beg, format='(I2.2)')+':'+String(min_beg,format='(I2.2)')+':'+String(sec_beg,format='(I2.2)')
      TimeStr_end = String(mon_end, format='(I2.2)')+'/'+String(day_end, format='(I2.2)')+'/'+String(hour_end, format='(I2.2)')+':'+String(min_end,format='(I2.2)')+':'+String(sec_end,format='(I2.2)')
      TimeStr_beg_vect(i_seg) = TimeStr_beg
      TimeStr_end_vect(i_seg) = TimeStr_end
    JulDay_beg_ji(i_seg) = JulDay_beg
    JulDay_end_ji(i_seg) = JulDay_end
    EndFor
  ENdElse
  If i eq 0 Then Begin
    TimeStr_beg_seg_SWP_ASWMS_vect  = TimeStr_beg_vect
    TimeStr_end_seg_SWP_ASWMS_vect  = TimeStr_end_vect
  EndIf   
  If i eq 1 Then Begin
    TimeStr_beg_seg_SWP_SWMS_vect  = TimeStr_beg_vect
    TimeStr_end_seg_SWP_SWMS_vect  = TimeStr_end_vect
  EndIf
  If i eq 2 Then Begin
    TimeStr_beg_seg_CounterProp_vect = TimeStr_beg_vect
    TimeStr_end_seg_CounterProp_vect = TimeStr_end_vect
  EndIf  
EndIf Else Begin
  If i eq 0 Then Begin
    TimeStr_beg_seg_SWP_ASWMS_vect  = 'Null'
    TimeStr_end_seg_SWP_ASWMS_vect  = 'Null'
  EndIf
  If i eq 1 Then Begin
    TimeStr_beg_seg_SWP_SWMS_vect  = 'Null'
    TimeStr_end_seg_SWP_SWMS_vect  = 'Null'
  EndIf
  If i eq 2 Then Begin
    TimeStr_beg_seg_CounterProp_vect = 'Null'
    TimeStr_end_seg_CounterProp_vect = 'Null'
  EndIf
EndElse
EndFor    

;;--
If (sub_SWP_ASWMS_seg_vect(0) eq -1) Then Begin
  CC_BxVx_seg_SWP_ASWMS_vect  = -9999.
  CC_ByVy_seg_SWP_ASWMS_vect  = -9999.
  CC_BzVz_seg_SWP_ASWMS_vect  = -9999.
EndIf Else Begin
  CC_BxVx_seg_SWP_ASWMS_vect  = CC_BxVx_seg_vect(sub_SWP_ASWMS_seg_vect)
  CC_ByVy_seg_SWP_ASWMS_vect  = CC_ByVy_seg_vect(sub_SWP_ASWMS_seg_vect)
  CC_BzVz_seg_SWP_ASWMS_vect  = CC_BzVz_seg_vect(sub_SWP_ASWMS_seg_vect)  
EndElse
  
If (sub_SWP_SWMS_seg_vect(0) eq -1) Then Begin
  CC_BxVx_seg_SWP_SWMS_vect  = -9999.
  CC_ByVy_seg_SWP_SWMS_vect  = -9999.
  CC_BzVz_seg_SWP_SWMS_vect  = -9999.  
EndIf Else Begin
  CC_BxVx_seg_SWP_SWMS_vect  = CC_BxVx_seg_vect(sub_SWP_SWMS_seg_vect)
  CC_ByVy_seg_SWP_SWMS_vect  = CC_ByVy_seg_vect(sub_SWP_SWMS_seg_vect)
  CC_BzVz_seg_SWP_SWMS_vect  = CC_BzVz_seg_vect(sub_SWP_SWMS_seg_vect)  
EndElse      

If (sub_CounterProp_seg_vect(0) eq -1) Then Begin
	CC_BxVx_seg_CounterProp_vect = -9999.
	CC_ByVy_seg_CounterProp_vect = -9999.
	CC_BzVz_seg_CounterProp_vect = -9999.
EndIf Else Begin
	CC_BxVx_seg_CounterProp_vect = CC_BxVx_seg_vect(sub_CounterProp_seg_vect)
	CC_ByVy_seg_CounterProp_vect = CC_ByVy_seg_vect(sub_CounterProp_seg_vect)
	CC_BzVz_seg_CounterProp_vect = CC_BzVz_seg_vect(sub_CounterProp_seg_vect)
EndElse	
	

Vp_bg_seg_vect = sqrt(Vx_bg_seg_vect^2.0+Vy_bg_seg_vect^2.0+Vz_bg_seg_vect^2.0)
;;--
dir_save = dir_data_CC
file_save = 'CorrCoeffs_B_V_components'+$
            '(EveryTimeInterval='+TimeInterval_str+'min)'+$
            '('+year_str+mon_str+day_str+').sav'
data_descrip  = 'got from "get_CorrCoeffs_B_V_Components_EveryTimeInterval(v2).pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  dJulDay_seg, num_segments, JulDay_cent_seg_vect, $
  Np_bg_seg_vect, Tp_bg_seg_vect, $
  Bx_bg_seg_vect, By_bg_seg_vect, Bz_bg_seg_vect, $
  theta_Bx, theta_By, theta_Bz, $
  Vx_bg_seg_vect, Vy_bg_seg_vect, Vz_bg_seg_vect, Vp_bg_seg_vect,  $
  CC_BxVx_seg_vect, CC_ByVy_seg_vect, CC_BzVz_seg_vect, $
  CC_nB_seg_vect, x_bg_seg_vect, $
  BComp_bg_seg_threshold, CC_BV_seg_threshold, $
  sub_SWP_ASWMS_seg_vect, sub_SWP_SWMS_seg_vect, $
  sub_CounterProp_seg_vect, $
  TimeStr_beg_seg_SWP_ASWMS_vect, TimeStr_end_seg_SWP_ASWMS_vect, $
  TimeStr_beg_seg_SWP_SWMS_vect, TimeStr_end_seg_SWP_SWMS_vect, $
  TimeStr_beg_seg_CounterProp_vect, TimeStr_end_seg_CounterProp_vect


;;--
;file_write  = dir_data_CC + $
;              'TimeStr_CC_SWP'+$
;              '(EveryTimeInterval='+TimeInterval_str+'min)'+$
;              '('+year_str+mon_str+day_str+')'+$              
;              '.txt'
;OpenW, lun_tmp, file_write, /Get_Lun
;PrintF, lun_tmp, 'TimeStr_beg_seg_SWP_ASWMS_vect: '
;PrintF, lun_tmp, TimeStr_beg_seg_SWP_ASWMS_vect
;PrintF, lun_tmp, 'TimeStr_end_seg_SWP_ASWMS_vect: '
;PrintF, lun_tmp, TimeStr_end_seg_SWP_ASWMS_vect
;PrintF, lun_tmp, 'CC_BxVx_seg_SWP_ASWMS_vect: '
;PrintF, lun_tmp, CC_BxVx_seg_SWP_ASWMS_vect
;PrintF, lun_tmp, 'CC_ByVy_seg_SWP_ASWMS_vect: '
;PrintF, lun_tmp, CC_ByVy_seg_SWP_ASWMS_vect
;PrintF, lun_tmp, 'CC_BzVz_seg_SWP_ASWMS_vect: '
;PrintF, lun_tmp, CC_BzVz_seg_SWP_ASWMS_vect
;PrintF, lun_tmp, '========================='
;PrintF, lun_tmp, 'TimeStr_beg_seg_SWP_SWMS_vect: '
;PrintF, lun_tmp, TimeStr_beg_seg_SWP_SWMS_vect
;PrintF, lun_tmp, 'TimeStr_end_seg_SWP_SWMS_vect: '
;PrintF, lun_tmp, TimeStr_end_seg_SWP_SWMS_vect
;PrintF, lun_tmp, 'CC_BxVx_seg_SWP_SWMS_vect: '
;PrintF, lun_tmp, CC_BxVx_seg_SWP_SWMS_vect
;PrintF, lun_tmp, 'CC_ByVy_seg_SWP_SWMS_vect: '
;PrintF, lun_tmp, CC_ByVy_seg_SWP_SWMS_vect
;PrintF, lun_tmp, 'CC_BzVz_seg_SWP_SWMS_vect: '
;PrintF, lun_tmp, CC_BzVz_seg_SWP_SWMS_vect
;Free_Lun, lun_tmp
;Close, lun_tmp


;;--

num_segs    = N_Elements(TimeStr_beg_seg_CounterProp_vect)



;i_c = fltarr(num_segs)
;For i_seg=0,num_segs-2 Do Begin
; if TimeStr_end_seg_CounterProp_vect(i_seg) eq TimeStr_beg_seg_CounterProp_vect(i_seg+1) then begin
;  i_c(i_seg) = 1
;  i_c(i_seg+1) = 1
; endif 
;endfor
;sub = where(i_c eq 1)
;num_sub = N_elements(sub)
;count = 0
;for i_s = 0,num_sub-1 do begin
;  if sub(i_s+1)-sub(i_s) ne 1 then begin
;    CC_BxVx_tmp     = mean(CC_BxVx_seg_CounterProp_vect(sub:(sub+i_s)))
;    CC_ByVy_tmp     = mean(CC_ByVy_seg_CounterProp_vect(sub:(sub+i_s)))
;    CC_BzVz_tmp     = mean(CC_BzVz_seg_CounterProp_vect(sub:(sub+i_s)))
;    Np_tmp          = mean(Np_bg_seg_vect(sub:(sub+i_s)))
;    Tp_tmp          = mean(Tp_bg_seg_vect(sub:(sub+i_s)))
;    Vp_tmp          = mean(Vp_bg_seg_vect(sub:(sub+i_s)))
;    x_GSE           = mean(x_bg_seg_vect(sub:(sub+i_s)))/6371.0     
;    PrintF, lun_tmp, TimeStr_beg_tmp, TimeStr_end_tmp, CC_BxVx_tmp, CC_ByVy_tmp, CC_BzVz_tmp, $
;      Np_tmp, Tp_tmp, Vp_tmp, x_GSE, $
;      Format='(A22, A22, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2)' 
;   endif    


;;


;;先不要
For i_seg=0,num_segs-1 Do Begin
;  sha = 0   ;sha=1则说明坏点
;  for i_gap = 0,ngap-1 do begin
;    width = (end_gaplabel(i_gap)-beg_gaplabel(i_gap)+dJulDay_seg-   $
;    abs(beg_gaplabel(i_gap)-JulDay_beg_ji(i_seg)+end_gaplabel(i_gap)-JulDay_end_ji(i_seg)))/2.0
;    if width le 3./(60.*24.) then begin
;      sha = 1
;    endif
;  endfor  
;  if sha eq 0 then begin
    TimeStr_beg_tmp = TimeStr_beg_seg_CounterProp_vect(i_seg)
    TimeStr_end_tmp = TimeStr_end_seg_CounterProp_vect(i_seg)
    CC_BxVx_tmp	    = CC_BxVx_seg_CounterProp_vect(i_seg)
    CC_ByVy_tmp	    = CC_ByVy_seg_CounterProp_vect(i_seg)
    CC_BzVz_tmp	    = CC_BzVz_seg_CounterProp_vect(i_seg)
    Np_tmp          = Np_bg_seg_vect(i_seg)
    Tp_tmp          = Tp_bg_seg_vect(i_seg)
    Vp_tmp          = Vp_bg_seg_vect(i_seg)
    x_GSE           = x_bg_seg_vect(i_seg)/6371.0
    theta_Bx_tmp    = theta_Bx(i_seg)
    theta_By_tmp    = theta_By(i_seg)    
    theta_Bz_tmp    = theta_Bz(i_seg)    
    Bx_tmp          = Bx_bg_seg_vect(i_seg)
    if TimeStr_beg_tmp eq 'Null' then begin
    endif else begin 
    PrintF, lun_tmp, TimeStr_beg_tmp, TimeStr_end_tmp, CC_BxVx_tmp, CC_ByVy_tmp, CC_BzVz_tmp, $
      Np_tmp, Tp_tmp, Vp_tmp, x_GSE, theta_Bx_tmp, theta_By_tmp, theta_Bz_tmp, Bx_tmp, $
	    Format='(A22, A22, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2, F10.2)' 
	  endelse
	 ;;;;;;这段不要
;	  endif
;    endif
;    if i_c(i_seg) eq 1 then begin
;      if i_c(i_seg-1) eq 1 then begin
;      endif
;      if i_c(i_seg-1) eq 0 then begin
  ;;;;;;;
;    endif
;    if sha eq 1 then begin
;    endif         
EndFor




Goto, Another_i_file
;Step5:
;;=====================
;;Step5
;
;;;--
;Set_Plot,'win'
;Device,DeComposed=0;, /Retain
;xsize=800.0 & ysize=1000.0
;Window,3,XSize=xsize,YSize=ysize,Retain=2
;
;;;--
;LoadCT,13
;TVLCT,R,G,B,/Get
;color_red = 0L
;TVLCT,255L,0L,0L,color_red
;R_red=255L & G_red=0L & B_red=0L
;color_green = 1L
;TVLCT,0L,255L,0L,color_green
;R_green=0L & G_green=255L & B_green=0L
;color_blue  = 2L
;TVLCT,0L,0L,255L,color_blue
;R_blue=0L & G_blue=0L & B_blue=255L
;color_white = 4L
;TVLCT,255L,255L,255L,color_white
;R_white=255L & G_white=255L & B_white=255L
;color_black = 3L
;TVLCT,0L,0L,0L,color_black
;R_black=0L & G_black=0L & B_black=0L
;num_CB_color= 256-5
;R=Congrid(R,num_CB_color)
;G=Congrid(G,num_CB_color)
;B=Congrid(B,num_CB_color)
;TVLCT,R,G,B
;R = [R_red,R_green,R_blue,R_black,R_white,R]
;G = [G_red,G_green,G_blue,G_black,G_white,G]
;B = [B_red,B_green,B_blue,B_black,B_white,B]
;TVLCT,R,G,B
;
;;;--
;color_bg    = color_white
;!p.background = color_bg
;Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background
;
;;;--
;position_img  = [0.06,0.08,0.99,0.95]
;
;;;--
;num_subimgs_x = 1
;num_subimgs_y = 8
;dx_subimg   = (position_img(2)-position_img(0))/num_subimgs_x
;dy_subimg   = (position_img(3)-position_img(1))/num_subimgs_y
;
;;;--
;x_margin_left = 0.07
;x_margin_right= 0.93
;y_margin_bot  = 0.07
;y_margin_top  = 0.93
;
;
;;;--
;For i_subimg_y = 0,7 Do Begin
;i_subimg_x  = 0
;win_position= [position_img(0)+dx_subimg*i_subimg_x+x_margin_left*dx_subimg,$
;        position_img(1)+dy_subimg*i_subimg_y+y_margin_bot*dy_subimg,$
;        position_img(0)+dx_subimg*i_subimg_x+x_margin_right*dx_subimg,$
;        position_img(1)+dy_subimg*i_subimg_y+y_margin_top*dy_subimg]
;position_subplot  = win_position
;xplot_vect  = JulDay_cent_seg_vect
;
;If i_subimg_y eq 7 Then Begin
;  yplot_vect  = Np_bg_seg_vect & ytitle='Np[cm^-3]'
;EndIf  
;If i_subimg_y eq 6 Then Begin
;  yplot_vect  = Tp_bg_seg_vect & ytitle='Tp[10^4K]'
;EndIf  
;If i_subimg_y eq 5 Then Begin
;  yplot_vect  = Bx_bg_seg_vect & ytitle='Bx_GSE[nT]'
;EndIf  
;If i_subimg_y eq 4 Then Begin
;  yplot_vect  = By_bg_seg_vect & ytitle='By_GSE[nT]'
;EndIf  
;If i_subimg_y eq 3 Then Begin
;  yplot_vect  = Bz_bg_seg_vect & ytitle='Bz_GSE[nT]'
;  yplot_vect  = Sqrt(Bx_bg_seg_vect^2+By_bg_seg_vect^2+Bz_bg_seg_vect^2) & ytitle='|B| [nT]'
;EndIf  
;If i_subimg_y eq 2 Then Begin
;  yplot_vect  = CC_BxVx_seg_vect & ytitle='CC_BxVx'
;EndIf         
;If i_subimg_y eq 1 Then Begin
;  yplot_vect  = CC_ByVy_seg_vect & ytitle='CC_ByVy'
;EndIf  
;If i_subimg_y eq 0 Then Begin
;  yplot_vect  = CC_BzVz_seg_vect & ytitle='CC_BzVz'
;EndIf  
;
;xrange  = [Min(JulDay_min_seg_vect), Max(JulDay_max_seg_vect)]
;xrange_time = xrange
;get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;xminor  = xminor_time
;;xminor    = 6
;yrange    = [Min(yplot_vect)-0.5,Max(yplot_vect)+0.5]
;xtitle    = ' '
;
;Plot,xplot_vect, yplot_vect,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
;  Position=position_subplot,$
;  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
;  XTitle=xtitle,YTitle=ytitle,$
;  Color=color_black,$
;  /NoErase,Font=-1, $
;  XThick=1.5,YThick=1.5,CharSize=1.2,CharThick=1.5,Thick=1.5
;
;;;--
;If (i_subimg_y eq 4 or i_subimg_y eq 5) Then Begin
;  Plots, xrange, [0.0,0.0], LineStyle=2, Thick=1.2, Color=color_black, NoClip=0
;  Plots, xrange, [-1.,-1.], LineStyle=2, Thick=1.2, Color=color_black, NoClip=0
;  Plots, xrange, [+1.,+1.], LineStyle=2, Thick=1.2, Color=color_black, NoClip=0
;EndIf
;If (i_subimg_y eq 0 or i_subimg_y eq 1 or i_subimg_y eq 2) Then Begin
;;  Plots, xrange, [0.0,0.0], LineStyle=2, Thick=1.2, Color=color_black
;  Plots, xrange, [-.5,-.5], LineStyle=2, Thick=1.2, Color=color_black, NoClip=0
;  Plots, xrange, [+.5,+.5], LineStyle=2, Thick=1.2, Color=color_black, NoClip=0
;EndIf
;  
;;;--
;If (sub_SWP_ASWMS_seg_vect(0) ne -1) Then Begin
;  sub_tmp = sub_SWP_ASWMS_seg_vect
;  Plots, xplot_vect(sub_tmp), yplot_vect(sub_tmp), Color=color_red, PSym=2, Thick=1.5
;EndIf
;If (sub_SWP_SWMS_seg_vect(0) ne -1) Then Begin
;  sub_tmp = sub_SWP_SWMS_seg_vect
;  Plots, xplot_vect(sub_tmp), yplot_vect(sub_tmp), Color=color_blue, PSym=2, Thick=1.5
;EndIf
;  
;  
;EndFor ;For i_subimg_y = 0,7 Do Begin
;
;
;;;--
;AnnotStr_tmp  = 'got from "get_CorrCoeffs_B_V_components_EveryTimeInterval.pro"'
;AnnotStr_arr  = [AnnotStr_tmp]
;Annotstr_tmp  = year_str+mon_str+day_str+'; '+sub_dir_date
;AnnotStr_arr  = [AnnotStr_arr, AnnotStr_tmp]
;num_strings     = N_Elements(AnnotStr_arr)
;For i_str=0,num_strings-1 Do Begin
;  position_v1   = [position_img(0),position_img(1)/(num_strings+2)*(i_str+1)]
;  CharSize    = 0.95
;  XYOuts,position_v1(0),position_v1(1),AnnotStr_arr(i_str),/Normal,$
;      CharSize=charsize,color=color_black,Font=-1
;EndFor
;
;
;;;--
;image_tvrd  = TVRD(true=1)
;file_version  = '(v1)'
;file_fig= 'CorrCoeffs_B_V_components'+$
;          '(EveryTimeInterval='+TimeInterval_str+'min)'+$
;          '('+year_str+mon_str+day_str+').png'
;Write_PNG, dir_fig+file_fig, image_tvrd; tvrd(/true), r,g,b
;
;
;;;;--
;Device,/Close 


Another_i_file:
EndFor ;For i_file=i_file_beg,i_file_end Do Begin

Free_Lun, lun_tmp
Close, lun_tmp

End_Program:
End
