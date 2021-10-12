assume cs:codesg
datasg segment
    dw 21 dup(0)
datasg ends
codesg segment
start:  mov ax,datasg
        mov ds,ax
        mov bx,0
        mov ax,1
        mov [bx].1,ax
        mov ax,12
        mov [bx].12,ax
        mov ax,10
        mov [bx].10,ax  ;点后面是10进制的
        mov ax,4c00h
        int 21h
codesg ends
end start