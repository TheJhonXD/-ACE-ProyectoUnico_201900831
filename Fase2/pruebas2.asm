DATA SEGMENT
	XC 	  DW 320  ; Pos X del centro
	YC 	  DW 240  ; Pos Y del centro
	TEMPO DW ?    ; Temporal
	
	COLOR DB 20   ; Color inicial
	LAST  DB "5"
	RAD   DW 50	  ; Radio del círculo
	HOR   DW 20
	VER   DW 10
	VID   DB ?	; Salvamos el modo de video :) 
	AUX DW 10
	X2 dw 0
	Y2 dw 10
    w dw (0)
    h dw (0)
    px dw 0
    py dw 0
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,SS:PILA
INICIO:
	MOV AX,DATA
	MOV DS,AX
	
	MOV AH,0Fh	; Petición de obtención de modo de vídeo
	INT 10h		; Llamada al BIOS
	MOV VID,AL

	MOV AH,00h	; Función para establecer modo de video
	MOV AL,13h	; Modo gráfico resolución 640x480
	INT 10h	

    xor cx, cx
    pix:
        mov ah, 0Ch
        mov al, 7
        mov bh, 0h
        mov dx, 100
        int 10h
        inc cx
        ;inc w
        cmp cx, 320
        jne pix

    xor dx, dx
    pix2:
        mov ah, 0Ch
        mov al, 7
        mov bh, 0h
        mov cx, 160
        int 10h
        inc dx
        ;inc h
        cmp dx, 200
        jne pix2
        
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


    ;Presiona una tecla
    mov ah,01h
    int 21h
    
			
	MOV AH,00h		; Función para re-establecer modo de texto
	MOV AL,VID		
	INT 10h		    ; Llamada al BIOS	
	
	MOV AH,004Ch
	INT 21h		
CODE ENDS
PILA SEGMENT STACK
      DB 777 DUP(?)
PILA ENDS
END INICIO