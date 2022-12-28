;Realiza una division
dividirCof macro divisor, dividendo, var
    push dx
    push ax

    xor ax, ax
    mov al, divisor
    mov bl, dividendo
    div bl
    mov var, al

    pop ax
    pop dx
endm

;Imprime una cadena
Print macro cadena
    push dx
    push ax

    mov ah, 09h
    mov dx, offset cadena
    int 21h

    pop ax
    pop dx
endm