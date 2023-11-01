;pro plot_distrubution_of_theta_width_B

device, decomposed=1
!P.background='FFFFFF'XL
!P.color='000000'XL


sub_dir_date  = 'wind\20071113-16\'

step1:


dir_restore = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_restore= 'Current_sheet_location_do.sav'
file_array  = File_Search(dir_restore+file_restore, count=num_files)
For i_file=0,num_files-1 Do Begin
  Print, 'i_file, file: ', i_file, ': ', file_array(i_file)
EndFor
i_select  = 0
;Read, 'i_select: ', i_select
file_restore  = file_array(i_select)
Restore, file_restore, /Verbose
;data_descrip= 'got from "locate_sheet.pro"'
;Save, FileName=dir_save+file_save, $
;   data_descrip, $
;    CS_location2 , $
;    width_real , theta_real, Btcha, time_mid


step2:


width_max = max(width_real)
width_min = min(width_real)
theta_max = max(theta_real)
theta_min = min(theta_real)
Btcha_max = max(Btcha)
Btcha_min = min(Btcha)
fen = 21.0
width_d = (width_max-width_min)/fen
theta_d = (theta_max-theta_min)/fen
Btcha_d = (Btcha_max-Btcha_min)/fen
n = (size(width_real))[1]
count_width = intarr(fen)
for i = 0,n-1 do begin
  for k=0,fen-1 do begin
    if width_real(i) GE (width_min+k*width_d) and width_real(i) LT (width_min+(k+1)*width_d) then begin
      count_width(k) = count_width(k)+1
    endif else begin
    endelse
  endfor
endfor  
count_width(20)=count_width(20)+1
c=indgen(21)
dwidth_plot = width_min+c*width_d

count_theta = intarr(fen)
for i=0,n-1 do begin
  for k=0,fen-1 do begin
    if theta_real(i) GE (theta_min+k*theta_d) and theta_real(i) LT (theta_min+(k+1)*theta_d) then begin
      count_theta(k) = count_theta(k)+1
    endif else begin
    endelse
  endfor
endfor  
count_theta(20)=count_theta(20)+1
dtheta_plot = theta_min+c*theta_d

count_Btcha = intarr(fen)
for i=0,n-1 do begin
  for k=0,fen-1 do begin
    if Btcha(i) GE (Btcha_min+k*Btcha_d) and Btcha(i) LT (Btcha_min+(k+1)*Btcha_d) then begin
      count_Btcha(k) = count_Btcha(k)+1
    endif else begin
    endelse
  endfor
endfor  
count_Btcha(20)=count_Btcha(20)+1
dBtcha_plot = Btcha_min+c*Btcha_d

;;--

xsize = 750.0
ysize = 1300.0
Window,1,XSize=xsize,YSize=ysize

plot,dwidth_plot,count_width,xtitle = 'width(s)',ytitle='',psym=-2,position = [0.1,0.75,0.9,0.98]
plot,dtheta_plot,count_theta,xtitle = 'theta',ytitle='',psym=-2,position = [0.1,0.45,0.9,0.68],/noerase
plot,dBtcha_plot,count_Btcha,xtitle = 'B(nT)',ytitle='',psym=-2,position = [0.1,0.15,0.9,0.38],/noerase

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'width_theta_Btcha_distrubution'+ $
        '.png'
Write_PNG, dir_fig+file_fig, image_tvrd

end
