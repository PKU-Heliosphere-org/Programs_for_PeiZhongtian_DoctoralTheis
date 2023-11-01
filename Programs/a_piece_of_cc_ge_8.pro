;pro A_piece_of_CC_ge_8



device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL




date = '20080406-08'
sub_dir_date  = 'wind\fast\'+date+'\'


step1:

read,'1(for V&B) or 2(for Vx&n)',select

if select eq 1 then begin
liang = 'V&B'

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'correlation.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "plot_sigma_time.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
;      corr ,period_vect , time_vect_wavlet

endif

if select eq 2 then begin
liang = 'Vx&n'

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Correlation__of_Vx&n.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "plot_sigma_time.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
;   wave_coher, wave_phase,period_vect , time_vect_wavlet
corr = wave_coher

endif

step2:

read,'the threshold', thre

ntime = n_elements(time_vect_wavlet)
nscale = n_elements(period_vect)



check = fltarr(ntime)

for i_time = 0,ntime-1 do begin
  if abs(corr(i_time,0)) ge thre and abs(corr(i_time,1)) ge thre and abs(corr(i_time,2)) ge thre $
  and abs(corr(i_time,3)) ge thre and abs(corr(i_time,4)) ge thre and abs(corr(i_time,5)) ge thre $
  and abs(corr(i_time,6)) ge thre and abs(corr(i_time,7)) ge thre and abs(corr(i_time,8)) ge thre $
  and abs(corr(i_time,9)) ge thre and abs(corr(i_time,10)) ge thre and abs(corr(i_time,11)) ge thre $
  and abs(corr(i_time,12)) ge thre and abs(corr(i_time,13)) ge thre and abs(corr(i_time,14)) ge thre $
  and abs(corr(i_time,15)) ge thre  then begin
    check(i_time) = 1
  endif else begin
  endelse
endfor
    
sub_8 = where(check eq 1)
;print,sub_8
n_sub = n_elements(sub_8)

step3:

sub_beg = fltarr(n_sub)
sub_end = fltarr(n_sub)

sub_beg(0) = sub_8(0)
if  sub_beg(0) eq 0 then sub_beg(0) = 0.1
for i = 0, n_sub-2 do begin
  if sub_8(i+1)-sub_8(i) gt 1 then begin
  sub_end(i) = sub_8(i)
  sub_beg(i+1) = sub_8(i+1)
  endif
endfor
sub_end(n_sub-1) = sub_8(n_sub-1)

sub_beg = sub_beg(where(sub_beg ne 0.0))
sub_beg = float(round(sub_beg))
sub_end = sub_end(where(sub_end ne 0.0))

print,sub_beg,sub_end

dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_save = 'sub_of_begin_ang_end_of_corr_'+liang+'_ge_0.8.sav'
data_descrip= 'got from "A_piece_of_CC_ge_8.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  sub_beg,sub_end





step4:

n_corr = n_elements(sub_beg)

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date;+'MFI\'
file_restore= 'wi_h0_mfi_'+date+'_v05.sav'
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
JulDay_b = JulDay_vect
BXYZ_GSE_2S_ARR = BXYZ_GSE_ARR
Bx_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(0,*))
By_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(1,*))
Bz_GSE_2S_vect = Reform(BXYZ_GSE_2S_ARR(2,*))
;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'wi_pm_3dp_'+date+'_inB.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, P_VEL_3s_arr, P_DEN_3s_arr, $
;  Px_VEL_3s_vect, Py_VEL_3s_vect, Pz_VEL_3s_vect, P_DEN_3s_vect, $
;  P_TEMP_3s_vect


if select eq 1 then begin
  
window,1,xsize=600,ysize=900

for i_c = 0,n_corr-1 do begin
  
sub_mid = round((sub_beg(i_c)+sub_end(i_c))/2.0)  

kd = 20 ;;

if sub_mid le kd then begin
  JulDay_CS = JulDay_2s_vect(0:(sub_mid+kd))
endif
if sub_mid ge (ntime-kd) then begin
  JulDay_CS = JulDay_2s_vect((sub_mid-kd):(ntime-1))
