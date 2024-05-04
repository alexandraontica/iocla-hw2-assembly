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

    mov esi, 0
init:
    cmp esi, ecx
    jge end_init

    mov byte [eax + esi], 0

    inc esi
    jmp init

end_init:
    mov esi, 0
verif:
    cmp esi, ecx
    jge end_init

    mov di, word [ebx + esi + 2] ; save the current passkey
    shl esi, 16
    
    mov dx, 0x8001 ; first and last bit is set
    and dx, di
    cmp dx, 0x8001
    jne end_if1

    mov dx, di ; temp
    shl edi, 16 ; I want the di register free, but i do not want to lose the data in it
    mov di, 0
    shr dx, 1
    and dx, 0x7F
    mov si, 0
loop1:
    cmp si, 7
    jge end_loop1

    test dx, 1
    jz isnt_set1

    inc di
isnt_set1:
    shl di, 1
    inc si
    jmp loop1

end_loop1:
    test di, 1
    jnz end_if1

    shr edi, 16
    mov dx, di ; temp
    shl edi, 16 ; I want the di register free, but i do not want to lose the data in it
    mov di, 0
    shr dx, 8
    and dx, 0x7F
    mov si, 0
loop2:
    cmp si, 7
    jge end_loop1

    test dx, 1
    jz isnt_set2

    inc di
isnt_set2:
    shl di, 1
    inc si
    jmp loop2
end_loop2:
    test di, 1
    jz end_if1

    mov edi, esi
    shr edi, 16
    mov byte [eax + edi], 1

end_if1:
    shr esi, 16
    inc esi
    jmp end_verif

end_verif:

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY