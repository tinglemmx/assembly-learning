;功能：显示用0结尾的字符串
;dh  行号
;dl  列号
;cl  颜色
;ds:si 指向字符串首地址
assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset sqr ;设置ds:si指向原地址
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset sqrend-offset sqr
        cld   ;DF置为0  si 和 di 递增方向
        rep movsb

        mov ax,0   ;在7ch处写入 中断程序的入口
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0

        mov ax,4c00h
        int 21h
sqr:    mov bh,0        ;第0页
        mov ah,2        ;置光标
        int 10h         ;置光标
        mov bl,cl       ;吧颜色转给bl

      s:mov ah,9     ;在光标位置显示字符
        mov al,[si]   ;字符
        mov cl,[si]
        mov ch,0
        mov bh,0  ;   第0页
        inc si
        jcxz ok
        mov cx,1
        int 10h
        jmp s
    ok: iret
sqrend: nop

code ends
end start



