function setunion, a, b
  ;
  compile_opt StrictArr
  if n_elements(a) eq 0 then return, b    ;A union NULL = a
  if n_elements(b) eq 0 then return, a    ;B union NULL = b
  return, where(histogram([a,b], OMin = omin)) + omin ; Return combined set
end