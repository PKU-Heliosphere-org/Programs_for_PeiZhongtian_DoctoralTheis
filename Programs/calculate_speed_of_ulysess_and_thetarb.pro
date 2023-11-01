pro calculate_speed_of_Ulysess_and_thetaRB

step1:
;;计算卫星速度
;;
;
;read,'degree of big circle', deg
;read,'distance from sun(AU)',dis
;read,'time(days)',time
;speed = deg*!pi/180.0*dis*1.5*10^4/time/8.64
;
;print,speed
;
;;plot,[0],[0]
;;xyouts,0.5,0.5,textoIDL('\pm')


step2:

;计算thetaBR

read,'distance from sun(AU)',dis
read,'velocity of SW(km/s)',sp_SW
read,'latitude in HGI(deg)',lati

tanphy = 2.0*!pi*dis*1.5*10^4*cos(lati*!pi/180.0)/(27.0*8.64*sp_SW)
phy = atan(tanphy)*180.0/!pi

print,tanphy,phy




end
