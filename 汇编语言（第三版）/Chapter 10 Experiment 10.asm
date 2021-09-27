assume cs:code
data segment
    db 'Welcome to masm!',0
data ends

code segment
start:  mov dh,8
        mov dl,3
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str

        mov ax,4c00h
        int 21h

; 说明：根据输入的行列和颜色 来显示字符串，字符串后面跟个0表示字符串结束
; 参数：dh表示行
; 参数：dl表示列
; 参数：cl表示颜色    
; 结果：根据输入的行列和颜色 来显示字符串

show_str:   push dx
            push cx
            mov ax,0b800h
            mov es,ax
            mov al,dh
            sub al,1
            mov bl,160
            mul bl
            mov dh,0
            add ax,dx
            sub ax,1
            mov di,ax
            mov al,dl
            sub al,1
            mov bl,2
            mul bl
            add di,ax
            mov al,cl

change:     mov cl,[si]
            mov ch,0
            jcxz ok
            mov es:[di],cx
            inc di
            mov es:[di],al
            inc di
            inc si
            jmp short change
ok:         pop cx
            pop dx            
            ret
code ends
end start