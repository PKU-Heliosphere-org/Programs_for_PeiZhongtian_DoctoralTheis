;pro calculate_average_of_time_series

date = '19950720-29w'
sub_dir_date  = 'new\'+date+'\'

dir_save    = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\'
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\CDF_wind\'
SetEnv,WIND_Data_Dir
SetEnv,WIND_Figure_Dir

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR

Bmag_ave = mean(BMAG_GSE_2S_ARR,/nan)
;n = n_elements(Bx_GSE_2s_vect)
;Br_unit = fltarr(n)
;Bt_unit = fltarr(n)
;Bn_unit = fltarr(n)
;Bmag_unit = fltarr(n)
;for i = 0,n-1 then begin
;Bmag_unit = sqrt(Bx_GSE_2s_vect^2+By_GSE_2s_vect^2+Bz_GSE_2s_vect^2)  
Br_aver = mean(Bx_GSE_2s_vect,/nan)
Bt_aver = mean(By_GSE_2s_vect,/nan)
Bn_aver = mean(Bz_GSE_2s_vect,/nan)
Bmag_aver = sqrt(Br_aver^2+Bt_aver^2+Bn_aver^2)  
Br_unita = Br_aver/Bmag_aver
Bt_unita = Bt_aver/Bmag_aver
Bn_unita = Bn_aver/Bmag_aver



step2:

dir_read  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_read = 'uy_coho1hr_merged_mag_plasma_19950701_v01.cdf'
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
;CDF_Control, cdf_id, Variable='Epoch3', Get_Var_Info=Info_Epoch3
;a num_records  = Info_Epoch.MaxAllocRec
;num_records    = Info_Epoch3.MaxRec + 1L
;CDF_VarGet, cdf_id, 'Epoch3', Epoch_3s_vect, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B3GSE', Bxyz_GSE_3s_arr, Rec_Count=num_records
;;;---
;CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
;num_records    = Info_Epoch.MaxRec + 1L
;CDF_VarGet, cdf_id, 'Epoch', Epoch_2s_vect, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B_RTN', Bxyz_GSE_2s_arr, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B_MAG', Bmag_GSE_2s_arr, Rec_Count=num_records
;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_1h_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'plasmaFlowSpeed', V_1h_plasma, Rec_Count=num_records
CDF_VarGet, cdf_id, 'protonDensity', N_1h_proton, Rec_Count=num_records
CDF_VarGet, cdf_id, 'protonTempLarge', T_1h_proton, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_1h_vect = Reform(Epoch_1h_vect)
epoch_beg   = Epoch_1h_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_2s_vect  = JulDay_beg+(Epoch_1h_vect-Epoch_beg)/24.



;456-695

V_aver = mean(V_1h_plasma(456:695))
N_aver = mean(N_1h_proton(456:695))
T_aver = mean(T_1h_proton(456:695))

beta_aver = (N_aver*T_aver/Bmag_ave^2.0)*0.35/10^4;(n_p_vect_3DP_plot*Tp_vect_3DP_plot/AbsB_vect_MFI_plot^2.0)*0.35


print,V_aver,Bmag_ave,Br_unita,Bt_unita,Bn_unita,N_aver,T_aver,beta_aver

END









