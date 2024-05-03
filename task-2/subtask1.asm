%include "../include/io.mac"

; declare your structs here

struc creds
    passkey: resw 1
    username: resb 51
endstruc

struc request 
    admin: resb 1
    prio: resb 1
    login_creds: resb 53  ; 2 bytes (short) + 51 bytes (string)
endstruc

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

    ; code

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY