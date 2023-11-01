function setintersection, a, b
  ;
  compile_opt StrictArr
  
  minab = min(a, Max=maxa) > min(b, Max=maxb) ;Only need intersection of ranges
  maxab = maxa < maxb
  ;
  ; If either set is empty, or their ranges don't intersect: result = NULL.
  if maxab lt minab or maxab lt 0 then return, -1
  r = where((histogram(a, Min=minab, Max=maxab) ne 0) and $
    (histogram(b, Min=minab, Max=maxab) ne 0), count)
    
  if count eq 0 then return, -1 else return, r + minab
end