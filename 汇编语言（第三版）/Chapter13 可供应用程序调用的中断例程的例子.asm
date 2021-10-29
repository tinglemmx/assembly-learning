;功能：求一word型数据的平方
;参数：（ax）= 要计算的数据
;返回值：dx、ax
;本例子  求 2*3456^2  
assume cs:code
code segment
start:  mov ax,3456
        int 7ch     ;调用中断7ch的中断例程，计算ax中的数据的平方
        add ax,ax   ;低位求和  和下面一条语句用来达到*2的目的
        adc dx,dx   ;高位求和并计算进位  和上面一条语句用来达到*2的目的
        mov ax,4c00h
        int 21h
code end
end start



