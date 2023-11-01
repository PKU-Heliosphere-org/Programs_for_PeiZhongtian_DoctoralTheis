;Prepare_WIND_BV_Wavelet_FFT,var,var_BG,dir_restore,dir_save,dir_fig,$
;  num_scales,file_version,n_hours,n_days,num_times,is_theta_1_or_2,$
;  JulDay_vect,B_RTN_3s_arr,$
;  time_vect,dtime,period_range,TimeRange_str,$
;  sub_dir_date, NUMDENS_VECT

date = '19950720-29-1'
sub_dir_date  = 'new\'+date+'\'

dir_save    = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
WIND_Data_Dir = 'WIND_Data_Dir=C:\Users\pzt\course\Research\CDF_wind\'
WIND_Figure_Dir = 'WIND_Figure_Dir=C:\Users\pzt\course\Research\CDF_wind\'
SetEnv,WIND_Data_Dir
SetEnv,WIND_Figure_Dir

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01_v.sav'
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
;  JulDay_1s_vect, B_RTN_1s_arr, Bmag_RTN_1s_arr, $
;  Bx_RTN_1s_vect, By_RTN_1s_vect, Bz_RTN_1s_vect, Bmag_RTN_1s_vect
;JulDay_1s_vect = JulDay_2s_vect
;Bx_RTN_1s_vect = Bx_GSE_2s_vect
;By_RTN_1s_vect = By_GSE_2s_vect
;Bz_RTN_1s_vect = Bz_GSE_2s_vect
;B_RTN_1S_ARR = BXYZ_GSE_2S_ARR
;;;---

Set_Plot, 'ps';'win'
;Device,DeComposed=0
;Window,0,xs=1000,ysize = 1000
Device,filename=dir_save+'wavelet_recon(time=0-0)(v1).eps',XSize=18,YSize=24,/Color,Bits=10,/Encapsul
Device,DeComposed=0

LoadCT,13,/silent
TVLCT,R,G,B,/Get
color_red = 255L
TVLCT,255L,0L,0L,color_red
color_green = 254L
TVLCT,0L,255L,0L,color_green
color_blue  = 253L
TVLCT,0L,0L,255L,color_blue
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 251L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
color_bg    = color_white
!p.background = color_bg
;!p.multi = [0,1,6]


Step1:
;===========================
;Step1: get the wavelet transform from magnetic field components



B_RTN_3s_arr_recon = B_RTN_1S_ARR+!values.F_nan

for i_Bcomp = 1,3 do begin
If i_BComp eq 1 Then begin
  FileName_BComp = 'Bx' 
  FileName_B = 'Br'
  tou1 = '(a)'
  tou2 = '(b)'
endif
If i_BComp eq 2 Then begin
  FileName_BComp = 'By' 
  FileName_B = 'Bt'
  tou1 = '(c)'
  tou2 = '(d)'  
endif
If i_Bcomp eq 3 Then begin
  FileName_BComp = 'Bz' 
  FileName_B = 'Bn'
  tou1 = '(e)'
  tou2 = '(f)'
endif
If i_Bcomp eq 4 Then FileName_BComp = 'Bmag'

;;--
If i_BComp eq 1 Then Begin
  BComp_RTN_vect  = Bx_RTN_1s_vect
EndIf
If i_BComp eq 2 Then Begin
  BComp_RTN_vect  = By_RTN_1s_vect
EndIf
If i_BComp eq 3 Then Begin
  BComp_RTN_vect  = Bz_RTN_1s_vect
EndIf
If i_BComp eq 4 Then Begin
  BComp_RTN_vect  = sqrt(Bx_RTN_1s_vect^2+By_RTN_1s_vect^2+Bz_RTN_1s_vect^2)
EndIf




period_min  = 6.0;1.0;1.e0  ;unit: s
period_max  = 1.e3;1.e3
period_range= [period_min, period_max]
num_times = N_Elements(JulDay_1s_vect)
time_vect = (JulDay_1s_vect(0:num_times-1)-JulDay_1s_vect(0))*(24.*60.*60.)
num_scales  = N_ELEMENTS(period_vect)

