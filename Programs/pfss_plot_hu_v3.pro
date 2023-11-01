;Write by Zhongmin Hu at Nov 2013

pro pfss_plot_hu_v3
pfss_hour0=[0.,6.,12.,18.,24.]*3600.+4.*60
pfss_hour=[3.,9.,15.,21.]*3600.+4.*60
;pfss_hour=[0.,6.,9.,18.]*3600.+4.*60
outsize=1024
outim=dblarr(1024,1024)
pfss_path='C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\' ; Path for Magnetograph hdf file 
path1='C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\' ;output file path
if file_test(path1,/directory) eq 0 then file_mkdir,path1


     file_pfss='Bfield_'+'20020521_000400'+'.sav' ;filename of Magnetograph hdf file 
 
  if file_test(pfss_path+file_pfss) eq 1 then begin

     t_use = '18:00 21-05-2002'
     out=get_sun(t_use)
     bcent=out[11] ;  central latitude of projection in degrees
     lcent=out[10] ;  central Carrington longitude of projection in degrees
     bbox=[lcent-10.,bcent-10.,lcent+10,bcent+10.] ;bbox = [lon1,lat1,lon2,lat2] defining bounding box in degrees
;                                                         outside of which no field line starting point can lie
 
  ;-----------PFSS PROCESS BEGIN---------
  
  ; read pfss_sample1.pro
  
     @pfss_data_block
     print,pfss_path+file_pfss
     pfss_restore,pfss_path+file_pfss
     invdens = 5 ;  factor inverse to line density, i.e. lower values = more lines
    
     pfss_field_start_coord,5,invdens,radstart=2.5,bbox=bbox  ;  starting points to be on a regular grid covering the full disk, with a starting radius of r=2.5 Rsun  
     pfss_trace_field
     width=1.05;1.05 
     mag  =2    ; mag=1 means solar_r=96 
     imsc =100;200 
     pfss_draw_field,outim=outim,bcent=bcent,lcent=lcent,width=width,mag=mag,imsc=imsc;,/noimage
      loadct,0  ;  loadct,3 also looks nice too：0
      tvlct,re,gr,bl,/get
      re(250:255)=[0b,0b,255b,255b,255b,255b]
      gr(250:255)=[255b,255b,0b,0b,255b,255b]
      bl(250:255)=[0b,0b,255b,255b,255b,255b]
      tvlct,re,gr,bl
;    popen,path1+time_string(t_list,format=2)+'_lat15',/encap
nax=size(outim,/dim)

read,'png(1) eps(2)',is_pe

if is_pe eq 1 then begin
set_plot,'win'
Device,DeComposed=0;, /Retain
window,0,xsiz=nax(0),ysiz=nax(1)
endif
if is_pe eq 2 then begin
Set_Plot,'PS'
file_fig= 'Figure0_'+$
        'pfss'+$
        '.eps'
xsize = 24.0
ysize = 24.0
Device, FileName=pfss_path+file_fig, XSize=xsize,YSize=ysize,/Color,Bits=8,/Encapsul
endif


Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData
;xyouts,0.02,0.85,'(a)',charsize=2,charthick = 2;,color = 0
     tvimage,outim,position = [0.2,0.15,0.95,0.9]

       
  ;------------END PFSS PROCESS---------- 
  
  
  endif


if is_pe eq 1 then begin  
file_fig= '200205230004_'+$
        'v1'+$
;        file_version+$
        '.png'
FileName=path1+file_fig
image_tvrd  = TVRD(true=1)
Write_PNG, FileName, image_tvrd; tvrd(/true), r,g,b
endif
if is_pe eq 2 then begin
device,/close
endif
;endwhile
;stop
end
