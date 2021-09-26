assume cs:codesg
datasg segment
    db "welcome to masm!"
datasg ends
codesg segment
start:  mov ah,0fh
        int 10h
        mov ah,0h
        int 10h
        mov ax,0b800h
        mov ds,ax
        mov ax,datasg
        mov es,ax
        mov bx,6e0h
        mov di,40h
        mov si,0h
        mov cx,10h
    s:  mov ax,es:[si]
        mov [bx][di],ax
        mov [bx].0a0h[di],ax
        mov [bx].140h[di],ax
        inc di            
        mov [bx][di],2h
        mov [bx].0a0h[di],24h
        mov [bx].140h[di],71h
        inc di
        inc si
        loop s
        mov ax,4c00h
        int 21h
codesg ends
end start