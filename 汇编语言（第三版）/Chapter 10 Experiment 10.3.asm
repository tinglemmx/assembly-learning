;将data段中的数据以十进制的形式显示出来
assume cs:codesg
data segment
    dd 1945,1946
    dd 16,100
    dd 3,3
    dd 8,20
data ends

data1 segment
    db 2,4,1,1,2,24
data1 ends
;0=总共行 
;1=总共列
;2=当前的行 
;3=当前列
;4=颜色
;5=行宽


stack segment
	db 32 dup(0)
stack ends


codesg segment
start:  mov ah,0fh
        int 10h
        mov ah,0h
        int 10h
        mov ax,data1
        mov es,ax
        mov ax,stack 
        mov ss,ax
        mov ax,data
        mov ds,ax
        mov si,2
        mov cx,2
s2:     mov al,es:[si]
        sub al,1
        mov es:[si],al
        inc si
        loop s2

        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0

s0:     mov cl,es:[2]
        mov ch,es:[3]
        call dtoc
        mov ch,es:[3]
        inc ch
        mov ah,es:[1]
        mov es:[3],ch
        sub ah,ch
        mov ch,0
        mov cl,ah
        jcxz s1
        jmp s0
s1:     mov cl,es:[2]
        inc cl
        mov es:[2],cl
        mov byte ptr es:[3],0
        mov al,es:[0]
        sub al,cl
        mov ch,0
        mov cl,al
        jcxz s_ok
        jmp s0
s_ok:   mov ax,4c00h
        int 21h    

; dtoc说明：将word型数据变为表示十进制数的字符串，字符串以0为结尾符。
; 参数：es;di指向要转的首地址
; 参数：ds:si指向字符串的首地址
; 参数：通告cl=行数 ch = 列数
; 参数：行数列数在外面循环 控制输入和输出的位置均在主程序
; 结果：无返回，循环用行控制

dtoc:       mov ax,0
            push ax
            mov al,cl
            mov cl,4
            mul cl
            mov si,ax
            mov al,es:[3]
            mov ah,0
            mul cl
            mul byte ptr es:[0]
            mov bx,ax
            mov ax,[bx][si]
            mov dx,[bx].2[si]
dtoc_s:     mov cx,10
            call divdw
            add cx,48
            push cx
            mov cx,ax
            add cx,dx
            jcxz show_str 
            jmp dtoc_s        





; show_str说明：根据输入的行列和颜色 来显示字符串，字符串后面跟个0表示字符串结束
; 参数：cl表示行
; 参数：ch表示列
; 参数：dl表示颜色     
; 结果：根据输入的行列和颜色 来显示字符串

show_str:   mov ah,0
            mov al,es:[2]
            add al,8
            mov cl,160
            mul cl
            mov bx,ax
            mov ah,0            
            mov al,es:[3]
            mov cl,es:[5]
            mul cl
            mov si,ax
            mov ax,0b800h
            mov ds,ax
change:     pop ax
            mov cx,ax
            mov ah,es:[4]
            jcxz ok_show_str
            mov [bx][si],ax
            add si,2
            jmp short change
ok_show_str:mov ax,data
            mov ds,ax
            ret

;说明：进行不会溢出的除数运算   被除数 dword   除数 word 结果 dword
;参数：  ax dword 型数据低16位
;        dx dword 数据的高16位
;        cx 除数
;结果： 返回 dx = 结果的高16位  0001h
;           ax = 结果的低16位  86a0h
;           cx = 余数          0
; 其实算法是  x/n = int（h/n）*65535+[rem(h/n)*65535+l]/n
; int() 商
; rem() 余数
; x 被除数
; n 除数
; h x的高16位
; l x的低16位

divdw:  push bx
        push ax
        push cx
        mov ax,dx
        mov dx,0
        div cx
        mov bx,ax
        pop cx
        pop ax
        div cx
        mov cx,dx
        mov dx,bx
        pop bx
        ret

codesg ends
end start            