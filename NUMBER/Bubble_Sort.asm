.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB "Enter some numbers: $"
MSG2 DB "After sorting: $"
NEWLINE DB 0AH,0DH,'$'
INPUT DB 30 DUP('$')

.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
    
    MOV AH , 9
    LEA DX , MSG1
    INT 21H
    
    
    ;TAKING INPUT
    MOV SI , 0
    MOV AH , 1
    START_INPUT:
        INT 21H
        CMP AL , 0DH
        JE END_INPUT
        MOV INPUT[SI] , AL
        INC SI
        JMP START_INPUT
    END_INPUT:    
    
    ;NEWLINE 
    MOV AH , 9
    LEA DX , NEWLINE
    INT 21H
    
    ;ASCENDING_SORT
    MOV SI, 0
        
    LOOP1:
        MOV DI, SI
        MOV AL, INPUT[SI]
        CMP AL, '$'
        JE END_LOOP1
        
        LOOP2:
            INC DI
            MOV BL, INPUT[DI]
            CMP BL, '$'
            JE END_LOOP2
            
            CMP AL, BL
            JG SWAP
            JMP LOOP2
        
        SWAP:
            MOV INPUT[SI], BL
            MOV INPUT[DI], AL
            MOV AL, BL
            JMP LOOP2
        
        END_LOOP2:
            INC SI
            JMP LOOP1
        
        END_LOOP1:
        
        OUTPUT:
            MOV AH, 9
            LEA DX , MSG2
            INT 21H
            LEA DX, INPUT
            INT 21H
        
        
    EXIT:
        MOV AH , 4CH
        INT 21H
    MAIN ENDP

END MAIN