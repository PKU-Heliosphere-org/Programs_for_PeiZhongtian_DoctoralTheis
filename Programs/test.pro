;pro test



sub_dir_date = 'model\'


step1:
n_p = 500


q = imsl_random(n_p,/poisson,parameters=4)

n = 10
x=indgen(n)
y=intarr(n)
for i =0,n-1 do begin
  sub = where(q eq i)
  y(i) = n_elements(sub)
endfor
   
  
plot,x,y

image_tvrd  = TVRD(true=1)
dir_fig   = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig  = 'text.png'
Write_PNG, dir_fig+file_fig, image_tvrd


end

