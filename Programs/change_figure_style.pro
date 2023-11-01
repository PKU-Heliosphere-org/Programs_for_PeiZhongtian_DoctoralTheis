pro change_figure_style

date = '19950720-29'
sub_dir_date  = 'new\'+date+'\'

dir_fig    = 'C:\Users\pzt\course\Research\CDF_wind\'+sub_dir_date
file_fig = 'wavelet_recon(time=0-0)(v1).png'

myimage = dialog_read_image(image=file_fig)
myimage = dialog_write_image('wavelet_recon(time=0-0)(v1).eps')

end