.MODEL SMALL
.STACK 100H

.DATA

NEWLINE DB 0AH , 0DH , '$'
MSG1 DB "Enter a digit: $"
MSGP DB "Number is Prime$"
MSGN DB "Number is Not Prime$"

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
    
    ;If num is less than 2 then it is Not Prime
    CMP BL, 2
    JL NOT_PRIME
    
    MOV AH, 0  ;For division operation AH is initialized by 0
    MOV AL, BL ;Restoring value of num in AL
    MOV CX, AX
    
    DEC BL
    
    CHECK_PRIME:
        CMP BL, 1
        JE PRIME
        DIV BL  ; Perform AX/BL and Remainder --> AH Quotient(result) --> AL
        CMP AH, 0  
        JE NOT_PRIME
        DEC BL
        MOV AX, CX
        JMP CHECK_PRIME            
    
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