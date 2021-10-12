assume cs:codesg
codesg segment
start:  mov ax,4240h
        mov dx,000fh
        mov cx,0ah
        call divdw
        mov ax,4c00h
        int 21h

;说明：进行不会溢出的除数运算   被除数 dword   除数 word 结果 dword
;参数：  ax dword 型数据低16位
;        dx dword 数据的高16位
;        cx 除数
;结果： 返回 dx = 结果的高16位  0001h
;           ax = 结果的低16位  86a0h
;           cx = 余数          0
; 其实算法是  x/n = int（h/n）*65535+[rem(h/n)*65535+l]/n
; int() 商
; rem() 余数
; x 被除数
; n 除数
; h x的高16位
; l x的低16位

divdw:  push bx
        push ax
        mov ax,dx
        mov dx,0
        div cx
        mov bx,ax
        pop ax
        div cx
        mov cx,dx
        mov dx,bx
        pop bx
        ret

codesg ends
end start

