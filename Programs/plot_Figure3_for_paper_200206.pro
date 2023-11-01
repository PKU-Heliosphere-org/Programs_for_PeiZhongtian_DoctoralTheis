;Pro plot_Figure3_for_paper_200206
;Pro plot_IMF_line_Bow_Shock_SC_Location, $
;      xyz_GSE_Re, Bxyz_GSE_nT, Vxyz_GSE_kmps, $
;      n_cm3, T_MK

;pre-call program: get_position_plasma_magnetic_aver_certain_time.pro

xyz_GSE_Re  = [18.8, 321.4, 23.1];[45.60, -38.87, 1.95]
Bxyz_GSE_nT = [-7.68, 6.67, 2.25];[-4.92, 0.92, 2.61]
Vxyz_GSE_kmps = [-644.,207.,-18.];[-678.8, 23.9, 6.9]
n_cm3 = 0.12;4.4
T_MK  = 0.5;0.29
      
;;--
theta_deg_min = -120.0  ;60
theta_deg_max = +120.0
num_thetas    = 101
theta_deg_vect  = theta_deg_min + Findgen(num_thetas)*(theta_deg_max-theta_deg_min)/(num_thetas-1)

;;;---
r_theta_vect  = Fltarr(num_thetas)
Vsw_kmps      = Norm(Vxyz_GSE_kmps)
Bxyz_nT_vect  = Bxyz_GSE_nT
For i_theta=0,num_thetas-1 Do Begin
  theta_deg = theta_deg_vect(i_theta)
  r_theta   = get_r_certain_theta_BowShock_ChaoJK(theta_deg, $
                n_cm3, Vsw_kmps, Bxyz_nT_vect, T_MK)
  r_theta_vect(i_theta) = r_theta ;unit: Re
EndFor

;;;---
phi_deg_min = 0.0
phi_deg_max = 359.0
num_phis    = 101
phi_deg_vect= phi_deg_min + Findgen(num_phis)*(phi_deg_max-phi_deg_min)/(num_phis-1)                

theta_arr = theta_deg_vect # (Fltarr(num_phis)+1)
phi_arr   = (Fltarr(num_thetas)+1) # phi_deg_vect
r_arr     = r_theta_vect # (Fltarr(num_phis)+1)

x_arr = r_arr * Cos(theta_arr*!pi/180)
y_arr = r_arr * Sin(theta_arr*!pi/180) * Cos(phi_arr*!pi/180) * (-1)
z_arr = r_arr * Sin(theta_arr*!pi/180) * Sin(phi_arr*!pi/180)

;;--
x_SC  = xyz_GSE_Re(0)
y_SC  = xyz_GSE_Re(1)
z_SC  = xyz_GSE_Re(2)
XRange  = [Min([Min(x_arr), x_SC]), Max([Max(x_arr), x_SC])]
YRange  = [Min([Min(y_arr), y_SC]), Max([Max(y_arr), y_SC])]
ZRange  = [Min([Min(z_arr), z_SC]), Max([Max(z_arr), z_SC])]
XRange  = [XRange(0)-0.1*(XRange(1)-XRange(0)), XRange(1)+0.1*(XRange(1)-XRange(0))]
YRange  = [YRange(0)-0.1*(YRange(1)-YRange(0)), YRange(1)+0.1*(YRange(1)-YRange(0))]
ZRange  = [ZRange(0)-0.1*(ZRange(1)-ZRange(0)), ZRange(1)+0.1*(ZRange(1)-ZRange(0))]
YRange  = [-Max([Abs(YRange)]),+Max([Abs(YRange)])]
ZRange  = [-Max([Abs(ZRange)]),+Max([Abs(ZRange)])]

ISurface, Z_arr, x_arr, y_arr, $
      XTitle='x(Re)', YTitle='Y(Re)', ZTitle='Z(Re)', $
      XRange=xrange,YRange=yrange,ZRange=zrange,XStyle=1,YStyle=1,ZStyle=1, $
      XThick=3.0,YThick=3.0,ZThick=3.0, $
      BackGround_Color=[255,255,255]
      
xplot_vect  = xrange
Bx=Bxyz_GSE_nT(0) & By=Bxyz_GSE_nT(1) & Bz=Bxyz_GSE_nT(2)
yplot_vect  = y_SC + By/Bx*(xrange - x_SC)
zplot_vect  = z_SC + Bz/Bx*(xrange - x_SC)            
iPlot, xplot_vect, yplot_vect, zplot_vect, $
    /OverPlot, Color=[255,0,0], Thick=3.0
iPlot, [x_SC,x_SC-0], [y_SC,y_SC], [z_SC,z_SC], $
    /OverPlot, Color=[0,0,255], Thick=3.0, Sym_Index=6,Sym_Size=3

End_Program:
End