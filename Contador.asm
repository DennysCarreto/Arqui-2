PROCESSOR 18F4550
#include <xc.inc>
    CONFIG PBADEN = OFF
    CONFIG WDT = OFF
    CONFIG WDTPS = 32768
    CONFIG FOSC = HS
    CONFIG FCMEN = OFF
    CONFIG IESO = OFF
    

psect resetVec, global, reloc = 2, class=CODE, delta=1 //Son banderas requeridas
resetVec:
    org 0x00	    // vector RESET
    goto inicio	    // Etiqueta 'inicio'
   
psect hi_int_vec, global, reloc = 2, class=CODE, delta=1 //Son banderas requeridas
    org	0x08
    goto HighIsrHandler
    
    
psect inicio, global, reloc = 2, class=CODE, delta=1 //Para definir etiquetas
org 0x20	    // posicion 32 de memoria de programa
inicio:
   // Configuracion de registros
   // Connfiguracion de TMR0
   movlw    0x03
   movwf    T0CON
   movlw    0xDB
   movwf    TMR0L
   movlw    0x0B
   movwf    TMR0H
   // configurar el puerto
   setf	    ADCON1
   clrf	    TRISD
   clrf	    PORTD
   // COnfigurar interrupciones
   movlw    0xc0
   movwf    INTCON
   movlw    0x84
   movwf    INTCON2
   bsf	    INTCON, 5
   bsf	    T0CON, 7
   // Principal
ciclo:
    goto ciclo

// bloque de interrupcion
HighIsrHandler:
    bcf	    T0CON, 7 
    bcf	    INTCON, 5
    bcf	    INTCON, 2
    btg	    PORTD, 0
    //aaaaaaaaaaaaaaaaa
    movlw   0x03
    movwf   T0CON
    movlw   0xDB
    movwf   TMR0L
    movlw   0x0B
    movwf   TMR0H
    //aaaaaaaaaaaaaaaaaaa
    movlw   0xc0
    movwf   INTCON
    movlw   0x84
    movwf   INTCON2
    bsf	    INTCON, 5
    bsf	    T0CON, 7
    retfie  1
    end	    resetVec