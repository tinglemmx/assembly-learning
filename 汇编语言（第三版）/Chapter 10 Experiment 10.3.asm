;将data段中的数据以十进制的形式显示出来
assume cs:codesg,ss:stack
data segment
    dw 123,12666,1,8,3,38
data ends
data1 segment
    dw 13 dup(0)
data1 ends
stack segment
	dw 13 dup(0)
stack ends

codesg segment
start:  mov ax,stack
        mov ss,ax
        mov ax,data
        mov es,ax
        mov ax,data1
        mov ds,ax
        mov di,0
        mov si,0
        mov cx,6
s:      mov ax,es:[di]
        call dtoc
        add di,2
        loop s
        sub bx,1
        mov [bx],0

        mov dh,20
        mov dl,3
        mov cl,2
        call show_str
        mov ax,4c00h
        int 21h    

; dtoc说明：将word型数据变为表示十进制数的字符串，字符串以0为结尾符。
; 参数：ax = word型数据
; 参数：ds:si指向字符串的首地址
; 结果：无返回

dtoc:       push cx
            push dx
            push bx
            mov si,0
s1:         mov cx,10
            mov dx,0
            div cx
            add dx,48
            mov [bx][si],dl
            mov cx,ax
            inc si
            jcxz ok_dtoc
            jmp s1

ok_dtoc:    call order
            pop bx
            pop dx
            pop cx 
            add bx,si
            mov [bx],","
            inc bx       
            ret

;数字放进去的时候是反的 要换顺序
order:      push si
            push ax
            push dx
            push cx
            push di
            mov di,0
            mov ax,si
            mov dl,2
            div dl
            mov ch,0
            mov cl,al
            jcxz order_ok
order_s0:   sub si,1
            mov al,[bx][di]
            mov ah,[bx][si]
            mov [bx][si],al
            mov [bx][di],ah
            inc di
            loop order_s0
order_ok:   pop di
            pop cx
            pop dx
            pop ax
            pop si
            ret


; show_str说明：根据输入的行列和颜色 来显示字符串，字符串后面跟个0表示字符串结束
; 参数：dh表示行
; 参数：dl表示列
; 参数：cl表示颜色    
; 参数：ds表示要显示的内容的起始地址    
; 结果：根据输入的行列和颜色 来显示字符串

show_str:   push si
            mov si,0
            push dx
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
            jcxz ok_show_str
            mov es:[di],cx
            inc di
            mov es:[di],al
            inc di
            inc si
            jmp short change
ok_show_str:pop cx
            pop dx 
            pop si           
            ret


codesg ends
end start            