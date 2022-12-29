DATA SEGMENT
	XC 	  DW 320  ; Pos X del centro
	YC 	  DW 240  ; Pos Y del centro
	TEMPO DW ?    ; Temporal
	
	COLOR DB 20   ; Color inicial
	LAST  DB "5"
	RAD   DW 50	  ; Radio del círculo
	HOR   DW ?
	VER   DW ?
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
	MOV AL,12h	; Modo gráfico resolución 640x480
	INT 10h	

    xor cx, cx
    pix:
        mov ah, 0Ch
        mov al, 7
        mov bh, 0h
        mov dx, 240
        int 10h
        inc cx
        ;inc w
        cmp cx, 640
        jne pix

    xor dx, dx
    pix2:
        mov ah, 0Ch
        mov al, 7
        mov bh, 0h
        mov cx, 320
        int 10h
        inc dx
        ;inc h
        cmp dx, 480
        jne pix2



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