;Pro test_GS_by_integration


num_x = 101
num_y = 101
A_arr = Dblarr(num_x,num_y)
dPdA  = 0.0

A_arr(1,*)  = Transpose(Dindgen(num_y)*0.1)
A_arr(1,*)  = Exp(-(Dindgen(num_y)-num_y/2)^2/2/(num_y/2./5)^2)

A_arr(*,0)  = A_arr(1,0)
A_arr(*,num_y-1)  = A_arr(1,num_y-1)

For i_x=2,num_x-1 Do Begin
For i_y=1,num_y-2 Do Begin
    ix_c=i_x-1 & ix_l=i_x-1-1 & ix_r=i_x-1+1
    iy_c=i_y & iy_l=i_y-1 & iy_u=i_y+1
  If i_x eq 2 Then Begin
    A_tmp = (-(A_arr(ix_c,iy_u)+A_arr(ix_c,iy_l)-2*A_arr(ix_c,iy_c)) + 2*A_arr(ix_c,iy_c)) / 2 + dPdA
    A_arr(i_x,i_y)  = A_tmp
    A_arr(0,i_y)  = A_tmp
  EndIf Else Begin
    A_tmp = -(A_arr(ix_c,iy_u)+A_arr(ix_c,iy_l)-2*A_arr(ix_c,iy_c)) + (2*A_arr(ix_c,iy_c)-A_arr(ix_l,iy_c)) + dPdA
    A_arr(i_x,i_y)  = A_tmp
  EndElse
EndFor
EndFor

End  
  