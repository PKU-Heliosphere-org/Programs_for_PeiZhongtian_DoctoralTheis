;pro Read_proton_velocity

sub_dir_date  = 'wind\another\199505\'


Step1:
;===========================
;Step1:
;read,'resolution',reso
reso = 3.0
;;--
dir_read  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_read = 'wi_pm_3dp_19950503_v03.cdf'
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



Step2:
;===========================
;Step2:

;;--
BadVal  = -1.e31

;;;---
Px_VEL_3s_vect  = Reform(P_VEL_3s_arr(0,*))
sub_nan = Where((Px_VEL_3s_vect eq BadVal) or (Abs(Px_VEL_3s_vect) ge 1000) or (Abs(Px_VEL_3s_vect) le 100))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Px_VEL_3s_vect ne BadVal) and (Abs(Px_VEL_3s_vect) lt 1000) and (Abs(Px_VEL_3s_vect) gt 100))
  JulDay_vect_v2 = JulDay_2s_vect(sub_val)
  Px_VEL_3s_vect_v2 = Px_VEL_3s_vect(sub_val)
  Px_VEL_3s_vect  = Interpol(Px_VEL_3s_vect_v2, JulDay_vect_v2, JulDay_2s_vect)
EndIf

;;;---
Py_VEL_3s_vect  = Reform(P_VEL_3s_arr(1,*))
sub_nan = Where((Py_VEL_3s_vect eq BadVal) or (Abs(Py_VEL_3s_vect) ge 1000))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Py_VEL_3s_vect ne BadVal) and (Abs(Py_VEL_3s_vect) lt 1000))
  JulDay_vect_v2 = JulDay_2s_vect(sub_val)
  Py_VEL_3s_vect_v2 = Py_VEL_3s_vect(sub_val)
  Py_VEL_3s_vect  = Interpol(Py_VEL_3s_vect_v2, JulDay_vect_v2, JulDay_2s_vect)
EndIf

;;;---
Pz_VEL_3s_vect  = Reform(P_VEL_3s_arr(2,*))
sub_nan = Where((Pz_VEL_3s_vect eq BadVal) or (Abs(Pz_VEL_3s_vect) ge 1000))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((Pz_VEL_3s_vect ne BadVal) and (Abs(Pz_VEL_3s_vect) lt 1000))
  JulDay_vect_v2 = JulDay_2s_vect(sub_val)
  Pz_VEL_3s_vect_v2 = Pz_VEL_3s_vect(sub_val)
  Pz_VEL_3s_vect  = Interpol(Pz_VEL_3s_vect_v2, JulDay_vect_v2, JulDay_2s_vect)
EndIf


;;;---
P_DEN_3s_vect  = Reform(P_DEN_3s_arr(0,*))
sub_nan = Where((P_DEN_3s_vect eq BadVal) or (Abs(P_DEN_3s_vect) ge 50))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((P_DEN_3s_vect ne BadVal) and (Abs(P_DEN_3s_vect) lt 50))
  JulDay_vect_v2 = JulDay_2s_vect(sub_val)
  P_DEN_3s_vect_v2 = P_DEN_3s_vect(sub_val)
  P_DEN_3s_vect  = Interpol(P_DEN_3s_vect_v2, JulDay_vect_v2, JulDay_2s_vect)
EndIf


;;;---
P_TEMP_3s_vect  = Reform(P_TEMP_3s_arr(0,*))
sub_nan = Where((P_TEMP_3s_vect eq BadVal) or (Abs(P_TEMP_3s_vect) ge 50))
If (sub_nan(0) ne -1) Then Begin
  sub_val = Where((P_TEMP_3s_vect ne BadVal) and (Abs(P_TEMP_3s_vect) lt 50))
  JulDay_vect_v2 = JulDay_2s_vect(sub_val)
  P_TEMP_3s_vect_v2 = P_TEMP_3s_vect(sub_val)
  P_TEMP_3s_vect  = Interpol(P_TEMP_3s_vect_v2, JulDay_vect_v2, JulDay_2s_vect)
EndIf

;;;---
;Px_VEL_3s_vect  = Reform(P_VEL_3s_arr(0,*))

Px_VEL_3s_vect_v2 = Px_VEL_3s_vect(where(finite(Px_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Px_VEL_3s_vect)))
Px_VEL_3s_vect  = Interpol(Px_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值



;;;---
;Py_VEL_3s_vect  = Reform(P_VEL_3s_arr(1,*))

Py_VEL_3s_vect_v2 = Py_VEL_3s_vect(where(finite(Py_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Py_VEL_3s_vect)))
Py_VEL_3s_vect  = Interpol(Py_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
;Pz_VEL_3s_vect  = Reform(P_VEL_3s_arr(2,*))

Pz_VEL_3s_vect_v2 = Pz_VEL_3s_vect(where(finite(Pz_VEL_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(Pz_VEL_3s_vect)))
Pz_VEL_3s_vect  = Interpol(Pz_VEL_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值
;;;---
;P_DEN_3s_vect  = Reform(P_DEN_3s_arr(0,*))

P_DEN_3s_vect_v2 = P_DEN_3s_vect(where(finite(P_DEN_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_DEN_3s_vect)))
P_DEN_3s_vect  = Interpol(P_DEN_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值


;P_TEMP_3s_vect  = Reform(P_TEMP_3s_arr(0,*))

P_TEMP_3s_vect_v2 = P_TEMP_3s_vect(where(finite(P_TEMP_3s_vect)))
JulDay_2s_vect_v2 = JulDay_2s_vect(where(finite(P_TEMP_3s_vect)))
P_TEMP_3s_vect  = Interpol(P_TEMP_3s_vect_v2, JulDay_2s_vect_v2, JulDay_2s_vect);线性插值


;;;---
P_VEL_3s_arr(0,*)  = Transpose(Px_VEL_3s_vect)
P_VEL_3s_arr(1,*)  = Transpose(Py_VEL_3s_vect)
P_VEL_3s_arr(2,*)  = Transpose(Pz_VEL_3s_vect)
P_DEN_3s_arr(0,*)  = Transpose(P_DEN_3s_vect)
P_TEMP_3s_arr(0,*)  = Transpose(P_TEMP_3s_vect)


Step3:
;===========================
;Step3:

;;--

num_times = Floor((Max(JulDay_2s_vect)-Min(JulDay_2s_vect))/(reso/(24.*60*60)))   ;2s是分辨率

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



;;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Read_proton_velocity.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
  P_TEMP_3s_vect
; JulDay_1min_vect, Bxyz_GSE_1min_arr, xyz_GSE_1min_arr







End_Program:
End