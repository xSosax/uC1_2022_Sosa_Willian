;-------------------------------------------------------------------------------
;@file		P2-Display_7SEG.s
;@brief		Es un programa que muestra valores alfanumericos en un display 7seg anodo comun ...
;		... sino esta presionado muestra los numeros, si se presiona muestra las letras.
;@date		14/01/2023
;@author	WILLIANS R. SOSA RAMIREZ 
;@frequency	f = 4MHz ---- >>>1Tcy = 1us<<<
;@ide		MPLAB X IDE v6.00
;-------------------------------------------------------------------------------   
    
PROCESSOR 18F57Q84
#include "Bit_Config.inc"
#include "retardos.inc"
#include <xc.inc>

PSECT resetVect,class=CODE,reloc=2  
resetVect:
    GOTO Main 
    
PSECT CODE 

Main:
    
Config_OSC:
    ;CONFIGURACION DEL OSCILADOR INTERNO A UNA FRECUENCIA DE 4MHZ
    BANKSEL OSCCON1 
    MOVLW   0x60	;selecccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1
        
CONFI_PORT:       
    BANKSEL PORTA       
    CLRF    PORTA,1     ;PORTA = 0
    CLRF    ANSELA,1    ;ANSELA<7:0> = 0  --- Port A digital
    BSF     TRISA,3,1   ;El (bit(3)=1) es una entrada 
    BSF     WPUA,3,1    ;Activamos la resistencia RA3 
    
Boton:  
    BTFSC   PORTA,3,1
    GOTO    No_Presionado
    
Si_Presionado:
;Valores <A-F> --> RD0(a),RD1(b),RD2(c),RD3(d),RD4(e),RD5(f),RD6(g)  
;Letra_A
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    BSF      PORTD,3,1
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSC    PORTA,3,1	;esta apagado el pulsador?
    GOTO     No_Presionado
  
;Letra_B
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x03	;00000011B --> w
    MOVWF    PORTD,1	;0x03 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSC    PORTA,3,1	;esta apagado el pulsador?
    GOTO     No_Presionado  
  
;Letra_C
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x46	;01000110B --> w
    MOVWF    PORTD,1	;0x46 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSC    PORTA,3,1	;esta apagado el pulsador?
    GOTO     No_Presionado 
  
;Letra_D
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x21	;00100001B --> w 
    MOVWF    PORTD,1	;0x21 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSC    PORTA,3,1	;esta apagado el pulsador?
    GOTO     No_Presionado
  
;Letra_E  
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x06	;00000110B --> w
    MOVWF    PORTD,1	;0x06 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSC    PORTA,3,1	;esta apagado el pulsador?
    GOTO     No_Presionado 
  
;Letra_F
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x0E	;00001110B --> w
    MOVWF    PORTD,1	;0x0E --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSC    PORTA,3,1	;esta apagado el pulsador?
    GOTO     No_Presionado 
    GOTO     Si_Presionado
    
No_Presionado:
;Valores <0-9> --> RD0(a),RD1(b),RD2(c),RD3(d),RD4(e),RD5(f),RD6(g) 
;Numero_0
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x40	;01000000B --> w 
    MOVWF    PORTD,1	;0x40 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado   
    
;Numero_1
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0xf9	;11111001B  --> w
    MOVWF    PORTD,1	;0xF9 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
     
;Numero_2
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x24	;00100100B --> w
    MOVWF    PORTD,1	;0x24 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
  
;Numero_3
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x30	;00110000B --> w
    MOVWF    PORTD,1	;0x30 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
  
;Numero_4
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x19	;00011001B --> w
    MOVWF    PORTD,1	;0x19 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
  
;Numero_5 
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x12	;00010010B --> w
    MOVWF    PORTD,1	;0x12 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
     
;Numero_6
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x02	;00000010B --> w
    MOVWF    PORTD,1	;0x02 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
  
;Numero_7
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x78	;01111000B --> w
    MOVWF    PORTD,1	;0x78 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
  
;Numero_8
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x00	;00000000B --> w
    MOVWF    PORTD,1	;0x00 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
  
;Numero_9
    BANKSEL  PORTD
    CLRF     PORTD,1	;PORTD = 0
    CLRF     LATD,1
    CLRF     ANSELD,1
    CLRF     TRISD,1
    MOVLW    0x18	;00011000B --> w
    MOVWF    PORTD,1	;0x18 --> PORTD
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms
    CALL     Delay_250ms ;retardo de 1 segundo
    GOTO     Boton
    BTFSS    PORTA,3,1	;esta apagado el pulsador?
    GOTO     Si_Presionado 
    RETURN

END resetVect


