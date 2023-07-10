.MODEL SMALL
.STACK 100H

.DATA
NEWLINE DB 0AH, 0DH, '$'

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX 
    
    MOV AH , 1
    MOV CX , 0
    
    INPUT:
        INT 21H
        CMP AL , 0DH
        JE EXIT_INPUT
        PUSH AX
        INC CX
        JMP INPUT
    EXIT_INPUT:
    
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    MOV AH , 2
    OUTPUT:
         POP DX
         INT 21H
         LOOP OUTPUT
    
    EXIT:
        MOV AH , 4CH
        INT 21H
        
    MAIN ENDP

END MAIN
        
    
    
       