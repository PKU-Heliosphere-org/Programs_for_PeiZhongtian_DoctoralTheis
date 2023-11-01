;Pro Read_h0_mfi_WIND_CDF_19950131

sub_dir_date	= 'new\19950720-29-1\'


Step1:
;===========================
;Step1:
;read,'resolution',reso
;;--
dir_read	= 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_read	= 'uy_1sec_vhm_19950729_v01.cdf'
file_array	= File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select	= 0
;Read, 'i_select: ', i_select
file_read	= file_array(i_select)
file_read	= StrMid(file_read, StrLen(dir_read), StrLen(file_read)-StrLen(dir_read))

;;--
CD, Current=wk_dir
CD, dir_read
cdf_id	= CDF_Open(file_read)
;;;---
;CDF_Control, cdf_id, Variable='Epoch3', Get_Var_Info=Info_Epoch3
;a num_records	= Info_Epoch.MaxAllocRec
;num_records		= Info_Epoch3.MaxRec + 1L
;CDF_VarGet, cdf_id, 'Epoch3', Epoch_3s_vect, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B3GSE', Bxyz_GSE_3s_arr, Rec_Count=num_records
;;;---
;CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
;num_records		= Info_Epoch.MaxRec + 1L
;CDF_VarGet, cdf_id, 'Epoch', Epoch_2s_vect, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B_RTN', Bxyz_GSE_2s_arr, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B_MAG', Bmag_GSE_2s_arr, Rec_Count=num_records
;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_1s_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'B_RTN', B_RTN_1s_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'B_MAG', Bmag_RTN_1s_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_1s_vect	= Reform(Epoch_1s_vect)
epoch_beg		= Epoch_1s_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
			/Breakdown_Epoch
JulDay_beg		= JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_1s_vect	= JulDay_beg+(Epoch_1s_vect-Epoch_beg)/(1.e3*24.*60.*60.)

;;--
;Epoch_1min_vect	= Reform(Epoch_1min_vect)
;epoch_beg		= Epoch_1min_vect(0)
;CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
;			/Breakdown_Epoch
;JulDay_beg		= JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
;JulDay_1min_vect= JulDay_beg+(Epoch_1min_vect-Epoch_beg)/(1.e3*24.*60.*60.)


Step2:
;===========================
;Step2:

