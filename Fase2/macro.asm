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

multiplicarFunc macro cof, var, res
    mov al, cof
    mov bl, var
    mul bl
    mov cl, al ; movemos el resultado a cx
    mov res, cx
endm

sumarFunc macro N1, N2

    mov ax, N1              ; MOV VARIABLE N1 A al
    adc ax, N2              ; SUMAR N1 Y N2
    ;add al, 30h             ; SUMAR RESULTADO CON 30H/48D
    mov N1, ax              ; MOVER RESULTADO A N3

endm

sumarFunc2 macro N1, N2
    
    mov al, N1              ; MOV VARIABLE N1 A al
    adc ax, N2              ; SUMAR N1 Y N2
    ;add al, 30h             ; SUMAR RESULTADO CON 30H/48D
    mov N2, ax              ; MOVER RESULTADO A N3

endm

restarFunc macro N1, N2
    mov ax, N1
    sbb ax, N2
    mov N2, ax
endm

restarFunc2 macro N1, N2
    mov ax, N1
    sbb ax, N2
    mov N1, ax
endm

sumar macro n1, n2

    mov al, n1              ; MOV VARIABLE N1 A al
    adc al, n2              ; SUMAR N1 Y N2
    ;add al, 30h             ; SUMAR RESULTADO CON 30H/48D
    mov n1, al            ; MOVER RESULTADO A N3

endm

restar macro n1, n2
    mov al, n1
    sbb al, n2
    mov n2, al
endm

Potencia macro base, exp, pot, cont
    local product
    push dx
    push ax

    ;xor cx, cx
    mov cl, exp ;Se cambia el registro cx con el numero de iteraciones   
    ;mov varAux, cl
    mov al, base
    mov pot, al
    product:
    mov al, base ; Se mueve el valor de la base al registro al
    mov bl, pot ; Se mueve a bl el valor de variable pot
    mul bl ; Se multiplica a bl
    mov pot, al ; Se pone el resultado en la variable pot
    inc cont  
    

    cmp cont, cl
    jne product          

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

ModoVideo macro video
	mov ah,0Fh	; Petición de obtención de modo de vídeo
	int 10h		; Llamada al BIOS
	mov video,al

    mov ah,00h	; Función para establecer modo de video
	mov al,13h	; Modo gráfico resolución 640x480
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
        mov dx, 100
        int 10h
        inc cx
        cmp cx, 320
        jne ejeX

    xor dx, dx
    ejeY:
        mov ah, 0Ch
        mov al, 20; Color rojo
        mov bh, 0h
        mov cx, 160
        int 10h
        inc dx
        cmp dx, 200
        jne ejeY

endm

PrintDot macro pmx, pmy
    xor cx, cx
    xor dx, dx
    mov cx, pmx
    mov dx, pmy
    mov ah, 0Ch
    mov al, 10
    mov bh, 0h
    int 10h

endm

PrintDot2 macro
    ;mov cx, pmx
    ;mov dx, pmy
    mov ah, 0Ch
    mov al, 10
    mov bh, 0h
    int 10h

endm

Pixel macro num1, num2, num3, num4

    mov cx, num1
    mov num3, cx

    mov dx, num2
    mov num4, dx

endm


GraficaX macro 
    xor cx, cx
        xor dx, dx
        MOV CX,161
        ;ADD CX,20
        MOV DX,99
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,162
        ;ADD CX,20
        MOV DX,96
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,163
        ;ADD CX,20
        MOV DX,91
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,164
        ;ADD CX,20
        MOV DX,84
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,165
        ;ADD CX,20
        MOV DX,75
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,166
        ;ADD CX,20
        MOV DX,64
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,167
        ;ADD CX,20
        MOV DX,51
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,168
        ;ADD CX,20
        MOV DX,36
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,169
        ;ADD CX,20
        MOV DX,19
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,170
        ;ADD CX,20
        MOV DX,0
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS






        xor cx, cx
        xor dx, dx
        MOV CX,159
        ;ADD CX,20
        MOV DX,99
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,158
        ;ADD CX,20
        MOV DX,96
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,157
        ;ADD CX,20
        MOV DX,91
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,156
        ;ADD CX,20
        MOV DX,84
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,155
        ;ADD CX,20
        MOV DX,75
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,154
        ;ADD CX,20
        MOV DX,64
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,153
        ;ADD CX,20
        MOV DX,51
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,152
        ;ADD CX,20
        MOV DX,36
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,151
        ;ADD CX,20
        MOV DX,19
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS

        xor cx, cx
        xor dx, dx
        MOV CX,150
        ;ADD CX,20
        MOV DX,0
        ;SUB DX,10

        MOV AH,0Ch		; Petición para escribir un punto
        MOV AL,10	; Color del pixel
        MOV BH,00h		; Página
        INT 10H			; Llamada al BIOS
endm


