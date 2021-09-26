; 偏移超界了 -128 ~ 127
assume cs:code
code segment
start:jmp short s
      db 128 dup (0)
    s:mov ax,0ffffh
code ends
end start