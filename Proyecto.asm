.286                            ; conjunto de instrucciones a usar
pila segment stack       		;segmento de pila
	     db 32 DUP('stack--')
pila ends

datos segment          ;segmento de datos, aquí van nuestras variables
	msg db  '1. Ingresar ecuacion', 13, 10  ;db significa defineme un byte se interprete defineme una localidad en memoria con el nombre de msg
    msg2 db '2. Imprimir la funcion almacenada', 13, 10
    msg3 db '3. Imprimir la derivada de dicha funcion', 13, 10
    msg4 db '4. Imprimir la integral de la funcion', 13, 10
    msg5 db '5. Graficar la funcion original, derivada o integral', 13, 10
    msg6 db '6. Encontrar los ceros de la funcion por medio del metodo de Newton', 13, 10
    msg7 db '7. Encontrar los ceros de la funcion por medio del metodo de Steffensen', 13, 10
    msg8 db '8. Salir de la aplicacion', 13, 10
    msg9 db '>>> Opc: $'
    message db 13, 10, 'El numero es: $'
datos ends

codigo segment 'code'            ;segmento de codigo acá empezaremos a programar
main proc FAR
            assume ss:pila, ds:datos, cs:codigo

            mov    ax,datos      ; guardo en el registro ax el valor de mi seg de datos
            mov    ds,ax         ; lo muevo a mi datasegment (segmento de datos) para poderlos usar

            ;------------ Mostrar menu ------------
            call mostrar_menu
            ;--------------------------------------

            call limpiar
            call posCursor
            call mostrar_menu

            mov    ah,4ch        ;funcion que finaliza un programa
            int    21h       

            ret
main endp                       ; fin del procedimiento main


mostrar_menu proc

    ;------------ Mostrar menu ------------
    mov    ah,09h         ;funcion para imprimir una cadena en pantalla
    lea    dx, msg   ; le digo que me imprima letrero 
    int    21h           ; interrupcion 21h 
    ;--------------------------------------

    ;------------ Pido la opcion ------------
    mov ah,01h
    int 21h
    sub al,48d ; ajusto para que aparezca el numero
    ;----------------------------------------  

    ;Guardo la opcion en cl
    mov cl,al
    ret

mostrar_menu endp


limpiar proc

    mov ah, 06h
    mov al, 00h
    mov bh, 07h
    mov cx, 0000h
    mov dx, 184fh
    int 10h

    ret

limpiar endp

posCursor proc

    mov ah,02h      ; funcion para posicionar el cursor en la pantalla
    mov bh,00h      ; modo de video
    mov dh,00h      ; columna donde se pondra
    mov dl,00h      ; fila donde se pondra
    int 10h

    ret

posCursor endp

codigo ends                     ; find del segmento de codigo
end main                        ; find del main