get_Wavelet_Transform_of_BComp_vect_WIND_v2_recon, $
  time_vect, BComp_RTN_vect, $    ;input
  period_range=period_range, $  ;input
  num_scales=num_scales, $ ;input
  BComp_wavlet_arr, $       ;output
  time_vect_v2=time_vect_v2, $
  period_vect=period_vect, $
  scale_vect=scale_vect, $
  Cdelta,psi0,wavepad,dj_wavlet


  
;get_Wavelet_Transform_of_BComp_vect_WIND_v2, $
;  time_vect, BComp_RTN_vect, $    ;input
;  period_range=period_range, $  ;input
;  num_scales=num_scales, $ ;input
;  BComp_wavlet_arr, $       ;output
;  time_vect_v2=time_vect_v2, $
;  period_vect=period_vect, $
;  scale_vect=scale_vect
;dj_wavlet=0.125
;Cdelta=1
;psi0=1
;wavepad = time_vect
dtime = 1

;help,scale_vect,Cdelta,psi0,wavepad

recon_vect = fltarr(n_elements(JulDay_1s_vect),n_elements(period_vect))+!values.F_nan
file_restore   = FileName_BComp+'_Morlet_wavlet_arr(time=*-*)_LIMed.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Plot_LIMed_program.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_wavlet_arr, iter_value_arr
for i_period=0,15 do begin
    
;BComp_wavlet_vect_pad = [reform(BComp_wavlet_arr(*,i_period)),fltarr(n_elements(wavepad)-n_elements(JulDay_2s_vect))]
BComp_wavlet_vect_pad = reform(BComp_wavlet_arr(*,i_period))


;y1=dj_wavlet*SQRT(dtime)/(Cdelta*psi0)*(abs(BComp_wavlet_vect_pad) # (1./SQRT(scale_vect(i_period))))
y1=dj_wavlet*SQRT(dtime)/(Cdelta*psi0)*(FLOAT(BComp_wavlet_vect_pad) # (1./SQRT(scale_vect(i_period))))
recon_vect(*,i_period) = y1[0:n_elements(JulDay_1s_vect)-1]
endfor
BComp_RTN_vect_recon_withnolargescale = total(RECON_VECT,2,/nan)

recon_vect = fltarr(n_elements(JulDay_1s_vect),n_elements(period_vect))+!values.F_nan
file_restore   = FileName_BComp+'_Morlet_wavlet_arr(time=*-*).sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Plot_LIMed_program.pro"'
;Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    JulDay_vect, time_vect_v2, period_vect, $
;    BComp_wavlet_arr, iter_value_arr
for i_period=0,15 do begin
  
  
;BComp_wavlet_vect_pad = [reform(BComp_wavlet_arr(*,i_period)),fltarr(n_elements(wavepad)-n_elements(JulDay_2s_vect))]
BComp_wavlet_vect_pad = reform(BComp_wavlet_arr(*,i_period))


;y1=dj_wavlet*SQRT(dtime)/(Cdelta*psi0)*(abs(BComp_wavlet_vect_pad) # (1./SQRT(scale_vect(i_period))))
y1=dj_wavlet*SQRT(dtime)/(Cdelta*psi0)*(FLOAT(BComp_wavlet_vect_pad) # (1./SQRT(scale_vect(i_period))))
recon_vect(*,i_period) = y1[0:n_elements(JulDay_1s_vect)-1]
endfor
BComp_RTN_vect_recon_largescale = BComp_RTN_vect-total(RECON_VECT,2,/nan)

B_RTN_3s_arr_recon(i_BComp-1.,*) = BComp_RTN_vect_recon_withnolargescale+BComp_RTN_vect_recon_largescale



;
;xrange  = [Min(JulDay_1s_vect), Max(JulDay_1s_vect)]
;xrange_time = xrange
;get_xtick_for_time_MacOS, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
;xtickv    = xtickv_time
;xticks    = N_Elements(xtickv)-1
;xticknames  = xticknames_time
;;xminor  = xminor_time
;xminor    = 6
; 
plot_day = 5
num_day = 86400

if i_Bcomp eq 1 then begin
  plot,JulDay_1s_vect((plot_day-2)*num_day:plot_day*num_day)-JulDay_1s_vect((plot_day-2)*num_day),BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day), $
    color=color_black,charsize=1.25,xstyle=1, charthick = 4,xthick=4,ythick=4,xtickformat='(A1)', $
    position=[0.15,0.81-(i_Bcomp-1)*0.28,0.95,0.95-(i_Bcomp-1)*0.28], ytitle=FileName_B+' (nT)'
;oplot,JulDay_2s_vect-JulDay_2s_vect(0),BComp_RTN_vect,color=color_red
oplot,JulDay_1s_vect((plot_day-2)*num_day:plot_day*num_day)-JulDay_1s_vect((plot_day-2)*num_day),B_RTN_3s_arr_recon(i_BComp-1,(plot_day-2)*num_day:plot_day*num_day),color=color_red
xyouts,-0.35,max(BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day)),tou1,charsize=1.25,charthick=4
endif else begin
plot,JulDay_1s_vect((plot_day-2)*num_day:plot_day*num_day)-JulDay_1s_vect((plot_day-2)*num_day),BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day),color=color_black,charsize=1.25, xstyle=1,charthick = 4,xthick=4,ythick=4,xtickformat='(A1)', $
  position=[0.15,0.81-(i_Bcomp-1)*0.28,0.95,0.95-(i_Bcomp-1)*0.28], ytitle=FileName_B+' (nT)',/noerase
;oplot,JulDay_2s_vect-JulDay_2s_vect(0),BComp_RTN_vect,color=color_red
oplot,JulDay_1s_vect((plot_day-2)*num_day:plot_day*num_day)-JulDay_1s_vect((plot_day-2)*num_day),B_RTN_3s_arr_recon(i_BComp-1,(plot_day-2)*num_day:plot_day*num_day),color=color_red
xyouts,-0.35,max(BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day)),tou1,charsize=1.25,charthick=4
endelse


