org 100h

mov dx,offset input ;prepare to string to be displayed(input)
mov ah,9            ;intrupt singal for output string
int 21h             ;intrupt call

mov cx,0
mov si,offset array

;takes 10 inputs separated by space
wait_for_input:
    mov ah,1    ;intrupt signal for input character
    int 21h     ;intrupt call
    mov [si],al ;storing input data in [si] or array
    
    mov ah,0eh  ;intrupt signal for output character
    mov al,' '  ;output character
    int 10h     ;intrupt call
    
    inc si
    inc cx
    cmp cx,10
    jne wait_for_input


;bubble sort starts
mov dh,0 ;clearing the data on dh (outer loop counter)
outer:
    mov si,offset array  ;intializing si as first element tracker in the array
    mov di,offset array  ;intializing di as second element tracker in the array
    mov cx,0             ;clearing data on cx (inner loop counter)
    inc dh
    cmp dh,10
    je print_output

inner:     
    inc di
    mov bl,[si]   ;temp1<-array[i] 
    
    ;check if 2 consecutive numbers are in asc order
    cmp bl,[di]   
    jna continue
    
    ;if 2 consecutive is not in order swap them
    mov dl,[di] ;temp2<-array[i+1]
    mov [si],dl ;array[i]<-temp2
    mov [di],bl ;array[i+1]<-temp1

continue:
    inc cx
    inc si
    
    cmp cx,9
    jne inner
    je outer
    ;bubble sort ended
    ;array is sorted in asc



;print result
print_output:
    lea dx,output  ;prepare to string to be displayed(output)
    mov ah,9       ;intrupt singal for output string
    int 21h        ;intrupt call
    
    lea si,array
    mov cx,0
    
    print:
    mov ah,0eh   ;intrupt input signal
    mov al,' '   ;write the character ' '
    int 10h      ;intrupt call
     
    mov al,[si]
    int 10h 
                        
    inc si
    inc cx
    cmp cx,10
    jne print
    je end
end:
    ret

input db "Enter 10 Numbers>> $"
output db "Sorted(ASC):$"
array db 10 dup(?)

