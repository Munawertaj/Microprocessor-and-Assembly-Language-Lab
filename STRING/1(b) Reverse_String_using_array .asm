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
    
    ;PRINT REVERSE USING LOOP
    ;   MOV CX , SI
    ;   DEC SI
    ;   PRINT:
    ;       DEC SI
    ;       MOV AH , 2
    ;       MOV DL , ST[SI]
    ;       LOOP PRINT
    
    
    OUTPUT:
        DEC SI
        CMP SI , 0
        JL EXIT
        MOV AH , 2
        MOV DL , ST[SI]
        INT 21H
        JMP OUTPUT    
                 
    EXIT:
        MOV AH , 4CH
        INT 21H
    MAIN ENDP

END MAIN