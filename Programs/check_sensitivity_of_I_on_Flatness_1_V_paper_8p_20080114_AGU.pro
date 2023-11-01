Pro check_sensitivity_of_I_on_Flatness_1_V_paper_8p_20080114_AGU

Prepare_WIND_BV_Wavelet_FFT,var,var_BG,dir_restore,dir_save,dir_fig,$
  num_scales,file_version,n_hours,n_days,num_times,is_theta_1_or_2,$
  JulDay_vect,B_RTN_3s_arr,$
  time_vect,dtime,period_range,TimeRange_str,$
  sub_dir_date, NUMDENS_VECT

suffix = ''
save_fig = 'N'
ii_period = 4;4;
small_period = 4
large_period = 6
FileName_BComp_wav = var+'x'
theta_filename = 'thetaRB'

file_restore = 'Flatness_PVI_'+FileName_BComp_wav+'_avg'+$
      file_version+suffix+'.sav'
restore,dir_restore+file_restore
;data_descrip= 'got from "Plot_avg_I_scles_combine.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  period_vect_plot,thres_F3_avg,thres_F3_std

file_restore = var+'_PSD_arr'+TimeRange_str+file_version+'_nan_gt1.sav'
restore,dir_restore+file_restore
;data_descrip= 'got from "get_WaveletTransform_from_BComp_wx.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  time_vect, period_vect, $
;  PSD_Bx_time_scale_arr, PSD_By_time_scale_arr, PSD_Bz_time_scale_arr, $
;  PSD_Bt_time_scale_arr, PSD_Bpara_time_scale_arr, PSD_Bperp_time_scale_arr, I
print,period_vect(ii_period)
I_trace = I(*,ii_period)
n_thres = 30.
thres = (findgen(n_thres)+1.)*0.1
;goto,end_program

file_restore = FileName_BComp_wav+'_wavlet_arr'+TimeRange_str+file_version+'.sav'
restore,dir_save+file_restore
;goto,step2
Flat = fltarr(n_thres)+!values.F_nan
for i_thres=0,n_thres-1 do begin
  BComp_wavlet_vect = BComp_wavlet_arr(*,ii_period)
  sub_int = where(I_trace gt thres(i_thres))
  BComp_wavlet_vect(sub_int) = !values.F_nan
  I_up = real_part(BComp_wavlet_vect)
  Flat(i_thres) = mean(I_up^4.,/nan)/(mean(I_up^2.,/nan))^2.
endfor

step2:
Set_Plot, 'ps'
LoadCT,13
TVLCT,R,G,B,/Get
color_red = 251L
TVLCT,255L,0L,0L,color_red
color_green = 254L
TVLCT,0L,255L,0L,color_green
color_blue  = 253L
TVLCT,0L,0L,255L,color_blue
color_white = 252L
TVLCT,255L,255L,255L,color_white
color_black = 255L
TVLCT,0L,0L,0L,color_black
num_CB_color= 256-5
R=Congrid(R,num_CB_color)
G=Congrid(G,num_CB_color)
B=Congrid(B,num_CB_color)
TVLCT,R,G,B
color_bg    = color_white
fig_name  = 'GaussPDF_and_PSD_at_diffI_'+var+$
        TimeRange_str+file_version+suffix+$
        '_1_AGU_1.eps'
file_fig    = dir_fig+fig_name
Device,FileName=file_fig,XSize=30,YSize=28,/Color,Bits=10,/Encapsul
Device,DeComposed=0
!p.background = color_bg
position0 = [0.10,0.08,0.33,0.32]
xshift = [0.32,0,0.32,0]
yshift = [0,0.32,0,0.32]

plot,period_vect_plot,thres_F3_avg,psym=-2,/xlog,charsize=1.5,charthick=3.5,$
  xtitle='Time scale '+TextoIDL('\tau')+' (s)',ytitle='I!DGauss!N',yr=[0,2],ys=1,xr=[1,1.e4],xs=1,thick=3,$
  xthick=3.5,ythick=3.5,xticklen=0.05,yticklen=0.03,position=[0.59,0.752,0.97,0.992]
