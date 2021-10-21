assume cs:codesg

codesg segment
    mov al,7bh
    mov cx,8
s:  inc al
    loop s

    mov ax,4c00h
    int 21h

codesg ends

end
