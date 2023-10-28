PROCESSOR 16F877
INCLUDE <P16F877.INC>
ORG 0 ;Vector de reset
GOTO INICIO
ORG 5

COUNT EQU H'40'
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ h'1';Este valor nos ayuda a que en retardo sea de 1/2 segundo (aprox se tarda 0.55 segundos para realizar el cambio)
cte2 equ h'15'
cte3 equ h'9D'
;1,09,70 = - 0 grados
;1, 10, 9B = 90 grados
;1, 15, 9D = 180 grados	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
;1,10,ff
;f, b, FF = 90 graddos
retardo 
	MOVLW cte1
 	MOVWF valor1
	tres:
		MOVLW cte2
		MOVWF valor2
	dos:
		MOVLW cte3
		MOVWF valor3
	uno:
		DECFSZ valor3
 		GOTO uno
		DECFSZ valor2
		GOTO dos
		DECFSZ valor1
		GOTO tres
	RETURN
;5 retardos hacen 180 grados

ENPARO:
    MOVLW h'FF'      ; Carga el valor FF en W
	MOVWF PORTC
	CALL retardo

	MOVLW h'00'      ; Carga el valor FF en W
	MOVWF PORTC	
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
;_____________________________________
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
	CALL retardo
    RETURN

INICIO:
CLRF PORTA ; Limpia PORTA
BSF STATUS,RP0 ; Cambia a banco 1
BCF STATUS,RP1
MOVLW 06H ; Define puertos A y E como digitales
MOVWF ADCON1
MOVLW H'3F' ; Configura puerto A como entrada
MOVWF TRISA
MOVLW H'0'
MOVWF TRISB
MOVWF TRISC
BCF STATUS,RP0 ; Cambia al banco 0
;Acomodar en la entrada por switch
LECTURA:
		
	CALL ENPARO
    	
	GOTO LECTURA
END

 ; Regresa de la rutina de retraso