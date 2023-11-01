;pro paper3_random_deltaB
sub_dir_date = 'model\'

step1:
alpha = 0.37



read,'pmodel(0) or beta(1):',is_q
if is_q eq 0 then begin
  q = 1./3
  strfang = 'pmodel'


a1=randomn(50,50,/uniform)
b=randomn(20,20,/uniform)
phase = b*2*!pi
funamp,1,a1,ampV1
;print,ampV1
deltaV1 = ampV1 # cos(phase)
;print,deltaV1

n = 50*2
deltaV2 = fltarr(n,20)
deltaV2(0:n/2-1,*) = alpha^q*deltaV1
deltaV2(n/2:n-1,*) = (1-alpha)^q*deltaV1


n = 50*2^2
deltaV3 = fltarr(n,20)
deltaV3(0:n/2-1,*) = alpha^q*deltaV2
deltaV3(n/2:n-1,*) = (1-alpha)^q*deltaV2


n = 50*2^3
deltaV4 = fltarr(n,20)
deltaV4(0:n/2-1,*) = alpha^q*deltaV3
deltaV4(n/2:n-1,*) = (1-alpha)^q*deltaV3

n = 50*2^4
deltaV5 = fltarr(n,20)
deltaV5(0:n/2-1,*) = alpha^q*deltaV4
deltaV5(n/2:n-1,*) = (1-alpha)^q*deltaV4

n = 50*2^5
deltaV6 = fltarr(n,20)
deltaV6(0:n/2-1,*) = alpha^q*deltaV5
deltaV6(n/2:n-1,*) = (1-alpha)^q*deltaV5


n = 50*2^6
deltaV7 = fltarr(n,20)
deltaV7(0:n/2-1,*) = alpha^q*deltaV6
deltaV7(n/2:n-1,*) = (1-alpha)^q*deltaV6


n = 50*2^7
deltaV8 = fltarr(n,20)
deltaV8(0:n/2-1,*) = alpha^q*deltaV7
deltaV8(n/2:n-1,*) = (1-alpha)^q*deltaV7


n = 50*2^8
deltaV9 = fltarr(n,20)
deltaV9(0:n/2-1,*) = alpha^q*deltaV8
deltaV9(n/2:n-1,*) = (1-alpha)^q*deltaV8


n = 50*2^9
deltaV10 = fltarr(n,20)
deltaV10(0:n/2-1,*) = alpha^q*deltaV9
deltaV10(n/2:n-1,*) = (1-alpha)^q*deltaV9

n = 50L*2^10
deltaV11 = dblarr(n,20)
deltaV11(0:n/2-1,*) = alpha^q*deltaV10
deltaV11(n/2:n-1,*) = (1-alpha)^q*deltaV10


n = 50L*2^11
deltaV12 = dblarr(n,20)
deltaV12(0:n/2-1,*) = alpha^q*deltaV11
deltaV12(n/2:n-1,*) = (1-alpha)^q*deltaV11

endif


if is_q eq 1 then begin
  
strfang = 'beta'


a1=randomn(100,100,/uniform)
b=randomn(50,50,/uniform)
phase = b*2*!pi
funamp,1,a1,ampV1
;print,ampV1
n_p = 500
deltaV0 = ampV1 # cos(phase)
deltaV1 = dblarr(100,50,n_p)
for i_q =0,n_p-1 do begin
deltaV1(*,*,i_q) = deltaV0 
endfor
;print,deltaV1


deltaV2 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=1)
for i_q =0,n_p-1 do begin
deltaV2(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV3 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=2)
for i_q =0,n_p-1 do begin
deltaV3(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV4 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=3)
for i_q =0,n_p-1 do begin
deltaV4(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV5 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=4)
for i_q =0,n_p-1 do begin
deltaV5(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV6 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=5)
for i_q =0,n_p-1 do begin
deltaV6(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV7 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=6)
for i_q =0,n_p-1 do begin
deltaV7(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV8 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=7)
for i_q =0,n_p-1 do begin
deltaV8(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV9 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=8)
for i_q =0,n_p-1 do begin
deltaV9(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV10 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=9)
for i_q =0,n_p-1 do begin
deltaV10(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV11 = dblarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=10)
for i_q =0,n_p-1 do begin
deltaV11(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor

deltaV12 = fltarr(100,50,n_p)
q = imsl_random(n_p,/poisson,parameters=11)
for i_q =0,n_p-1 do begin
deltaV12(*,*,i_q) = deltaV1(*,*,i_q) * alpha^q(i_q)
endfor
  
  
  
  
endif  



file_save ='random_deltaB_'+strfang+'_'+string(alpha)+'.sav'
dir_save  = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
data_descrip= 'got from "paper3_random_deltaB.pro"'
Save, FileName=dir_save+file_save, $
  data_descrip, $
  deltaV1, deltaV2, deltaV3, deltaV4, deltaV5, deltaV6, deltaV7, deltaV8, deltaV9, deltaV10, deltaV11, deltaV12


end

