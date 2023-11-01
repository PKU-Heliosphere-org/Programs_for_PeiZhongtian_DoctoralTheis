;Pro plot_mag_velo

Date = '20050522'
sub_dir_date  = 'others\weak\'+Date+'\'

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


step1:


;;--
dir_read  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_read = 'uy_m0_bai_20050522_v01.cdf'
file_array  = File_Search(dir_read+file_read, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_read = file_array(i_select)
file_read = StrMid(file_read, StrLen(dir_read), StrLen(file_read)-StrLen(dir_read))

;;--
CD, Current=wk_dir
CD, dir_read
cdf_id  = CDF_Open(file_read)
;;;---
;CDF_Control, cdf_id, Variable='Epoch3', Get_Var_Info=Info_Epoch3
;a num_records  = Info_Epoch.MaxAllocRec
;num_records    = Info_Epoch3.MaxRec + 1L
;CDF_VarGet, cdf_id, 'Epoch3', Epoch_3s_vect, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B3GSE', Bxyz_GSE_3s_arr, Rec_Count=num_records
;;;---
CDF_Control, cdf_id, Variable='Epoch', Get_Var_Info=Info_Epoch
num_records   = Info_Epoch.MaxRec + 1L
CDF_VarGet, cdf_id, 'Epoch', Epoch_m_vect, Rec_Count=num_records
CDF_VarGet, cdf_id, 'Velocity', Vxyz_GSE_m_arr, Rec_Count=num_records
;CDF_VarGet, cdf_id, 'B_MAG', Bmag_GSE_2s_arr, Rec_Count=num_records
;;;---
CDF_Close, cdf_id
CD, wk_dir


;;--
Epoch_m_vect = Reform(Epoch_m_vect)
epoch_beg   = Epoch_m_vect(0)
CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
      /Breakdown_Epoch
JulDay_beg    = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
JulDay_m_vect  = JulDay_beg+(Epoch_m_vect-Epoch_beg)/(1.e3*24.*60.*60.)

;;--
;Epoch_1min_vect  = Reform(Epoch_1min_vect)
;epoch_beg    = Epoch_1min_vect(0)
;CDF_Epoch, epoch_beg, year_beg, mon_beg, day_beg, hour_beg, min_beg, sec_beg, milli_beg, $
;     /Breakdown_Epoch
;JulDay_beg   = JulDay(mon_beg,day_beg,year_beg,hour_beg,min_beg, sec_beg+milli_beg*1.e-3)
;JulDay_1min_vect= JulDay_beg+(Epoch_1min_vect-Epoch_beg)/(1.e3*24.*60.*60.)

;;--
dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'uy_1sec_vhm_20050522_v01.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "Read_h0_mfi_WIND_CDF_19950131.pro"'
;Save, FileName=dir_save+file_save, $
;  data_descrip, $
;  JulDay_2s_vect, Bxyz_GSE_2s_arr, Bmag_GSE_2s_arr, $
;  Bx_GSE_2s_vect, By_GSE_2s_vect, Bz_GSE_2s_vect, Btotal_GSE_2s_vect


Step2:
;===========================
;Step2:

Vx_GSE_m_arr = Vxyz_GSE_m_arr(0,*)
Vy_GSE_m_arr = Vxyz_GSE_m_arr(1,*)
Vz_GSE_m_arr = Vxyz_GSE_m_arr(2,*)
Vtotal_GSE_m_arr = sqrt(Vx_GSE_m_arr^2+Vy_GSE_m_arr^2+Vz_GSE_m_arr^2)

;--
dir_save  = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_save = StrMid(file_read, 0, StrLen(file_read)-4)+'.sav'
data_descrip= 'got from "Plot_mag_velo.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  JulDay_m_vect, Vx_GSE_m_arr , $
  Vy_GSE_m_arr , Vz_GSE_m_arr , $
  Vtotal_GSE_m_arr
  
  
  
step3:

i = 0
Read, 'i(1/2/3 for 磁场分量/总磁场/Vx): ', i
If i eq 1 Then begin
  FileName_xuan='Bcomp'
Bx_RTN_vect  = reform(Bxyz_GSE_2s_arr(0,*))
By_RTN_vect  = reform(Bxyz_GSE_2s_arr(1,*))
Bz_RTN_vect  = reform(Bxyz_GSE_2s_arr(2,*))

xrange  = [fix(JulDay_2s_vect(0))+0.5,fix(JulDay_2s_vect(0))+1.5]
yrange  = [-2.,2.]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 4
;position_SubImg=[0.10,0.15,0.90,0.98]
plot_time=JulDay_2s_vect-fix(JulDay_2s_vect(0))-0.5
plot,plot_time,Bx_RTN_vect,yRange=yrange,xstyle= 4,color='ff0000'XL
plot,plot_time,By_RTN_vect,yRange=yrange,xstyle= 4,color='00ff00'XL,/NoErase
plot,plot_time,Bz_RTN_vect,yRange=yrange,xstyle= 4,color='0000ff'XL,/NoErase
plot,xrange,XRange=xrange,yRange=yrange,XStyle=1, $
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04, $
  /NoData,Color=0L,xtitle='time',ytitle='B(nT)', $
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0
XYouts,500,300,'Bx',color='ff0000'XL,charsize=1.2,charthick=2,/DEvice
XYouts,550,300,'By',color='00ff00'XL,charsize=1.2,charthick=2,/DEvice
XYouts,600,300,'Bz',color='0000ff'XL,charsize=1.2,charthick=2,/DEvice
xyouts,150,300,'Date:'+date,charsize=1.2,charthick=2,/DEvice

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_fig  = 'Bcomp_time_arr'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endif

If i eq 2 Then begin
  FileName_xuan='Btotal'
Bx_RTN_vect  = reform(Bxyz_GSE_2s_arr(0,*))
By_RTN_vect  = reform(Bxyz_GSE_2s_arr(1,*))
Bz_RTN_vect  = reform(Bxyz_GSE_2s_arr(2,*))
Btotal_RTN_vect = sqrt(Bx_RTN_vect^2+By_RTN_vect^2+Bz_RTN_vect^2)

xrange  = [fix(JulDay_2s_vect(0))+0.5,fix(JulDay_2s_vect(0))+1.5]
yrange  = [0.,2.]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 4
;position_SubImg=[0.10,0.15,0.90,0.98]
plot_time=JulDay_2s_vect-fix(JulDay_2s_vect(0))-0.5
plot,plot_time,Btotal_RTN_vect,yRange=yrange,xstyle= 4
plot,xrange,XRange=xrange,yRange=yrange,XStyle=1, $
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04, $
  /NoData,Color=0L,xtitle='time',ytitle='Bt(nT)', $
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0
xyouts,150,300,'Date:'+date,charsize=1.2,charthick=2,/DEvice
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_fig  = 'Btotal_time_arr'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd
  
endif  

If i eq 3 Then begin
  FileName_xuan='Vx'

xrange  = [fix(JulDay_m_vect(0))+0.5,fix(JulDay_m_vect(0))+1.5]
yrange  = [200,600]
xrange_time = xrange
get_xtick_for_time, xrange_time, xtickv=xtickv_time, xticknames=xticknames_time, xminor=xminor_time
xtickv    = xtickv_time
xticks    = N_Elements(xtickv)-1
xticknames  = xticknames_time
xminor    = 4
;position_SubImg=[0.10,0.15,0.90,0.98]
plot_time=JulDay_m_vect-fix(JulDay_m_vect(0))-0.5
plot,plot_time,Vx_GSE_m_arr,yRange=yrange,xstyle= 4
plot,xrange,XRange=xrange,yRange=yrange,XStyle=1, $
  XTicks=xticks,XTickV=xtickv,XTickName=xticknames,XMinor=xminor,XTickLen=0.04, $
  /NoData,Color=0L,xtitle='time',ytitle='Vx(km/s)', $
  /NoErase,Font=-1,CharThick=1.0,Thick=1.0
 xyouts,150,70,'Date:'+date,charsize=1.2,charthick=2,/DEvice 
image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\research\CDF_wind\'+sub_dir_date
file_fig  = 'Vx_time_arr'+$
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

endif

End_Program:
End



















