endif else begin
  JulDay_CS = JulDay_2s_vect((sub_mid-kd):(sub_mid+kd))
endelse
xsm = min(JulDay_CS)
xla = max(JulDay_CS)

xrange  = [JulDay_2s_vect(sub_mid-kd), JulDay_2s_vect(sub_mid+kd)]
yrange  = [-10.0, 10.0]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.69,0.9,0.99],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  Font=-1,CharThick=1.0,Thick=1.0


Bx = Bx_GSE_2s_vect((sub_mid-kd):(sub_mid+kd))
Vx_B = Px_VEL_3s_vect((sub_mid-kd):(sub_mid+kd))*sqrt(P_DEN_3s_arr((sub_mid-kd):(sub_mid+kd)))/22.0
yB = 10.0
widtime=JulDay_2s_vect(sub_beg(i_c):sub_end(i_c))
xbian=fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_beg(i_c))
xbianh = fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_end(i_c))
ybian=findgen(sub_end(i_c)-sub_beg(i_c)+2)/(sub_end(i_c)-sub_beg(i_c)+1)*yB-0.5*yB
widy=fltarr(sub_end(i_c)-sub_beg(i_c)+1)
Bx_mean = mean(Bx,/nan)
Vx_mean = mean(Vx_B,/nan)
plot,JulDay_CS,Bx-Bx_mean,position=[0.15,0.69,0.9,0.99],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/NoErase
plot,JulDay_CS,Vx_B-Vx_mean,position=[0.15,0.69,0.9,0.99],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbianh,ybian,position=[0.15,0.69,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,850,'Bx-Bx0',charsize=1.2,charthick=2,/DEvice
xyouts,300,850,'Vx-Vx0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice



Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.36,0.9,0.66],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /noerase,Font=-1,CharThick=1.0,Thick=1.0

By = By_GSE_2s_vect((sub_mid-kd):(sub_mid+kd))
Vy_B = Py_VEL_3s_vect((sub_mid-kd):(sub_mid+kd))*sqrt(P_DEN_3s_arr((sub_mid-kd):(sub_mid+kd)))/22.0
yB = 10.0
widtime=JulDay_2s_vect(sub_beg(i_c):sub_end(i_c))
xbian=fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_beg(i_c))
xbianh = fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_end(i_c))
ybian=findgen(sub_end(i_c)-sub_beg(i_c)+2)/(sub_end(i_c)-sub_beg(i_c)+1)*yB-0.5*yB
widy=fltarr(sub_end(i_c)-sub_beg(i_c)+1)
By_mean = mean(By,/nan)
Vy_mean = mean(Vy_B,/nan)
plot,JulDay_CS,By-By_mean,position=[0.15,0.36,0.9,0.66],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/noerase
plot,JulDay_CS,Vy_B-Vy_mean,position=[0.15,0.36,0.9,0.66],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbianh,ybian,position=[0.15,0.36,0.9,0.66],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,550,'By-By0',charsize=1.2,charthick=2,/DEvice
xyouts,300,550,'Vy-Vy0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice



Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.03,0.9,0.33],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  /noerase,Font=-1,CharThick=1.0,Thick=1.0

Bz = Bz_GSE_2s_vect((sub_mid-kd):(sub_mid+kd))
Vz_B = Pz_VEL_3s_vect((sub_mid-kd):(sub_mid+kd))*sqrt(P_DEN_3s_arr((sub_mid-kd):(sub_mid+kd)))/22.0
yB = 10.0
widtime=JulDay_2s_vect(sub_beg(i_c):sub_end(i_c))
xbian=fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_beg(i_c))
xbianh = fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_end(i_c))
ybian=findgen(sub_end(i_c)-sub_beg(i_c)+2)/(sub_end(i_c)-sub_beg(i_c)+1)*yB-0.5*yB
widy=fltarr(sub_end(i_c)-sub_beg(i_c)+1)
Bz_mean = mean(Bz,/nan)
Vz_mean = mean(Vz_B,/nan)
plot,JulDay_CS,Bz-Bz_mean,position=[0.15,0.03,0.9,0.33],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/noerase
plot,JulDay_CS,Vz_B-Vz_mean,position=[0.15,0.03,0.9,0.33],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbianh,ybian,position=[0.15,0.03,0.9,0.33],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,250,'Bz-Bz0',charsize=1.2,charthick=2,/DEvice
xyouts,300,250,'Vz-Vz0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'timeccge0.8\'
;file_version= '(v1)'
file_fig  = 'timeccge0.8_'+$
        string(i_c+1)+'th'+ $
 ;       file_version+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endfor

