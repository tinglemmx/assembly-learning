;功能：屏幕中答应80个！ ，用中断模拟loop指令
; 先cs=cs-1
; 如果cs不为0  IP = IP + 位移

assume cs:code
code segment
start:  mov ax,0b800h
        mov es,ax
        mov di,160*12
        mov bx,offset s-offset se      ; 偏移量=(s-se)     还原就是  se+偏移量 = se+（s-se）=s
        mov cx,80
s:      mov byte ptr es:[di],'!'
        mov byte ptr es:[di+1],2
        add di,2
        int 7ch
se:     nop
        mov ax,4c00h
        int 21h
code ends
end start



