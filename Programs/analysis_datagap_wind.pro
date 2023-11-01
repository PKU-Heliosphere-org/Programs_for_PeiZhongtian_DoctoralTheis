;pro analysis_datagap_wind


sub_dir_date = 'wind\Alfven1\'
sub_dir_date1 = 'wind\fast\case1\'

num_day = 1

;dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_restore= 'Num_datagaps_slow_and_fast'+'_v.sav'
;file_array  = File_Search(dir_restore+file_restore, count=num_files)
;For i_file=0,num_files-1 Do Begin
;  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
;EndFor
;i_select  = 0
;;Read, 'i_select: ', i_select
;file_restore  = file_array(i_select)
;Restore, file_restore, /Verbose



;goto,step2
step1:

i_slow = 1
;num_datagap_slow = fltarr(num_day)

dtime_slow = fltarr(num_day)

;for i_slow = 1, num_day do begin

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_h2_mfi_20020525_v05_Wai'+'.sav';strcompress(string(i_slow),/remove_all)+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect

;num_datagap_slow(i_slow-1) = num_datagaps



;print,size(Bx_GSE_vect_plot)
N_time = n_elements(JulDay_vect_interp)
dtime_slow(i_slow-1) = (JulDay_vect_interp(1)-JulDay_vect_interp(0))*86400.
for i_gap = 0,num_datagaps-1 do begin
  for i_time = 0,N_time-1 do begin
    a = (JulDay_vect_interp(i_time)-JulDay_beg_DataGap_vect(i_gap))*86400.
    if abs(a) le dtime_slow(i_slow-1)/2. then begin
      sub_beg = i_time
      break
    endif
  endfor
  for i_time = 0,N_time-1 do begin
    b = (JulDay_vect_interp(i_time)-JulDay_end_DataGap_vect(i_gap))*86400.
    if abs(b) le dtime_slow(i_slow-1)/2. then begin
      sub_end = i_time
      break
    endif
  endfor  
  for i_time = sub_beg,sub_end do begin
    if (i_time-sub_beg) ge 2 and (sub_end-i_time) ge 2 then begin
      Bx_GSE_vect_interp(i_time) = !values.f_nan
      By_GSE_vect_interp(i_time) = !values.f_nan
      Bz_GSE_vect_interp(i_time) = !values.f_nan
    endif
  endfor
endfor
;N_should(i_slow-1) = (JulDay_vect_plot(N_time-1)-JulDay_vect_plot(0))*86400./dtime(i_slow-1)
;;print,dtime,N_time,N_should
;N_datagap(i_slow-1) = round(N_should(i_slow-1)-N_time)



;print,size(Bx_GSE_vect_interp),size(By_GSE_vect_interp),size(Bz_GSE_vect_interp)



dir_save  = dir_restore
;a dir_save  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
;a file_save = 'Bxyz_GSE_arr'+TimeRange_plot_str+'.sav'
file_save = 'wi_h2_mfi_20020525_v05_Wai'+'.sav';strcompress(string(i_slow),/remove_all)+'_v.sav'

data_descrip  = 'got from "analysis_datagap_wind.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip,  $
 ;   TimeRange_str, $
 ;   JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


;endfor

goto,end_program
step2:

dtime_fast = fltarr(num_day)
num_datagap_fast = fltarr(num_day)

for i_fast = 1, num_day do begin

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date1
file_restore= strcompress(string(i_fast),/remove_all)+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_199502.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    TimeRange_str, $
;    JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
;    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp, $
;    sub_beg_BadBins_vect, sub_end_BadBins_vect, $
;    num_DataGaps, JulDay_beg_DataGap_vect, JulDay_end_DataGap_vect
num_datagap_fast(i_fast-1) = num_datagaps



;print,size(Bx_GSE_vect_plot)
N_time = n_elements(JulDay_vect_interp)
dtime_fast(i_fast-1) = (JulDay_vect_interp(1)-JulDay_vect_interp(0))*86400.
for i_gap = 0,num_datagaps-1 do begin
  for i_time = 0,N_time-1 do begin
    a = (JulDay_vect_interp(i_time)-JulDay_beg_DataGap_vect(i_gap))*86400.
    if abs(a) le dtime_fast(i_fast-1)/2. then begin
      sub_beg = i_time
      break
    endif
  endfor
  for i_time = 0,N_time-1 do begin
    b = (JulDay_vect_interp(i_time)-JulDay_end_DataGap_vect(i_gap))*86400.
    if abs(b) le dtime_fast(i_fast-1)/2. then begin
      sub_end = i_time
      break
    endif
  endfor  
  for i_time = sub_beg,sub_end do begin
    if (i_time-sub_beg) ge 2 and (sub_end-i_time) ge 2 then begin
      Bx_GSE_vect_interp(i_time) = !values.f_nan
      By_GSE_vect_interp(i_time) = !values.f_nan
      Bz_GSE_vect_interp(i_time) = !values.f_nan
    endif
  endfor
endfor
;N_should(i_slow-1) = (JulDay_vect_plot(N_time-1)-JulDay_vect_plot(0))*86400./dtime(i_slow-1)
;;print,dtime,N_time,N_should
;N_datagap(i_slow-1) = round(N_should(i_slow-1)-N_time)



;print,size(Bx_GSE_vect_interp),size(By_GSE_vect_interp),size(Bz_GSE_vect_interp)



dir_save  = dir_restore
;a dir_save  = GetEnv('WIND_MFI_Data_Dir')+sub_dir_date+''
;a file_save = 'Bxyz_GSE_arr'+TimeRange_plot_str+'.sav'
file_save = strcompress(string(i_fast),/remove_all)+'_v.sav'

data_descrip  = 'got from "analysis_datagap_wind.pro"'
Save, FileName=dir_save+file_save, $
    data_descrip,  $
 ;   TimeRange_str, $
 ;   JulDay_vect_plot, Bx_GSE_vect_plot, By_GSE_vect_plot, Bz_GSE_vect_plot, $
    JulDay_vect_interp, Bx_GSE_vect_interp, By_GSE_vect_interp, Bz_GSE_vect_interp


endfor



;dir_save  = dir_restore
;file_save = 'Num_datagaps_slow_and_fast'+'_v.sav'
;data_descrip  = 'got from "analysis_datagap_wind.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip,  $
;    num_datagap_slow, num_datagap_fast, dtime_slow, dtime_fast


End_program:

end





