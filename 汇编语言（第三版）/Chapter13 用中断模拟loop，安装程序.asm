;功能：上一个例子7ch中断的安装程序，
;实现loop的功能
assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset lp ;设置ds:si指向原地址
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset lpret-offset lp
        cld   ;DF置为0  si 和 di 递增方向
        rep movsb

        mov ax,0   ;在7ch处写入 中断程序的入口
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0

        mov ax,4c00h
        int 21h
lp:     push bp
        mov bp,sp
        dec cx
        jcxz lpret
        add [bp+2],bx
lpret:  pop bp
        iret

code ends
end start



