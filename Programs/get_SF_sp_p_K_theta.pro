
;pro get_SF_sp_p_K_theta
;

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

sub_dir_date  = 'new\19950721\'



Step1:
;===========================
;Step1:



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'MagDeflectAng_time_scale_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_MagDefectionAngle_time_scale_arr_WIND_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, scale_vect, $
; MagDeflectAng_arr


size_Mag = size(MagDeflectAng_arr)
n_time = size_mag(1)
n_scale = size_mag(2)
for i = 0,n_time-1 do begin
  for j = 0,n_scale-1 do begin
    if MagDeflectAng_arr(i,j) gt 90 then begin
      MagDeflectAng_arr(i,j) = 180.0-MagDeflectAng_arr(i,j)
    endif
  endfor
endfor








n_jie = 10
jie = findgen(n_jie)+1.0
num_periods = 32
km = 10.0

n_theta = 9
sf = fltarr(n_theta,n_jie,num_periods,km)


for i_jie = 0,n_jie-1 do begin
;i_jie=1
;;--
jieshu = jie(i_jie)
;;--

;;;---


;Diff_Bt_arr = Diff_BComp_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Bt_StructFunct'+string(jieshu)+'_arr(time=*-*)*.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_StructFunct_of_Bperp_Bpara_theta_scale_arr_19760307.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_min, time_vect, period_vect, $
;  Bt_StructFunct_arr, $
;  Bt_StructFunct_vect, $
;  Diff_Bt_arr, $
;  num_times_vect



;Bt_StructFunct_vect  = StructFunct_Bt_theta_scale_arr



step2:
num_periods = N_Elements(period_vect)
sigma = fltarr(num_periods)

for j = 0,num_periods-1 do begin
  sigma(j) = stddev(Diff_Bt_arr(*,j),/nan)
  
  sub_1 = where(MagDeflectAng_arr(*,j) gt 0 and MagDeflectAng_arr(*,j) le 10)
  sub_2 = where(MagDeflectAng_arr(*,j) gt 10 and MagDeflectAng_arr(*,j) le 20)
  sub_3 = where(MagDeflectAng_arr(*,j) gt 20 and MagDeflectAng_arr(*,j) le 30)
  sub_4 = where(MagDeflectAng_arr(*,j) gt 30 and MagDeflectAng_arr(*,j) le 40)
  sub_5 = where(MagDeflectAng_arr(*,j) gt 40 and MagDeflectAng_arr(*,j) le 50)
  sub_6 = where(MagDeflectAng_arr(*,j) gt 50 and MagDeflectAng_arr(*,j) le 60)
  sub_7 = where(MagDeflectAng_arr(*,j) gt 60 and MagDeflectAng_arr(*,j) le 70)
  sub_8 = where(MagDeflectAng_arr(*,j) gt 70 and MagDeflectAng_arr(*,j) le 80)
  sub_9 = where(MagDeflectAng_arr(*,j) gt 80 and MagDeflectAng_arr(*,j) le 90)
 for i_theta = 0,8 do begin
  if i_theta eq 0 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_1,j)
    stringthe = '0-10'
  endif
  if i_theta eq 1 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_2,j)
    stringthe = '10-20'
  endif
  if i_theta eq 2 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_3,j)
    stringthe = '20-30'
  endif
  if i_theta eq 3 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_4,j)
    stringthe = '30-40'
  endif
  if i_theta eq 4 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_5,j)
    stringthe = '40-50'
  endif
  if i_theta eq 5 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_6,j)
    stringthe = '50-60'
  endif  
  if i_theta eq 6 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_7,j)
    stringthe = '60-70'
  endif  
  if i_theta eq 7 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_8,j)
    stringthe = '70-80'
  endif    
  if i_theta eq 8 then begin
    Bt_SF_theta = Bt_StructFunct_arr(sub_9,j)
    stringthe = '80-90'
  endif  
        
  dBt_min = min(Diff_Bt_arr(*,j),/nan)
  dBt_max = max(Diff_Bt_arr(*,j),/nan)
  sell = 21.0
  dBt = (dBt_max-dBt_min)/sell
  count = fltarr(sell)
  N= (size(Bt_SF_theta))[1]
  Bt_f = fltarr(N,sell)
  for m=0,N-1 do begin
    for a=0,sell-1 do begin
      if Diff_Bt_arr(m,j) GE (dBt_min+a*dBt) and Diff_Bt_arr(m,j) LT (dBt_min+(a+1.0)*dBt) then begin
        count(a) = count(a)+1
        Bt_f(m,a) = Bt_sf_theta(m)
      endif else begin
      endelse
    endfor
  endfor
;count(sell-1)=count(sell-1)+1
;Bt_f(N-1,sell-1) = dBt_max
Bt_h = fltarr(sell)

for b=0,sell-1 do begin
  Bt_te = Bt_f(where(Bt_f(*,b) ne 0.0),b)
  Bt_h(b) = mean(Bt_te)
endfor
x_Bt = dBt_min+findgen(sell)*dBt
pdf = count/float(N)

plot,x_Bt,pdf,xtitle='dBt(nT)',ytitle='PDF'
xyouts,200,200,'theta='+stringthe,charsize=1.2,charthick=2,/DEvice
xyouts,200,250,'period='+string(period_vect(j))+'s',charsize=1.2,charthick=2,/DEvice
xyouts,200,300,'sigma='+string(sigma(j)),charsize=1.2,charthick=2,/DEvice
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'PDF_of_dBt_'+$
        'period='+string(period_vect(j))+'_sell=21_'+stringthe+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd
  
  
  
;  for i_the = 0,n_theta-1 do begin
  for k = 0,km-1 do begin
 ; k=0
    ksigma = (k+1.0)*sigma(j)
   fua = 0
   zhenga = 0 
   fua = round((-ksigma-dBt_min)/dBt)
   zhenga = round((ksigma-dBt_min)/dBt)
   if fua lt 0 then fua = 0
   if zhenga gt sell-1 then zhenga = sell-1
   
 ;   pdfs = mean(pdf(fua:zhenga))*(zhenga-fua+1.0)
    sf(i_theta,i_jie,j,k) = mean(Bt_h(fua:zhenga)*pdf(fua:zhenga))*(zhenga-fua+1.0)*dBt

  endfor   
 endfor                                                 
endfor


endfor

print,sf

dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'sf_sp_p_k_theta_21sell.sav'
data_descrip= 'got from "get_SF_sp_p_K.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sf,n_jie,num_periods,km,period_vect,n_theta

end


















