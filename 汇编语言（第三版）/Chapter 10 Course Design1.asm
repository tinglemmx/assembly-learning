;把Chapter8 question7 中的代码 结果显示出来

assume cs:codesg
data segment
dw 21 dup(1975)
dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dw 11542,14430,15257,17800
data ends

data1 segment
dW 1680 dup(0)
data1 ends
;列1 年份 2byte： 0到41 
;列2 利润 4byte： 42到41+4*21=125
;列3 人数 2byte： 126到125+42=167
;列4 人均利润 4byte：168到167+4*21=251
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
        call average
        call dtoc

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
;为了避免人均超过65535用双字来存人均
;列1 年份 2byte： 0到41 
;列2 利润 4byte： 42到41+4*21=125
;列3 人数 2byte： 126到125+42=167
;列4 人均利润 4byte：168到167+4*21=251
average：  push cx
           mov bx,0
           mov ax,[bx].42   ;第bx+1行  第2列利润 低16位   
           mov dx,[bx].44   ;第bx+1行  第2列利润 高16位
           mov cx,[bx].126     ;第bx+1行  第3列人数 16位
           call divdw
           mov [bx].168,ax       ;第bx+1行  第4列人均利润 低16位
           mov [bx].170,dx      ;第bx+1行  第4列人均利润 高16位
           pop cx
           loop average
           ret

;说明：进行不会溢出的除数运算   被除数 dword   除数 word 结果 dword
;参数：  ax dword 型数据低16位
;        dx dword 数据的高16位
;        cx 除数
;结果： 返回 dx = 结果的高16位  
;           ax = 结果的低16位  
;           cx = 余数          
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

;名称：show_table
;功能：初始化一行table 全部写空格 4+6+8+4+6+4+4=36
;参数：es
;返回：无



;名称：dtoc
;功能：将dword型数转变为表示十进制的字符串，字符串以0为结尾符
;参数：(ax)=dword型数据的低16位
;参数：(dx)=dword型数据的高16位
;参数：es:si指向字符串的首地址
;返回：无






codesg ends
end start