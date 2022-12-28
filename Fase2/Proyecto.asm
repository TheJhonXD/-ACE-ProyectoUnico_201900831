;.286                            ; conjunto de instrucciones a usar
include macro.asm
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
    opc2 db 13, 10, 'Funcion almacenada: $'
    opc3 db 13, 10, 'Derivada de la funcion: $'
    opc4 db 13, 10, 'Integral de la funcion: $'
    opc5 db 13, 10, 'Opcion 5 $'
    opc6 db '** Metodo de Steffensen ** $', 13, 10
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

    ;Mensaje de ingreso de parametros metodo de steffensen
    met_msg db 13, 10, 'Aproximacion inicial: $'
    met_msg1 db 13, 10, 'Numero de iteraciones máximo: $'
    met_msg2 db 13, 10, 'Coeficiente de tolerancia: $'
    met_msg3 db 13, 10, 'Grado de tolerancia: $'
    met_msg4 db 13, 10, 'Límite superior del método: $'
    met_msg5 db 13, 10, 'Límite inferior: $'

    ;Coeficientes
    u  db 00
    d  db 00
    c0 db 00
    c1 db 00
    c2 db 00
    c3 db 00
    c4 db 00
    c5 db 00
    
    ;Coeficientes derivados
    cd1 db 00
    cd2 db 00
    cd3 db 00
    cd4 db 00
    cd5 db 00

    ;Coeficientes integrados
    ci0 db 00
    ci1 db 00
    ci2 db 00
    ci3 db 00
    ci4 db 00
    ci5 db 00

    ;Literales
    l1 db 'X$'
    l2 db 'X^2$'
    l3 db 'X^3$'
    l4 db 'X^4$'
    l5 db 'X^5$'
    l6 db 'X^6$'

    ;Parametros
    p_init db 00
    p_iter db 00
    p_coef db 00
    p_grad db 00
    p_lsup db 00
    p_linf db 00

    ;Variables Steffensen
    s_x db 00


    ;signos
    sig_suma  db ' + $'
    sig_resta db ' - $'
    sig_punto db ' . $'
    let_C     db 'C$'

    ;ERROR
    msg_error db 'Entrada no valida$'

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
                call printEqL5
                call pressAnyKey

            jmp mostrar_menu

            opcion3:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc3  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 
                call derivada
                call pressAnyKey
            jmp mostrar_menu
            
            opcion4:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc4  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 
                call integral
                call pressAnyKey

            jmp mostrar_menu

            opcion5:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc5  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 
                call pressAnyKey
            jmp mostrar_menu

            opcion6:
                call menu_steff_new
                call pressAnyKey
            jmp mostrar_menu

            opcion7:
                mov    ah,09h   ;funcion para imprimir una cadena en pantalla
                lea    dx, opc7  ; le digo que me imprima letrero 
                int    21h      ; interrupcion 21h 
                call pressAnyKey
            jmp mostrar_menu

            salir:
                mov    ah,4ch        ;funcion que finaliza un programa
                int    21h       

            ret
main endp                       ; fin del procedimiento main


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
        call resetCof
        jmp sub_opcion1
    subaux_opcion2:
        call resetCof
        jmp sub_opcion2
    subaux_opcion3:
        call resetCof
        jmp sub_opcion3
    subaux_opcion4:
        call resetCof
        jmp sub_opcion4
    subaux_opcion5:
        call resetCof
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

menu_steff_new proc

    call limpiar
    call posCursor
    ;Imprime titulo de menu
    Print opc6
    ;Pregunta
    Print met_msg
    ;Captura dos numeros de entrada
    call capTwoNums
    ;----- Unir los numeros --------
    call unirNums
    mov p_init, al  ; muevo el resultado a p_init
    ;------------------------------
    ;Pregunta
    Print met_msg1
    ;Captura dos numeros de entrada
    call capTwoNums
    ;----- Unir los numeros --------
    call unirNums
    mov p_iter, al  ; muevo el resultado a p_iter
    ;------------------------------
    ;Pregunta
    Print met_msg2
    ;Captura dos numeros de entrada
    call capTwoNums
    ;----- Unir los numeros --------
    call unirNums
    mov p_coef, al  ; muevo el resultado a p_coef
    ;------------------------------
    ;Pregunta
    Print met_msg3
    ;Captura dos numeros de entrada
    call capTwoNums
    ;----- Unir los numeros --------
    call unirNums
    mov p_grad, al  ; muevo el resultado a p_grad
    ;------------------------------
    ;Pregunta
    Print met_msg4
    ;Captura dos numeros de entrada
    call capTwoNums
    ;----- Unir los numeros --------
    call unirNums
    mov p_lsup, al  ; muevo el resultado a p_lsup
    ;------------------------------
    ;Pregunta
    Print met_msg5
    ;Captura dos numeros de entrada
    call capTwoNums
    ;----- Unir los numeros --------
    call unirNums
    mov p_linf, al  ; muevo el resultado a p_linf
    ;------------------------------

    ret

