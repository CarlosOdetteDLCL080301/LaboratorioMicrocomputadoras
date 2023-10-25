PROCESSOR 16F877
INCLUDE <P16F877.INC>
ORG 0 ;Vector de reset
GOTO INICIO
ORG 5

COUNT EQU H'40'
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 80h;Este valor nos ayuda a que en retardo sea de 1/2 segundo (aprox se tarda 0.55 segundos para realizar el cambio)
cte2 equ 50h
cte3 equ 60h

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

CASO_CERO:
    MOVLW 0x00      ; Carga el valor FF en W
	MOVWF PORTC     ; Escribe el valor en PORTB
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN

CASO_UNO:
	MOVLW B'100'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'0100'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_DOS:
	MOVLW B'100'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'1000'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_TRES:
	MOVLW B'010'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'0001'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_CUATRO:
	MOVLW B'110'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'0010'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_CINCO:
	MOVLW B'110'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'0101'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_SEIS:
	MOVLW B'110'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'1010'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_SIETE:
	MOVLW B'110'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'1001'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_OCHO:
	MOVLW B'110'      ; Carga el valor FF en W
    MOVWF PORTC     ; Escribe el valor en PORTC
    MOVLW B'0110'      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina


INICIO: CLRF PORTA ; Limpia PORTA
BSF STATUS,RP0 ; Cambia a banco 1
BCF STATUS,RP1
MOVLW 06H ; Define puertos A y E como digitales
MOVWF ADCON1
MOVLW H'3F' ; Configura puerto A como entrada
MOVWF TRISA
MOVLW H'0'
MOVWF TRISB
BCF STATUS,RP0 ; Cambia al banco 0
LECTURA:
	;------------CASO 0: PARO PARO
	; Compara el valor de PORTA con 0 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 0         ; Compara W con 0
    ; Si el resultado de la comparación es igual a cero (PORTA = 0), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_CERO	
	BCF STATUS, Z

	;------------CASO 1: PARO HORARIO
	; Compara el valor de PORTA con 1 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 1         ; Compara W con 1
    ; Si el resultado de la comparación es igual a cero (PORTA = 1), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_UNO
	BCF STATUS, Z
	
	;------------CASO 2: PARO ANTI-HORARIO
	; Compara el valor de PORTA con 2 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 2         ; Compara W con 2
    ; Si el resultado de la comparación es igual a cero (PORTA = 2), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_DOS
	BCF STATUS, Z

	;------------CASO 3: HORARIO PARO
	; Compara el valor de PORTA con 3 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 3         ; Compara W con 3
    ; Si el resultado de la comparación es igual a cero (PORTA = 3), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_TRES
	BCF STATUS, Z
	;------------CASO 4: ANTI-HORARIO PARO
	; Compara el valor de PORTA con 4 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 4         ; Compara W con 4
    ; Si el resultado de la comparación es igual a cero (PORTA = 4), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_CUATRO
	BCF STATUS, Z
	;------------CASO 5: HORARIO HORARIO
	; Compara el valor de PORTA con 5 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 5         ; Compara W con 5
    ; Si el resultado de la comparación es igual a cero (PORTA = 5), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_CINCO
	BCF STATUS, Z

	;------------CASO 6: ANTI-HORARIO ANTI-HORARIO
	; Compara el valor de PORTA con 6 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 6         ; Compara W con 6
    ; Si el resultado de la comparación es igual a cero (PORTA = 6), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_SEIS
	BCF STATUS, Z
	;------------CASO 7: HORARIO ANTI-HORARIO
	; Compara el valor de PORTA con 7 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 7         ; Compara W con 7
    ; Si el resultado de la comparación es igual a cero (PORTA = 7), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_SIETE
	BCF STATUS, Z
	;------------CASO 8: ANTI-HORARIO HORARIO
	; Compara el valor de PORTA con 8 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 8         ; Compara W con 8
    ; Si el resultado de la comparación es igual a cero (PORTA = 8), entonces salta a la rutina específica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_OCHO
	BCF STATUS, Z
	
	GOTO LECTURA

END

 ; Regresa de la rutina de retraso