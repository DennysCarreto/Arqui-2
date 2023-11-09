
_configurar:

;Temperatura.c,3 :: 		void configurar() {
;Temperatura.c,5 :: 		ADCON0 = 0;
	CLRF        ADCON0+0 
;Temperatura.c,6 :: 		ADCON1 = 0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;Temperatura.c,7 :: 		ADCON2 = 0x80;
	MOVLW       128
	MOVWF       ADCON2+0 
;Temperatura.c,9 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;Temperatura.c,10 :: 		PIR1 = 0;
	CLRF        PIR1+0 
;Temperatura.c,11 :: 		PIE1 = 0x40;
	MOVLW       64
	MOVWF       PIE1+0 
;Temperatura.c,12 :: 		IPR1 = 0x40;
	MOVLW       64
	MOVWF       IPR1+0 
;Temperatura.c,14 :: 		TRISA = 1;
	MOVLW       1
	MOVWF       TRISA+0 
;Temperatura.c,15 :: 		TRISC = 0;
	CLRF        TRISC+0 
;Temperatura.c,16 :: 		TRISD = 0;
	CLRF        TRISD+0 
;Temperatura.c,18 :: 		PORTA = 0;
	CLRF        PORTA+0 
;Temperatura.c,19 :: 		PORTC = 0;
	CLRF        PORTC+0 
;Temperatura.c,20 :: 		PORTD = 0;
	CLRF        PORTD+0 
;Temperatura.c,22 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;Temperatura.c,23 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;Temperatura.c,24 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_interrupt:

;Temperatura.c,26 :: 		void interrupt(){
;Temperatura.c,27 :: 		GO_DONE_bit = 0;
	BCF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;Temperatura.c,28 :: 		ADIF_bit = 0;
	BCF         ADIF_bit+0, BitPos(ADIF_bit+0) 
;Temperatura.c,29 :: 		temp = (ADRESH *256 + ADRESL) * 0.4887;
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	CALL        _int2double+0, 0
	MOVLW       227
	MOVWF       R4 
	MOVLW       54
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;Temperatura.c,30 :: 		PORTD = temp;
	MOVF        R0, 0 
	MOVWF       PORTD+0 
;Temperatura.c,33 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;Temperatura.c,34 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;Temperatura.c,36 :: 		void main() {
;Temperatura.c,37 :: 		configurar();
	CALL        _configurar+0, 0
;Temperatura.c,38 :: 		while(1);
L_main0:
	GOTO        L_main0
;Temperatura.c,39 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
