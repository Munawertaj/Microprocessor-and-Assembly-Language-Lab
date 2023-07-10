.MODEL SMALL
.STACK 100H

.DATA

NEWLINE DB 0AH,0DH,'$'
ST DB 30 DUP('$')

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
    
    ;TAKING INPUT
    MOV SI , 0
    INPUT:
        MOV AH , 1
        INT 21H
        CMP AL , 0DH
        JE END_INPUT
        MOV ST[SI] , AL
        INC SI
        JMP INPUT
    END_INPUT:    
    
    ;NEWLINE 
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    
    MOV DI , 0
    
    CASE_CHANGE:
        MOV DL , ST[DI]
        CMP DL , '$'
        JE OUTPUT
        
        CMP DL , 'A'
        JL NO_CHANGE
        
        CMP DL , 'z'
        JG NO_CHANGE
        
        CMP DL , 'Z'
        JG CHECK_LOWER
        
        XOR DL , 32
        JMP NO_CHANGE
        
        CHECK_LOWER:
            CMP DL , 'a'
            JL NO_CHANGE
            XOR DL , 32 
             
        NO_CHANGE:
            MOV ST[DI] , DL
            INC DI
            JMP CASE_CHANGE
     
    
    OUTPUT:
        LEA DX , ST
        MOV AH , 9
        INT 21H     
    
    EXIT:
        MOV AH , 4CH
        INT 21H
    MAIN ENDP

END MAIN