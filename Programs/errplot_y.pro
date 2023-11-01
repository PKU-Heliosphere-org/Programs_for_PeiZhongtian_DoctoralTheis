;-
Pro Errplot_Y,  Low, High,Y, Width = width, $
    DEVICE=device, $   ; swallow this keyword so user can't set it
    NOCLIP=noclipIn, $ ; we use a different default than PLOTS
    _REF_EXTRA=_extra

compile_opt idl2

on_error,2                      ;Return to caller if an error occurs
if n_params(0) eq 3 then begin  ;X specified?
    up = high
    down = low
    yy = y
endif else begin                ;Only 2 params
    up = y
    down = low
    yy=findgen(n_elements(up))  ;make our own x
endelse

w = ((n_elements(width) eq 0) ? 0.01 : width) * $ ;Width of error bars
  (!x.window[1] - !x.window[0]) * !d.x_size * 0.5
n = n_elements(up) < n_elements(down) < n_elements(yy) ;# of pnts

; If user hasn't set NOCLIP, follow what is in !P.
; This is different than PLOTS, whose default is always NOCLIP=1.
noclip = (N_ELEMENTS(noclipIn) gt 0) ? noclipIn : !P.NOCLIP

for i=0,n-1 do begin            ;do each point.
    xy0 = convert_coord(down[i], yy[i], /DATA, /TO_DEVICE) ;get device coords
    xy1 = convert_coord(up[i], yy[i], /DATA, /TO_DEVICE)
    plots,  $
      [replicate(xy0[0],3), replicate(xy1[0],3)], $
      [xy0[1] + [-w, w,0], xy1[1] + [0, -w, w]],  $
      /DEVICE, NOCLIP=noclip, PSYM=0, _STRICT_EXTRA=_extra
endfor
end
