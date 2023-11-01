;Pro fit_FFT_PSD
Date = '19950130-0203'
sub_dir_date  = 'wind\'+Date+'\'


device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


step3:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date 
file_restore = 'Bx'+'_FFT_arr'+$
        '(time=)'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  freq_vect_FFT, PSD_vect_FFT
Bx_PSD_FFT_arr = PSD_vect_FFT
  
  
file_restore = 'By'+'_FFT_arr'+$
        '(time=)'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
; freq_vect_FFT, PSD_vect_FFT
By_PSD_FFT_arr = PSD_vect_FFT



file_restore = 'Bz'+'_FFT_arr'+$
        '(time=)'+$
        '.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  freq_vect_FFT, PSD_vect_FFT
Bz_PSD_FFT_arr = PSD_vect_FFT    

i_BComp = 0
Read, 'i_BComp(1/2/3/4 for Bx/By/Bz/Btotal): ', i_BComp
If i_BComp eq 1 Then begin
FileName_BComp='Bx'
PSD_total_vect_FFT = Bx_PSD_FFT_arr
endif
If i_BComp eq 2 Then begin
FileName_BComp='By'
PSD_total_vect_FFT = By_PSD_FFT_arr
endif
If i_Bcomp eq 3 Then begin
FileName_BComp='Bz'
PSD_total_vect_FFT = Bz_PSD_FFT_arr
endif
If i_Bcomp eq 4 Then begin
FileName_BComp='Btotal'
PSD_total_vect_FFT = Bx_PSD_FFT_arr + By_PSD_FFT_arr + Bz_PSD_FFT_arr
endif


step4:    
    
xrange=[0.00001,0.1]
yrange=[1.0e-4,1.0e4]    
window,1,title='PSD-frequency'    
Plot,freq_vect_FFT, PSD_total_vect_FFT,xtitle='frequency(Hz)',ytitle='PSD(nT^2/HZ)',xrange=xrange,yrange=yrange,xticklen = -0.02,/XLOG,/YLOG    

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = FileName_BComp+'_PSD_FFT'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd
    
 ;sm_PSD_vect_FFT = smooth(PSD_total_vect_FFT,11)
 sm_PSD_vect_FFT = lsmth(PSD_total_vect_FFT,0.1)
 
 window,2,title='PSD-frequency after smooth(11 ponits)'
 Plot,freq_vect_FFT, sm_PSD_vect_FFT,xtitle='frequency(Hz)',ytitle='PSD(nT^2/Hz)',xrange=xrange,yrange=yrange,/XLOG,/YLOG  

; x=[0.00002,0.00002]
; y=[1.0e-2,0.0631]
; plot,  x,y,/XLOG,/YLOG ,/noerase,xrange=xrange,yrange=yrange
 
m=0
n=0
while  freq_vect_FFT(n) le 0.0007 do begin
  n=n+1
endwhile
while  freq_vect_FFT(m) le 0.1 do begin
  m=m+1
endwhile
result = linfit(alog10(freq_vect_FFT(n:(m-1))),alog10(sm_PSD_vect_FFT(n:(m-1))))
print,result 
x=freq_vect_FFT(n:(m-1))
y=10.^(result(0)+result(1)*alog10(x))
;window,2
plot,x,y,xrange=xrange,yrange=yrange,color='0000ff'XL,xstyle=4,ystyle=4,/XLOG,/YLOG,/noerase

xyouts,200,200,'k='+string(result(1)),charsize=1.2,charthick=2,/DEvice 
xyouts,200,100,'Date:'+date,charsize=1.2,charthick=2,/DEvice
 
 
image_tvrd = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_version= '(v1)'
file_fig  = FileName_BComp+'_PSD_FFT_smooth'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd



;分两段拟合  
; n=0
; m=0
; ;m = size(freq_vect_FFT,/dimensions)
; while  freq_vect_FFT(n) le 0.0031623 do begin
;  n=n+1
; endwhile
;while  freq_vect_FFT(m) le 0.1 do begin
;  m=m+1
;endwhile
;
;  
;result1 = linfit(alog10(freq_vect_FFT(1:(n-1))),alog10(PSD_total_vect_FFT(1:(n-1))),prob = prob1 ,sigma = sigma1) 
;result1s = linfit(alog10(freq_vect_FFT(1:(n-1))),alog10(sm_PSD_vect_FFT(1:(n-1))),prob = prob1s ,sigma = sigma1s)
;result2 = linfit(alog10(freq_vect_FFT(n:(m-1))),alog10(PSD_total_vect_FFT(n:(m-1))),prob = prob2 ,sigma = sigma2)
;result2s = linfit(alog10(freq_vect_FFT(n:(m-1))),alog10(sm_PSD_vect_FFT(n:(m-1))),prob = prob2s ,sigma = sigma2s)
;
;print,result1,result1s,result2,result2s

END_program:
END