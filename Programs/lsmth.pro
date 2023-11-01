; Fonction de lissage logarithmique
;0<factor<1
FUNCTION lsmth,y,factor

size_data=size(y,/dimensions)

if (n_elements(size_data) eq 1) then begin
	a=fltarr(1,size_data[0])
	a[0,*] = y
	y=a
endif

size_data=size(y,/dimensions)
n_comp = size_data[0]
pts = size_data[1]

Fzero = dblarr(n_comp,pts)

FOR i=0, n_comp-1 DO BEGIN
	for jj = 0L,pts-1 do begin
   		nlow = jj - long(factor*jj)
    	nhi = jj + long(factor*jj)
    	if (nhi gt pts) then break

    	if (nhi eq nlow) then begin
        	Fzero[i,jj] = y[i,jj]
        endif
    	if (nhi ne nlow) then begin
        	Fzero[i,jj] = total(y[i,nlow:nhi-1])/n_elements(y[i,nlow:nhi-1])
    	endif

	endfor
ENDFOR

RETURN, Fzero

END