
_configurar:

;HolaMundo_v1.c,1 :: 		void configurar(){
;HolaMundo_v1.c,3 :: 		TRISD = 0;
	CLRF        TRISD+0 
;HolaMundo_v1.c,4 :: 		PORTD = 0;
	CLRF        PORTD+0 
;HolaMundo_v1.c,5 :: 		}
L_end_configurar:
	RETURN      0
; end of _configurar

_main:

;HolaMundo_v1.c,7 :: 		void main() {
;HolaMundo_v1.c,8 :: 		configurar();
	CALL        _configurar+0, 0
;HolaMundo_v1.c,9 :: 		while(1)
L_main0:
;HolaMundo_v1.c,12 :: 		PORTD = PORTD + 1;
	INCF        PORTD+0, 1 
;HolaMundo_v1.c,15 :: 		delay_ms(200);
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
;HolaMundo_v1.c,16 :: 		}
	GOTO        L_main0
;HolaMundo_v1.c,18 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
