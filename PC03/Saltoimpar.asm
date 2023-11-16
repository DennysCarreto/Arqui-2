PROCESSOR 18f4550
#include  <xc.inc>
    // CONFIGURACIONES DE PILON
    CONFIG PBADEN = OFF ; PORTB ANALOG DIGITAL ENABLE= OFF
    CONFIG WDT = OFF	    ;Watch docg timer
    CONFIG WDTPS = 32768
    CONFIG FOSC = HS	    ;Oscilador de 8Mhz
    CONFIG FCMEN = OFF
    CONFIG IESO = OFF

psect	resetVec, global, reloc=2, class=CODE, delta=1
 resetVec:
    org	    0x00
    goto    inicio
 psect hi_int_vec, global, reloc=2, class=CODE, delta=1
    org     0x08
    goto    HighIsrHandler
 psect inicio, global, reloc=2, class=CODE, delta=1;
    org	    0x20
 inicio:
    ;-----------------Configuración de registros-----------------
    flag   set 0x60
    movlw   0x01
    movwf   flag
    movlw   0x06
    movwf   T0CON	    ;T0CON = 0x06  (que es usar pre-escala 1:128)
    movlw   0xCB
    movwf   TMR0L
    movlw   0xF3
    movwf   TMR0H

	
    ;-----------------Configuracion del puerto--------------------
    setf    ADCON1
    clrf    TRISD	    ;COnfigurar puertos como salida
    clrf    PORTD
    clrf    TRISB
    
    ;----------------Configuración interrupciones----------------
    movlw   0xC0
    movwf   INTCON
    movlw   0x04
    movwf   INTCON2
    bsf	    INTCON, 5
    bsf	    T0CON, 7
    movlw   0x01
    movwf   PORTD
    
    ;---------------------Programa pincipal---------------------
 checkDirection:
 ;comprueba la direccion del corrimiento con el
 ;cambio del bit 0 o 7
    btfsc   PORTD, 6
    goto    flagRight
    btfsc   PORTD, 0
    goto    flagLeft
    recheck:
    goto    checkDirection
 
 flagRight:
 ;activa la direccion del corrimiento a la derecho
    movlw   0x00
    movwf   flag
    goto    recheck
    
 flagLeft:
 ;activa el corrimiento a la izquierda
    movlw   0x01
    movwf   flag
    goto    recheck
 
 HighIsrHandler:
    bcf	    T0CON, 7	    ;TMR0ON = 0
    bcf	    INTCON, 5	    ;TMR0IE = 0
    bcf	    INTCON, 2	    ;TMR0IF = 0
    
    ;compruaba la bandera de direccion para ver la 
    ;direccion del corrimiento
    btfss   flag, 0
    goto    shiftRight
    goto    shiftLeft
    
    
    
    reconfig:
    movlw   0xCB
    movwf   TMR0L
    movlw   0xF3
    movwf   TMR0H
    bsf	    INTCON, 5	    ;TMR0IE = 1
    movlw   0x86
    movwf   T0CON	    ;T0CON = 0x05  (que es usar pre-escala 1:128) y encenderlo de nuevo
    retfie  1
    
    shiftRight:
    rrncf   PORTD
    rrncf   PORTD
    goto    reconfig
    
    shiftLeft:
    rlncf   PORTD
    rlncf   PORTD
    goto    reconfig
    
    end	    resetVec





