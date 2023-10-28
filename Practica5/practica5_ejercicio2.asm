PROCESSOR 16F877
INCLUDE <P16F877.INC>
ORG 0 ;Vector de reset
GOTO INICIO
ORG 5

COUNT EQU H'40'
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ h'01';Este valor nos ayuda a que en retardo sea de 1/2 segundo (aprox se tarda 0.55 segundos para realizar el cambio)
cte2 equ h'0B'
cte3 equ h'FF'

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

PRE_VUELTAS_ANTIHORARIO:;Sentido horario
;ESTAMOS EN 0 GRADOS
;VUELTA DE +90 GRADOS, AHORA ROTO 90 GRADOS
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
;VUELTA DE +90 GRADOS, AHORA ROTO 180 GRADOS
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
;VUELTA DE +90 GRADOS, AHORA ROTO 270 GRADOS
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
;VUELTA DE +90 GRADOS, AHORA ROTO 360 GRADOS
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
    CALL retardo
    RETURN          ; Regresa de la rutina

PRE_VUELTAS_HORARIO:; Sentido horario
;ESTAMOS EN 0 GRADOS
;VUELTA DE +90 GRADOS, AHORA ROTO 90 GRADOS
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
;VUELTA DE +90 GRADOS, AHORA ROTO 180 GRADOS
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
;VUELTA DE +90 GRADOS, AHORA ROTO 270 GRADOS
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
;VUELTA DE +90 GRADOS, AHORA ROTO 360 GRADOS
    MOVLW B'11000000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'01100000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'00110000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    MOVLW B'10010000'
    MOVWF PORTB     ; Escribe el valor en PORTB
	CALL retardo
    RETURN          ; Regresa de la rutina

UnaVueltaAntihorario:
;Se definen las variables
N equ h'24'
MOVLW H'180' ; Configura puerto A como entrada
MOVWF N
	loop_begin:
		MOVF N,W
		BTFSC STATUS,Z
		GOTO loop_end
	loop_body:
		CALL PRE_VUELTAS_ANTIHORARIO
		DECF N,F
		GOTO loop_begin
	loop_end:
    RETURN          ; Regresa de la rutina

CASO_CUATRO:
    MOVLW 0xFF      ; Carga el valor FF en W
    MOVWF PORTB     ; Escribe el valor en PORTB
    RETURN          ; Regresa de la rutina

UnaVueltaHorario:
;Se definen las variables
M equ h'25'
MOVLW H'180' ; Configura puerto A como entrada
MOVWF M
	loop_begin_H:
		MOVF M,W
		BTFSC STATUS,Z
		GOTO loop_end_H
	loop_body_H:
		CALL PRE_VUELTAS_HORARIO
		DECF M,F
		GOTO loop_begin_H
	loop_end_H:
    RETURN          ; Regresa de la rutina

vueltasHorario:
;Se definen las variables
cantVueltasHorario equ h'26'
MOVLW H'5' ; Configura puerto A como entrada
MOVWF cantVueltasHorario
	loop_begin_cantVueltasHorario:
		MOVF cantVueltasHorario,W
		BTFSC STATUS,Z
		GOTO loop_end_cantVueltasHorario
	loop_body_cantVueltasHorario:
		CALL UnaVueltaHorario
		DECF cantVueltasHorario,F
		GOTO loop_begin_cantVueltasHorario
	loop_end_cantVueltasHorario:
    RETURN          ; Regresa de la rutina

vueltasAntiHorario:
;Se definen las variables
cantVueltasAntiHorario equ h'27'
MOVLW H'A' ; Configura puerto A como entrada
MOVWF cantVueltasAntiHorario
	loop_begin_cantVueltasAntiHorario:
		MOVF cantVueltasAntiHorario,W
		BTFSC STATUS,Z
		GOTO loop_end_cantVueltasAntiHorario
	loop_body_cantVueltasAntiHorario:
		CALL UnaVueltaAntihorario
		DECF cantVueltasAntiHorario,F
		GOTO loop_begin_cantVueltasAntiHorario
	loop_end_cantVueltasAntiHorario:
    RETURN          ; Regresa de la rutina

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
BCF STATUS,RP0 ; Cambia al banco 0
;Acomodar en la entrada por switch
;CALL UnaVueltaAntihorario
;CALL UnaVueltaHorario
;CALL vueltasHorario
CALL vueltasAntiHorario
LECTURA:
	
    ;CALL CASO_TRES

	GOTO LECTURA
END

 ; Regresa de la rutina de retraso