errplot,period_vect_plot,thres_F3_avg-thres_F3_std,thres_F3_avg+thres_F3_std,thick=3
xyouts,2,1.6,'(b)',charsize=1.6,charthick=5
oplot,[40.,40.],[0,2],linestyle=2,thick=4
oplot,[400,400],[0,2],linestyle=2,thick=4
oplot,[1,10000],[0.56,0.56],linestyle=2,thick=4

sub_thres = where(thres ge 0.4)
plot,thres(sub_thres),Flat(sub_thres),xtitle='I!Dthres!N',ytitle='Flatness of Re('+TextoIDL('\omega')+'!D'+$
  FileName_BComp_wav+'!N)',psym=-2,charsize=1.5,charthick=3.5,thick=3,$
  xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.03,position=[0.1,0.752,0.48,0.992],/noerase;position0+1.5*xshift+2.1*yshift
oplot,[0,max(thres)],[3,3],linestyle=2,thick=4
;xyouts,1.5,7,TextoIDL('\tau')+'='+string(period_vect(ii_period),format='(I3)')+'s',charsize=2,charthick=3.5
oplot,[0.56,0.56],[0,Flat(where(thres eq 0.3))],linestyle=2,thick=4
oplot,[1.5,1.5],[0,Flat(where(thres eq 1.5))],linestyle=2,thick=4
xyouts,0.25,6.5,'(a)',charsize=1.6,charthick=5
xyouts,1.6,1,'Stream !U#!N3',charsize=1.8,charthick=5

min = -5.
max = 5.
nbins = 100.
xx = (max-min)/nbins*findgen(nbins)+min
;!p.multi = [0,4,2,0,1]

thres_plot = 0.56
BComp_wavlet_vect = BComp_wavlet_arr(*,ii_period)
sub_int = where(I_trace gt thres_plot)
if sub_int(0) ne -1 then BComp_wavlet_vect(sub_int) = !values.F_nan
I_up = real_part(BComp_wavlet_vect)
I_dn = stddev(I_up,/nan)
I_plot = I_up/I_dn
Flat = mean(I_up^4.,/nan)/(mean(I_up^2.,/nan))^2.
yy = histogram(I_plot,min=min,max=max,nbins=nbins,/nan)
yy = yy/float(n_elements(where(finite(I_plot))))/((max-min)/nbins)
plot,xx,yy,color=color_black,xs=1,charsize=1.5,thick=5,/nodata,$
  charthick=3.5,ytitle='PDF',xtitle='Re(w_'+FileName_BComp_wav+')/'+TextoIDL('\sigma'),title=FileName_BComp_wav+$
  '('+'I<'+string(thres_plot,format='(f4.2)')+')',/ylog,yr=[1.e-4,1.],ys=1,xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.05,$
  ytickname='10!u'+string(indgen(5)-4,format='(I0)')+'!n',ycharsize=1.2,position=position0+yshift,/noerase
oplot,xx,yy,color=color_red,thick=5
;xyouts,-2.6,1.e-3,'F='+string(Flat,format='(f4.2)'),$
;  charsize=1.5,charthick=3.5,color=color_red
;xyouts,-2.6,4.e-4,TextoIDL('\sigma')+'='+string(I_dn,format='(f4.2)')+'km/s',$
;  charsize=1.5,charthick=3.5,color=color_red
yy_gauss = gaussfit(xx,yy,nterms=3)
oplot,xx,yy_gauss,color=color_blue,thick=4,linestyle=2
xyouts,-4.5,0.23,'(c)',charsize=1.6,charthick=5
;---
FileName_BComp=var+'t'
suffix = '_nan_gt.56'
file_restore = 'PSD_'+FileName_BComp+'_'+theta_filename+'_period_arr'+$
        TimeRange_str+file_version+suffix+'.sav' ; ;thetaVB ;_nan_gt1 ;'+theta_filename+'
