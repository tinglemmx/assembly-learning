assume cs:codesg
datasg segment
    dd 0,0,0,0,0,0
datasg ends

; ds[0] = 结果dx ，结果的高16位
; ds[2] = 结果ax ，结果的低16位
; ds[4] = 结果cx , 余数
codesg segment
start:  mov ax,datasg
        mov ds,ax
        mov bx,0
        mov ax,4240h
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
divdw:  push cx
        push dx
        push ax
        mov ax,dx
        mov dx,0
        div cx
        pop ax
        push ax
        div cx
        mov word ptr ds:[0h],ax
        mov word ptr ds:[4h],dx
        pop ax
        pop dx
        pop cx
        mov ax,dx
        mov dx,0
        div cx
        mov word ptr ds:[2h],ax
        ret
codesg ends
end start
