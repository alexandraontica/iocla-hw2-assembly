%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov ecx, 16777215 ; 00000000111111111111111111111111 decimal
    and ecx, eax ; the id becomes 0

    mov edx, 16777215
    cmp edx, ecx
    jz has_all_permissions
    jmp doesnt_have_all_permissions

has_all_permissions:
    mov ebx, 1
    jmp end_function

doesnt_have_all_permissions:
    mov ebx, 0

end_function:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
