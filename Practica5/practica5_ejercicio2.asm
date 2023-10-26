PROCESSOR 16F877
INCLUDE <P16F877.INC>
ORG 0 ;Vector de reset
GOTO INICIO
ORG 5

COUNT EQU H'40'
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 40h;Este valor nos ayuda a que en retardo sea de 1/2 segundo (aprox se tarda 0.55 segundos para realizar el cambio)
cte2 equ 40h
cte3 equ 40h

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

CASO_UNO:;Sentido horario
    MOVLW B'10000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'01000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    RETURN          ; Regresa de la rutina

CASO_DOS:; Sentido antihorario
    MOVLW B'10000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'01000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'00100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'00010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

CASO_TRES:
	loop_begin:
		MOVF N,W
		BTFSC STATUS,Z
		GOTO loop_end
	loop_body:
		CALL CASO_UNO
        CALL CASO_UNO
		DECF N,F
		GOTO loop_begin
	loop_end:
    RETURN          ; Regresa de la rutina

CASO_CUATRO:
    MOVLW 0xFF      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

INICIO:
;Se definen las variables
N equ h'24'
MOVLW H'5' ; Configura puerto A como entrada
MOVWF N

CLRF PORTA ; Limpia PORTA
BSF STATUS,RP0 ; Cambia a banco 1
BCF STATUS,RP1
MOVLW 06H ; Define puertos A y E como digitales
MOVWF ADCON1
MOVLW H'3F' ; Configura puerto A como entrada
MOVWF TRISA
MOVLW H'0'
MOVWF TRISB
BCF STATUS,RP0 ; Cambia al banco 0

CALL CASO_TRES

LECTURA:
	
    CALL CASO_TRES

	GOTO LECTURA
END

 ; Regresa de la rutina de retraso