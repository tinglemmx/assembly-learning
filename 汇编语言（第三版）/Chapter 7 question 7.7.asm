assume cs:codesg,ds:datasg
datasg segment
db 'ibm             '
db 'dec             '
db 'dos             '
db 'vax             '
datasg ends
codesg segment
start: mov ax,datasg
       mov ds,ax
       mov bx,0
       mov cx,4
    s: mov si,0
       mov dx,cx
       mov cx,10h
    s0:mov al,[bx+si]
       and al,11011111B    
       mov [bx+si],al
       inc si
       loop s0
       mov cx,dx
       add bx,10h
       loop s
       mov ax,4c00h
       int 21h
codesg ends
end start