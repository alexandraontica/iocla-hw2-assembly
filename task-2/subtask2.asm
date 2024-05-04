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

    inc esi
    jmp init

end_init:
    xor esi, esi
verif:
    cmp esi, [ebp + 12] 
    jge end_verif

    mov di, word [ebp + 8 + esi + 2] ; save the current passkey
    
    mov dx, 0x8001 ; first and last bit is set
    and dx, di
    cmp dx, 0x8001
    jne end_if1

    mov dx, di ; temp
    shr dx, 1
    and dx, 0x7F
    xor ecx, ecx
    xor ebx, ebx
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
    xor ecx, ecx
    xor ebx, ebx
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
    jmp end_verif

end_verif:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY