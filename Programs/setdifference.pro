function setdifference, a, b
  ;
  compile_opt StrictArr
  ;
  ; = a and (not b) = elements in A but not in B
  mina = min(a, Max=maxa)
  minb = min(b, Max=maxb)
  if (minb gt maxa) or (maxb lt mina) then return, a ;No intersection...
  r = where((histogram(a, Min=mina, Max=maxa) ne 0) and $
    (histogram(b, Min=mina, Max=maxa) eq 0), count)
  if count eq 0 then return, -1 else return, r + mina
end