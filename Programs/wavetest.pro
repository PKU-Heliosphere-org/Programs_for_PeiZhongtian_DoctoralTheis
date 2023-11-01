;************************************************************** WAVETEST
;+
; NAME:   WAVETEST
;
; PURPOSE:   Example IDL program for WAVELET, using NINO3 SST dataset
;
; EXECUTION:
;
;            IDL> .run wavetest
;
;
; See "http://paos.colorado.edu/research/wavelets/"
; Written January 1998 by C. Torrence
;
;-
;**************************************************************

	n = 504
	sst = FLTARR(n)
	OPENR,1,'D:\科学工具\IDL_Library\wave_idl\sst_nino3.dat'   ; input SST time series
	READF,1,sst
	CLOSE,1

;------------------------------------------------------ Computation

; normalize by standard deviation (not necessary, but makes it easier
; to compare with plot on Interactive Wavelet page, at
; "http://paos.colorado.edu/research/wavelets/plot/"
	sst = (sst - TOTAL(sst)/n)

	;;--
	sst	= sst*3.0

	dt = 0.25*1
	time = FINDGEN(n)*dt + 1871.0  ; construct time array
	xrange = [1870,2000]  ; plotting range
	pad = 1
	s0 = dt    ; this says start at a scale of 3 months
	dj = 0.25  ; this will do 4 sub-octaves per octave
	j1 = 9./dj  ; this says do 9 powers-of-two with dj sub-octaves each
	mother = 'Morlet'
	recon_sst = sst   ; save an extra copy, so we don't erase original sst

; estimate lag-1 autocorrelation, for red-noise significance tests
; Note that we actually use the global wavelet spectrum (GWS)
; for the significance tests, but if you wanted to use red noise,
; here's how you could calculate it...
	lag1 = (A_CORRELATE(sst,1) + SQRT(A_CORRELATE(sst,2)))/2.

; Wavelet transform:
	wave = WAVELET(recon_sst,dt,PERIOD=period,SCALE=scale,S0=s0, $
		PAD=pad,COI=coi,DJ=dj,J=j1,MOTHER=mother,/RECON)
	power = (ABS(wave))^2  ; compute wavelet power spectrum
	global_ws = TOTAL(power,1)/n   ; global wavelet spectrum (GWS)
	J = N_ELEMENTS(scale) - 1

; Significance levels, assuming the GWS as background spectrum:
	signif = WAVE_SIGNIF(sst,dt,scale,0, $
		GWS=global_ws,SIGLVL=0.90,MOTHER=mother)
	signif = REBIN(TRANSPOSE(signif),n,J+1)  ; expand signif --> (J+1)x(N) array
	signif = power/signif   ; where ratio > 1, power is significant

; GWS significance levels:
	dof = n - scale   ; the -scale corrects for padding at edges
	global_signif = WAVE_SIGNIF(sst,dt,scale,1, $
		LAG1=0.0,DOF=dof,MOTHER=mother,CDELTA=Cdelta,PSI0=psi0)

; check total variance (Parseval's theorem) [Eqn(14)]
	scale_avg = REBIN(TRANSPOSE(scale),n,J+1)  ; expand scale-->(J+1)x(N) array
	power_norm = power/scale_avg
	variance = (MOMENT(sst))(1)
	recon_variance = dj*dt/(Cdelta*n)*TOTAL(power_norm)  ; [Eqn(14)]

	IF (N_ELEMENTS(recon_sst) GT 1) THEN BEGIN
		recon_variance = (MOMENT(recon_sst))(1)
; RMS of Reconstruction [Eqn(11)]
		rms_error = SQRT(TOTAL((sst - recon_sst)^2)/n)
		PRINT
		PRINT,'        ******** RECONSTRUCTION ********'
		PRINT,'original variance =',variance,' degC^2'
		PRINT,'reconstructed var =',FLOAT(recon_variance),' degC^2'
		PRINT,'Ratio = ',recon_variance/variance
		PRINT,'root-mean-square error of reconstructed sst = ',rms_error,' degC'
		PRINT
		IF (mother EQ 'DOG') THEN BEGIN
			PRINT,'Note: for better reconstruction with the DOG, you need'
			PRINT,'      to use a very small s0.'
		ENDIF
		PRINT
	ENDIF

; Scale-average between El Nino periods of 2--8 years
	avg = WHERE((scale GE 2) AND (scale LT 8))
	scale_avg = dj*dt/Cdelta*TOTAL(power_norm(*,avg),2)  ; [Eqn(24)]
	scaleavg_signif = WAVE_SIGNIF(sst,dt,scale,2, $
		GWS=global_ws,SIGLVL=0.90,DOF=[2,7.9],MOTHER=mother)


;===============================
;-added by JSHEPT on 2008-12-02
;-get 'PSD_vect' as a function of 'freq_vect' (power-spectrum-density)(km^2/Hz)
num_times	= n
wave_vect	= sst
num_freqs   = num_times/2
df          = 1./(2*dt)/num_freqs
freq_vect   = Findgen(num_freqs)*df
FFT_wave_vect   = FFT(wave_vect,-1)
;;--unit: km for IDL-FFT,
;;--FFT_wave_vect(1:i_freq)=reverse(FFT_wave_vect(num_times-i_freq:num_times-1)), i_freq<num_freqs
;;--FFT_wave_vect(0), FFT_wave_vect(num_freqs) are single without equivalent values
PSD_vect    = Findgen(num_freqs)    ;unit: km^2/Hz
For i_freq=0,num_freqs-1 Do Begin
    FFT_wave_tmp= FFT_wave_vect(i_freq)
    If i_freq eq 0 Then Begin
       PSD_tmp  = num_times*dt*Abs(FFT_wave_tmp)^2  ;unit: s*km^2 (km^2/Hz)
    EndIf Else Begin
    If i_freq eq num_freqs-1 Then Begin
       PSD_tmp  = num_times*dt*Abs(FFT_wave_tmp)^2
    EndIf Else Begin
       PSD_tmp  = 2*num_times*dt*Abs(FFT_wave_tmp)^2
    EndElse
    EndElse
    PSD_vect(i_freq)    = PSD_tmp
EndFor

freq_vect_FFT	= freq_vect

period_vect			= period
freq_vect_wavlet	= 1/period_vect
period_vect_wavlet	= period_vect
PSD_vect_FFT		= Interpol(PSD_vect, freq_vect_FFT, freq_vect_wavlet)

;-added by JSHEPT on 2008-12-02
;===============================


;------------------------------------------------------ Plotting
printfile = 0

!P.FONT = -1
!P.CHARSIZE = 1
IF (printfile) THEN BEGIN
	SET_PLOT,'ps'
	DEVICE,/PORT,/INCH,XSIZE=6.5,XOFF=1,YSIZE=6,YOFF=3,/COLOR,BITS=8
	!P.FONT = 0
	!P.CHARSIZE = 0.75
ENDIF ELSE Begin
	Set_Plot,'Win'
	WINDOW,0,XSIZE=600,YSIZE=700
EndElse
!P.MULTI = 0
!X.STYLE = 1
!Y.STYLE = 1
LOADCT,39

;--- Plot time series
	pos1 = [0.1,0.75,0.7,0.95]
	PLOT,time,sst,XRANGE=xrange, $
		XTITLE='Time (year)',YTITLE='NINO3 SST (!Uo!NC)', $
		TITLE='a) NINO3 Sea Surface Temperature (seasonal)', $
		POSITION=pos1
	IF (N_ELEMENTS(recon_sst) GT 1) THEN OPLOT,time,recon_sst,COLOR=144
	XYOUTS,0.85,0.9,/NORMAL,ALIGN=0.5, $
		'!5WAVELET ANALYSIS!X'+$
		'!C!CC. Torrence & G.P. Compo'+$
		'!C!Chttp://paos.colorado.edu/!Cresearch/wavelets/'

;--- Contour plot wavelet power spectrum
	yrange = [64,0.5]   ; years
	levels = [0.5,1,2,4]*9
	colors = [64,128,208,254]
	period2 = FIX(ALOG(period)/ALOG(2))   ; integer powers of 2 in period
	ytickv = 2.^(period2(UNIQ(period2)))  ; unique powers of 2
	pos2 = [pos1(0),0.35,pos1(2),0.65]

	CONTOUR,power,time,period,/NOERASE,POSITION=pos2, $
		XRANGE=xrange,YRANGE=yrange,/YTYPE, $
		YTICKS=N_ELEMENTS(ytickv)-1,YTICKV=ytickv, $
		LEVELS=levels,C_COLORS=colors,/FILL, $
		XTITLE='Time (year)',YTITLE='Period (years)', $
		TITLE='b) Wavelet Power Spectrum (contours at 0.5,1,2,4!Uo!NC!U2!N)'
; significance contour, levels at -99 (fake) and 1 (significant)
	CONTOUR,signif,time,period,/OVERPLOT,LEVEL=1,THICK=2, $
		C_LABEL=1,C_ANNOT='90%',C_CHARSIZE=1
; cone-of-influence, anything "below" is dubious
	x = [time(0),time,MAX(time)]
	y = [MAX(period),coi,MAX(period)]
	color = 4
	POLYFILL,x,y,ORIEN=+45,SPACING=0.5,COLOR=color,NOCLIP=0,THICK=1
	POLYFILL,x,y,ORIEN=-45,SPACING=0.5,COLOR=color,NOCLIP=0,THICK=1
	PLOTS,time,coi,COLOR=color,NOCLIP=0,THICK=1

;--- Plot global wavelet spectrum
	pos3 = [0.74,pos2(1),0.95,pos2(3)]
	blank = REPLICATE(' ',29)
	PLOT,global_ws,period,/NOERASE,POSITION=pos3, $
		THICK=2,XSTYLE=10,YSTYLE=9, $
		YRANGE=yrange,/YTYPE,YTICKLEN=-0.02, $
		XTICKS=2,XMINOR=2, $
		YTICKS=N_ELEMENTS(ytickv)-1,YTICKV=ytickv,YTICKNAME=blank, $
		XTITLE='Power (!Uo!NC!U2!N)',TITLE='c) Global'
	;;--added by JSHEPT on 2008-12-02
	PLOTs,PSD_vect_FFT,period, $
		LineStyle=1,NoClip=0
	;;--added by JSHEPT on 2008-12-02
	OPLOT,global_signif,period,LINES=2
	XYOUTS,1.7,60,'95%'

;--- Plot 2--8 yr scale-average time series
	pos4 = [pos1(0),0.05,pos1(2),0.25]
	PLOT,time,scale_avg,/NOERASE,POSITION=pos4, $
		XRANGE=xrange,YRANGE=[0,MAX(scale_avg)*1.25],THICK=2, $
		XTITLE='Time (year)',YTITLE='Avg variance (!Uo!NC!U2!N)', $
		TITLE='d) 2-8 yr Scale-average Time Series'
	OPLOT,xrange,scaleavg_signif+[0,0],LINES=1

IF (printfile) THEN DEVICE,/CLOSE
END
