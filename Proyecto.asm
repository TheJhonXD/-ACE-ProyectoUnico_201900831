.286                            ; conjunto de instrucciones a usar
pila segment stack       		;segmento de pila
	     db 32 DUP('stack--')
pila ends

datos segment          ;segmento de datos, aquí van nuestras variables
    ;--- MENU ---
	msg db  '1. Ingresar ecuacion', 13, 10  ;db significa defineme un byte se interprete defineme una localidad en memoria con el nombre de msg
    msg2 db '2. Imprimir la funcion almacenada', 13, 10
    msg3 db '3. Imprimir la derivada de dicha funcion', 13, 10
    msg4 db '4. Imprimir la integral de la funcion', 13, 10
    msg5 db '5. Graficar la funcion original, derivada o integral', 13, 10
    msg6 db '6. Encontrar los ceros de la funcion por medio del metodo de Newton', 13, 10
    msg7 db '7. Encontrar los ceros de la funcion por medio del metodo de Steffensen', 13, 10
    msg8 db '8. Salir de la aplicacion', 13, 10
    msg9 db '>>> Opc: $'

    salido db 13, 10, 'Presione una tecla para continuar... $'

    message db 13, 10, 'El numero es: $'
    opc2 db 13, 10, 'Opcion 2 $'
    opc3 db 13, 10, 'Opcion 3 $'
    opc4 db 13, 10, 'Opcion 4 $'
    opc5 db 13, 10, 'Opcion 5 $'
    opc6 db 13, 10, 'Opcion 6 $'
    opc7 db 13, 10, 'Opcion 7 $'
    opc8 db 13, 10, 'Opcion 8 $'

    ; Submenu de Ingresar ecuacion
    sub_msg  db 13, 10, '*** Elija el grado de la ecuacion ***'
    sub_msg1 db 13, 10, '1. Grado 1'
    sub_msg2 db 13, 10, '2. Grado 2'
    sub_msg3 db 13, 10, '3. Grado 3'
    sub_msg4 db 13, 10, '4. Grado 4'
    sub_msg5 db 13, 10, '5. Grado 5'
    sub_msg6 db 13, 10, '6. Salir menu ecuacion', 13, 10
    sub_msg7 db '>>> Opc: $'


    ;Mensaje de ingreso de coeficientes
    cof_msg  db 13, 10, 'Ingrese el coeficiente para el grado 0: $'
    cof_msg1 db 13, 10, 'Ingrese el coeficiente para el grado 1: $'
    cof_msg2 db 13, 10, 'Ingrese el coeficiente para el grado 2: $'
    cof_msg3 db 13, 10, 'Ingrese el coeficiente para el grado 3: $'
    cof_msg4 db 13, 10, 'Ingrese el coeficiente para el grado 4: $'
    cof_msg5 db 13, 10, 'Ingrese el coeficiente para el grado 5: $'

    ;Coeficientes
    u  db 0
    d  db 0
    c0 db 0
    c1 db 0
    c2 db 0
    c3 db 0
    c4 db 0
    c5 db 0


datos ends

