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
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN

CASO_UNO:
    MOVLW 0xFF      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_DOS:
	MOVLW 0x80      ; Carga el valor 0xFF en W (todos los bits en 1)
    MOVWF PORTB     ; Enciende todos los bits de PORTB
	MOVLW 8         ; Carga el valor 8 en W (representa el n�mero de bits en PORTB)
    MOVWF COUNT     ; Almacena el valor en un registro COUNT para usarlo como contador

LOOP_CORRIMIENTO_CASO_DOS:
	CALL retardo      ; Llama a la rutina de retraso
    BCF STATUS, C   ; Limpia el bit de acarreo
    RRF PORTB, 7    ; Corre el bit m�s significativo hacia la derecha en PORTB
    DECFSZ COUNT ; Decrementa el contador y salta si es cero (si se alcanza el final)
    GOTO LOOP_CORRIMIENTO_CASO_DOS
	RETURN

CASO_TRES:
	MOVLW 0x1      ; Carga el valor 0xFF en W (todos los bits en 1)
    MOVWF PORTB     ; Enciende todos los bits de PORTB
	MOVLW 8         ; Carga el valor 8 en W (representa el n�mero de bits en PORTB)
    MOVWF COUNT     ; Almacena el valor en un registro COUNT para usarlo como contador
LOOP_CORRIMIENTO_CASO_TRES:
	CALL retardo      ; Llama a la rutina de retraso
    BCF STATUS, C   ; Limpia el bit de acarreo
    RLF PORTB,7	    ; Corre el bit menos significativo hacia la izquierda en PORTB
    DECFSZ COUNT	 ; Decrementa el contador y salta si es cero (si se alcanza el final)
    GOTO LOOP_CORRIMIENTO_CASO_TRES
	RETURN

CASO_CUATRO:
	CALL CASO_DOS
	CALL CASO_TRES
	RETURN

CASO_CINCO:
 	MOVLW 0x00      ; Carga el valor 0x00 en W (todos los bits en 0)
    MOVWF PORTB     ; Apaga todos los bits de PORTB
    CALL retardo      ; Llama a la rutina de retraso
    MOVLW 0xFF      ; Carga el valor 0xFF en W (todos los bits en 1)
    MOVWF PORTB     ; Enciende todos los bits de PORTB
    CALL retardo      ; Llama a la rutina de retraso nuevamente
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
	;------------CASO 0: Todos los leds apagados
	; Compara el valor de PORTA con 0 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 0         ; Compara W con 0
    ; Si el resultado de la comparaci�n es igual a cero (PORTA = 0), entonces salta a la rutina espec�fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_CERO	
	BCF STATUS, Z

	;------------CASO 1: Todos los leds encendidos
	; Compara el valor de PORTA con 1 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 1         ; Compara W con 1
    ; Si el resultado de la comparaci�n es igual a cero (PORTA = 1), entonces salta a la rutina espec�fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_UNO
	BCF STATUS, Z
	
	;------------CASO 2: Corrimiento del bit m�s significativo hacia la derecha	
	; Compara el valor de PORTA con 2 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 2         ; Compara W con 2
    ; Si el resultado de la comparaci�n es igual a cero (PORTA = 2), entonces salta a la rutina espec�fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_DOS
	BCF STATUS, Z

	;------------CASO 3: Corrimiento del bit menos significativo hacia la izquierda
	; Compara el valor de PORTA con 3 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 3         ; Compara W con 3
    ; Si el resultado de la comparaci�n es igual a cero (PORTA = 3), entonces salta a la rutina espec�fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_TRES
	BCF STATUS, Z
	;------------CASO 4: Corrimiento del bit m�s significativo hacia la derecha y a la izquierda
	; Compara el valor de PORTA con 4 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 4         ; Compara W con 4
    ; Si el resultado de la comparaci�n es igual a cero (PORTA = 4), entonces salta a la rutina espec�fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_CUATRO
	BCF STATUS, Z
	;------------CASO 5: Apagar y encender todos los bits.
	; Compara el valor de PORTA con 5 y ejecuta la llamada a la rutina correspondiente
    MOVF PORTA, W   ; Lee el valor de PORTA y lo coloca en W
    XORLW 5         ; Compara W con 5
    ; Si el resultado de la comparaci�n es igual a cero (PORTA = 3), entonces salta a la rutina espec�fica
    BTFSC STATUS, Z ; Comprueba el bit Z en el registro STATUS
    CALL CASO_CINCO
	BCF STATUS, Z
	
	GOTO LECTURA
END

 ; Regresa de la rutina de retraso