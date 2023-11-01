Pro TimeStr_to_JuliNum_v2,TimeStr,JuliNum
;transform 'TimeStr' got from head.UTC_S of SUMER image
;to 'JuliNum' vector including 'year/mon/dat/hour/minute/second'

year_str	= StrMid(TimeStr,0,4)
month_str	= StrMid(TimeStr,5,2)
date_str	= StrMid(TimeStr,8,2)
hour_str	= StrMid(TimeStr,11,2)
minute_str	= StrMid(TimeStr,14,2)
second_str	= StrMid(TimeStr,17,6)

year_num	= Fix(year_str)
month_num	= Fix(month_str)
date_num	= Fix(date_str)
hour_num	= Fix(hour_str)
minute_num	= Fix(minute_str)
second_num	= Float(second_str)


JuliNum		= JULDAY(month_num, date_num, year_num, hour_num, minute_num, second_num)

Return
End

