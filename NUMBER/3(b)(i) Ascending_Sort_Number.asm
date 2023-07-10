.MODEL SMALL
.STACK 100H

.DATA

NEWLINE DB 0AH,0DH,'$'
NUMBER DB 30 DUP('$')
CNT DB ?
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
        MOV NUMBER[SI] , AL
        INC SI
        JMP INPUT
    END_INPUT:    
    
    ;NEWLINE 
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    
    MOV BL , 0
    ASCENDING_SORT:
        MOV CNT , 0
        MOV DI , 0
        
        COUNT:
            MOV DL , NUMBER[DI]
            INC DI
            CMP DL , '$'
            JE END_COUNT
            
            SUB DL , 48
            
            CMP DL , BL
            JE INCREASE
            
            JMP COUNT
            
            INCREASE:
                INC CNT
                JMP COUNT          
       
        END_COUNT:
        
        
        MOV AH , 2
        MOV DL , BL
        ADD DL , 48
        PRINT_NUM:
            CMP CNT , 0
            JE CONTINUE
            INT 21H
            DEC CNT
            JMP PRINT_NUM
            
        
        CONTINUE:
            CMP BL , 9
            JE EXIT
            INC BL
            JMP ASCENDING_SORT
        
    EXIT:
        MOV AH , 4CH
        INT 21H
    MAIN ENDP

END MAIN