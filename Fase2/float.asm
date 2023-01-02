;.286                            ; conjunto de instrucciones a usar
pila segment stack       		;segmento de pila
	     db 32 DUP('stack--')
pila ends

datos segment          ;segmento de datos, aquí van nuestras variables
    ;--- MENU ---
	msg db  'Examen final - VD2022 - Jhonatan Josue Tzunun Yax - 201900831', 13, 10, '$'
    salido db 13, 10, 'Presione una tecla para continuar... $'
    a: dq 4.56 
    b: dq 4.57
    res: dq ?
    res2 db ?
datos ends

codigo segment 'code'            ;segmento de codigo acá empezaremos a programar
main proc FAR
            assume ss:pila, ds:datos, cs:codigo

            mov    ax,datos      ; guardo en el registro ax el valor de mi seg de datos
            mov    ds,ax         ; lo muevo a mi datasegment (segmento de datos) para poderlos usar
            call limpiar
            call posCursor
            fld qword ptr [a] ;load a into st0
            ;fld qword ptr [b]   ;st0 = a * a = a^2
            fadd qword ptr [b]
            fstp qword ptr [res2]
            frndint

            mov ah, 02h
            mov dl, res2
            ;add dl, 30h
            int 21h
            call pressAnyKey
            
            ;fstp qword [res]
            ;push qword ptr [res]
            ;extrn _printf
            ;call _printf
            ;call printf  ; Print string

            ;call printf
            salir:
                mov    ah,4ch        ;funcion que finaliza un programa
                int    21h       

            ret
main endp                       ; fin del procedimiento main

;Espera a que presione una letra
pressAnyKey proc
    ;mostrar mensaje de salido
    mov ah, 09h
    lea dx, salido
    int 21h

    ;------------ Espero que presione ------------
    mov ah,01h
    int 21h
    ;sub al,48d      ; ajusto para que aparezca el numero
    ;--------------------------------------------- 

    ret

pressAnyKey endp

;Limpia la ventana
limpiar proc

    mov ah, 06h     ; funcino que desplaza las lineas hacia arriba
    mov al, 00h     ; Numero de lineas a desplazar
    mov bh, 07h     ; atributo a usar en las lineas
    mov cx, 0000h   ; linea y columna donde comienza la ventana
    mov dx, 184fh   ; linea y columna donde termina la ventana
    int 10h

    ret

limpiar endp

;Posiciona el cursor al inicio
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