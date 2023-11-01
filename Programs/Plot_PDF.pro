;pro PLot_PDF

;window,3
device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL
;Pro fanwavelet
Date = '19950720-29'
sub_dir_date  = 'new\'+date+'\'
;;--

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01.sav'
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
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect
Bxyz_GSE_2s_arr_ori = Bxyz_GSE_2s_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_19950720-29_v01_recon.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "wavelet_recon.pro"'
; Save, FileName=dir_save+file_save, $
;    data_descrip, $
;    JulDay_2s_vect,  $
;    BXYZ_GSE_2S_ARR
BXYZ_GSE_2S_ARR_recon = BXYZ_GSE_2S_ARR




Read, 'time lag(s): ', time
;time = 1000.0

Set_Plot, 'ps';'win'
;Device,DeComposed=0
;Window,0,xs=1000,ysize = 1000
Device,filename=dir_restore+'W_'+string(time)+'.eps',$
XSize=20,YSize=20,/Color,Bits=10,/Encapsul
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
!p.multi = [0,2,3]



i_BComp = 0

for i_BComp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then begin
  FileName_BComp = 'Bx' 
  FileName_B = 'Br'
  
endif
If i_BComp eq 2 Then begin
  FileName_BComp = 'By' 
  FileName_B = 'Bt'
endif
If i_Bcomp eq 3 Then begin
  FileName_BComp = 'Bz' 
  FileName_B = 'Bn'
endif




step1:

;print,size(time_vect_v2),size(JulDay_vect)
;print,JulDay_vect(0),time_vect_v2(0)


N_o= N_elements(BXYZ_GSE_2S_ARR_ori(i_BComp-1,*))
N_r= N_elements(BXYZ_GSE_2S_ARR_recon(i_BComp-1,*))
;ie = i/2.0
;d=fltarr(N-ie)
;for j=0,N-ie-1 do begin
;  d(j) = Bmag_GSE_2s_arr(j+ie)-Bmag_GSE_2s_arr(j)
;endfor
delta_o = fltarr(N_o-round(time/2.0))
delta_r = fltarr(N_r-round(time/2.0))
for i=0,N_o-round(time/2.0)-1 do begin
  delta_o(i) = BXYZ_GSE_2S_ARR_ori(i_BComp-1,i+round(time/2.0))-BXYZ_GSE_2S_ARR_ori(i_BComp-1,i)
endfor
;d = real_part(BComp_wavlet_arr(*,i))
for i=0,N_r-round(time/2.0)-1 do begin
  delta_r(i) = BXYZ_GSE_2S_ARR_recon(i_BComp-1,i+round(time/2.0))-BXYZ_GSE_2S_ARR_recon(i_BComp-1,i)
endfor


step2:;画PDF
for i_we = 0,1 do begin
  
  if i_we eq 0 then begin
  d = delta_o
  N = N_o-round(time/2.0)
  if i_Bcomp eq 1 then lab = '(a)'
  if i_Bcomp eq 2 then lab = '(c)'
  if i_Bcomp eq 3 then lab = '(e)'
  biao=lab+'original '+FileName_B
  endif
  if i_we eq 1 then begin
  d = delta_r
  N = N_r-round(time/2.0)
  if i_Bcomp eq 1 then lab = '(b)'
  if i_Bcomp eq 2 then lab = '(d)'
  if i_Bcomp eq 3 then lab = '(f)'
  biao=lab+'reconstruction '+FileName_B
  endif

dmax = max(d,/nan)
dmin = min(d,/nan)
drange = dmax-dmin
sell = 40.0
dpart = drange/sell

count = lonarr(sell)
for j=0,N-1 do begin
  for k=0,sell-1 do begin
    if d(j) GE (dmin+k*dpart) and d(j) LT (dmin+(k+1)*dpart) then begin
      count(k) = count(k)+1
    endif else begin
    endelse
  endfor
endfor
count(sell-1)=count(sell-1)+1

step3:


c=indgen(sell)
d_plot = dmin+c*dpart
dstd = stddev(d,/nan)
d_plot = d_plot/dstd      ;;;;横坐标
;;;--
;for e=0,39 do begin
;  if count(e) eq 0 then begin
;    count(e)=1
;  endif
;endfor
;;;--

y_plot = float(count)/float(N)
y_plot = y_plot*dstd/dpart          ;纵坐标
plot,d_plot,y_plot,xtitle='d'+FileName_B+'/'+textoIDL('\sigma'),ytitle='PDF',$
psym=-1,color = color_black,charsize=1.5,charthick=1.5,thick=1.5,xrange=[-12.0,12.0],yrange=[10^(-6.0),1.0],/ylog
xyouts,-13.0,0.3,biao,charsize=0.8,charthick=1.5


;result = gaussfit(db_plot,alog10(y_plot))
result = gaussfit(d_plot,y_plot,para,nterms=3)
result = para(0)*exp(-((d_plot-para(1))/(1.*para(2)))^2/2.);+para(3)
print,para
oplot,d_plot,result,color=color_red,psym=-1,thick=1.5;,xrange=[-8,8],yrange=[-5,0],/noerase

endfor

;

endfor

;image_tvrd  = TVRD(true=1)
;dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;file_fig  = 'W_'+string(time)+'.png'
;Write_PNG, dir_fig+file_fig, image_tvrd

Device,/close



end