menu_steff_new endp


;Captura dos numeros en la entrada
capTwoNums proc

    ;------------ Pido la opcion ------------
    decena:
        ;Primer numero (decena)
        mov ah,01h
        int 21h
        sub al,30h      ; ajusto para que aparezca el numero
        mov d, al

    ; Segundo numero (unidad)
    cetena:
        mov ah,01h
        int 21h
        sub al,30h      ; ajusto para que aparezca el numero
        mov u, al
        ;----------------------------------------
    
    salirCapTwoNums:
        ret

capTwoNums endp


;Muestra los dos numeros en memoria
showTwoNums proc
    AAM
    mov bx, ax

    ;Compruebo si el registro bh es 0, si lo es no imprimo su contenido
    cmp bh, 00
    je unNumero

    mov ah, 02h
    mov dl, bh
    add dl, 30h
    int 21h

    ;Imprimo el segundo numero
    unNumero:
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

;Pone en cero los coeficientes
resetCof proc

    mov c0, 00
    mov c1, 00
    mov c2, 00
    mov c3, 00
    mov c4, 00
    mov c5, 00

    mov cd1, 00
    mov cd2, 00
    mov cd3, 00
    mov cd4, 00
    mov cd5, 00

    mov ci0, 00
    mov ci1, 00
    mov ci2, 00
    mov ci3, 00
    mov ci4, 00
    mov ci5, 00

    ret

resetCof endp

;imprime en pantalla una ecuacion de grado 1
printEqL1 proc

    print_gr1:
        cmp c1,00      ; compara las opciones que el usuario ingresa 
        je print_gr0  ; si es igual a 0 salta a print_gr0

        ;Muestra el mensaje en pantalla
        mov al, c1
        call showTwoNums

        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l1  ;muestra la literal x
        int 21h

        ;Muestra el signo de suma
        mov ah, 09h
        lea dx, sig_suma
        int 21h

    print_gr0:
        cmp c0,00      ; compara las opciones que el usuario ingresa 
        je salidoEqL1  ; si no es igual a 0 salta a salidoEqL1

        ;Muestra el mensaje en pantalla
        mov al, c0
        call showTwoNums

    salidoEqL1:
        ret

printEqL1 endp

;imprime en pantalla una ecuacion de grado 2
printEqL2 proc
    cmp c2,00      ; compara las opciones que el usuario ingresa 
    je salidoEqL2  ; si es igual a 0 salta a salidoEqL2

    ;Muestra el mensaje en pantalla
    mov al, c2
    call showTwoNums

    ;Muestra el mensaje en pantalla
    mov ah, 09h
    lea dx, l2  ;muestra la literal x^2
    int 21h

    cmp c1, 00
    jne salidoEqL2aux
    cmp c0, 00
    jne salidoEqL2aux
    jmp salidoEqL2

    salidoEqL2aux:
        ;Muestra el signo de suma
        mov ah, 09h
        lea dx, sig_suma
        int 21h

    salidoEqL2:
        call printEqL1

    ret

printEqL2 endp

;imprime en pantalla una ecuacion de grado 3
printEqL3 proc
    cmp c3,00      ; compara las opciones que el usuario ingresa 
    je salidoEqL3  ; si es igual a 0 salta a salidoEqL3

    ;Muestra el mensaje en pantalla
    mov al, c3
    call showTwoNums

    ;Muestra el mensaje en pantalla
    mov ah, 09h
    lea dx, l3  ;muestra la literal x^3
    int 21h

    cmp c2, 00
    jne salidoEqL3aux
    cmp c1, 00
    jne salidoEqL3aux
    cmp c0, 00
    jne salidoEqL3aux
    jmp salidoEqL3

    salidoEqL3aux:
        ;Muestra el signo de suma
        mov ah, 09h
        lea dx, sig_suma
        int 21h

    salidoEqL3:
        call printEqL2

    ret

printEqL3 endp

;imprime en pantalla una ecuacion de grado 4
printEqL4 proc
    cmp c4,00      ; compara las opciones que el usuario ingresa 
    je salidoEqL4  ; si es igual a 0 salta a salidoEqL4

    ;Muestra el mensaje en pantalla
    mov al, c4
    call showTwoNums

    ;Muestra el mensaje en pantalla
    mov ah, 09h
    lea dx, l4  ;muestra la literal x^4
    int 21h

    cmp c3, 00
    jne salidoEqL4aux
    cmp c2, 00
    jne salidoEqL4aux
    cmp c1, 00
    jne salidoEqL4aux
    cmp c0, 00
    jne salidoEqL4aux
    jmp salidoEqL4

    salidoEqL4aux:
        ;Muestra el signo de suma
        mov ah, 09h
        lea dx, sig_suma
        int 21h

    salidoEqL4:
        call printEqL3

    ret

