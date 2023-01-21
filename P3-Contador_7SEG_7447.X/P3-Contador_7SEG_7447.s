;-------------------------------------------------------------------------------
;@file		P3-Contador_7SEG_7447.s
;@brief		Es un contador ascendente cuando no esta presionado el pulsador del uC  ...
;		... y empieza a descender si esta presionado. Utilizando un decodificador BCD 7seg 7447.
;@date		14/01/2023
;@author	WILLIANS R. SOSA RAMIREZ 
;@frequency	f = 4MHz ---- >>>1Tcy = 1us<<<
;@ide		MPLAB X IDE v6.00
;-------------------------------------------------------------------------------   
    
PROCESSOR 18F57Q84
#include "Bit_Config.inc"
#include "retardos.inc"
#include <xc.inc>
    
PSECT resetVect, class=CODE, reloc=2
resetVect: 
    GOTO Main

PSECT CODE
Main:
    CALL    CONFI_OSC,1
    CALL    CONFI_PORT,1
   
INICIO:
    BTFSC   PORTA,3,0	;esta presionado el pulsador?
    GOTO    ASCENDENTE
     
DESCENDENTE:
    MOVLW   0		;w = 0
    MOVWF   0x502,a	;w --> 0x502
    MOVLW   0		;w = 0
    MOVWF   0x503,a	;w --> 0x503
    
VERIFICA_2:   
    BTFSS   STATUS,4,a	;esta en 1 el 4 bit del registro STATUS
    GOTO    CONTINUA_9_0
    BTFSS   0x502,4,a	;esta en 1 el 4 bit del registro 0x502?
    GOTO    CONTINUA_9_0
    BTFSS   0x502,7,a	;esta en 1 el 7 bit del registro 0x502?
    GOTO    CONTINUA_9_0
    DECF    0x503,1,0	;decrementar el valor del registro 0x503
    MOVLW   9		;w = 9
    MOVWF   0x502,a	;w --> 0x502
    BTFSS   0x503,4,a	;esta en 1 el 4 bit del registro 0x503
    GOTO    CONTINUA_9_0
    BTFSS   0x503,7,a	;esta en 1 el 7 bit del registro 0x503
    GOTO    CONTINUA_9_0
    MOVLW   9		;w = 9
    MOVWF   0x502,a	;w --> 0x502
    MOVLW   9		;w = 9
    MOVWF   0x503,a	;w --> 0x503
    GOTO    VERIFICA_2
    
CONTINUA_9_0: 
    MOVF    0x502,w,a	;0x502 --> w
    MOVWF   PORTB,0	;w --> PORTB
    MOVF    0x503,w,a	;0x503 --> w
    MOVWF   PORTD,0	;w --> PORTD
    BTFSC   PORTA,3,0	;esta presionado el pulsador?
    GOTO    VERIFICA
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1 ;retardo de 1 segundo
    BTFSC   PORTA,3,0	;esta presionado el pulsador?
    GOTO    VERIFICA
    DECF    0x502,f,a	;decrementar el valor del registro 0x502
    GOTO    VERIFICA_2
   
ASCENDENTE:
    MOVLW   0		;w = 0
    MOVWF   0x502,a	;w --> 0x502
    MOVLW   0		;w = 0
    MOVWF   0x503,a	;w --> 0x503
    
VERIFICA:  
    BTFSS   0x502,1,a	;esta en 1 el 1 bit del registro 0x502
    GOTO    CONTINUA_0_9
    BTFSS   0x502,3,a	;esta en 1 el 3 bit del registro 0x502
    GOTO    CONTINUA_0_9
    INCF    0x503,1,0	;incrementa el valor del registro 0x503
    CLRF    0x502,a	;0x502 = 0
    BTFSS   0x503,1,a	;esta en 1 el 1 bit del registro 0x503
    GOTO    CONTINUA_0_9
    BTFSS   0x503,3,a	;esta en 1 el 3 bit del registro 0x503
    GOTO    CONTINUA_0_9
    CLRF    0x503,a	;0x503 = 0
    CLRF    0x502,a	;0x502 = 0
    GOTO    VERIFICA
    
CONTINUA_0_9: 
    MOVF    0x502,w,a	;0x502 --> w
    MOVWF   PORTB,0	;w --> PORTB
    MOVF    0x503,w,a	;0x503 --> w
    MOVWF   PORTD,0	;w --> PORTD
    BTFSS   PORTA,3,0	;no esta presionado el pulsador?
    GOTO    VERIFICA_2
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1 ;retardo de 1 segundo
    BTFSS   PORTA,3,0	;no esta presionado el pulsador?
    GOTO    VERIFICA_2
    
INCREMENTO:
    INCF    0x502,f,a	;incrementa el valor del registro 0x502
    GOTO    VERIFICA
       
CONFI_OSC:  
    BANKSEL OSCCON1
    MOVLW   0x60	;selecccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1
    RETURN
    
CONFI_PORT:
    ;Configuracion de puertos para los leds de corrimiento
    BANKSEL PORTB   
    CLRF    PORTB,1	;PORTB = 0
    CLRF    LATB,1	;LATB = 0 -- Leds apagado
    CLRF    ANSELB,1	;ANSELB = 0 -- Digital
    CLRF    TRISB,1
    ;Configuracion de puertos para los leds de corrimiento
    BANKSEL PORTD   
    CLRF    PORTD,1	;PORTD = 0
    CLRF    LATD,1	;LATD = 0 -- Leds apagado
    CLRF    ANSELD,1	;ANSELD = 0 -- Digital
    CLRF    TRISD,1
    ;Configuracion de butom
    CLRF    PORTA,1	
    CLRF    ANSELA,1	;ANSELA = 0 -- Digital
    BSF	    TRISA,3,1	;TRISA = 1 --> entrada
    BSF	    WPUA,3,1	;Activo la reistencia Pull-Up
    RETURN
   
END resetVect