restore,dir_restore+file_restore
;restore,dir_restore+'3dp\PSD_Vvect_thetaRB_period_arr(time=20080114-20080120).sav'
;data_descrip= 'got from "get_PSD_of_BVComp_theta_scale_wx.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  theta_bin_min_vect, theta_bin_max_vect, $
;  period_vect, $
;  theta_RB_arr, theta_VB_arr, $
;  PSD_BComp_theta_scale_arr, PSD_BComp_theta_scale_noavg_arr, LgStd_BComp_theta_scale_arr, PSD_BComp_theta_scale_arr_lm, $
;  num_theta_scale_arr, is_theta_1_or_2
theta_bin_cen_vect_plot = 0.5*(theta_bin_min_vect+theta_bin_max_vect)
sub_theta = where(theta_bin_cen_vect_plot ge 0 and theta_bin_cen_vect_plot le 90)
PlotSym, 0, 1.0, FILL=1,thick=3,color=color_red
plot,theta_bin_cen_vect_plot(sub_theta),PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)$
  /max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),/nodata,$
  xr=[0,90],xs=1,charsize=1.5,thick=2,charthick=3.5,ytitle='Relative PSD of '+var+'_Trace',xtitle=TextoIDL('\theta_{RB}')+' (!Uo!N)',$
  yr=[0.2,1.2],ys=1,psym=-8,position=position0,/noerase,xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.05
oplot,theta_bin_cen_vect_plot(sub_theta),PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)$
  /max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),psym=-8
oplot,[0,90],[1,1],linestyle=2,thick=4
PlotSym, 0, 1.0, FILL=0,thick=3,color=color_red
xyouts,5,1.05,'(f)',charsize=1.6,charthick=5
;xyouts,20,1.02,string(max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),format='(f6.1)')+'(km/s)!U2!N/Hz',$
;  charsize=1.5,charthick=3.5,color=color_red
;================================

thres_plot = 1.5
BComp_wavlet_vect = BComp_wavlet_arr(*,ii_period)
sub_int = where(I_trace gt thres_plot)
if sub_int(0) ne -1 then BComp_wavlet_vect(sub_int) = !values.F_nan
I_up = real_part(BComp_wavlet_vect)
I_dn = stddev(I_up,/nan)
I_plot = I_up/I_dn
Flat = mean(I_up^4.,/nan)/(mean(I_up^2.,/nan))^2.
yy = histogram(I_plot,min=min,max=max,nbins=nbins,/nan)
yy = yy/float(n_elements(where(finite(I_plot))))/((max-min)/nbins)
plot,xx,yy,color=color_black,xs=1,charsize=1.5,thick=5,$
  charthick=3.5,ytitle='',xtitle='Re(w_'+FileName_BComp_wav+')/'+TextoIDL('\sigma'),title=FileName_BComp_wav+$
  '('+'I<'+string(thres_plot,format='(f4.2)')+')',/ylog,yr=[1.e-4,1.],ys=1,xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.05,$
  ytickname='10!u'+string(indgen(5)-4,format='(I0)')+'!n',ycharsize=1.2,position=position0+xshift+yshift,/noerase
xyouts,-2.6,1.e-3,'F='+string(Flat,format='(f4.2)'),$
  charsize=1.5,charthick=3.5,color=color_black
xyouts,-2.6,4.e-4,TextoIDL('\sigma')+'='+string(I_dn,format='(f4.2)')+'km/s',$
  charsize=1.5,charthick=3.5,color=color_black
yy_gauss = gaussfit(xx,yy,nterms=3)
oplot,xx,yy_gauss,color=color_red,thick=4,linestyle=2
xyouts,-4.5,0.23,'(d)',charsize=1.6,charthick=5
;---
FileName_BComp=var+'t'
suffix = '_nan_gt1.5'
file_restore = 'PSD_'+FileName_BComp+'_'+theta_filename+'_period_arr'+$
        TimeRange_str+file_version+suffix+'.sav' ; ;thetaVB ;_nan_gt1 ;'+theta_filename+'
restore,dir_restore+file_restore
sub_theta = where(theta_bin_cen_vect_plot ge 0 and theta_bin_cen_vect_plot le 90)
PlotSym, 0, 1.0, FILL=1,thick=3
plot,theta_bin_cen_vect_plot(sub_theta),PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)$
  /max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),$
  xr=[0,90],xs=1,charsize=1.5,thick=2,charthick=3.5,ytitle='',xtitle=TextoIDL('\theta_{RB}')+' (!Uo!N)',$
