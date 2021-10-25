assume cs:codesg

codesg segment
    mov ax,111h
    mov bl,1h
    div bl

    mov ax,4c00h
    int 21h

codesg ends

end
