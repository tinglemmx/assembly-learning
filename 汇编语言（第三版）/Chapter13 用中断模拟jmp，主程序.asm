;功能：屏幕12行显示  data中的字符串
;int 7ch
;用bx向中断例程传位移

assume cs:code
data segment
        db 'conversation',0
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov si,0
        mov ax,0b800h
        mov es,ax
        mov di,160*12
s:      cmp byte ptr [si],0   ;用cmp来判断 不用jcxz了
        je ok
        mov al,[si]
        mov es:[di],al
        mov es:[di+1],2
        inc si
        add di,2
        mov bx,offset s-offset ok
        int 7ch
ok:     mov ax,4c00h
        int 21h

code ends
end start



