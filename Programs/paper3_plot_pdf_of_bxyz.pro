;pro paper3_plot_PDF_of_Bxyz

sub_dir_date  = 'wind\slow\case2_v\'


num_theta_bins  = 90L
num_periods = 32
ss = 31

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore=   'deltaBxyz_of_'+'quan'+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_LocalBG_of_MagField_at_Scales_19760307_v2.pro"'
;Save, FileName=dir_save+file_save, $
;  period_vect,diff_Bx_arr,diff_By_arr,diff_Bz_arr
;  

  Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=600.0 & ysize=600.0
    Window,1,XSize=xsize,YSize=ysize,Retain=2
;;--
    LoadCT,13
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
    
    ;;--
    color_bg    = color_white
    !p.background = color_bg
    Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData  ;change the background 


;;画Bx的PDF
Bx_tex = diff_Bx_arr(*,ss);10000s尺度
n_time = n_elements(Bx_tex)
Bx_max = max(Bx_tex,/nan)
Bx_min = min(Bx_tex,/nan)
n_cell = 100.0
min_vect = Bx_min+findgen(n_cell)*(Bx_max-Bx_min)/n_cell
max_vect = Bx_min+(findgen(n_cell)+1)*(Bx_max-Bx_min)/n_cell
n_PDF = fltarr(n_cell)
for i_cell = 0,n_cell-1 do begin
;  for i_t = 0,n_time-1 do begin
 ;   if Bx_tex(i_t) ge min_vect(i_cell) and Bx_tex(i_t) lt max_vect(i_cell) then begin
      n_PDF(i_cell) = n_elements(where(Bx_tex ge min_vect(i_cell) and Bx_tex lt max_vect(i_cell)))
;    endif
;  endfor
endfor  

p_PDF = n_PDF/n_time
miu = mean(Bx_tex,/nan)
;Ga_PDF = exp(-((min_vect+max_vect)/2.-miu)^2/2./std^2)/(sqrt(2*!pi)*std)


;plot,(min_vect+max_vect)/2.,p_PDF,yrange=[0.00001,1.0],xtitle='Bx(nT)',ytitle='PDF',color=color_black,/ylog
;oplot,(min_vect+max_vect)/2.,Ga_PDF,color=color_red

;;;;;;;;;;;;;;;;;;;
dpart = max_vect(0)-min_vect(0)
B_plot = (min_vect+max_vect)/2.0
Bstd = stddev(Bx_tex,/nan)
B_plot = B_plot/Bstd      ;;;;横坐标
;;;--
;for e=0,39 do begin
;  if count(e) eq 0 then begin
;    count(e)=1
;  endif
;endfor
;;;--


p_pdf = p_pdf*Bstd/dpart          ;纵坐标
plot,B_plot,p_pdf,xtitle='Bx(nT)'+'/'+textoIDL('\sigma'),ytitle='PDF',$
psym=-1,color = color_black,charsize=1.5,charthick=1.5,thick=1.5,xrange=[-5.0,5.0],yrange=[10^(-5.0),1.0],/ylog
;xyouts,-13.0,0.3,biao,charsize=0.8,charthick=1.5


;result = gaussfit(db_plot,alog10(y_plot))
result = gaussfit(B_plot,p_pdf,para,nterms=3)
result = para(0)*exp(-((B_plot-para(1))/(1.*para(2)))^2/2.);+para(3)
print,para
oplot,B_plot,result,color=color_red,psym=-1,thick=1.5;,xrange=[-8,8],yrange=[-5,0],/noerase
;;;;;;;;;;;;;;;;;;;


image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'PDF_'+string(period_vect(ss))+'s'+'_Bx'+'.png'
Write_PNG, dir_fig+file_fig, image_tvrd



end


