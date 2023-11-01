;pro get_SF_sp_p_K
;

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

sub_dir_date  = 'new\19950508-12\'



Step1:
;===========================
;Step1:



n_jie = 10
jie = findgen(n_jie)+1.0
num_periods = 32
km = 10.0
n_theta = 90
sf = fltarr(n_jie,num_periods,km)


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
  dBt_min = min(Diff_Bt_arr(*,j),/nan)
  dBt_max = max(Diff_Bt_arr(*,j),/nan)
  sell = 50.0
  dBt = (dBt_max-dBt_min)/sell
  count = fltarr(sell)
  N= (size(Diff_Bt_arr))[1]
  Bt_f = fltarr(N,sell)
  for m=0,N-1 do begin
    for a=0,sell-1 do begin
      if Diff_Bt_arr(m,j) GE (dBt_min+a*dBt) and Diff_Bt_arr(m,j) LT (dBt_min+(a+1.0)*dBt) then begin
        count(a) = count(a)+1
        Bt_f(m,a) = Bt_StructFunct_arr(m,j)
      endif else begin
      endelse
    endfor
  endfor
count(sell-1)=count(sell-1)+1
;Bt_f(N-1,sell-1) = dBt_max
Bt_h = fltarr(sell)

for b=0,sell-1 do begin
  Bt_te = Bt_f(where(Bt_f(*,b) ne 0.0),b)
  Bt_h(b) = mean(Bt_te)
endfor
x_Bt = dBt_min+findgen(sell)*dBt
pdf = count/float(N)

plot,x_Bt,pdf,xtitle='dBt(nT)',ytitle='PDF'
;xyouts,200,200,'p='+string(i_jie+1),charsize=1.2,charthick=2,/DEvice
xyouts,200,250,'period='+string(period_vect(j))+'s',charsize=1.2,charthick=2,/DEvice
xyouts,200,300,'sigma='+string(sigma(j)),charsize=1.2,charthick=2,/DEvice
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'PDF_of_dBt_'+$
        'period='+string(period_vect(j))+'_sell='+string(sell)+ $
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
    sf(i_jie,j,k) = mean(Bt_h(fua:zhenga)*pdf(fua:zhenga))*(zhenga-fua+1.0)*dBt

  endfor                                                   
endfor


endfor

print,sf

dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = 'sf_sp_p_k_'+string(sell)+'.sav'
data_descrip= 'got from "get_SF_sp_p_K.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sf,n_jie,num_periods,km,period_vect

end