if i_Bcomp eq 3 then begin
  plot,JulDay_1s_vect((plot_day-2)*num_day:plot_day*num_day)-JulDay_1s_vect((plot_day-2)*num_day),BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day)-B_RTN_3s_arr_recon(i_BComp-1,(plot_day-2)*num_day:plot_day*num_day), $
    xstyle=1,color=color_black,charsize=1.25, charthick = 4,xthick=4,ythick=4,$
 ;   XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04,$
    position=[0.15,0.67-(i_Bcomp-1)*0.28,0.95,0.81-(i_Bcomp-1)*0.28], ytitle=textoIDL('\Delta')+FileName_B+' (nT)', $
    xtitle='Time (days) '+'19950723-24',/noerase
xyouts,-0.35,max(BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day)-B_RTN_3s_arr_recon(i_BComp-1,(plot_day-2)*num_day:plot_day*num_day))-0.1,tou2,charsize=1.25,charthick=4
endif else begin
plot,JulDay_1s_vect((plot_day-2)*num_day:plot_day*num_day)-JulDay_1s_vect((plot_day-2)*num_day),BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day)-B_RTN_3s_arr_recon(i_BComp-1,(plot_day-2)*num_day:plot_day*num_day),xstyle=1,color=color_black,charsize=1.25,charthick = 4,xthick=4,ythick=4,xtickformat='(A1)', $
  position=[0.15,0.67-(i_Bcomp-1)*0.28,0.95,0.81-(i_Bcomp-1)*0.28], ytitle=textoIDL('\Delta')+FileName_B+' (nT)',/noerase
xyouts,-0.35,max(BComp_RTN_vect((plot_day-2)*num_day:plot_day*num_day)-B_RTN_3s_arr_recon(i_BComp-1,(plot_day-2)*num_day:plot_day*num_day)),tou2,charsize=1.25,charthick=4  
endelse

endfor

;;;--
;image_tvrd  = TVRD(true=1)
;dir_fig   = dir_save
;file_version= '(v1)'
;file_fig  = 'wavelet_recon'+$
;        '(time=0-0)'+$
;        file_version+$
;        '.eps'
;Write_PNG, dir_fig+file_fig, image_tvrd
Device,/close



;;--
B_RTN_1S_ARR = B_RTN_3s_arr_recon

;!p.multi = 0
file_save   = 'uy_1sec_vhm_19950720-29_v01_recon.sav'
data_descrip= 'got from "wavelet_recon.pro"'
 Save, FileName=dir_save+file_save, $
    data_descrip, $
    JulDay_1s_vect,  $
     B_RTN_1S_ARR
     
end