;  /ylog,yr=[0.2,2.],ys=1,psym=-2,$
  yr=[0.2,1.2],ys=1,psym=-8,position=position0+xshift,/noerase,xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.05
oplot,[0,90],[1,1],linestyle=2,thick=4
PlotSym, 0, 1.0, FILL=0,thick=3
xyouts,5,1.05,'(g)',charsize=1.6,charthick=5
xyouts,20,1.02,string(max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),format='(f6.1)')+'(km/s)!U2!N/Hz',charsize=1.5,charthick=3.5
;================================

thres_plot = 1000.
BComp_wavlet_vect = BComp_wavlet_arr(*,ii_period)
sub_int = where(I_trace gt thres_plot)
if sub_int(0) ne -1 then BComp_wavlet_vect(sub_int) = !values.F_nan
I_up = real_part(BComp_wavlet_vect)
I_dn = stddev(I_up,/nan)
I_plot = I_up/I_dn
Flat = mean(I_up^4.,/nan)/(mean(I_up^2.,/nan))^2.
yy = histogram(I_plot,min=min,max=max,nbins=nbins,/nan)
yy = yy/float(n_elements(where(finite(I_plot))))/((max-min)/nbins)
plot,xx,yy,color=color_black,xs=1,charsize=1.5,thick=5,$
  charthick=3.5,ytitle='',xtitle='Re(w_'+FileName_BComp_wav+')/'+TextoIDL('\sigma'),title=FileName_BComp_wav+$
  '(Original)',/ylog,yr=[1.e-4,1.],ys=1,xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.05,$
  ytickname='10!u'+string(indgen(5)-4,format='(I0)')+'!n',ycharsize=1.2,position=position0+2.*xshift+yshift,/noerase
xyouts,-2.6,1.e-3,'F='+string(Flat,format='(f4.2)'),$
  charsize=1.5,charthick=3.5,color=color_black
xyouts,-2.6,4.e-4,TextoIDL('\sigma')+'='+string(I_dn,format='(f4.2)')+'km/s',$
  charsize=1.5,charthick=3.5,color=color_black
yy_gauss = gaussfit(xx,yy,nterms=3)
oplot,xx,yy_gauss,color=color_blue,thick=4,linestyle=2
xyouts,-4.5,0.23,'(e)',charsize=1.6,charthick=5
;---
FileName_BComp=var+'t'
suffix = ''
file_restore = 'PSD_'+FileName_BComp+'_'+theta_filename+'_period_arr'+$
        TimeRange_str+file_version+suffix+'.sav' ; ;thetaVB ;_nan_gt1 ;'+theta_filename+'
restore,dir_restore+file_restore
sub_theta = where(theta_bin_cen_vect_plot ge 0 and theta_bin_cen_vect_plot le 90)
PlotSym, 0, 1.0, FILL=1,thick=3
plot,theta_bin_cen_vect_plot(sub_theta),PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)$
  /max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),$
  xr=[0,90],xs=1,charsize=1.5,thick=2,charthick=3.5,ytitle='',xtitle=TextoIDL('\theta_{RB}')+' (!Uo!N)',$
  yr=[0.2,1.2],ys=1,psym=-8,position=position0+2.*xshift,/noerase,xthick=3.5,ythick=3.5,xticklen=0.03,yticklen=0.05

print,position0+2.*xshift
oplot,[0,90],[1,1],linestyle=2,thick=4
PlotSym, 0, 1.0, FILL=0,thick=3
xyouts,5,1.05,'(h)',charsize=1.6,charthick=5
xyouts,20,1.02,string(max(PSD_BComp_theta_scale_arr_lm(sub_theta,small_period)),format='(f6.1)')+'(km/s)!U2!N/Hz',charsize=1.5,charthick=3.5

device,/close
;set_plot,'win'
;image_tvrd  = TVRD(true=1)
file_fig  = 'GaussPDF_and_PSD_at_diffI_'+var+$
        TimeRange_str+file_version+suffix+$
        '.png'
if save_fig eq 'Y' then Write_PNG, dir_fig+file_fig, image_tvrd
;================================


end_program:
!p.multi=0
end