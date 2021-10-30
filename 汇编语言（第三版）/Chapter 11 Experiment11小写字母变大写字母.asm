;将小写字母变成大写字母
assume cs:code
datasg segment
    db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends    
code segment
start:  mov ax,datasg
        mov ds,ax
        mov si,0
        call letterc

        mov ax,4c00h
        int 21h

letterc:push ax
        push si
      s:mov al,[si]
        cmp al,0
        je ok
        cmp al,97
        jb next
        cmp al,122
        ja next
        add al,11011111B
        mov [si],al  
   next:inc si  
        loop s
    ok: pop si
        pop ax
        ret
code ends
end start  