;Pro test_SVD

; Define the array A:
A = [[1.0, 2.0, -1.0, 2.5], $
     [1.5, 3.3, -0.5, 2.0], $
     [3.1, 0.7,  2.2, 0.0], $
     [0.0, 0.3, -2.0, 5.3], $
     [2.1, 1.0,  4.3, 2.2], $
     [0.0, 5.5,  3.8, 0.2]]

; Compute the Singular Value Decomposition:
SVDC, A, W, U, V

; Print the singular values:
PRINT, W

;IDL prints:
;
;8.81973      2.65502      4.30598      6.84484 
;To verify the decomposition, use the relationship A = U ## SV ## TRANSPOSE(V), where SV is a diagonal array created from the output vector W:

sv = FLTARR(4, 4)
FOR K = 0, 3 DO sv[K,K] = W[K]
result = U ## sv ## TRANSPOSE(V)
PRINT, result

Print, A ## V(0,*)
Print, W(0) * U(0,*)

End