; rainbow_matlab.pro
; Port Matlab's rainbow colour table to IDL. 

; Input: length n
; Output: arrays of r, g, b components; each has dimension of n. 

pro rainbow_matlab, r, g, b, n
  r = bytarr(n)
  g = bytarr(n)
  b = bytarr(n)

  node0 = 0
  node1 = n / 8
  node2 = n * 3 / 8
  node3 = n * 5 / 8
  node4 = n * 7 / 8
  node5 = n - 1

  r(node0:node2-1) = 0
  r(node2:node3) = 255 * bindgen(node3 - node2 + 1) / (node3 - node2)
  r(node3+1:node4-1) = 255
  r(node4:node5) = 255 - 127 * bindgen(node5 - node4 + 1) / (node5 - node4)

  g(node0:node1-1) = 0
  g(node1:node2) = 255 * bindgen(node2 - node1 + 1) / (node2 - node1)
  g(node2+1:node3-1) = 255
  g(node3:node4) = 255 - 255 * bindgen(node4 - node3 + 1) / (node4 - node3)
  g(node4+1:node5) = 0

  b(node0:node1) = 128 + 128 * bindgen(node1 - node0 + 1) / (node1 - node0)
  b(node1+1:node2-1) = 255
  b(node2:node3) = 255 - 255 * bindgen(node3 - node2 + 1) / (node3 - node2)
  b(node3+1:node5) = 0
  
  sub_tmp=Where(r eq 0 and g eq 0 and b eq 0)
  If sub_tmp(0) ne -1 Then Begin
    r(sub_tmp(0)) = r(sub_tmp(0)-1)
    g(sub_tmp(0)) = g(sub_tmp(0)-1)
    b(sub_tmp(0)) = b(sub_tmp(0)-1)
  EndIf
  
end 
