.model small

.stack 64

.data
msg0  db  'Digite un numero: $'
msg1  db  'El numero es cero $'
msg2  db  'El numero es positivo $'
msg3  db  'El numero es negativo $'

num db 0

.code

    inicio proc FAR

    mov ax, @data
    mov ds, ax


    mov ah, 09h
    lea dx, msg0
    int 21h

    ;leer numero de 2 digitos
    mov ah, 01h
    int 21h
    sub al, 30h
    mov num, al
    int 21h
    sub al, 30h
    mov ah, num

    mov bl, num

    ;comparacion
    cmp bl, 0
    je igual
    jg mayor
    jl menor 

    igual:
        mov ah, 09h
        lea dx, msg1
        int 21h
        jmp salir

    mayor:
        mov ah, 09h
        lea dx, msg2
        int 21h
        jmp salir

    menor:
        mov ah, 09h
        lea dx, msg3
        int 21h
        jmp salir
    
    salir:
        mov ax, 4c00h
        int 21h
    inicio endp
end

;end INICIO
;end