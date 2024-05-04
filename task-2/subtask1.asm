%include "../include/io.mac"

struc request 
    admin: resb 1
    prio: resb 1
    login_creds: resb 53  ; 2 bytes (short) + 51 bytes (string)
endstruc

section .text
    global sort_requests
    extern printf

sort_requests:
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; adresa vectorului requests
    mov ecx, [ebp + 12]     ; lungimea vectorului

    ; Initializăm indecșii și variabila temporară
    mov esi, 0              ; i = 0
    outer_loop:
        mov edi, ecx        ; edi = length

        dec edi             ; edi = length - 1
        inner_loop:
            cmp edi, esi    ; edi >= esi
            jl end_inner_loop  ; Dacă edi < esi, s-a terminat bucla internă

            ; Calculăm adresele pentru requests[j] și requests[j+1]
            mov eax, ebx            ; adresa de început a vectorului requests
            add eax, edi            ; adresa requests[j]
            mov edx, ebx            ; adresa de început a vectorului requests
            add edx, edi            ; adresa requests[j+1]

            ; Comparăm prioritățile
            mov al, [eax + request.prio]
            cmp al, [edx + request.prio]
            ja swap_requests        ; Dacă prio[j] > prio[j+1], facem swap

            ; Dacă prioritățile sunt egale, comparăm username-urile
            jne next_iteration      ; Dacă prio[j] != prio[j+1], mergem la următoarea iterație
            mov esi, 0              ; k = 0
            compare_usernames:
                mov al, [eax + request.login_creds + creds.username + esi]  ; caracterul curent din username[j]
                cmp al, [edx + request.login_creds + creds.username + esi]  ; caracterul curent din username[j+1]
                je continue_comparison  ; Dacă sunt egale, continuăm să comparăm următorii caractere
                ja swap_requests        ; Dacă caracterul curent din username[j] > username[j+1], facem swap
                jmp end_inner_loop      ; Altfel, terminăm bucla internă
                continue_comparison:
                    inc esi             ; Incrementăm indicele pentru a trece la următorul caracter
                    cmp esi, 51         ; Am ajuns la sfârșitul username-ului
                    jge next_iteration  ; Dacă am ajuns la sfârșit, mergem la următoarea iterație
                    jmp compare_usernames  ; Altfel, continuăm să comparăm caracterele
            next_iteration:
                dec edi             ; Decrementăm j pentru a trece la următorul element
                jmp inner_loop      ; Continuăm bucla internă
        end_inner_loop:

    ; Finalizăm sortarea
    jmp outer_loop          ; Continuăm bucla externă

    swap_requests:
        ; Facem swap între requests[j] și requests[j+1]
        mov eax, [eax + request.admin]         ; admin[j]
        xchg al, [edx + request.admin]         ; admin[j+1]
        mov [edx + request.admin], al

        mov eax, [eax + request.prio]          ; prio[j]
        xchg al, [edx + request.prio]          ; prio[j+1]
        mov [edx + request.prio], al

        mov eax, [eax + request.login_creds]   ; login_creds[j]
        mov edx, [edx + request.login_creds]   ; login_creds[j+1]
        mov [edx + creds.passkey], eax         ; passkey[j+1] = passkey[j]
        mov eax, [eax + creds.username]        ; username[j]
        mov [edx + creds.username], eax        ; username[j+1] = username[j]

        jmp end_inner_loop      ; Am terminat cu acest swap

    end_outer_loop:
    
    popa
    leave
    ret
