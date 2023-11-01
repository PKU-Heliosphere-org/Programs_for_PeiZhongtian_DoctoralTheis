;pro read_T_velocity_etal

Date = '19950509-13'
sub_dir_date  = 'new\'+Date+'\'

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


step1:


;;--
dir_read  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_read = 'uy_m0_bai_19950513_v01.cdf'
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
;CDF_Control, cdf_id, Variable='Epoch3', Get_Var_Info=Info_Epoch3
;a num_records  = Info_Epoch.MaxAllocRec
;num_records    = Info_Epoch3.MaxRec + 1L
;CDF_VarGet, cdf_id, 'Epoch3', Epoch_3s_vect, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B3GSE', Bxyz_GSE_3s_arr, Rec_Count=num_records
;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_m_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'Velocity', Vxyz_GSE_m_arr, Rec_Count=num_records
CDF_VarGet, cdf_id, 'Density', Density, Rec_Count=num_records
CDF_VarGet, cdf_id, 'Temperature', Temp, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B_MAG', Bmag_GSE_2s_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir


;;--
Density_p = Density(0,*)
Temp_p = Temp(0,*)


Epoch_m_vect = Reform(Epoch_m_vect)
epoch_beg   = Epoch_m_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_m_vect  = JulDay_beg+(Epoch_m_vect-Epoch_beg)/(1.e3*24.*60.*60.)

Step2:
;===========================
;Step2:

Vx_GSE_m_arr = Vxyz_GSE_m_arr(0,*)
Vy_GSE_m_arr = Vxyz_GSE_m_arr(1,*)
Vz_GSE_m_arr = Vxyz_GSE_m_arr(2,*)
Vtotal_GSE_m_arr = sqrt(Vx_GSE_m_arr^2+Vy_GSE_m_arr^2+Vz_GSE_m_arr^2)

;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Plot_mag_velo.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_m_vect, Vx_GSE_m_arr , $
  Vy_GSE_m_arr , Vz_GSE_m_arr , $
  Vtotal_GSE_m_arr, $
  Density_p, Temp_p

end
