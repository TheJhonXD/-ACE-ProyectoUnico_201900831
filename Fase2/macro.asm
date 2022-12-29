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

multiplicar macro cof, var, res
    push dx
    push ax

    mov al, cof
    mov bl, var
    mul bl
    mov res, al

    pop ax
    pop dx
endm

sumar macro N1, N2
    push dx
    push ax

    mov al, N1              ; MOV VARIABLE N1 A al
    add al, N2              ; SUMAR N1 Y N2
    ;add al, 30h             ; SUMAR RESULTADO CON 30H/48D
    mov N1, al              ; MOVER RESULTADO A N3

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

Potencia macro base, exp, pot
    push dx
    push ax

    mov cl, exp ;Se cambia el registro cx con el numero de iteraciones
    product:
    mov al, base ; Se mueve el valor de la base al registro al
    mov bl, pot ; Se mueve a bl el valor de variable pot
    mul bl ; Se multiplica a bl
    mov pot, al ; Se pone el resultado en la variable pot
    loop product ; Se retorna a la etiqueta product si cx no es cero

    pop ax
    pop dx
endm

ModoVideo macro video
	mov ah,0Fh	; Petición de obtención de modo de vídeo
	int 10h		; Llamada al BIOS
	mov video,AL

    mov ah,00h	; Función para establecer modo de video
	mov al,12h	; Modo gráfico resolución 640x480
	int 10h	
endm

ModoTexto macro video
    mov ah,00h		; Función para re-establecer modo de texto
	mov al,video		
	int 10h		    ; Llamada al BIOS	
endm

PrintEjes macro
    local ejeX, ejeY
    xor cx, cx
    ejeX:
        mov ah, 0Ch
        mov al, 20; Color rojo
        mov bh, 0h
        mov dx, 240
        int 10h
        inc cx
        cmp cx, 640
        jne ejeX

    xor dx, dx
    ejeY:
        mov ah, 0Ch
        mov al, 20; Color rojo
        mov bh, 0h
        mov cx, 320
        int 10h
        inc dx
        cmp dx, 480
        jne ejeY

endm

PrintDot macro px, py

    mov ah, 0Ch
    mov al, 7
    mov bh, 0h
    mov cx, px
    int 10h
    mov dx, py

endm


GetPoint macro x5, x4, x3, x2, x1, x0, result

    cmp x5, 00
    je cuatro



endm
