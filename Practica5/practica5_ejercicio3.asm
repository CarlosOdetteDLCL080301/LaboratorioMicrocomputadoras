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
;1, 15, 9D = 180 grados
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

IZQUIERDA:
	MOVLW h'1'  ; Carga el nuevo valor para cte1 en W
    MOVWF cte1; Almacena el valor en cte1

    MOVLW h'04'; Carga el nuevo valor para cte2 en W
    MOVWF cte2; Almacena el valor en cte2

    MOVLW h'70'; Carga el nuevo valor para cte3 en W
    MOVWF cte3; Almacena el valor en cte3
	CALL ENPARO
	RETURN

CENTRAL:
	MOVLW h'1'  ; Carga el nuevo valor para cte1 en W
    MOVWF cte1; Almacena el valor en cte1

    MOVLW h'12'; Carga el nuevo valor para cte2 en W
    MOVWF cte2; Almacena el valor en cte2

    MOVLW h'70'; Carga el nuevo valor para cte3 en W
    MOVWF cte3; Almacena el valor en cte3
	CALL ENPARO
	RETURN

DERECHA:
	MOVLW h'1'  ; Carga el nuevo valor para cte1 en W
    MOVWF cte1; Almacena el valor en cte1

    MOVLW h'18'; Carga el nuevo valor para cte2 en W
    MOVWF cte2; Almacena el valor en cte2

    MOVLW h'9D'; Carga el nuevo valor para cte3 en W
    MOVWF cte3; Almacena el valor en cte3
	CALL ENPARO
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

	;------------CASO 0: MOTOR EN PARO
	; Compara el valor de PORTA con 0 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 0         ; Compara W con 0
    ; Si el resultado de la comparaci?n es igual a cero (PORTA = 0), entonces salta a la rutina espec?fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL IZQUIERDA
	BCF STATUS, Z

	;------------CASO 1: GIRA EN SENTIDO HORARIO
	; Compara el valor de PORTA con 1 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 1         ; Compara W con 1
    ; Si el resultado de la comparaci?n es igual a cero (PORTA = 1), entonces salta a la rutina espec?fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CENTRAL
	BCF STATUS, Z
	
	;------------CASO 2: GIRA EN SENTIDO ANTI-HORARIO
	; Compara el valor de PORTA con 2 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 4         ; Compara W con 2
    ; Si el resultado de la comparaci?n es igual a cero (PORTA = 2), entonces salta a la rutina espec?fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL DERECHA
	BCF STATUS, Z	

	GOTO LECTURA
END

 ; Regresa de la rutina de retraso