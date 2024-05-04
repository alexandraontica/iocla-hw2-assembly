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

    ; Initialize index variable i = 0
    mov esi, 0

    ; Loop through requests array
    .loop_requests:
        ; Check if i < length
        cmp esi, ecx
        jge .end_loop_requests

        ; Load passkey into AX from requests[i].login_creds.passkey
        mov ax, word [ebx + esi * 8 + 4]

        ; Check if passkey & 0x8001 == 0x8001
        and ax, 8001h
        cmp ax, 8001h
        jne .next_iteration

        ; Initialize num_even_bits = 0, num_odd_bits = 0
        mov edx, 0
        mov edi, 0

        ; Calculate num_even_bits
        mov cx, ax
        shr cx, 1
        and cx, 7Fh
        mov ebx, 7
        .calculate_even_bits:
            test cx, 1
            jz .even_bit_not_set
            inc edx
        .even_bit_not_set:
            shr cx, 1
            dec ebx
            cmp ebx, 0
            jg .calculate_even_bits

        ; Calculate num_odd_bits
        mov cx, ax
        shr cx, 8
        and cx, 7Fh
        mov ebx, 7
        .calculate_odd_bits:
            test cx, 1
            jz .odd_bit_not_set
            inc edi
        .odd_bit_not_set:
            shr cx, 1
            dec ebx
            cmp ebx, 0
            jg .calculate_odd_bits

        ; Check if num_even_bits is even and num_odd_bits is odd
        test edx, 1
        jnz .next_iteration
        test edi, 1
        jz .next_iteration

        ; Set connected[i] = 1
        mov byte [eax + esi], 1

    .next_iteration:
        ; Increment index variable i
        inc esi
        jmp .loop_requests

    .end_loop_requests:

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
