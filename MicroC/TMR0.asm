
_configurar:

;HolaMundo_v2TIMER0.c,1 :: 		void configurar(){
;HolaMundo_v2TIMER0.c,3 :: 		T0CON = 0X68;
	MOVLW       104
	MOVWF       T0CON+0 
;HolaMundo_v2TIMER0.c,4 :: 		TMR0L = 0XEB;
	MOVLW       235
	MOVWF       TMR0L+0 
;HolaMundo_v2TIMER0.c,5 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;HolaMundo_v2TIMER0.c,7 :: 		ADCON1 = 0XFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;HolaMundo_v2TIMER0.c,8 :: 		TRISA = 0X10;
	MOVLW       16
	MOVWF       TRISA+0 
;HolaMundo_v2TIMER0.c,9 :: 		TRISD = 0;
	CLRF        TRISD+0 
;HolaMundo_v2TIMER0.c,10 :: 		PORTD = 0;
	CLRF        PORTD+0 
;HolaMundo_v2TIMER0.c,12 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;HolaMundo_v2TIMER0.c,13 :: 		INTCON2 = 0X84;
	MOVLW       132
	MOVWF       INTCON2+0 
;HolaMundo_v2TIMER0.c,14 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;HolaMundo_v2TIMER0.c,16 :: 		TMR0ON_bit = 1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;HolaMundo_v2TIMER0.c,17 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_main:

;HolaMundo_v2TIMER0.c,19 :: 		void main() {
;HolaMundo_v2TIMER0.c,20 :: 		configurar();
	CALL        _configurar+0, 0
;HolaMundo_v2TIMER0.c,21 :: 		while(1)
L_main0:
;HolaMundo_v2TIMER0.c,22 :: 		{  PORTD = TMR0ON;
	MOVLW       7
	MOVWF       PORTD+0 
;HolaMundo_v2TIMER0.c,27 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
;HolaMundo_v2TIMER0.c,28 :: 		}
	GOTO        L_main0
;HolaMundo_v2TIMER0.c,29 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
