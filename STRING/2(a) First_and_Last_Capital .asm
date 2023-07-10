.MODEL SMALL
.STACK 100H

.DATA

NEWLINE DB 0AH,0DH,'$'
ST DB 30 DUP('$')
MSG1 DB "First Capital Letter : $"
MSG2 DB "Last Capital Letter : $"
MSG3 DB "No Capital$"

FIRST DB 'a'
LAST DB '0'

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
    
    ;TAKING INPUT
    MOV SI , 0
    MOV AH , 1
    INPUT:
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
    FIND:
        MOV DL , ST[DI]
        INC DI
        CMP DL , '$'
        JE END_FIND
 
        CMP DL , 'Z'
        JG CONTINUE
        
        CMP DL , FIRST
        JL CHANGE_FIRST
        JMP CHECK_LAST
        
        CHANGE_FIRST:
            MOV FIRST , DL
        
        CHECK_LAST:
            CMP DL , LAST
            JG CHANGE_LAST
            JMP CONTINUE
        
        CHANGE_LAST:
            MOV LAST , DL
        
        CONTINUE:
            JMP FIND
       
    END_FIND:
    
    CMP FIRST , 'a'
    JE NO_OUTPUT
    
    OUTPUT:
        MOV AH , 9
        LEA DX , MSG1
        INT 21H
        
        MOV AH , 2
        MOV DL , FIRST
        INT 21H
        
        MOV AH , 9
        LEA DX , NEWLINE
        INT 21H
        
        MOV AH , 9
        LEA DX , MSG2
        INT 21H
        
        MOV AH , 2
        MOV DL , LAST
        INT 21H
        
        JMP EXIT     
    
    NO_OUTPUT:
        MOV AH , 9
        LEA DX , MSG3
        INT 21H
        JMP EXIT
        
    EXIT:
        MOV AH , 4CH
        INT 21H
    MAIN ENDP

END MAIN