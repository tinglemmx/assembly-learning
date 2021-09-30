;把Chapter8 question7 中的代码 结果显示出来

assume cs:codesg
data segment
dw 21 dup(1975)
dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dw 11542,14430,15257,17800
data ends
table segment
db 21 dup ('year summ ne ??')
table ends

codesg segment
start:  mov ax,data
        mov ds,ax

        ;bx 代表列
        mov cx,21
        mov ax,1975
        call generate_year


        mov ax,4c00h
        int 21h

; 自动生成年份 ，年份根据输入的值递增1， generate_year
; 参数：ax = 年，ds：ds = 段位置，cx = 个数
; 返回：从开始位置后 cx 个 字
generate_year:  push ax
                push bx
                push si
                push cx
                mov bx,0
                mov si,0
generate_year_s:mov [bx][si],ax
                inc ax
                add si,2
                loop generate_year_s
                pop cx
                pop si
                pop bx
                pop ax
                ret

; 计算人均average
; 参数 cx = 个数 ，ds 段位置 
; 返回 无
average：  push ax
           push dx
           push cx
           push bx
           push si
           mov si,0
           mov bx,0
           add bx,42
           mov ax,[bx][si]
           mov dx,[bx].2[si]
           add bx,84
           div word ptr [bx][si]


                

;名称：show_table
;功能：初始化一行table 全部写空格 4+6+8+4+6+4+4=36
;参数：es
;返回：无



;名称：dtoc
;功能：将dword型数转变为表示十进制的字符串，字符串以0为结尾符
;参数：(ax)=dword型数据的低16位
;参数：(dx)=dword型数据的高16位
;参数：ds:si指向字符串的首地址
;返回：无






codesg ends
end start