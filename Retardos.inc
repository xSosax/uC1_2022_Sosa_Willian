;-------------------------------------------------------------------------------
;@file		retardos.inc
;@brief		Este es una libreria de retardos.
;@date		09/01/2023
;@author	WILLIANS R. SOSA RAMIREZ 
;@frequency	f = 4MHz ---- >>>1Tcy = 1us<<<
;@ide		MPLAB X IDE v6.00
;-------------------------------------------------------------------------------   
    
PSECT udata_acs
contador1: DS 1		      ; reserva 1 byte en access ram
contador2: DS 1		      ; reserva 1 byte en access ram
  
PSECT code

; --------------- retardo_1 >10us< ---------------
; T = (6+4k)*Tcy = 10us

Delay_10us:                   ;  2Tcy --- CALL
    MOVLW   1                 ;  1TCY --- k=1
    MOVWF   contador1,0       ;  1TCY
Loop_a:   
    NOP			      ;  k*Tcy
    DECFSZ  contador1,1,0     ;  (k-1) + 3Tcy
    GOTO    Loop_a	      ;  (k-1)*2Tcy
    RETURN                    ;  2Tcy
    
; --------------- retardo_2 >25us< ---------------
; T = (6+4k)*Tcy = 26us
    
Delay_25us:	              ;  2Tcy --- CALL
    MOVLW   5                 ;  1Tcy --- k=5
    MOVWF   contador1,0       ;  1Tcy
Loop_b:   
    NOP                       ;  k*Tcy
    DECFSZ  contador1,1,0     ;  (k-1) + 3Tcy
    GOTO    Loop_b            ;  (k-1)*2Tcy
    RETURN                    ;  2Tcy
    
; --------------- retardo_3 >50us< ---------------
; T = (6+4k)*Tcy = 50us

Delay_50us:                   ;  2Tcy --- CALL
    MOVLW   11                ;  1Tcy --- k=11
    MOVWF   contador1,0       ;  1Tcy
Loop_c:
    NOP                       ;  k*Tcy
    DECFSZ  contador1,1,0     ;  (k-1) + 3Tcy
    GOTO    Loop_c            ;  (k-1)*2Tcy
    RETURN                    ;  2Tcy
                                                                    
; --------------- retardo_4 >100us< ---------------           
; T = (6+4k)*Tcy = 102us
    
Delay_100us:                  ;  2Tcy --- CALL
    MOVLW   24                ;  1Tcy --- k=24
    MOVWF   contador1,0       ;  1Tcy
Loop_d:
    NOP                       ;  1*Tcy
    DECFSZ  contador1,1,0     ;  (k-1) + 3Tcy
    GOTO    Loop_d            ;  (k-1)*2Tcy
    RETURN                    ;  2Tcy
      
; --------------- retardo_5 >200us< ---------------
; T = (6+4k)*Tcy = 202us
    
Delay_200us:                  ;  2Tcy --- CALL
    MOVLW   49                ;  1Tcy --- k=49
    MOVWF   contador1,0       ;  1Tcy
Loop_e:
    NOP                       ;  k*Tcy
    DECFSZ  contador1,1,0     ;  (k-1) + 3Tcy
    GOTO    Loop_e            ;  (k-1)*2Tcy
    RETURN                    ;  2Tcy
 
; --------------- retardo_6 >250us< ---------------
; T = (6+4k)*Tcy = 250us
    
Delay_250us:		      ;  2Tcy --- CALL
    MOVLW   61                ;  1Tcy --- k=61
    MOVWF   contador1,0       ;  1Tcy
Loop_f:
    NOP                       ;  k*Tcy
    DECFSZ  contador1,1,0     ;  (k-1) + 3Tcy
    GOTO    Loop_f            ;  (k-1)*2Tcy
    RETURN                    ;  2TCY

; --------------- retardo_7 >500us< ---------------
; T = (6+4k)*Tcy = 502us
    
Delay_500us:                  ;   2Tcy --- CALL
    MOVLW   124               ;   1Tcy --- k=124
    MOVWF   contador1,0       ;   1Tcy
Loop_g:
    NOP                       ;   k2*k*Tcy
    DECFSZ  contador1,1,0     ;   (k-1) + 3Tcy
    GOTO    Loop_g            ;   (k-1)*2Tcy
    RETURN                    ;   2Tcy    
    
; --------------- retardo_8 >1ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 1ms
      
Delay_1ms:                    ;  2Tcy --- Call
    MOVLW   1                 ;  1Tcy --- k2=1
    MOVWF   contador2,0       ;  1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_a:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_a:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3*Tcy)
    GOTO    Loop_Int_a        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_a        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy
  
; --------------- retardo_9 >5ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 5ms

Delay_5ms:                    ;  2Tcy --- Call
    MOVLW   5                 ;  1Tcy --- k2=5
    MOVWF   contador2,0       ;  1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_b:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_b:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3Tcy)
    GOTO    Loop_Int_b        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_b        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy   
    
; --------------- retardo_10 >10ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 10ms
    
Delay_10ms:                   ;  2Tcy --- Call
    MOVLW   10                ;  1Tcy --- k2=10
    MOVWF   contador2,0       ;  1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_c:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_c:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3Tcy)
    GOTO    Loop_Int_c        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_c        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy   
   
; --------------- retardo_11 >25ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 25ms

Delay_25ms:                   ;  2Tcy --- Call
    MOVLW   25                ;  1Tcy --- k2=25
    MOVWF   contador2,0       ;  1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_d:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_d:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3Tcy)
    GOTO    Loop_Int_d        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_d        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy    
    
; --------------- retardo_12 >50ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 50ms

Delay_50ms:                   ;  2Tcy --- Call
    MOVLW   50                ;  1Tcy --- k2=50
    MOVWF   contador2,0       ;  1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_e:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_e:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3Tcy)
    GOTO    Loop_Int_e        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_e        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy  
                                                                   
; --------------- retardo_13 >100ms< ---------------            
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 100.1ms
Delay_100ms:                  ;  2Tcy --- Call
    MOVLW   100               ;  1Tcy --- k2=100
    MOVWF   contador2,0       ;  1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_f:                          
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_f:                             
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3Tcy)
    GOTO    Loop_Int_f        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_f        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy  
    
; --------------- retardo_14 >200ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 200.2ms
Delay_200ms:                  ;  2Tcy --- Call
    MOVLW   200               ;  1Tcy --- k2=250
    MOVWF   contador2,0	      ;	 1Tcy
; T = (6+4k)us = 1ms 
Loop_Ext_g:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_g:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3*Tcy)
    GOTO    Loop_Int_g        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_g        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy 
    
; --------------- retardo_15 >250ms< ---------------
; T = (k2*(6+4(k)us))+k2*(1us)+ 6*(1us) = 250.2ms
Delay_250ms:                  ;  2Tcy --- Call
    MOVLW   250               ;  1Tcy --- k2=250
    MOVWF   contador2,0       ;  1Tcy
; T= (6+4k)us = 1ms 
Loop_Ext_h:  
    MOVLW   249               ;  k2*Tcy --- k=249
    MOVWF   contador1,0       ;  k2*Tcy
Loop_Int_h:
    Nop                       ;  k2*k*Tcy
    DECFSZ  contador1,1,0     ;  k2*((k-1) + 3*Tcy)
    GOTO    Loop_Int_h        ;  k2((k-1)*2Tcy)
    DECFSZ  contador2,1,0     ;  (k2-1) + 3Tcy
    GOTO    Loop_Ext_h        ;  (k2-1)*2Tcy
    RETURN                    ;  2Tcy
