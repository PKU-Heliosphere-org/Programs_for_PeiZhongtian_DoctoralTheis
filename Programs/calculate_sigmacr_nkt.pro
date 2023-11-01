;pro calculate_sigmaCR_nkT



date='19950906'
sub_dir_date  = 'wind\another\199509\fast\'


Step1:
;===========================
;Step1:



dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Pressure'+'_time_scale_arr(time=*-*)'+'.sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Bcomp_time_scale_arr , period_vect 

PSD_pressure_time_scale_arr = PSD_Bcomp_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'MagPressure'+'_time_scale_arr(time=*-*)'+'.sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Bcomp_time_scale_arr , period_vect 

PSD_magpressure_time_scale_arr = PSD_Bcomp_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Pre+Mag'+'_time_scale_arr(time=*-*)'+'.sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Bcomp_time_scale_arr , period_vect 

PSD_premag1_time_scale_arr = PSD_Bcomp_time_scale_arr


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore = 'PSD_'+'Pre-Mag'+'_time_scale_arr(time=*-*)'+'.sav'  
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_PSD_of_BComp_theta_scale_arr_200802.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  PSD_Bcomp_time_scale_arr , period_vect 

PSD_premag2_time_scale_arr = PSD_Bcomp_time_scale_arr

step2:


sizp = size(PSD_premag2_time_scale_arr)
sigmac_arr = fltarr(sizp(1),sizp(2))
sigmar_arr = fltarr(sizp(1),sizp(2))

for j = 0,sizp(2)-1 do begin  
for i = 0,sizp(1)-1 do begin
  sigmac_arr(i,j) = (PSD_premag1_time_scale_arr(i,j)-PSD_premag2_time_scale_arr(i,j))/(PSD_premag1_time_scale_arr(i,j)+PSD_premag2_time_scale_arr(i,j))
  sigmar_arr(i,j) = (PSD_pressure_time_scale_arr(i,j)-PSD_magpressure_time_scale_arr(i,j))/(PSD_pressure_time_scale_arr(i,j)+PSD_magpressure_time_scale_arr(i,j))
endfor
endfor


per_point = 5.*60./3.

n_point = round(sizp(1)/per_point)


for j = 0,sizp(2)-1 do begin  ;每个尺度画一个图
    eb = fltarr(n_point)
    ev = fltarr(n_point)
    ezheng = fltarr(n_point)
    efu = fltarr(n_point)
    sigmac = fltarr(n_point)
    sigmar = fltarr(n_point)
    
    
    for i = 0L,n_point-1 do begin
       eb(i) = mean(PSD_pressure_time_scale_arr(100L*i:(100L*(i+1)-1),j),/nan)
       ev(i) = mean(PSD_magpressure_time_scale_arr(100*i:(100L*(i+1)-1),j),/nan)
       ezheng(i) = mean(PSD_premag1_time_scale_arr(100*i:(100L*(i+1)-1),j),/nan)
       efu(i) = mean(PSD_premag2_time_scale_arr(100*i:(100L*(i+1)-1),j),/nan)
       sigmac(i) = (ezheng(i)-efu(i))/(ezheng(i)+efu(i))
       sigmar(i) = (ev(i)-eb(i))/(ev(i)+eb(i))
    endfor


    Set_Plot, 'win'
    Device,DeComposed=0;, /Retain
    xsize=500.0 & ysize=500.0
    Window,2,XSize=xsize,YSize=ysize,Retain=2
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
    
    
    xrange=[-1.0,1.0]
    yrange=[-1.0,1.0]
    

    
    plot,sigmac,sigmar,psym=1, XRange=xrange, YRange=yrange,  $
      xtitle='sigmac',ytitle='sigmar',/isotropic,color=color_black,/noerase
   
      
    y=(findgen(101))/50.-1.0
    x=sqrt(1-y^2.0)
    plot,x,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase
     
    x1=0.8*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase
    x1=0.6*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase
    x1=0.4*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase
    x1=0.2*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase
    x1=0.*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase
    x1=-0.2*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase    
    x1=-0.4*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase    
    x1=-0.6*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase    
    x1=-0.8*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase    
    x1=-1.0*x
    plot,x1,y,xstyle=4, ystyle=4,linestyle=2,xrange=[-1.0,1.0],yrange=[-1.0,1.0],/isotropic,/noerase    
    
    xyouts,0.0,-0.7,'0',charsize=0.85,charthick=1.5
    xyouts,0.1,-0.7,'0.2',charsize=0.85,charthick=1.5
    xyouts,0.28,-0.7,'0.4',charsize=0.85,charthick=1.5
    xyouts,0.4,-0.7,'0.6',charsize=0.85,charthick=1.5
    xyouts,0.55,-0.7,'0.8',charsize=0.85,charthick=1.5
    xyouts,-0.2,-0.7,'-0.2',charsize=0.85,charthick=1.5
    xyouts,-0.38,-0.7,'-0.4',charsize=0.85,charthick=1.5    
    xyouts,-0.65,-0.7,'-0.8',charsize=0.85,charthick=1.5    
    xyouts,0.7,-0.7,'1.0',charsize=0.85,charthick=1.5    
    xyouts,-0.5,-0.7,'-0.6',charsize=0.85,charthick=1.5
    xyouts,-0.8,-0.7,'-1.0',charsize=0.85,charthick=1.5  
    
    image_tvrd  = TVRD(true=1)
    dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'5min\'
    file_version= '(v1)'
    file_fig  = 'pressure'+'_'+string(period_vect(j))+'s'+'_scale_sigmac_sigmar'+  $
            '.png'
    Write_PNG, dir_fig+file_fig, image_tvrd



endfor






end
