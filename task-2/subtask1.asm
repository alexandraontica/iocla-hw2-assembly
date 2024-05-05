%include "../include/io.mac"

; declare your structs here

; struc creds
;     passkey: resw 1
;     username: resb 51
; endstruc

; struc request 
;     admin: resb 1
;     prio: resb 1
;     login_creds: resb 53  ; 2 bytes (short) + 51 bytes (string)
; endstruc

section .text
    global sort_requests
    extern printf

sort_requests:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    xor esi, esi
sort_loop1:
    mov ecx, [ebp + 12] 
    dec ecx 
    cmp esi, ecx 
    jge end_sort_loop1

    mov edx, [ebp + 8] ; requests array address
    mov ecx, esi ; the index of the element in the array
    imul ecx, ecx, 55 ; multiply the index by the size of the structure
    add edx, ecx ; edx points to the curent request

    inc esi
    mov edi, esi
    dec esi
sort_loop2:
    cmp edi, [ebp + 12] 
    jge end_sort_loop2

    mov ebx, [ebp + 8] ; requests array address
    mov ecx, edi ; the index of the element in the array
    imul ecx, ecx, 55 ; multiply the index by the size of the structure
    add ebx, ecx ; ebx points to the curent request

    ; check the admin fields:
    mov cl, byte [ebx] ; admin from the second loop
    mov al, byte [edx] ; admin from the first loop
    and cl, 1
    and al, 1
    cmp cl, al 
    je admins_are_eq
    jl next_request

    ; the request in ebx in made by an admin,
    ; the one in edx is not
    ; swap:

    mov eax, edx 
    mov edx, ebx
    mov ebx, eax
    jmp next_request

admins_are_eq:
    ; check the prio fields:
    mov cl, byte [ebx + 1] ; prio from the second loop
    mov al, byte [edx + 1] ; prio from the first loop
    cmp al, cl 
    je prios_are_eq
    jl next_request

    ; swap:

    mov eax, edx 
    mov edx, ebx
    mov ebx, eax
    jmp next_request

prios_are_eq:
    ; check the usernames:
    mov ecx, [ebx + 4] ; username from the second loop
    mov eax, [edx + 4] ; username from the first loop

next_request:
    inc edi 
    jmp sort_loop2
end_sort_loop2:
    inc esi
    jmp sort_loop1
end_sort_loop1:
  
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ; DO NOT MODIFY
