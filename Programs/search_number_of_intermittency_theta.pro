;pro search_number_of_intermittency_theta


sub_dir_date  = 'new\19950720-29-1\'


step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'time_remove_abs.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Plot_LIMed_program_v1.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; time_move

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=  'LocalBG_of_MagField_for_AutoCorr(time=19950720-19950729)(period=6.0-1999).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect, period_vect, $
; Bxyz_LBG_RTN_arr
;;;---



step2:

num_times = N_Elements(time_vect)
num_periods = N_Elements(period_vect)
theta_arr = Fltarr(num_times, num_periods)
Bx_LBG_RTN_arr  = Reform(Bxyz_LBG_RTN_arr(0,*,*))
Bt_LBG_RTN_arr  = Reform(Sqrt(Bxyz_LBG_RTN_arr(0,*,*)^2+Bxyz_LBG_RTN_arr(1,*,*)^2+Bxyz_LBG_RTN_arr(2,*,*)^2))
theta_arr = ACos(Bx_LBG_RTN_arr/Bt_LBG_RTN_arr)*180/!pi


step3:;;lim(8)92s,theta(15)100s

for i_Bcomp = 0,2 do begin
subr_remove = where(time_move(i_BComp,*,8) ne 0)
theta_move = theta_arr(subr_remove,15)

num_theta_small = n_elements(where(theta_arr(*,15) gt 0 and theta_arr(*,15) le 10))
num_theta_large = n_elements(where(theta_arr(*,15) ge 80 and theta_arr(*,15) lt 90))
min_theta_n = n_elements(where(theta_move gt 0 and theta_move le 10))
max_theta_n = n_elements(where(theta_move ge 80 and theta_move lt 90))

print,float(min_theta_n)/num_theta_small*100.,float(max_theta_n)/num_theta_large*100.

step4:

print,float(num_theta_small)/num_times*100.,float(num_theta_large)/num_times*100.


endfor
end








