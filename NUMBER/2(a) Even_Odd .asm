.MODEL SMALL
.STACK 100H

.DATA

NEWLINE DB 0AH , 0DH , '$'
MSG1 DB "Enter a digit: $"
EV DB "Number is Even$"
OD DB "Number is Odd$"

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
    
    ;Printing Input message
    MOV AH , 9
    LEA DX , MSG1
    INT 21H
    
    ;Taking input
    MOV AH , 1
    INT 21H
    
    ;Storing the value of AL into BL because of the interruption of NEWLINE later
    SUB AL , '0'
    MOV BL , AL
    
    ;Printing newline
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    ;Performing AND operation (num & 1) = 0 then num is EVEN else ODD
    MOV AL , 1
    AND BL , AL
    
    CMP BL , 0
    JE EVEN
    
    ODD:
        MOV AH , 9
        LEA DX , OD
        INT 21H
        JMP EXIT
    
    EVEN:
        MOV AH , 9
        LEA DX , EV
        INT 21H            
    
    EXIT:
        MOV AH , 4CH
        INT 21H
        MAIN ENDP

END MAIN