;Pro Read_OR_PRE_WIND_CDF_20000608(v2)

;sub_dir_date  = 'OR_PRE/2002/' ; 2002-12/';'1995-01--1995-02/';'1995-12-23/'
;sub_dir_date  = '2005-03/'
;sub_dir_name  = ''
WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\or_pre\';+sub_dir_name+sub_dir_date  ;+TimeRange_str
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\He\';+sub_dir_name+sub_dir_date ;+TimeRange_str
SetEnv, WIND_Data_Dir
SetEnv, WIND_Figure_Dir


Step1:
;===========================
;Step1:

;;--
dir_read	= GetEnv('WIND_Data_Dir')
file_read	= 'wi_or_pre_2002????_v0?.cdf'
file_array	= File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
	Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_file_beg	= 0
i_file_end	= num_files-1
Print, 'i_file_beg/end: ', i_file_beg, i_file_end
Read, 'i_file_beg, i_file_end: ', i_file_beg, i_file_end

;;--
For i_file=i_file_beg,i_file_end Do Begin

i_select	= i_file
file_read	= file_array(i_select)
file_read	= StrMid(file_read, StrLen(dir_read), StrLen(file_read)-StrLen(dir_read))


;;--
CD, Current=wk_dir
CD, dir_read
cdf_id  = CDF_Open(file_read)
;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch  ;as r-variable
;a num_records  = Info_Epoch.MaxAllocRec
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'GSE_POS', xyz_GSE_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir

;;--
Epoch_vect  = Reform(Epoch_vect(0,*))
epoch_beg = Epoch_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg  = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_vect = JulDay_beg+(Epoch_vect-Epoch_beg)/(1.e3*24.*60.*60.)
JulDay_vect_OR = JulDay_vect


Step2:
;===========================
;Step2:

;;--
dir_save	= GetEnv('WIND_Data_Dir')
file_save	= StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Read_OR_PRE_WIND_CDF_20000608.pro"'
Print, 'file_read: ', file_read
Print, 'data_descrip: '
Print, data_descrip
Save, FileName=dir_save+file_save, $
	data_descrip, $
	JulDay_vect_OR, Epoch_vect, $
	xyz_GSE_arr

; Note: sequence order stored in the tensor 
; vv_uniq  = [0,4,8,1,2,5]           ; => Uniq elements of a symmetric 3x3 matrix
; vv_trace = [0,4,8]                 ; => diagonal elements of a 3x3 matrix	


Goto, Another_i_file		


Another_i_file:
EndFor ;For i_file=i_file_beg,i_file_end Do Begin


End_Program:
End
