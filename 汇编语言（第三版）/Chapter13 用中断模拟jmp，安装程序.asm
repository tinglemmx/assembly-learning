;功能：上一个例子7ch中断的安装程序，
;实现loop的功能
assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset jump ;设置ds:si指向原地址
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset jumpend-offset jump
        cld   ;DF置为0  si 和 di 递增方向
        rep movsb

        mov ax,0   ;在7ch处写入 中断程序的入口
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0

        mov ax,4c00h
        int 21h
jump:   push bp
        push bx
        mov bp,sp
        add [bp+4],bx   ;我这边push 了 两个 sp 移动了2次  每次2 字节  所以要+4
        pop bx
        pop bp
        iret
jumpend:  nop
code ends
end start



