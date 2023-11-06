PROCESSOR 18F4550
#include <xc.inc>

psect resetVec, global, reloc = 2, class=CODE, delta=1 //Son banderas requeridas

resetVec:
    org 0x00	    // vector RESET
    goto inicio	    // Etiqueta 'inicio'
    org 0x20	    // posicion 32 de memoria de programa

    psect inicio, global, reloc = 2, class=CODE, delta=1 //Para definir etiquetas
inicio:
    contador set 0x60
    contador2 set 0x61
    // inicializar variables
    movlw   0xff	// w = 255
    movwf   contador	// contador = w = 255
    movlw   0xff
    movwf   contador2
    // configurar
    clrf    TRISD	// TRISD = 0000 0000, pone todo el puerto a 0 => configurado como salida
    // movlw   0x01	// Empezar en el puerto numero 1 = 0x01
    movlw   0x80	// Empezar en el puerto numero 8 = 0x80
    movwf    PORTD	// PORTD = 0000 0001, pone todo el puerto a 1 => valor inicial 1
    
retardo:
    decfsz  contador,1	    // contador --, si es 0 se salta la instruccion
    goto    retardo
    movlw   0xff
    movwf   contador
    //Contador 2
    decfsz  contador2,1    //Contador2 --
    goto    retardo
    movlw   0xff
    movwf   contador2  
    // Rotar a la izquierda
    // rlncf   PORTD, 1
    // Rotar a la derecha
    rrncf   PORTD, 1
    goto    retardo
    end	    resetVec