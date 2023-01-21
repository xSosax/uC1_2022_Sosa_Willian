;-------------------------------------------------------------------------------
;@file		P1-Corrimiento_Leds.s
;@brief		Es un corrimiento de leds pares e impares, se inicia cuando se presiona el pulsador ...
;		... del uC PIC18F57Q84 y se detiene cuando se vuelve a presionar.
;@date		14/01/2023
;@author	WILLIANS R. SOSA RAMIREZ 
;@frequency	f = 4MHz ---- >>>1Tcy = 1us<<<
;@ide		MPLAB X IDE v6.00
;-------------------------------------------------------------------------------   
    
PROCESSOR 18F57Q84
#include "Bit_Config.inc"
#include "retardos.inc"
#include <xc.inc>

PSECT resecVect,class=CODE,reloc=2
resetVect: 
    GOTO Main

PSECT CODE  
    
Main:
    CALL    CONFI_OSC,1
    CALL    CONFI_PORT,1
  
INICIO:
    BTFSC   PORTA,3,0	    ;esta presionado el pulsador?
    GOTO    APAGADO
    
Leds_pares:
    BCF     LATE,0,1	    
    MOVLW   1		    ;w = 00000001
    MOVWF   0x502,a	    ;w --> 0x502
    
LOOP:
    RLNCF   0x502,f,a	    ;00000010
    MOVF    0X502,w,a	    ;0x502 --> w
    BANKSEL PORTC
    MOVWF   PORTC,1	    ;0x502 --> PORTC
    BSF     LATE,1,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1   ;retardo de 1/2 segundo
    BTFSC   PORTA,3,0	    ;esta presionado el pulsador?
    GOTO    Continua_par
    GOTO    PARE_1 
    
Continua_par:
    BTFSC   0x502,7,0	    ;el led 7 del registro 0x502 esta a cero?
    GOTO    Leds_impares
    RLNCF   0x502,f,a	    ;rotacion a la izquierda
    MOVF    0X502,w,a	    ;0x502 --> w
    GOTO    LOOP
     
Leds_impares:
    BCF     LATE,1,1
    MOVLW   1		    ;w = 1
    MOVWF   0X502,a	    ;w --> 0x502
    
LOOP_2:
    BANKSEL PORTC
    MOVWF   PORTC,1	    ;w --> PORTC
    BSF     LATE,0,1
    CALL    Delay_250ms,1   ;retardo de 1/4 segundo
    BTFSC   PORTA,3,0	    ;esta presionado el pulsador?
    GOTO    Continua_impar
    GOTO    PARE_2
    
Continua_impar:
    BTFSC   0x502,6,0	    ;el led 6 del registro 0x502 es cero?
    GOTO    Leds_pares
    RLNCF   0x502,f,a	    ;rotar a la izquierda
    RLNCF   0x502,f,a	    ;rotar a la izquierda
    MOVF    0X502,w,a	    ;0x502 --> w
    GOTO    LOOP_2
    
APAGADO:
    CLRF    PORTC,1	    ;PORTC = 0
    GOTO    INICIO
    
PARE_1:
    RETARDO:
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms	    ;retardo de 1 segundo
    CAPTURA:
    MOVF    0X502,w,a	    ;0x502 --> w
    BANKSEL PORTC
    MOVWF   PORTC,1	    ;w --> PORTC
    BSF     LATE,1,1
    BTFSC   PORTA,3,0	    ;esta presionado el pulsador?
    GOTO    CAPTURA
    GOTO    Continua_par
   
PARE_2:
    RETARDO_2:
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms	    ;retardo de 1 segundo
    CAPTURA_2: 
    MOVF    0X502,w,a	    ;0x502 --> w
    BANKSEL PORTC
    MOVWF   PORTC,1	    ;ox502 --> PORTC
    BSF     LATE,0,1
    BTFSC   PORTA,3,0	    ;si preionamos PORTA = 0
    GOTO    CAPTURA_2
    GOTO    Continua_impar
    
CONFI_OSC:
    ;CONFIGURACION DEL OSCILADOR INTERNO A UNA FRECUENCIA DE 4MHZ
    BANKSEL OSCCON1
    MOVLW   0x60	;selecccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1
    RETURN
    
CONFI_PORT:
    ;Configuracion de puertos para los leds de corrimiento
    BANKSEL PORTC   
    CLRF    PORTC,1	;PORTC = 0
    CLRF    LATC,1	;LATC = 0 -- Leds off
    CLRF    ANSELC,1	;ANSELC<7:0> = 0 -- digital
    CLRF    TRISC,1	;TRISC<0:7> = 0 -- salida
    ;Configuracion de leds para visualizar cuando se da el corrimiento par o impar.
    BANKSEL PORTE   
    CLRF    PORTE,1	;PORTE = 0
    BCF     LATE,0,1	;LATE = 1 -- Leds off
    BCF     LATE,1,1
    CLRF    ANSELE,1	;ANSELC<7:0> = 0 -- digital
    CLRF    TRISE,1	;TRISA<0:7> = 0 -- salida
    ;Configuracion de butom
    BANKSEL PORTA
    CLRF    PORTA,1	
    CLRF    ANSELA,1	;ANSELA<7:0> = 0 -- digital
    BSF	    TRISA,3,1	;TRISA<3> = 1 -- entrada
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up
    RETURN  
 
END resetVect


