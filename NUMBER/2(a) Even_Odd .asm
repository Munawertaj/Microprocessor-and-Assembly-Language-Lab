.MODEL SMALL
.STACK 100H

.DATA
NEWLINE DB 0AH , 0DH , '$'
EV DB "Number is even$"
OD DB "Number is odd$"
.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
    
    MOV AH , 1
    INT 21H
    
    SUB AL , 48
    MOV BL , AL
    
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    MOV AL , 1
    AND BL , AL
    
    CMP BL , 0
    JE EVEN
    
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