printEqL4 endp

;imprime en pantalla una ecuacion de grado 5
printEqL5 proc
    cmp c5,00      ; compara las opciones que el usuario ingresa 
    je salidoEqL5  ; si es igual a 0 salta a salidoEqL5

    ;Muestra el mensaje en pantalla
    mov al, c5
    call showTwoNums

    ;Muestra el mensaje en pantalla
    mov ah, 09h
    lea dx, l5  ;muestra la literal x^5
    int 21h

    cmp c4, 00
    jne salidoEqL5aux
    cmp c3, 00
    jne salidoEqL5aux
    cmp c2, 00
    jne salidoEqL5aux
    cmp c1, 00
    jne salidoEqL5aux
    cmp c0, 00
    jne salidoEqL5aux
    jmp salidoEqL5

    salidoEqL5aux:
        ;Muestra el signo de suma
        mov ah, 09h
        lea dx, sig_suma
        int 21h

    salidoEqL5:
        call printEqL4

    ret

printEqL5 endp

mostrar_suma proc
    ;Muestra el signo de suma
    mov ah, 09h
    lea dx, sig_suma
    int 21h
    ret
mostrar_suma endp


derivada proc

    ; llama al procedimiento derivar
    call derivar
    
    cmp cd5,00      ; compara la variable con 0
    je print_derG3  ; si es igual a 0 salta a print_derG3

    ;Muestra el mensaje en pantalla
    mov al, cd5
    call showTwoNums
    
    ;Muestra el mensaje en pantalla
    mov ah, 09h
    lea dx, l4  ;muestra la literal x^4
    int 21h

    cmp cd4, 00
    jne print_derG3aux
    cmp cd3, 00
    jne print_derG2aux
    cmp cd2, 00
    jne print_derG1aux
    cmp cd1, 00
    jne print_derG0aux
    jmp salir_derivada
    ;-------------------------------------------------------------


    print_derG3aux:
        call mostrar_suma
        jmp print_derG3
    print_derG2aux:
        call mostrar_suma
        jmp print_derG2
    print_derG1aux:
        call mostrar_suma
        jmp print_derG1
    print_derG0aux:
        call mostrar_suma
        jmp print_derG0

    print_derG3:
        cmp cd4,00      ; compara la variable con 0
        je print_derG2  ; si es igual a 0 salta a print_derG2

        ;Muestra el mensaje en pantalla
        mov al, cd4
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l3  ;muestra la literal x^3
        int 21h

        cmp cd3, 00
        jne print_derG2aux
        cmp cd2, 00
        jne print_derG1aux
        cmp cd1, 00
        jne print_derG0aux
        jmp salir_derivada
    ;--------------------------------------------------------------
    print_derG2:
        cmp cd3,00      ; compara la variable con 0
        je print_derG1  ; si es igual a 0 salta a print_derG1

        ;Muestra el mensaje en pantalla
        mov al, cd3
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l2  ;muestra la literal x^2
        int 21h

        cmp cd2, 00
        jne print_derG1aux
        cmp cd1, 00
        jne print_derG0aux
        jmp salir_derivada
    ;---------------------------------------------------------------
    print_derG1:
        cmp cd2,00      ; compara la variable con 0
        je print_derG0  ; si es igual a 0 salta a salidoEqL5aux

        ;Muestra el mensaje en pantalla
        mov al, cd2
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l1  ;muestra la literal x
        int 21h

        cmp cd1, 00
        jne print_derG0aux
        jmp salir_derivada
    ;----------------------------------------------------------------
    print_derG0:
        cmp cd1,00      ; compara la variable con 0
        je salir_derivada  ; si es igual a 0 salta a salidoEqL5

        ;Muestra el mensaje en pantalla
        mov al, cd1
        call showTwoNums
        
    salir_derivada:
        ret

derivada endp


;Realiza la derivada de la funcion
derivar proc

    cmp c1, 00
    je derG2

    mov al, c1
    mov cd1, al

    derG2:
        cmp c2, 00
        je derG3

        mov al, c2
        mov bl, 2
        mul bl
        mov cd2, al
    
    derG3:
        cmp c3, 00
        je derG4

        mov al, c3
        mov bl, 3
        mul bl
        mov cd3, al

    derG4:
        cmp c4, 00
        je derG5

        mov al, c4
        mov bl, 4
        mul bl
        mov cd4, al

    derG5:
        cmp c5, 00
        je salirDerivarG1

        mov al, c5
        mov bl, 5
        mul bl
        mov cd5, al

    salirDerivarG1:
        ret


