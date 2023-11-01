;pro calculate_component_sigma_cr





sub_dir_date  = 'wind\slow\20060430-0503\'


zf = 'b_n'

step1:

;read,'use wavlet(0) or delta(1):',select
;
;if select eq 0 then begin

dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location_do.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "locate_sheet.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
 ;CS_location2 , $
  ;  width_real , time_mid


read,'plot CS(0) or not CS(1) or track one CS(2)',select

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
CS_location2 = round(CS_location2)
reso = 3.0

n_CS = n_elements(width_real)
sub_te = round(width_real/(reso*2.0))




if select eq 0 then begin
  for j = 0,sizp(2)-1 do begin  ;j是尺度个数
  
  
    eb = fltarr(n_CS)
    ev = fltarr(n_CS)
    ezheng = fltarr(n_CS)
    efu = fltarr(n_CS)
    sigmac = fltarr(n_CS)
    sigmar = fltarr(n_CS)
    
    eb_sd = fltarr(n_CS)
    ev_sd = fltarr(n_CS)
    ezheng_sd = fltarr(n_CS)
    efu_sd = fltarr(n_CS)
    sigmac_sd = fltarr(n_CS)
    sigmar_sd = fltarr(n_CS)   
      
    for i = 0,n_CS-1 do begin
        eb(i) = mean(PSD_BBComp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        ev(i) = mean(PSD_VVComp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        ezheng(i) = mean(PSD_VB1Comp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        efu(i) = mean(PSD_VB2Comp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        eb_sd(i) = stddev(PSD_BBComp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        ev_sd(i) = stddev(PSD_VVComp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        ezheng_sd(i) = stddev(PSD_VB1Comp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        efu_sd(i) = stddev(PSD_VB2Comp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        sigmac(i) = (ezheng(i)-efu(i))/(ezheng(i)+efu(i))
        sigmar(i) = (ev(i)-eb(i))/(ev(i)+eb(i))
        sigmac_sd(i) = 2.*sqrt(efu(i)^2.0*ezheng_sd(i)^2.0+ezheng(i)^2.0*efu_sd(i)^2.0)/(ezheng(i)+efu(i))^2.0
        sigmar_sd(i) = 2.*sqrt(eb(i)^2.0*ev_sd(i)^2.0+ev(i)^2.0*eb_sd(i)^2.0)/(ev(i)+eb(i))^2.0  
    endfor
    
    
    sigmac_real =  sigmac(where(sigmac ne 0.0))
    sigmar_real =  sigmar(where(sigmar ne 0.0))
    
    
    
    
    
;    dir_save = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
;    file_save = 'sigmac_sigmar_noCS.sav'
;    data_descrip= 'got from "calculate_sigma_cr.pro"'
;    Save, FileName=dir_save+file_save, $
;      data_descrip, $
;      sigmac,sigmar,period_vect 
    
    
    ;step3:
    
    
    num_scale = n_elements(period_vect)
    
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
    
    ;position = [0.2,0.2,0.9,0.9]
    ;Plot, xrange, yrange, XRange=xrange, YRange=yrange,   $  ;range
    ;    xtitle='sigmac',ytitle='sigmar',color=color_black,charsize=1.0,charthick=1, $
    ;    /NoErase, /NoData
    ;
    ;
    ;plot,sigmac_real,sigmar_real,psym=1, $
    ;  /isotropic,color=color_black,/noerase
    ;ErrPlot, sigmac_real, sigmar_real-sigmar_sd, sigmar_real+sigmar_sd, $
    ;    Thick=1.5
    
    plot,sigmac_real,sigmar_real,psym=1, XRange=xrange, YRange=yrange,  $
      xtitle='sigmac',ytitle='sigmar',/isotropic,color=color_black,/noerase
;    ErrPlot, sigmac_real, sigmar_real-sigmar_sd, sigmar_real+sigmar_sd, color = color_blue, $
;        Thick=1.0
;    ErrPlot_y,  sigmac_real-sigmac_sd, sigmac_real+sigmac_sd, sigmar_real, color = color_blue, $
;        Thick=1.0      
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
    dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\yes\'
    file_version= '(v1)'
    file_fig  = Comp+'_'+string(period_vect(j))+'s'+'_scale_sigmac_sigmar'+'_yesCS'+zf+  $
            '.png'
    Write_PNG, dir_fig+file_fig, image_tvrd
    
  
  endfor
endif  


if select eq 1 then begin
  for j = 0,sizp(2)-1 do begin  ;j是尺度个数
  
  
    eb = fltarr(n_CS-1)
    ev = fltarr(n_CS-1)
    ezheng = fltarr(n_CS-1)
    efu = fltarr(n_CS-1)
    sigmac = fltarr(n_CS-1)
    sigmar = fltarr(n_CS-1)
    
    eb_sd = fltarr(n_CS-1)
    ev_sd = fltarr(n_CS-1)
    ezheng_sd = fltarr(n_CS-1)
    efu_sd = fltarr(n_CS-1)
    sigmac_sd = fltarr(n_CS-1)
    sigmar_sd = fltarr(n_CS-1)   
      
    for i = 0,n_CS-2 do begin
      if CS_location2(i)+sub_te(i) ge CS_location2(i+1)-sub_te(i+1) then begin
        
      endif
      if CS_location2(i)+sub_te(i) lt CS_location2(i+1)-sub_te(i+1) then begin
        eb(i) = mean(PSD_BBComp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        ev(i) = mean(PSD_VVComp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        ezheng(i) = mean(PSD_VB1Comp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        efu(i) = mean(PSD_VB2Comp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        eb_sd(i) = stddev(PSD_BBComp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        ev_sd(i) = stddev(PSD_VVComp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        ezheng_sd(i) = stddev(PSD_VB1Comp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        efu_sd(i) = stddev(PSD_VB2Comp_time_scale_arr((CS_location2(i)+sub_te(i)):(CS_location2(i+1)-sub_te(i+1)),j),/nan)
        sigmac(i) = (ezheng(i)-efu(i))/(ezheng(i)+efu(i))
        sigmar(i) = (ev(i)-eb(i))/(ev(i)+eb(i))
        sigmac_sd(i) = 2.*sqrt(efu(i)^2.0*ezheng_sd(i)^2.0+ezheng(i)^2.0*efu_sd(i)^2.0)/(ezheng(i)+efu(i))^2.0
        sigmar_sd(i) = 2.*sqrt(eb(i)^2.0*ev_sd(i)^2.0+ev(i)^2.0*eb_sd(i)^2.0)/(ev(i)+eb(i))^2.0  
      endif
    endfor
    
    
    sigmac_real =  sigmac(where(sigmac ne 0.0))
    sigmar_real =  sigmar(where(sigmar ne 0.0))
    
    
    
    
    num_scale = n_elements(period_vect)
    
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
    
    ;Plot, xrange, yrange, XRange=xrange, YRange=yrange, XStyle=1,YStyle=1,  $  ;range
    ;    xtitle='sigmac',ytitle='sigmar',color=color_black,charsize=1.5,charthick=2, $
    ;    /NoErase, /NoData
    ;
    ;
    ;plot,sigmac_real,sigmar_real,psym=1, $
    ;  /isotropic,color=color_black,/noerase
    ;ErrPlot, sigmac_real, sigmar_real-sigmar_sd, sigmar_real+sigmar_sd, $
    ;    Thick=1.5
    
    plot,sigmac_real,sigmar_real,psym=1, XRange=xrange, YRange=yrange,  $
      xtitle='sigmac',ytitle='sigmar',/isotropic,color=color_black,/noerase
;    ErrPlot, sigmac_real, sigmar_real-sigmar_sd, sigmar_real+sigmar_sd, color = color_blue, $
;        Thick=1.0
;    ErrPlot_y,  sigmac_real-sigmac_sd, sigmac_real+sigmac_sd, sigmar_real, color = color_blue, $
;        Thick=1.0     
      
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
    dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\no\'
    file_version= '(v1)'
    file_fig  = Comp+'_'+string(period_vect(j))+'s'+'_scale_sigmac_sigmar'+'_noCS'+zf+  $
            '.png'
    Write_PNG, dir_fig+file_fig, image_tvrd
    
  
  endfor

endif



if select eq 2 then begin
  for i = 0,n_CS-1 do begin  ;i是电流片个数  
    n_period = sizp(2)
    
    eb = fltarr(n_period)
    ev = fltarr(n_period)
    ezheng = fltarr(n_period)
    efu = fltarr(n_period)
    sigmac = fltarr(n_period)
    sigmar = fltarr(n_period)  
    for j = 0,n_period-1 do begin
        eb(j) = mean(PSD_BBComp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        ev(j) = mean(PSD_VVComp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        ezheng(j) = mean(PSD_VB1Comp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        efu(j) = mean(PSD_VB2Comp_time_scale_arr((CS_location2(i)-sub_te(i)):(CS_location2(i)+sub_te(i)),j),/nan)
        sigmac(j) = (ezheng(j)-efu(j))/(ezheng(j)+efu(j))
        sigmar(j) = (ev(j)-eb(j))/(ev(j)+eb(j))
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
    
    ;position = [0.2,0.2,0.9,0.9]
    ;Plot, xrange, yrange, XRange=xrange, YRange=yrange,   $  ;range
    ;    xtitle='sigmac',ytitle='sigmar',color=color_black,charsize=1.0,charthick=1, $
    ;    /NoErase, /NoData
    ;
    ;
    ;plot,sigmac_real,sigmar_real,psym=1, $
    ;  /isotropic,color=color_black,/noerase
    ;ErrPlot, sigmac_real, sigmar_real-sigmar_sd, sigmar_real+sigmar_sd, $
    ;    Thick=1.5
    
    plot,sigmac,sigmar, XRange=xrange, YRange=yrange,  $
      xtitle='sigmac',ytitle='sigmar',/isotropic,color=color_black,/noerase
;    ErrPlot, sigmac_real, sigmar_real-sigmar_sd, sigmar_real+sigmar_sd, color = color_blue, $
;        Thick=1.0
;    ErrPlot_y,  sigmac_real-sigmac_sd, sigmac_real+sigmac_sd, sigmar_real, color = color_blue, $
;        Thick=1.0      
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
    dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date+'zf\yes\track\'
    file_version= '(v1)'
    file_fig  = Comp+'_'+string(i+1)+'_sigmac_sigmar'+'_yesCS'+zf+  $
            '.png'
    Write_PNG, dir_fig+file_fig, image_tvrd
      
  endfor
endif  
  
  
endfor

END_program:
end








