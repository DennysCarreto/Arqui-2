
_configurar:

;HolaMundo_v3.c,3 :: 		void configurar(){
;HolaMundo_v3.c,5 :: 		T0CON = 0x03;
	MOVLW       3
	MOVWF       T0CON+0 
;HolaMundo_v3.c,6 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;HolaMundo_v3.c,7 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;HolaMundo_v3.c,8 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;HolaMundo_v3.c,10 :: 		TRISB = 0X01;
	MOVLW       1
	MOVWF       TRISB+0 
;HolaMundo_v3.c,11 :: 		PORTB = 0;
	CLRF        PORTB+0 
;HolaMundo_v3.c,12 :: 		TRISD = 0;
	CLRF        TRISD+0 
;HolaMundo_v3.c,13 :: 		PORTD = 0;
	CLRF        PORTD+0 
;HolaMundo_v3.c,15 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;HolaMundo_v3.c,16 :: 		INTCON2 = 0xF4;
	MOVLW       244
	MOVWF       INTCON2+0 
;HolaMundo_v3.c,17 :: 		INT0IE_bit = 1;
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;HolaMundo_v3.c,21 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_interrupt:

;HolaMundo_v3.c,23 :: 		void interrupt() {
;HolaMundo_v3.c,24 :: 		if (t0IF_bit == 1){
	BTFSS       T0IF_bit+0, BitPos(T0IF_bit+0) 
	GOTO        L_interrupt0
;HolaMundo_v3.c,25 :: 		TMR0ON_bit = 0;
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;HolaMundo_v3.c,26 :: 		T0IE_bit = 0;
	BCF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;HolaMundo_v3.c,27 :: 		T0IF_bit = 0;
	BCF         T0IF_bit+0, BitPos(T0IF_bit+0) 
;HolaMundo_v3.c,28 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;HolaMundo_v3.c,29 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;HolaMundo_v3.c,30 :: 		RD0_bit = !RD0_bit;
	BTG         RD0_bit+0, BitPos(RD0_bit+0) 
;HolaMundo_v3.c,31 :: 		T0CON = 0x83;
	MOVLW       131
	MOVWF       T0CON+0 
;HolaMundo_v3.c,32 :: 		}
	GOTO        L_interrupt1
L_interrupt0:
;HolaMundo_v3.c,34 :: 		if(INT0IF_bit == 1){
	BTFSS       INT0IF_bit+0, BitPos(INT0IF_bit+0) 
	GOTO        L_interrupt2
;HolaMundo_v3.c,35 :: 		INT0IE_bit = 0;
	BCF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;HolaMundo_v3.c,36 :: 		INT0IF_bit = 0;
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;HolaMundo_v3.c,37 :: 		if (encender == 0){
	MOVLW       0
	XORWF       _encender+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt10
	MOVLW       0
	XORWF       _encender+0, 0 
L__interrupt10:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;HolaMundo_v3.c,38 :: 		encender = 1;
	MOVLW       1
	MOVWF       _encender+0 
	MOVLW       0
	MOVWF       _encender+1 
;HolaMundo_v3.c,39 :: 		T0IE_bit = 1;
	BSF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;HolaMundo_v3.c,40 :: 		TMR0ON_bit = 1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;HolaMundo_v3.c,41 :: 		}
	GOTO        L_interrupt4
L_interrupt3:
;HolaMundo_v3.c,43 :: 		encender = 0;
	CLRF        _encender+0 
	CLRF        _encender+1 
;HolaMundo_v3.c,44 :: 		T0IE_bit = 0;
	BCF         T0IE_bit+0, BitPos(T0IE_bit+0) 
;HolaMundo_v3.c,45 :: 		TMR0ON_bit = 0;
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;HolaMundo_v3.c,46 :: 		}
L_interrupt4:
;HolaMundo_v3.c,47 :: 		INT0IE_bit = 1;
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;HolaMundo_v3.c,48 :: 		}
L_interrupt2:
;HolaMundo_v3.c,49 :: 		}
L_interrupt1:
;HolaMundo_v3.c,51 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt

_main:

;HolaMundo_v3.c,53 :: 		void main() {
;HolaMundo_v3.c,54 :: 		configurar();
	CALL        _configurar+0, 0
;HolaMundo_v3.c,55 :: 		while  (1);
L_main5:
	GOTO        L_main5
;HolaMundo_v3.c,56 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
