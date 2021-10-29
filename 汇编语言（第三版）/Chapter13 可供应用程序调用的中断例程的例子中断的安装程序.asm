;功能：上一个例子7ch中断的安装程序，实现平方的功能
;参数：（ax）= 要计算的数据
;返回值：dx、ax
;安装在0:200处
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
sqr:    mul ax
        iret
sqrend: nop

code ends
end start



