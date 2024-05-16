org 100h

;display the string on "Enter>>"
mov dx,0
lea dx,input
mov ah,9
int 21h

mov cx,0
mov dh,0
lea si,array

;takes 10 inputs separated by space
enter:
mov ah,1
int 21h
mov [si],al

mov ah,0eh ;printing the space
mov al,' '
int 10h

inc si
inc cx
cmp cx,10
jne enter

mov dh,0


outer:
lea si,array
lea di,array
mov cx,0
add dh,1
cmp dh,10
je print
jne inner
inner:     
inc di;i+1
mov bl,[si] 

;check if 2 consecutive numbers are in asc order
cmp bl,[di]
jna continue

;if 2 consecutive is not in order swap them
mov dl,[di];temp<-a[i+1]
mov [si],dl;a[i]<-a[i+1]
mov [di],bl;a[i+1]<-temp

continue:
inc cx
inc si

cmp cx,9
jne inner
je outer




;print result
print:
lea dx,output
mov ah,9
int 21h

lea si,array
lea di,array
lea bx,B
mov cx,0

printos:
inc di
mov dh,[si]
mov dl,[di]
cmp dl,dh
je end_cond  

mov ah,0eh 

mov al,' '
int 10h 
 
mov al,[si]
int 10h 
  
mov [bx],al 
inc bx  
         
        
end_cond:  
inc si
add cx,1
cmp cx,10
jne printos
je end
end:
ret

input db "enter>>$"
output db "ascend order$"
dim equ 10
new db 10,13
array db dim dup(?)
B db 0
