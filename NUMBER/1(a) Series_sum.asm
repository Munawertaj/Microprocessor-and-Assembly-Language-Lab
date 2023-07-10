.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB "Enter the value of N: $"
RESULT DB "The sum is = $"
NEWLINE DB 0AH , 0DH , '$'

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
    
    ;Printing newline and Output message
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    LEA DX , RESULT
    INT 21H
    
    MOV AL , 0
    
    SUMMATION:
        CMP BL , 0
        JE OUTPUT
        ADD AL , BL
        DEC BL
        JMP SUMMATION
    
    OUTPUT:
        ADD AL , 48
        MOV AH , 2
        MOV DL , AL
        INT 21H            
    
    EXIT:
        MOV AH , 4CH
        INT 21H
        MAIN ENDP

END MAIN