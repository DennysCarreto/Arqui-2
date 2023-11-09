
_configurar:

;EjemploADC.c,1 :: 		void configurar() {
;EjemploADC.c,3 :: 		ADCON0 = 0;
	CLRF        ADCON0+0 
;EjemploADC.c,4 :: 		ADCON1 = 0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;EjemploADC.c,5 :: 		ADCON2 = 0x80;
	MOVLW       128
	MOVWF       ADCON2+0 
;EjemploADC.c,7 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;EjemploADC.c,8 :: 		PIR1 = 0;
	CLRF        PIR1+0 
;EjemploADC.c,9 :: 		PIE1 = 0x40;
	MOVLW       64
	MOVWF       PIE1+0 
;EjemploADC.c,10 :: 		IPR1 = 0x40;
	MOVLW       64
	MOVWF       IPR1+0 
;EjemploADC.c,12 :: 		TRISA = 1;
	MOVLW       1
	MOVWF       TRISA+0 
;EjemploADC.c,13 :: 		TRISC = 0;
	CLRF        TRISC+0 
;EjemploADC.c,14 :: 		TRISD = 0;
	CLRF        TRISD+0 
;EjemploADC.c,16 :: 		PORTA = 0;
	CLRF        PORTA+0 
;EjemploADC.c,17 :: 		PORTC = 0;
	CLRF        PORTC+0 
;EjemploADC.c,18 :: 		PORTD = 0;
	CLRF        PORTD+0 
;EjemploADC.c,20 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;EjemploADC.c,21 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;EjemploADC.c,22 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_interrupt:

;EjemploADC.c,24 :: 		void interrupt(){
;EjemploADC.c,25 :: 		GO_DONE_bit = 0;
	BCF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;EjemploADC.c,26 :: 		ADIF_bit = 0;
	BCF         ADIF_bit+0, BitPos(ADIF_bit+0) 
;EjemploADC.c,27 :: 		PORTD = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       PORTD+0 
;EjemploADC.c,28 :: 		PORTC = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       PORTC+0 
;EjemploADC.c,29 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;EjemploADC.c,30 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;EjemploADC.c,32 :: 		void main() {
;EjemploADC.c,33 :: 		configurar();
	CALL        _configurar+0, 0
;EjemploADC.c,34 :: 		while(1);
L_main0:
	GOTO        L_main0
;EjemploADC.c,35 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