codigo segment 'code'            ;segmento de codigo acá empezaremos a programar
main proc FAR
            assume ss:pila, ds:datos, cs:codigo

            mov    ax,datos      ; guardo en el registro ax el valor de mi seg de datos
            mov    ds,ax         ; lo muevo a mi datasegment (segmento de datos) para poderlos usar

            ;------------ Menú ------------
            mostrar_menu:
                call limpiar
                call posCursor
                ;------------ Mostrar menu ------------
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, msg  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 
                ;--------------------------------------

                ;------------ Pido la opcion ------------
                mov ah,01h
                int 21h
                ;sub al,48d      ; ajusto para que aparezca el numero
                ;----------------------------------------  

                ;mov cl,al       ;Guardo la opcion en cl


                cmp al,31h      ; compara las opciones que el usuario ingresa 
                je opcion1  ; si presiono 1 realizara un salto intermedio a la opcion 1
                cmp al,32h      ; si presiono 2 realiza el salto intermedio a la opcion 2
                je opcion2
                cmp al,33h
                je opcion3
                cmp al,34h
                je opcion4
                cmp al,35h
                je opcion5
                cmp al,36h
                je opcion6
                cmp al,37h
                je opcion7
                cmp al,38h
                je salir
            ;--------------------------------------

            jmp mostrar_menu

            opcion1:
                call menu_ecuacion 

            jmp mostrar_menu

            opcion2:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc2  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 

            jmp mostrar_menu

            opcion3:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc3  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 

            jmp mostrar_menu
            
            opcion4:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc4  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 

            jmp mostrar_menu

            opcion5:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc5  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 

            jmp mostrar_menu

            opcion6:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc6  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 

            jmp mostrar_menu

            opcion7:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc7  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 

            jmp mostrar_menu

            salir:
                mov    ah,4ch        ;funcion que finaliza un programa
                int    21h       

            ret
main endp                       ; fin del procedimiento main


