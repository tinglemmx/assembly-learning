assume cs:codesg
data segment
db 21 dup('1975')
dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dw 11542,14430,15257,17800
data ends
table segment
db 21 dup ('year summ ne ??')
table ends

codesg segment
start:mov ax,data
mov ds,ax
mov bx,0
mov si,0
mov cx,21
mov ax,table
mov es,ax
s:add [bx].2 si
mov ax,[bx].5[si]
mov dx,[bx].7[si]
div word ptr [bx].0aH[si]
mov [bx].4[si],32
mov [bx].9[si],32
mov [bx].0ch[si],32
mov [bx].0fh[si],32
loop s
mov ax,4c00h
int 21h
codesg ends
end start