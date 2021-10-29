;功能：通过中断7ch将 小写字母变大写字母
assume cs:code
date segment
    db 'conversation',0
date ends

code segment
start:  mov ax,date
        mov ds,ax
        mov si,0

        int 7ch     ;调用中断7ch的中断例程，

        mov ax,4c00h
        int 21h
code ends
end start