;Submenu ecuacion
menu_ecuacion proc

    mostrar_submenu:
        call limpiar
        call posCursor

        ;-----  Muestra el submenu ------------
        mov    ah, 09h      ;funcion para imprimir una cadena en pantalla
        lea    dx, sub_msg  ; le digo que me imprima letrero 
        int    21h          ; interrupcion 21h 
        ;--------------------------------------

        ;------------ Pido la opcion ------------
        mov ah,01h
        int 21h
        ;sub al,48d      ; ajusto para que aparezca el numero
        ;----------------------------------------  


        cmp al,31h      ; compara las opciones que el usuario ingresa 
        je subaux_opcion1  ; si presiono 1 realizara un salto intermedio a la subaux_opcion 1
        cmp al,32h      ; si presiono 2 realiza el salto intermedio a la subaux_opcion 2
        je subaux_opcion2
        cmp al,33h
        je subaux_opcion3
        cmp al,34h
        je subaux_opcion4
        cmp al,35h
        je subaux_opcion5
        cmp al,36h
        je subaux_opcion6

    jmp mostrar_submenu

    subaux_opcion1:
        jmp sub_opcion1
    subaux_opcion2:
        jmp sub_opcion2
    subaux_opcion3:
        jmp sub_opcion3
    subaux_opcion4:
        jmp sub_opcion4
    subaux_opcion5:
        jmp sub_opcion5
    subaux_opcion6:
        jmp salirSubmenu

    sub_opcion1:
        ;mostrar mensaje de coeficiente 0
        mov ah, 09h
        lea dx, cof_msg
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c0, al  ; muevo el resultado a c0
        ;------------------------------

        ;mostrar mensaje de coeficiente 1
        mov ah, 09h
        lea dx, cof_msg1
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c1, al  ; muevo el resultado a c1
        ;------------------------------
    jmp salirSubmenu


    sub_opcion2:
        ;mostrar mensaje de coeficiente 0
        mov ah, 09h
        lea dx, cof_msg
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c0, al  ; muevo el resultado a c0
        ;------------------------------

        ;mostrar mensaje de coeficiente 1
        mov ah, 09h
        lea dx, cof_msg1
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c1, al  ; muevo el resultado a c1
        ;------------------------------

        ;mostrar mensaje de coeficiente 2
        mov ah, 09h
        lea dx, cof_msg2
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c2, al  ; muevo el resultado a c2
        ;------------------------------
    jmp salirSubmenu

    sub_opcion3:
        ;mostrar mensaje de coeficiente 0
        mov ah, 09h
        lea dx, cof_msg
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c0, al  ; muevo el resultado a c0
        ;------------------------------

        ;mostrar mensaje de coeficiente 1
        mov ah, 09h
        lea dx, cof_msg1
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c1, al  ; muevo el resultado a c1
        ;------------------------------

        ;mostrar mensaje de coeficiente 2
        mov ah, 09h
        lea dx, cof_msg2
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c2, al  ; muevo el resultado a c2
        ;------------------------------

        ;mostrar mensaje de coeficiente 3
        mov ah, 09h
        lea dx, cof_msg3
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c3, al  ; muevo el resultado a c3
        ;------------------------------
    jmp salirSubmenu

    sub_opcion4:
        ;mostrar mensaje de coeficiente 0
        mov ah, 09h
        lea dx, cof_msg
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c0, al  ; muevo el resultado a c0
        ;------------------------------

        ;mostrar mensaje de coeficiente 1
        mov ah, 09h
        lea dx, cof_msg1
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c1, al  ; muevo el resultado a c1
        ;------------------------------

        ;mostrar mensaje de coeficiente 2
        mov ah, 09h
        lea dx, cof_msg2
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c2, al  ; muevo el resultado a c2
        ;------------------------------

        ;mostrar mensaje de coeficiente 3
        mov ah, 09h
        lea dx, cof_msg3
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c3, al  ; muevo el resultado a c3
        ;------------------------------

        ;mostrar mensaje de coeficiente 4
        mov ah, 09h
        lea dx, cof_msg4
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c4, al  ; muevo el resultado a c4
        ;------------------------------
    jmp salirSubmenu

    sub_opcion5:
        ;mostrar mensaje de coeficiente 0
        mov ah, 09h
        lea dx, cof_msg
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c0, al  ; muevo el resultado a c0
        ;------------------------------

        ;mostrar mensaje de coeficiente 1
        mov ah, 09h
        lea dx, cof_msg1
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c1, al  ; muevo el resultado a c1
        ;------------------------------

        ;mostrar mensaje de coeficiente 2
        mov ah, 09h
        lea dx, cof_msg2
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c2, al  ; muevo el resultado a c2
        ;------------------------------

        ;mostrar mensaje de coeficiente 3
        mov ah, 09h
        lea dx, cof_msg3
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c3, al  ; muevo el resultado a c3
        ;------------------------------

        ;mostrar mensaje de coeficiente 4
        mov ah, 09h
        lea dx, cof_msg4
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c4, al  ; muevo el resultado a c4
        ;------------------------------

        ;mostrar mensaje de coeficiente 5
        mov ah, 09h
        lea dx, cof_msg5
        int 21h

        ;Captura dos numeros de entrada
        call capTwoNums
        
        ;----- Unir los numeros --------
        call unirNums
        mov c5, al  ; muevo el resultado a c5
        ;------------------------------
    jmp salirSubmenu


    salirSubmenu:
        ;mostrar mensaje de salido
        mov ah, 09h
        lea dx, salido
        int 21h
        ;-------------------------
        mov ah,01h
        int 21h

    ret
menu_ecuacion endp


;Captura dos numeros en la entrada
capTwoNums proc

    ;------------ Pido la opcion ------------
    ;Primer numero (decena)
    mov ah,01h
    int 21h
    sub al,30h      ; ajusto para que aparezca el numero
    mov d, al

    ; Segundo numero (unidad)
    mov ah,01h
    int 21h
    sub al,30h      ; ajusto para que aparezca el numero
    mov u, al
    ;----------------------------------------

    ret

capTwoNums endp


;Muestra los dos numeros en memoria
showTwoNums proc

    AAM
    mov bx, ax
    mov ah, 02h
    mov dl, bh
    add dl, 30h
    int 21h

    mov ah, 02h
    mov dl, bl
    add dl, 30h
    int 21h

    ret

showTwoNums endp

;Convertir decena y unidad en uno
unirNums proc

    ;Guardando en variable la unidad y decena por multiplicacion y suma
    mov al, d
    mov bl, 10
    mul bl
    add al, u

    ret

unirNums endp


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