.MODEL SMALL
.STACK 100H

.DATA
NEWLINE DB 0AH , 0DH , '$'
MSGP DB "Number is Prime$"
MSGN DB "Number is Not Prime$"
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
    
    CMP BL , 2
    JE PRIME
    
    CMP BL , 3
    JE PRIME
    
    CMP BL , 5
    JE PRIME
    
    CMP BL , 7
    JE PRIME            
    
    NOT_PRIME:
        MOV AH , 9
        LEA DX , MSGN
        INT 21H
        JMP EXIT
        
    PRIME:
        MOV AH , 9
        LEA DX , MSGP
        INT 21H
    
    EXIT:
        MOV AH , 4CH
        INT 21H
        MAIN ENDP

END MAIN