endif


if select eq 2 then begin
  
window,1,xsize=600,ysize=400

for i_c = 0,n_corr-1 do begin
  
sub_mid = round((sub_beg(i_c)+sub_end(i_c))/2.0)  

kd = 20 ;;

if sub_mid le kd then begin
  JulDay_CS = JulDay_2s_vect(0:(sub_mid+kd))
  sub_min = 0
  sub_max = sub_mid+kd
endif
if sub_mid ge (ntime-kd) then begin
  JulDay_CS = JulDay_2s_vect((sub_mid-kd):(ntime-1))
  sub_min = sub_mid-kd
  sub_max = ntime-1  
endif 
if sub_mid lt (ntime-kd) and sub_mid gt kd then begin
  JulDay_CS = JulDay_2s_vect((sub_mid-kd):(sub_mid+kd))
  sub_min = sub_mid-kd
  sub_max = sub_mid+kd  
endif
xsm = min(JulDay_CS)
xla = max(JulDay_CS)

xrange  = [JulDay_2s_vect(sub_min), JulDay_2s_vect(sub_max)]
yrange  = [-10.0, 10.0]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 6
;;;---
ytitle = 'Vx(km/s) & n(*10/cm^3)'
Plot,xrange,yrange,XRange=xrange,YRange=yrange,XStyle=1,YStyle=1,$
  Position=[0.15,0.1,0.9,0.99],$
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
  XTitle=xtitle,YTitle=ytitle,$
  /NoData,Color=0L,$
  Font=-1,CharThick=1.0,Thick=1.0


n = P_DEN_3s_arr((sub_min):(sub_max))
Vx = Px_VEL_3s_vect((sub_min):(sub_max))
yB = 10.0
widtime=JulDay_2s_vect(sub_beg(i_c):sub_end(i_c))
xbian=fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_beg(i_c))
xbianh = fltarr(sub_end(i_c)-sub_beg(i_c)+2)+JulDay_2s_vect(sub_end(i_c))
ybian=findgen(sub_end(i_c)-sub_beg(i_c)+2)/(sub_end(i_c)-sub_beg(i_c)+1)*yB-0.5*yB
widy=fltarr(sub_end(i_c)-sub_beg(i_c)+1)
n_mean = mean(n,/nan)
Vx_mean = mean(Vx,/nan)
plot,JulDay_CS,(n-n_mean)*10.,position=[0.15,0.1,0.9,0.99],thick=2,yrange=[-yB,yB],XStyle=4, YStyle=4,/NoErase
plot,JulDay_CS,Vx-Vx_mean,position=[0.15,0.1,0.9,0.99],xtitle='time(s)',ytitle='B(nT)',thick=2,yrange=[-yB,yB],color='0000ff'XL,XStyle=4, YStyle=4,/noerase
plot,widtime,widy-0.5*yB,position=[0.15,0.1,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,widtime,widy+0.5*yB,position=[0.15,0.1,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbian,ybian,position=[0.15,0.1,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
plot,xbianh,ybian,position=[0.15,0.1,0.9,0.99],color='f0f000'XL,xrange=[xsm,xla],yrange=[-yB,yB],xstyle=4,ystyle=4,/noerase
xyouts,200,850,'n-n0',charsize=1.2,charthick=2,/DEvice
xyouts,300,850,'Vx-Vx0',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice



image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'timeccge0.8\'
file_fig  = 'corr_Vx_n_ge'+string(thre)+'_'+$
        string(i_c+1)+'th'+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endfor

endif


end_program:
end



