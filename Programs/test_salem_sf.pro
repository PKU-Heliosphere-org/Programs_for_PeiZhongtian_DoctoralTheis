;pro test_SALEM_SF


sub_dir_date  = 'new\19950720-29pvi\'


Step1:
;===========================
;Step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bx'+'_Haar_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr
Bx_wavlet_arr = BComp_wavlet_arr

wef = size(BComp_wavlet_arr)
n_time = wef(1)

period = [4.0,8.0,16.0,32.0,64.0,128.0,256.0,512.0,1024.0]
m = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0]
n_period = n_elements(period)
n_jie = 6
Bt_f = fltarr(n_time,n_jie,n_period)
SF = fltarr(n_jie,n_period)
SF_f = fltarr(n_jie,n_period)
sigma = fltarr(n_period)
eita = fltarr(n_period)
n_percent = fltarr(n_period)
;i_Tran = 0
;Read, 'i_Tran(1/2 for Morlet/Haar): ', i_Tran
;If i_Tran eq 1 Then FileName_Tran='Morlet'
;If i_Tran eq 2 Then FileName_Tran='Haar'

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'By'+'_Haar_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr
;;;---

By_wavlet_arr = BComp_wavlet_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bz'+'_Haar_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr

Bz_wavlet_arr = BComp_wavlet_arr

Bt_wavlet_arr = sqrt(Bx_wavlet_arr^2.0+By_wavlet_arr^2.0+Bz_wavlet_arr^2.0)

step2:
read,'Bx,By,Bz,Bt for 1,2,3,4', i
if i eq 1 then begin
  Bc_wavlet_arr = Bx_wavlet_arr
  str = 'Bx'
endif
if i eq 2 then begin
  Bc_wavlet_arr = By_wavlet_arr
    str = 'By'
endif
if i eq 3 then begin
  Bc_wavlet_arr = Bz_wavlet_arr
    str = 'Bz'
endif
if i eq 4 then begin
  Bc_wavlet_arr = Bt_wavlet_arr
    str = 'Bt'
endif


for i_jie = 0,n_jie-1 do begin
  for i_period = 0,n_period-1 do begin
    SF(i_jie,i_period) = mean((abs(Bc_wavlet_arr(*,i_period)))^(i_jie+1),/nan)/2.0^((m(i_period)/2.0-1.0)*(i_jie+1.0))
  endfor
endfor



;endfor







step3:
;read,'F:',F
F=5
for i_jie = 0,n_jie-1 do begin
for i_period = 0,n_period-1 do begin
sigma(i_period) =  mean((abs(Bc_wavlet_arr(*,i_period)))^2.0,/nan)
eita(i_period) = F*sigma(i_period)
Bt_f = Bc_wavlet_arr
Bt_f(where(abs(Bc_wavlet_arr(*,i_period))^2.0 gt eita(i_period)),i_period) = !values.F_nan
n_poit = n_elements(where(abs(Bc_wavlet_arr(*,i_period))^2.0 gt eita(i_period)))
n_percent(i_period) = float(n_poit)/float(n_time)
SF_f(i_jie,i_period) = mean((abs(Bt_f(*,i_period)))^(i_jie+1),/nan)/2.0^((m(i_period)/2.0-1.0)*(i_jie+1.0))
endfor
endfor

dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'sf_SALEM_'+str+'_(period=4-1024s)'+'.sav'
data_descrip= 'got from "get_SF_sp_p_K.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  SF,SF_f
  
  
step4:
p = [1.0,2.0,3.0,4.0,5.0,6.0]
sp = fltarr(n_jie)
sp_f = fltarr(n_jie)
for i_jie = 0,n_jie-1 do begin
  wed = linfit(alog10(period),alog10(SF(i_jie,*)))
  sp(i_jie) = wed(1)
  wes = linfit(alog10(period),alog10(SF_f(i_jie,*)))
  sp_f(i_jie) = wes(1)
endfor

plot,p,sp,yrange = [0,3]
plot,p,sp_f,color='FF0000'XL,yrange=[0,3],/noerase
print,n_percent
end