derivar endp

integral proc

    ; llama al procedimiento integrar
    call integrar
    
    cmp ci5,00      ; compara la variable con 0
    je print_intG4  ; si es igual a 0 salta a print_derG3

    ;Muestra el mensaje en pantalla
    mov al, ci5
    call showTwoNums
    
    ;Muestra el mensaje en pantalla
    mov ah, 09h
    lea dx, l6  ;muestra la literal x^6
    int 21h

    cmp ci4, 00
    jne print_intG4aux
    cmp ci3, 00
    jne print_intG3aux
    cmp ci2, 00
    jne print_intG2aux
    cmp ci1, 00
    jne print_intG1aux
    cmp ci0, 00
    jne print_intG0aux
    jmp salir_integral
    ;-------------------------------------------------------------


    print_intG4aux:
        call mostrar_suma
        jmp print_intG4
    print_intG3aux:
        call mostrar_suma
        jmp print_intG3
    print_intG2aux:
        call mostrar_suma
        jmp print_intG2
    print_intG1aux:
        call mostrar_suma
        jmp print_intG1
    print_intG0aux:
        call mostrar_suma
        jmp print_intG0

    print_intG4:
        cmp ci4,00      ; compara la variable con 0
        je print_intG3  ; si es igual a 0 salta a print_derG2

        ;Muestra el mensaje en pantalla
        mov al, ci4
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l5  ;muestra la literal x^5
        int 21h

        cmp ci3, 00
        jne print_intG3aux
        cmp ci2, 00
        jne print_intG2aux
        cmp ci1, 00
        jne print_intG1aux
        cmp ci0, 00
        jne print_intG0aux
        jmp salir_integral
    ;--------------------------------------------------------------
    print_intG3:
        cmp ci3,00      ; compara la variable con 0
        je print_intG2  ; si es igual a 0 salta a print_derG1

        ;Muestra el mensaje en pantalla
        mov al, ci3
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l4  ;muestra la literal x^2
        int 21h

        cmp ci2, 00
        jne print_intG2aux
        cmp ci1, 00
        jne print_intG1aux
        cmp ci0, 00
        jne print_intG0aux
        jmp salir_integral
    ;---------------------------------------------------------------
    print_intG2:
        cmp ci2,00      ; compara la variable con 0
        je print_intG1  ; si es igual a 0 salta a salidoEqL5aux

        ;Muestra el mensaje en pantalla
        mov al, ci2
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l3  ;muestra la literal x
        int 21h

        cmp ci1, 00
        jne print_intG1aux
        cmp ci0, 00
        jne print_intG0aux
        jmp salir_integral
    ;----------------------------------------------------------------
    print_intG1:
        cmp ci1,00      ; compara la variable con 0
        je print_intG0  ; si es igual a 0 salta a salidoEqL5

        ;Muestra el mensaje en pantalla
        mov al, ci1
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l2  ;muestra la literal x
        int 21h

        cmp ci0, 00
        jne print_intG0aux
        jmp salir_integral

    print_intG0:
        cmp ci0,00      ; compara la variable con 0
        je salir_integral  ; si es igual a 0 salta a salidoEqL5

        ;Muestra el mensaje en pantalla
        mov al, ci0
        call showTwoNums
        
        ;Muestra el mensaje en pantalla
        mov ah, 09h
        lea dx, l1  ;muestra la literal x
        int 21h
    
    mov ah, 09h
    lea dx, sig_suma  ;muestra la literal x
    int 21h

    mov ah, 09h
    lea dx, let_C  ;muestra la literal C
    int 21h

    salir_integral:
        ret

integral endp


;dividirCof proc
;    xor ax, ax
;    mov al, c1
;dividirCof endp


integrar proc
    mov al, c0
    mov ci0, al

    cmp c1, 00
    je intG2
    dividirCof c1, 2, ci1
    ;mov ci1, al
    ;mov al, c1
    ;mov cd1, al

    intG2:
        cmp c2, 00
        je intG3

        dividirCof c2, 3, ci2
        ;mov ci2, al
    
    intG3:
        cmp c3, 00
        je intG4

        dividirCof c3, 4, ci3
        ;mov ci3, al

    intG4:
        cmp c4, 00
        je intG5

        dividirCof c4, 5, ci4
        ;mov ci4, al

    intG5:
        cmp c5, 00
        je salirIntegrarG1

        dividirCof c5, 6, ci5
        ;mov ci5, al

    salirIntegrarG1:
        ret

integrar endp


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