;;--
BadVal	= -1.e31
;;;---
Bx_RTN_1s_vect	= Reform(B_RTN_1s_arr(0,*))
sub_nan	= Where((Bx_RTN_1s_vect eq BadVal) or (Abs(Bx_RTN_1s_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
	sub_val	= Where((Bx_RTN_1s_vect ne BadVal) and (Abs(Bx_RTN_1s_vect) lt 200))
	JulDay_1s_vect_v2	= JulDay_1s_vect(sub_val)
	Bx_RTN_1s_vect_v2	= Bx_RTN_1s_vect(sub_val)
	Bx_RTN_1s_vect	= Interpol(Bx_RTN_1s_vect_v2, JulDay_1s_vect_v2, JulDay_1s_vect);线性插值
EndIf
;;;---
By_RTN_1s_vect  = Reform(B_RTN_1s_arr(1,*))
sub_nan = Where((By_RTN_1s_vect eq BadVal) or (Abs(By_RTN_1s_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((By_RTN_1s_vect ne BadVal) and (Abs(By_RTN_1s_vect) lt 200))
  JulDay_1s_vect_v2 = JulDay_1s_vect(sub_val)
  By_RTN_1s_vect_v2 = By_RTN_1s_vect(sub_val)
  By_RTN_1s_vect  = Interpol(By_RTN_1s_vect_v2, JulDay_1s_vect_v2, JulDay_1s_vect);线性插值
EndIf
;;;---
Bz_RTN_1s_vect  = Reform(B_RTN_1s_arr(2,*))
sub_nan = Where((Bz_RTN_1s_vect eq BadVal) or (Abs(Bz_RTN_1s_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Bz_RTN_1s_vect ne BadVal) and (Abs(Bz_RTN_1s_vect) lt 200))
  JulDay_1s_vect_v2 = JulDay_1s_vect(sub_val)
  Bz_RTN_1s_vect_v2 = Bz_RTN_1s_vect(sub_val)
  Bz_RTN_1s_vect  = Interpol(Bz_RTN_1s_vect_v2, JulDay_1s_vect_v2, JulDay_1s_vect);线性插值
EndIf
;;;---
Bmag_RTN_1s_vect  = Reform(Bmag_RTN_1s_arr(0,*))
sub_nan = Where((Bmag_RTN_1s_vect eq BadVal) or (Abs(Bmag_RTN_1s_vect) ge 200))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Bmag_RTN_1s_vect ne BadVal) and (Abs(Bmag_RTN_1s_vect) lt 200))
  JulDay_2s_vect_v2 = JulDay_2s_vect(sub_val)
  Bmag_RTN_1s_vect_v2 = Bmag_RTN_1s_vect(sub_val)
  Bmag_RTN_1s_vect  = Interpol(Bmag_RTN_1s_vect_v2, JulDay_1s_vect_v2, JulDay_1s_vect)
EndIf
;;;---
B_RTN_1s_arr(0,*)	= Transpose(Bx_RTN_1s_vect)
B_RTN_1s_arr(1,*)	= Transpose(By_RTN_1s_vect)
B_RTN_1s_arr(2,*)	= Transpose(Bz_RTN_1s_vect)
Bmag_RTN_1s_arr(0,*)  = Transpose(Bmag_RTN_1s_vect)
;Btotal_GSE_2s_vect    = sqrt(Bx_GSE_2s_vect^2+By_GSE_2s_vect^2+Bz_GSE_2s_vect^2)


;;;计算datagap时间
;;--
dJulDay_interp = 1.0/(24.*60.*60.)
num_times     = N_Elements(JulDay_1s_vect)
;dJulDay_vect  = fltarr(num_times+1)
dJulDay_vect  = JulDay_1s_vect(1:num_times-1) - JulDay_1s_vect(0:num_times-2)
;dJulDay_vect(0)    = abs(JulDay_1s_vect(0)-round(JulDay_1s_vect(0)-0.5)-0.5)
;dJulDay_vect(num_times) = abs(JulDay_1s_vect(0)-round(JulDay_1s_vect(0)+0.5)+0.5)
beg_gap = abs(JulDay_1s_vect(0)-round(JulDay_1s_vect(0)-0.5)-0.5)
end_gap = abs(JulDay_1s_vect(num_times-1)-round(JulDay_1s_vect(num_times-1)+0.5)+0.5)
dTime_vect    = dJulDay_vect * (24.*60.*60)
dTime_median  = 1.5;2.*dJulDay_interp*(24.*60.*60.);Median(dTime_vect);间隔大于1.5s认为是datagap
sub_DataGaps  = where(dTime_vect ge dTime_median);Where(dTime_vect ge 4*dTime_median)
If (sub_DataGaps(0) ne -1) Then Begin
  num_DataGaps  = N_Elements(sub_DataGaps)
  JulDay_beg_DataGap_vect = Dblarr(num_DataGaps)
  JulDay_end_DataGap_vect = Dblarr(num_DataGaps)
  JulDay_length_dataGap_vect = Dblarr(num_DataGaps)
  num_gappoints = dblarr(num_dataGaps)
  For i_DataGap=0,num_DataGaps-1 Do Begin
    JulDay_beg_DataGap_vect(i_DataGap)  = JulDay_1s_vect(sub_DataGaps(i_DataGap))
    JulDay_end_DataGap_vect(i_DataGap)  = JulDay_1s_vect(sub_DataGaps(i_DataGap)+1)
    JulDay_length_dataGap_vect(i_DataGap) = JulDay_end_DataGap_vect(i_DataGap)-JulDay_beg_DataGap_vect(i_DataGap)
    num_gappoints(i_DataGap) = round((JulDay_end_DataGap_vect(i_DataGap)-JulDay_beg_DataGap_vect(i_DataGap))/dJulDay_interp) - 1
  EndFor
  num_gapData = total(num_gappoints,/nan)
EndIf Else Begin
  num_DataGaps  = 0L
  num_gapData = 0L
  JulDay_beg_DataGap_vect = -1.0
  JulDay_end_DataGap_vect = -1.0
endelse


;print,dJulDay_vect(0),dJulDay_vect(123)





Step3:
;===========================
;Step3:

;;--
;a num_times	= Round(24.*3600./3.1)
num_times	= Floor((Max(JulDay_1s_vect)-Min(JulDay_1s_vect))/(1.0/(24.*60*60)))   ;2s是分辨率
;a CalDat, JulDay_3s_vect(0), mon_beg, day_beg, year_beg, hour_beg, min_beg, sec_beg
;a JulDay_beg	= JulDay(mon_beg, day_beg, year_beg, 0.0, 0.0, 0.0)
;a JulDay_end	= JulDay(mon_beg, day_beg, year_beg, 23.0, 59.0, 59.0)
JulDay_beg	= Min(JulDay_1s_vect)
JulDay_end	= Max(JulDay_1s_vect)
JulDay_1s_vect_v3	= JulDay_beg+(JulDay_end-JulDay_beg)/(num_times-1)*Findgen(num_times)
;;;---
Bx_RTN_1s_vect_v3	= Interpol(Reform(B_RTN_1s_arr(0,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
By_RTN_1s_vect_v3	= Interpol(Reform(B_RTN_1s_arr(1,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
Bz_RTN_1s_vect_v3	= Interpol(Reform(B_RTN_1s_arr(2,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
Bmag_RTN_1s_vect_v3 = Interpol(Reform(Bmag_RTN_1s_arr(0,*)), JulDay_1s_vect, JulDay_1s_vect_v3)
B_RTN_1s_arr_v3	= Fltarr(3,num_times)
Bmag_RTN_1s_arr_v3  = Fltarr(1,num_times)
B_RTN_1s_arr_v3(0,*)	= Transpose(Bx_RTN_1s_vect_v3)
B_RTN_1s_arr_v3(1,*)	= Transpose(By_RTN_1s_vect_v3)
B_RTN_1s_arr_v3(2,*)	= Transpose(Bz_RTN_1s_vect_v3)
Bmag_RTN_1s_arr_v3(0,*) = Transpose(Bmag_RTN_1s_vect_v3)

Bx_RTN_1s_vect = Reform(B_RTN_1s_arr_v3(0,*))
By_RTN_1s_vect = Reform(B_RTN_1s_arr_v3(1,*))
Bz_RTN_1s_vect = Reform(B_RTN_1s_arr_v3(2,*))
Bmag_RTN_1s_vect = Reform(Bmag_RTN_1s_arr_v3(0,*))
;;;---
JulDay_1s_vect	= JulDay_1s_vect_v3
B_RTN_1s_arr	= B_RTN_1s_arr_v3
Bmag_RTN_1s_arr = Bmag_RTN_1s_vect_v3

;;--
dir_save	= 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save	= StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
	Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect
;	JulDay_1min_vect, Bxyz_GSE_1min_arr, xyz_GSE_1min_arr



dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = '10_datagap.sav'
data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_1s_vect, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect, $
  JulDay_length_dataGap_vect, num_gappoints, num_gapData, beg_gap, end_gap

print,JulDay_length_dataGap_vect*86400.,beg_gap*86400.,end_gap*86400.

End_Program:
End