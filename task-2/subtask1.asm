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

section .bss
    idx1 resd 1
    idx2 resd 1

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
    mov [idx1], esi
sort_loop1:
    mov ecx, [ebp + 12] 
    dec ecx 
    mov esi, [idx1]
    cmp esi, ecx 
    jge end_sort_loop1

    mov edx, [ebp + 8] ; requests array address
    mov ecx, esi ; the index of the element in the array
    imul ecx, ecx, 55 ; multiply the index by the size of the structure
    add edx, ecx ; edx points to the curent request

    ; mov byte [edx], 2 ; debugging
    inc esi
    mov edi, esi
    mov [idx2], edi
    dec esi
sort_loop2:
    mov edi, [idx2]
    cmp edi, [ebp + 12] 
    jge end_sort_loop2

    mov ebx, [ebp + 8] ; requests array address
    mov ecx, edi ; the index of the element in the array
    imul ecx, ecx, 55 ; multiply the index by the size of the structure
    add ebx, ecx ; ebx points to the curent request

    ; mov byte [ebx + 1], 3 ; debugging

    ; check the admin fields:
    movzx ecx, byte [ebx] ; admin from the second loop
    movzx eax, byte [edx] ; admin from the first loop
    and ecx, 1
    and eax, 1
    cmp ecx, eax
    je admins_are_eq
    jg swap
    jmp next_request

admins_are_eq:
    ; check the prio fields:
    movzx ecx, byte [ebx + 1] ; prio from the second loop
    movzx eax, byte [edx + 1] ; prio from the first loop
    cmp eax, ecx
    je prios_are_eq
    jg swap
    jmp next_request

prios_are_eq:
    ; check the usernames:
    ; [ebx + 4] - username from the second loop
    ; [edx + 4] - username from the first loop
    xor esi, esi ; index to iterate through the username
check_usernames:
    cmp esi, 51
    jge next_request

    ; mov byte [ebx + 4 + esi], 97
    ; mov byte [edx + 4 + esi], 97

    mov al, byte [edx + 4 + esi] 
    mov cl, byte [ebx + 4 + esi]
    cmp al, cl 
    jg swap

    ; mov byte [ebx + 4 + esi], 97
    ; mov byte [edx + 4 + esi], 97

    inc esi
    jmp check_usernames

swap:
    xor esi, esi ; index to iterate through the username
swap_usernames:
    cmp esi, 51
    jge swap_the_rest

    mov al, byte [edx + 4 + esi] 
    mov cl, byte [ebx + 4 + esi]
    mov byte [edx + 4 + esi], cl 
    mov byte [ebx + 4 + esi], al

    inc esi
    jmp swap_usernames

swap_the_rest:
    ; passkeys
    mov ax, word [edx + 2]
    mov cx, word [ebx + 2]
    mov word [edx + 2], cx
    mov word [ebx + 2], ax

    ; priorities:
    mov al, byte [edx + 1]
    mov cl, byte [ebx + 1]
    mov byte [edx + 1], cl
    mov byte [ebx + 1], al

    ; admins:
    mov al, byte [edx]
    mov cl, byte [ebx]
    mov byte [edx], cl
    mov byte [ebx], al

next_request:
    mov edi, [idx2]
    inc edi 
    mov [idx2], edi
    jmp sort_loop2
end_sort_loop2:
    mov esi, [idx1]
    inc esi
    mov [idx1], esi
    jmp sort_loop1
end_sort_loop1:
  
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ; DO NOT MODIFY
