;Pro get_dB_over_b0


sub_dir_date  = 'new\19951116-25\'


Step1:
;===========================
;Step1:

;;--
dir_restore = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19951116-25_v01.sav'
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

i=size(JulDay_2s_vect,/dimensions)
time = fltarr(i)
second=fltarr(i)
hour=fltarr(i)
time = JulDay_2s_vect-long(JulDay_2s_vect(0))-0.5
second = time*86400.0
hour= time*24

j=size(Bt_GSE_2s_vect,/dimensions)

a = long(fix(j/hour(j)))
n = 0
t = uint(hour(j))
value = fltarr(t(0))
for n = 0,(t(0)-2) do begin

Bx_var = variance(Bx_GSE_2s_vect(n*a:(n+1)*a))
By_var = variance(By_GSE_2s_vect(n*a:(n+1)*a))
Bz_var = variance(Bz_GSE_2s_vect(n*a:(n+1)*a))
Bt_var = sqrt(Bx_var+By_var+Bz_var)

meanBt = mean(Bt_GSE_2s_vect(n*a:(n+1)*a))
value(n) = Bt_var/meanBt
endfor

Bx_var = variance(Bx_GSE_2s_vect((t(0)-1)*a:(j-1)))
By_var = variance(By_GSE_2s_vect((t(0)-1)*a:(j-1)))
Bz_var = variance(Bz_GSE_2s_vect((t(0)-1)*a:(j-1)))
Bt_var = sqrt(Bx_var+By_var+Bz_var)

meanBt = mean(Bt_GSE_2s_vect((t(0)-1)*a:(j-1)))
value((t(0)-1)) = Bt_var/meanBt

x=indgen(t(0))+1
device,decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL

xtitle='time:hour'
ytitle='dB/B0'
plot,x,value,PSYM = 2,xtitle=xtitle,ytitle=ytitle


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = 'dB_over_B0_var_perhour'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

;;--




End_program:
end


