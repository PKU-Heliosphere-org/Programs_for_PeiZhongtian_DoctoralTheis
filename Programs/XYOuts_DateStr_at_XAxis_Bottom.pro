Pro xyouts_DateStr_at_XAxis_Bottom, $
    JulDay_range, position_plot, $
    dypos_xyouts=dypos_xyouts, $
    color=color_xyouts, charsize=charsize_xyouts, charthick=charthick_xyouts

dJulDay = JulDay_range(1)-JulDay_range(0)
JulDay_beg_00 = Floor(JulDay_range(0), /L64)
JulDay_end_00 = Ceil(JulDay_range(1), /L64)

num_days  = (JulDay_end_00 - JulDay_beg_00) + 1
JulDay_MidDay_vect  = Dblarr(num_days)
For i_day=0,num_days-1 Do Begin
  JulDay_MidDay_vect(i_day) = JulDay_beg_00 + i_day + 0.0
EndFor

i_xyout = 0L
For i_day=0,num_days-1 Do Begin
  JulDay_MidDay_tmp = JulDay_MidDay_vect(i_day)
  CalDat, JulDay_MidDay_tmp, mon_tmp, day_tmp, year_tmp, hour_tmp, min_tmp, sec_tmp
  If JulDay_MidDay_tmp ge JulDay_range(0) and JulDay_MidDay_tmp le JulDay_range(1) Then Begin
    If i_xyout eq 0L Then Begin
      DateStr_tmp = String(year_tmp,format='(I4.4)')+'/'+String(mon_tmp,format='(I2.2)')+'/'+String(day_tmp,format='(I2.2)')
    EndIf Else Begin
      DateStr_tmp = String(mon_tmp,format='(I2.2)')+'/'+String(day_tmp,format='(I2.2)')
    EndElse  
  EndIf Else Begin
    Goto, Another_i_day
  EndElse
  xpos_tmp  = position_plot(0) + (position_plot(2)-position_plot(0))*(JulDay_MidDay_tmp-JulDay_range(0))/(JulDay_range(1)-JulDay_range(0))
  ypos_tmp  = position_plot(1) - dypos_xyouts
  XYOuts, xpos_tmp, ypos_tmp, DateStr_tmp, Alignment=0.5, /Normal, $
    Color=color_xyouts, CharSize=charsize_xyouts, CharThick=charthick_xyouts
  i_xyout = i_xyout + 1L  
  Another_i_day:
EndFor  

End_Program:
End    