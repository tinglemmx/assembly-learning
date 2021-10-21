assume cs:code             ; cf  of  sf  zf  pf
code segment               ; 0   0   0   0   0
start:  sub al,al          ; 0   0   0   1   1
        mov al,10h         ; 0   0   0   1   1 
        add al,90h         ; 0   0   1   0   1
        mov al,80h         ; 0   0   1   0   1 
        add al,80h         ; 1   1   0   1   1
        mov al,0FCh        ; 1   1   0   1   1 
        add al,05h         ; 1   0   0   0   0
        mov al,7dh         ; 1   0   0   0   0
        add al,0bh         ; 0   1   1   0   1
        sub al,al          ; 0   0   0   1   1
        mov al,1           ; 0   0   0   1   1
        push ax            ; 0   0   0   1   1
        pop bx             ; 0   0   0   1   1
        add al,bl          ; 0   0   0   0   0
        add al,10          ; 0   0   0   0   1
        mul al             ; 0   0   0   0   0  
        mov ax,4c00h       ; 
        int 21h
code ends
end start        
