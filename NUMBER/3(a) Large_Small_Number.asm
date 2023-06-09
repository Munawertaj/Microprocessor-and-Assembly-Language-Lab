.MODEL SMALL
.STACK 100H

.DATA

NEWLINE DB 0AH,0DH,'$'
NUMBER DB 30 DUP('$')  ; Declaring an array of size 30, initialize each value by '$'
MSG DB "Enter numbers[0~9] without space: $"
MSG1 DB "Smallest Number : $"
MSG2 DB "largest Number : $"

BIG DB '0'
SMALL DB '9'

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
    
    ;Printing Input message
    MOV AH , 9
    LEA DX , MSG
    INT 21H
    
    ;TAKING INPUT
    MOV AH , 1
    MOV SI , 0
    INPUT:
        INT 21H
        CMP AL , 0DH
        JE END_INPUT
        MOV NUMBER[SI] , AL
        INC SI
        JMP INPUT
    END_INPUT:    
    
    ;NEWLINE 
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    MOV DI , 0
    FIND:
        MOV DL , NUMBER[DI]
        INC DI
        CMP DL , '$' ; Checking last character 
        JE END_FIND
        
        CMP DL , SMALL
        JL CHANGE_SMALL
        JMP CHECK_BIG
        
        CHANGE_SMALL:
            MOV SMALL , DL
        
        CHECK_BIG:
            CMP DL , BIG
            JL CONTINUE
        
        CHANGE_BIG:
            MOV BIG , DL
        
        CONTINUE:
            JMP FIND
       
    END_FIND:
    
    OUTPUT:
        MOV AH , 9
        LEA DX , MSG1
        INT 21H
        
        MOV AH , 2
        MOV DL , SMALL
        INT 21H
        
        MOV AH , 9
        LEA DX , NEWLINE
        INT 21H
        
        LEA DX , MSG2
        INT 21H
        
        MOV AH , 2
        MOV DL , BIG
        INT 21H
        
    EXIT:
        MOV AH , 4CH
        INT 21H
        MAIN ENDP

END MAIN