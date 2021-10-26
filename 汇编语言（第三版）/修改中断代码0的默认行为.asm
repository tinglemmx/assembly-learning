assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset do0    ;设置ds:si指向源地址
        mov ax,0
        mov es,ax
        mov di,200h             ;设置es:di指向目的地址
        mov cx,offset do0end-offset do0  ;-是编译器识别的运算符号，编译器可以用它来进行两个常熟的减法
        cld                         ;设置传输方向为正
        rep movsb
        
        mov ax,0
        mov es,ax
        mov word ptr es:[0*4],200h    ;设置中断向量表的0号表项 放置偏移地址
        mov word ptr es:[0*4+2],0     ;设置中断向量表的0号表项 放置段地址

        mov ax,4c00h
        int 21h
    do0:jmp short do0start
        db "divide error!"           ;overflow！就放在jmp后面
do0start:mov ax,cs
        mov ds,ax
        mov si,202h             ;设置ds:si 指向字符串,因为jmp short do0start 这条指令是两个字节 后面就是divide error!

        mov ax,0b800h
        mov es,ax
        mov di,12*160+36*2    ;设置es:di 指向显存空间中间位置

        mov cx,13          ;设置cx为字符串长度
    s:  mov al,[si]
        mov es:[di],al
        mov es:[di].1,2h
        inc si
        add di,2
        loop s

        mov ax,4c00h
        int 21h
do0end: nop    
code ends
end start
