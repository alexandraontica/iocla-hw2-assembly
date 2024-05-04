%include "../include/io.mac"

; declare your structs here

section .text
    global check_passkeys
    extern printf

check_passkeys:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; connected
    ;; DO NOT MODIFY

    ;; Your code starts here

    xor esi, esi
init:
    cmp esi, [ebp + 12] 
    jge end_init

    mov byte [eax + esi], 0

    mov edx, [ebp + 8] ; requests array address
    mov ecx, esi ; the index of the element in the array
    imul ecx, ecx, 55 ; multiply the index by the size of the structure
    add edx, ecx ; edx points to the curent request
    add edx, 2 ; edx points to the passkey in the request
    mov di, word [edx] ; save the passkey
 
    mov dx, 0x8001 ; first and last bit are set
    and dx, di
    cmp dx, 0x8001
    jne end_if1

    mov dx, di ; temp
    shr dx, 1
    and dx, 0x7F
    xor ecx, ecx ; index
    xor ebx, ebx ; counter
loop1:
    cmp ecx, 7
    jge end_loop1

    test dx, 1
    jz isnt_set1

    inc ebx
isnt_set1:
    shl dx, 1
    inc ecx
    jmp loop1

end_loop1:
    test ebx, 1
    jnz end_if1

    mov dx, di ; temp
    shr dx, 8
    and dx, 0x7F
    xor ecx, ecx ; index
    xor ebx, ebx ; counter
loop2:
    cmp ecx, 7
    jge end_loop2

    test dx, 1
    jz isnt_set2

    inc ebx
isnt_set2:
    shl dx, 1
    inc ecx
    jmp loop2
end_loop2:
    test ebx, 1
    jz end_if1

    mov byte [eax + esi], 1

end_if1:

    inc esi
    jmp init

end_init:
    xor esi, esi
; verif:  ;; asta nu face decat o iteratie, de ce nu stiu
;     cmp esi, [ebp + 12]
;     jge end_verif

;     ; mov edx, [ebp + 8] ; requests array address
;     ; mov ecx, esi ; the index of the element in the array
;     ; imul ecx, ecx, 55 ; multiply the index by the size of the structure
;     ; add edx, ecx ; edx points to the curent request
;     ; add edx, 2 ; edx points to the passkey in the request
;     ; mov di, word [edx] ; save the passkey
 
;     ; mov dx, 0x8001 ; first and last bit are set
;     ; and dx, di
;     ; cmp dx, 0x8001
;     ; jne end_if1

;     ; mov dx, di ; temp
;     ; shr dx, 1
;     ; and dx, 0x7F
;     ; xor ecx, ecx ; index
;     ; xor ebx, ebx ; counter
; ; loop1:
; ;     cmp ecx, 7
; ;     jge end_loop1

; ;     test dx, 1
; ;     jz isnt_set1

; ;     inc ebx
; ; isnt_set1:
; ;     shl dx, 1
; ;     inc ecx
; ;     jmp loop1

; ; end_loop1:
; ;     test ebx, 1
; ;     jnz end_if1

; ;     mov dx, di ; temp
; ;     shr dx, 8
; ;     and dx, 0x7F
; ;     xor ecx, ecx ; index
; ;     xor ebx, ebx ; counter
; ; loop2:
; ;     cmp ecx, 7
; ;     jge end_loop2

; ;     test dx, 1
; ;     jz isnt_set2

; ;     inc ebx
; ; isnt_set2:
; ;     shl dx, 1
; ;     inc ecx
; ;     jmp loop2
; ; end_loop2:
; ;     test ebx, 1
; ;     jz end_if1

;     mov byte [eax + esi], 1

; end_if1:
;     inc esi
;     jmp end_verif

; end_verif:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY