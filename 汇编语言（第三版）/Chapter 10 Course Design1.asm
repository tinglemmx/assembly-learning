;把Chapter8 question7 中的代码 结果显示出来

assume cs:codesg
data segment
dd 21 dup(1975)
dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
dd 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dd 11542,14430,15257,17800
dd 21 dup(0)    ;不预留空间可能会导致覆盖掉其他的内容 导致程序异常
data ends
;列1 年份 4byte： 0到84
;列2 利润 4byte： 85到168
;列3 人数 4byte： 169到252
;列4 人均利润 4byte：253到336 写最后
data1 segment
    db 21,4,1,1,5,24
data1 ends
;0=总共行 
;1=总共列
;2=当前的行 
;3=当前列
;4=颜色
;5=行宽

stack segment
	db 32 dup(0)
stack ends


codesg segment
start:  mov ax,data
        mov ds,ax
        mov ax,data1
        mov es,ax
        mov ah,0fh
        int 10h
        mov ah,0h
        int 10h

        ;bx 代表列
        mov cx,21
        mov ax,1975
        call generate_year
        call average 

        mov si,2
        mov cx,2
init:   mov al,es:[si]
        sub al,1
        mov es:[si],al
        inc si
        loop init
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0

s0:     mov cl,es:[2]
        mov ch,es:[3]
        call dtoc
        mov ch,es:[3]
        inc ch
        mov ah,es:[1]
        mov es:[3],ch
        sub ah,ch
        mov ch,0
        mov cl,ah
        jcxz s1
        jmp s0
s1:     mov cl,es:[2]
        inc cl
        mov es:[2],cl
        mov byte ptr es:[3],0
        mov al,es:[0]
        sub al,cl
        mov ch,0
        mov cl,al
        jcxz s_ok
        jmp s0
s_ok:   mov ax,4c00h
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
                add si,4
                loop generate_year_s
                pop cx
                pop si
                pop bx
                pop ax
                ret

; 计算人均average
; 参数 cx = 个数 ，ds 段位置 , 写道表格的最后
; 返回 无
;为了避免人均超过65535用双字来存人均
;列1 年份 4byte： 0到83   
;列2 利润 4byte： 84到169   54h
;列3 人数 4byte： 168到251   A8H
;列4 人均利润 4byte：252到335 写最后  fch
average:   mov bx,0
average_s0:push cx
           mov ax,[bx].84   ;第bx+1行  第2列利润 低16位   
           mov dx,[bx].86   ;第bx+1行  第2列利润 高16位
           mov cx,[bx].168     ;第bx+1行  第3列人数 16位
           call divdw
           mov [bx].252,ax       ;第bx+1行  第4列人均利润 低16位
           mov [bx].254,dx      ;第bx+1行  第4列人均利润 高16位
           add bx,4
           pop cx
           loop average_s0
           ret

;说明：进行不会溢出的除数运算   被除数 dword   除数 word 结果 dword
;参数：  ax dword 型数据低16位
;        dx dword 数据的高16位u
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

; dtoc说明：将word型数据变为表示十进制数的字符串，字符串以0为结尾符。
; 参数：es;di指向要转的首地址
; 参数：ds:si指向字符串的首地址
; 参数：通告cl=行数 ch = 列数
; 参数：行数列数在外面循环 控制输入和输出的位置均在主程序
; 结果：无返回，循环用行控制

dtoc:       mov ax,0
            push ax
            mov al,cl
            mov cl,4
            mul cl
            mov si,ax
            mov al,es:[3]
            mov ah,0
            mul cl
            mul byte ptr es:[0]
            mov bx,ax
            mov ax,[bx][si]
            mov dx,[bx].2[si]
dtoc_s:     mov cx,10
            call divdw
            add cx,48
            push cx
            mov cx,ax
            add cx,dx
            jcxz show_str 
            jmp dtoc_s        





; show_str说明：根据输入的行列和颜色 来显示字符串，字符串后面跟个0表示字符串结束
; 参数：cl表示行
; 参数：ch表示列
; 参数：dl表示颜色     
; 结果：根据输入的行列和颜色 来显示字符串

show_str:   mov ah,0
            mov al,es:[2]
            add al,0  ;这个定义从第几行输出
            mov cl,160
            mul cl
            mov bx,ax
            mov ah,0            
            mov al,es:[3]
            mov cl,es:[5]
            mul cl
            mov si,ax
            mov ax,0b800h
            mov ds,ax
change:     pop ax
            mov cx,ax
            mov ah,es:[4]
            jcxz ok_show_str
            mov [bx][si],ax
            add si,2
            jmp short change
ok_show_str:mov ax,data
            mov ds,ax
            ret






codesg ends
end start