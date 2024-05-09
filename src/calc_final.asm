;;;;;;;;;;;;;;;;;;;;
;Macro declarations;
;;;;;;;;;;;;;;;;;;;;


;printing a character
print_char macro char
    push ax
    push dx
    
    mov ah,2
    mov dl,char
    int 21h
    
    pop dx
    pop ax
endm

;display content 
display_content macro data
    push ax
    push dx
    
    ;store data address to dx
    lea dx, data              
    
    ;display data of input1
    mov ah,9
    int 21h  
    
    pop dx
    pop ax
endm

;store input number on register
store_num macro reg
    push ax
    
    ;wait for character input
    mov ah,1
    int 21h
    
    ;store the frist input in reg register
    mov reg,al
    ;change the number from asci to number format
    sub reg,30h
    
    pop ax
endm

;display numbers
dispaly_num macro num
    
    local begin_print, calc, skip, end_print, end_wait

    PUSH    AX
    PUSH    BX
    PUSH    CX
    PUSH    DX
    
    mov ax,0
    mov al,num
        
    ; flag to prevent printing zeros before number:
    MOV     CX, 1

    ; (result of "/ 10" is always less or equal to 9).
    MOV     BX, 10       ; 0ah - divider.

    ; AX is zero?
    CMP     AX, 0
    JZ      zero

    begin_print:

        ; check divider (if zero go to end_print):
        CMP     BX,0
        JZ      end_print

        ; avoid printing zeros before number:
        CMP     CX, 0
        JE      calc
        ; if AX<BX then result of DIV will be zero:
        CMP     AX, BX
        JB      skip
    calc:
        MOV     CX, 0   ; set flag.

        MOV     DX, 0
        DIV     BX      ; AX = DX:AX / BX   (DX=remainder).

        ; print last digit
        ; AH is always ZERO, so it's ignored
        ADD     AL, 30h    ; convert to ASCII code.
        print_char    AL


        MOV     AX, DX  ; get remainder from last div.

    skip:
        ; calculate BX=BX/10
        PUSH    AX
        PUSH    CX
        MOV     CX,10
        MOV     DX, 0
        MOV     AX, BX
        DIV     CX  ; AX = DX:AX / 10   (DX=remainder).
        MOV     BX, AX
        POP     CX
        POP     AX

        JMP     begin_print
    
    zero:
        print_char 30h; 30h is zero with ascii code
        
    end_print:

        POP     DX
        POP     CX
        POP     BX
        POP     AX

endm




;main code starts here
org 100h

;inputs display
input1 db 10,13,'Input Num 1:$'
input2 db 10,13,'Input Num 2:$'


display_content input1

;take input num1 and store it to bl
store_num bl

display_content input2

;take input num2 and store it to bh
store_num bh

;answer display
ans db 10,13,'A:$'

;add the two numbers
add bl,bh

display_content ans 
  
dispaly_num bl

;wait for any keyboard key to end the program
mov ah,0
int 16h

end