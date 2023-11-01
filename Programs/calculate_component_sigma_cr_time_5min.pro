;pro calculate_component_sigma_cr_time_5min



sub_dir_date  = 'wind\slow\19950222-25\'


zf = 'b_n'

step1:

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\'
file_restore= 'Bx'+'_wavlet_arr(time=*-*)'+zf+'.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "get_WaveletTransform_from_BComp_vect_200802.pro"'
;Save, FileName=dir_save+file_save, $
; data_descrip, $
; JulDay_min_v2, time_vect_v2, period_vect, $
; BComp_wavlet_arr


i_BComp = 0

for i_Bcomp = 1,3 do begin
;Read, 'i_BComp(1/2/3 for Bx/By/Bz): ', i_BComp
If i_BComp eq 1 Then begin
  Comp='X'
  BComp='Bx'
  VComp='Vx'
  VB1Comp='Vx+Bx'
  VB2Comp='Vx-Bx'
endif
If i_BComp eq 2 Then begin
  Comp='Y'
  BComp='By'
  VComp='Vy'
  VB1Comp='Vy+By'
  VB2Comp='Vy-By'
endif
If i_Bcomp eq 3 Then begin
  Comp='Z'
  BComp='Bz'
  VComp='Vz'
  VB1Comp='Vz+Bz'
  VB2Comp='Vz-Bz'
endif
  
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\'
file_restore = 'PSD_'+BComp+'_time_scale_arr(time=*-*)'+zf+'.sav'  
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
;  PSD_BComp_time_scale_arr

PSD_BBComp_time_scale_arr =   PSD_BComp_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\'
file_restore = 'PSD_'+VComp+'_time_scale_arr(time=*-*)'+zf+'.sav'  
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
;  PSD_BComp_time_scale_arr
PSD_VVComp_time_scale_arr =   PSD_BComp_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\'
file_restore = 'PSD_'+VB1Comp+'_time_scale_arr(time=*-*)'+zf+'.sav'  
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
;  PSD_BComp_time_scale_arr
PSD_VB1Comp_time_scale_arr =   PSD_BComp_time_scale_arr

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\'
file_restore = 'PSD_'+VB2Comp+'_time_scale_arr(time=*-*)'+zf+'.sav'  
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
;  PSD_BComp_time_scale_arr 

PSD_VB2Comp_time_scale_arr =   PSD_BComp_time_scale_arr


step2:

sizp = size(PSD_VB2Comp_time_scale_arr)
sigmac_arr = fltarr(sizp(1),sizp(2))
sigmar_arr = fltarr(sizp(1),sizp(2))

for j = 0,sizp(2)-1 do begin  
for i = 0,sizp(1)-1 do begin
  sigmac_arr(i,j) = (PSD_VB1Comp_time_scale_arr(i,j)-PSD_VB2Comp_time_scale_arr(i,j))/(PSD_VB1Comp_time_scale_arr(i,j)+PSD_VB2Comp_time_scale_arr(i,j))
  sigmar_arr(i,j) = (PSD_VVComp_time_scale_arr(i,j)-PSD_BBComp_time_scale_arr(i,j))/(PSD_VVComp_time_scale_arr(i,j)+PSD_BBComp_time_scale_arr(i,j))
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
       eb(i) = mean(PSD_BBComp_time_scale_arr(100L*i:(100L*(i+1)-1),j),/nan)
       ev(i) = mean(PSD_VVComp_time_scale_arr(100*i:(100L*(i+1)-1),j),/nan)
       ezheng(i) = mean(PSD_VB1Comp_time_scale_arr(100*i:(100L*(i+1)-1),j),/nan)
       efu(i) = mean(PSD_VB2Comp_time_scale_arr(100*i:(100L*(i+1)-1),j),/nan)
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
    dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\5min\'
    file_version= '(v1)'
    file_fig  = Comp+'_'+string(period_vect(j))+'s'+'_scale_sigmac_sigmar'+zf+  $
            '.png'
    Write_PNG, dir_fig+file_fig, image_tvrd



endfor



endfor



end



