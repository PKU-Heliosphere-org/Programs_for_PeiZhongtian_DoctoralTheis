;***** Sample IDL code for reading GOES SEM data from a NetCDF file
;***** version date 2011-07-27
;***** http://ngdc.noaa.gov/stp/satellite/goes/dataaccess.html

;***** If you would like to dump NetCDF attributes to a text file use something like this:
;***** http://www.atmos.umd.edu/~gcm/usefuldocs/hdf_netcdf/ncdfshow.html


;************************************
; convert julian day to date time string yyyy-mm-dd hh:mm:ss.sss
;
;************************************

function convertJulianToString, julianDay

CALDAT, JulianDay, Month, Day, Year, Hour, Minute, Second

dateTimeString = $
  strtrim(string(year),2) + '-' + $
  strtrim(string(month,format="(I2.2)" ),2) + '-' + $
  strtrim(string(Day,format="(I2.2)" ),2) + ' ' + $
  strtrim(string(Hour, format="(I2.2)"),2) + ":" + $
  strtrim(string(Minute, format="(I2.2)"),2) + ":" + $
  strtrim(string(Second, format="(F6.3)"),2)

;print, "gsp_convertJulianToString says :", dateTimeString

return, dateTimeString

end




