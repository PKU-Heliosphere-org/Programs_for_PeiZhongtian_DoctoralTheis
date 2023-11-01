;pro count_howmany_times_of_sub
;已夭折
sub_dir_date  = '20050929\'



device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

Step1:
;===========================
;Step1:

dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore = 'sub_of_angle'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, scale_vect, $
;  MagDeflectAng_arr, $
;  subGT30, subLE10

;;--
dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_20050929_v01.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_Ulysess_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_2s_vect, Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, $
; BMAG_GSE_2S_ARR, BXYZ_GSE_2S_ARR, Btotal_GSE_2s_vect
Bt_GSE_2s_vect    = sqrt(Bx_GSE_2s_vect^2+By_GSE_2s_vect^2+Bz_GSE_2s_vect^2)


step2:
;step2_1:
;计算一共多少段
j=0L
n_GT30 = size(subGT30,/dimensions)
Bfdx = dblarr(n_GT30)
Bfdy = dblarr(n_GT30)
Bfdz = dblarr(n_GT30)
for i=0,n_GT30(0)-2 do begin
if (subGT30(i+1)-subGT30(i)) eq 1 then begin
  Bfdx(i)=Bx_GSE_2s_vect(subGT30(i))
  Bfdy(i)=By_GSE_2s_vect(subGT30(i))
  Bfdz(i)=Bz_GSE_2s_vect(subGT30(i))
  Bfdx(i+1)=Bx_GSE_2s_vect(subGT30(i+1))
  Bfdy(i+1)=By_GSE_2s_vect(subGT30(i+1))
  Bfdz(i+1)=Bz_GSE_2s_vect(subGT30(i+1))
  endif else begin
    j=j+1
  endelse
endfor
j=j+1
print,j
;xutime=indgen(j)

;检验0
for ii=1,n_GT30(0)-2 do begin
  if bfdx(ii) eq 0 then begin
    bfdx(ii)=(bfdx(ii-1)+bfdx(ii+1))/2.0
    endif
    if bfdy(ii) eq 0 then begin
    bfdy(ii)=(bfdy(ii-1)+bfdy(ii+1))/2.0
    endif
    if bfdz(ii) eq 0 then begin
    bfdz(ii)=(bfdz(ii-1)+bfdz(ii+1))/2.0
    endif
endfor
    
bfdx=bfdx(1:n_GT30(0)-2)
bfdy=bfdy(1:n_GT30(0)-2)
bfdz=bfdz(1:n_GT30(0)-2)
bfd=sqrt(bfdx^2+bfdy^2+bfdz^2)
B_mean = mean(bfd)
dBx = variance(bfdx)
dBy = variance(bfdy)
dBz = variance(bfdz)
dB = sqrt(dBx+dBy+dBz)
print,dB/B_mean

;step2_2:
;计算每段的dB/B0
step3:
j=0L
n_LE10 = size(subLE10,/dimensions)
Bfdx = dblarr(n_LE10)
Bfdy = dblarr(n_LE10)
Bfdz = dblarr(n_LE10)
for i=0,n_LE10(0)-2 do begin
if (subLE10(i+1)-subLE10(i)) eq 1 then begin
  Bfdx(i)=Bx_GSE_2s_vect(subLE10(i))
  Bfdy(i)=By_GSE_2s_vect(subLE10(i))
  Bfdz(i)=Bz_GSE_2s_vect(subLE10(i))
  Bfdx(i+1)=Bx_GSE_2s_vect(subLE10(i+1))
  Bfdy(i+1)=By_GSE_2s_vect(subLE10(i+1))
  Bfdz(i+1)=Bz_GSE_2s_vect(subLE10(i+1))
  endif else begin
    j=j+1
  endelse
endfor
j=j+1
print,j
;xutime=indgen(j)

;检验0
for ii=1,n_LE10(0)-2 do begin
    if bfdx(ii) eq 0 then begin
    bfdx(ii)=(bfdx(ii-1)+bfdx(ii+1))/2.0
    endif
    if bfdy(ii) eq 0 then begin
    bfdy(ii)=(bfdy(ii-1)+bfdy(ii+1))/2.0
    endif
    if bfdz(ii) eq 0 then begin
    bfdz(ii)=(bfdz(ii-1)+bfdz(ii+1))/2.0
    endif
endfor
    
bfdx=bfdx(1:n_LE10(0)-2)
bfdy=bfdy(1:n_LE10(0)-2)
bfdz=bfdz(1:n_LE10(0)-2)
bfd=sqrt(bfdx^2+bfdy^2+bfdz^2)
B_mean = mean(bfd)
dBx = variance(bfdx)
dBy = variance(bfdy)
dBz = variance(bfdz)
dB = sqrt(dBx+dBy+dBz)
print,dB/B_mean



end_program:
end








