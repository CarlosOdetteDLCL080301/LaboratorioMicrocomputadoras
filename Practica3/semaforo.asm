processor 16f877
include <p16f877.inc>
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 100h;Este valor nos ayuda a que en retardo sea de 1/2 segundo (aprox se tarda 0.55 segundos para realizar el cambio)
cte2 equ 96h
cte3 equ 50h
 
 ORG 0
 GOTO INICIO
 ORG 5
INICIO:
	BSF STATUS,RP0
 	BCF STATUS,RP1
 	MOVLW H'0'
 	MOVWF TRISB
 	BCF STATUS,RP0
 	CLRF PORTB 
 
 loop2:
	;Estado 1 = V1, R2
	MOVLW 0X41
	MOVWF PORTB
	CALL retardo
	;Estado 2 = A1, R2
 	MOVLW 0X21
	MOVWF PORTB
	CALL retardo
	;Estado 3 = R1, V2
	MOVLW 0X14
	MOVWF PORTB
	CALL retardo
	;Estado 4 = R1, A2
	MOVLW 0X12
	MOVWF PORTB
	CALL retardo
	GOTO loop2
	
 
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
END