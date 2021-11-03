;功能：显示用0结尾的字符串
;dh  行号
;dl  列号
;cl  颜色
;ds:si 指向字符串首地址
assume cs:code
data segment
    db "welcome to masm!",0
data ends
code segment
start:  mov dh,10
        mov dl,10
        mov cl,6
        mov ax,data
        mov ds,ax
        mov si,0
        int 7ch
        mov ax,4c00h
        int 21h
code ends
end start



