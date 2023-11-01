Pro get_LMN_from_MVA, Bxyz_arr, $
      l_vect=l_vect, m_vect=m_vect, n_vect=n_vect, $
      lambda_l=lambda_l, lambda_m=lambda_m, lambda_n=lambda_n
      
      
;;--
num_times = (Size(Bxyz_arr))[1]
BB_3D_arr = Fltarr(3,3,num_times)
For i_time=0,num_times-1 Do Begin
  Bxyz_vect = Reform(Bxyz_arr(i_time,*))
  BB_3D_arr(*,*,i_time) = Bxyz_vect # Bxyz_vect
EndFor
BB_2D_arr = Total(BB_3D_arr,3)/num_times

;;--
Bxyz_aver_vect  = Reform(Total(Bxyz_arr,1)/num_times)
B0B0_2D_arr = Bxyz_aver_vect # Bxyz_aver_vect

;;--
M_2D_arr  = BB_2D_arr - B0B0_2D_arr

;;--
is_method_1or2  = 2
If is_method_1or2 eq 1 Then Begin
eigvec_arr  = Complexarr(3,3)
eigval_vect = Complexarr(3)
eigvec_arr  = Eigenvec(M_2D_arr, eigval_vect)
eigval_vect = Real_Part(eigval_vect)
eigvec_arr  = Real_Part(eigvec_arr)  
EndIf Else Begin
If is_method_1or2 eq 2 Then Begin
; Compute the tridiagonal form of A:
A = M_2D_arr 
TRIRED, A, D, E 
; Compute the eigenvalues (returned in vector D) and 
; the eigenvectors (returned in the rows of the array A): 
TRIQL, D, E, A
eigval_vect = D
eigvec_arr  = A 
EndIf
EndElse


;;;---
sub_lmn = Reverse(Sort(Abs(eigval_vect)))
sub_l = sub_lmn(0)
lambda_l  = eigval_vect(sub_l)
l_vect  = eigvec_arr(*,sub_l)
sub_m = sub_lmn(1)
lambda_m  = eigval_vect(sub_m)
m_vect  = eigvec_arr(*,sub_m)
sub_n = sub_lmn(2)
lambda_n  = eigval_vect(sub_n)
n_vect  = eigvec_arr(*,sub_n)

l_vect  = l_vect/Norm(l_vect)
m_vect  = m_vect/Norm(m_vect)
n_vect  = n_vect/Norm(n_vect)


End_Program:
Return

End

      