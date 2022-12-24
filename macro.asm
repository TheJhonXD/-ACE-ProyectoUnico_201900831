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