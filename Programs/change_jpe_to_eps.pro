;pro change_jpe_to_eps


dir_fig     = 'C:\Users\pzt\course\Research\CDF_wind\wind\Alfven\'

step1:

file_jpg='eit.png'

filename = dir_fig+file_jpg


image_C2 = read_image(filename)

;Device, decomposed=0
;loadct,0
;tVimage,BYTSCL(image_C2)
image_size = size(image_C2)
print,image_size

image_C2 = image_C2(*,26:(image_size[2]-1))

print,size(image_C2)

Set_Plot,'PS'
filename= dir_fig+'eit.eps'
xsize = 20.0
ysize = 20.0
Device, FileName=filename, XSize=xsize,YSize=ysize ,decomposed=0;,/color
loadct,0


Plot,[0,1],[0,1],XStyle=1+4,YStyle=1+4,/NoData
xyouts,0.02,0.85,'(b)',charsize=2,charthick = 2;,color = 0
xyouts,0.18,0.04,'C2:2002/5/22 00:50  EIT:2002/5/22 00:48',charsize=1.5,charthick = 3
TVimage,BYTSCL(image_C2),position = [0.2,0.15,0.95,0.9]

;

Device,/Close 




end