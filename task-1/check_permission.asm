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
    mov edx, al ; save the id
    mov ecx, dword [ant_permissions + edx * 4]  ; save the permissions of the ant with the given id
    shr ecx, 8  ; remove the id

    mov edx, 0xFFFFFF
    test edx, ecx
    jz doesnt_have_all_permissions

    mov dword [ebx], 1
    jmp end_function

doesnt_have_all_permissions:
    mov dword [ebx], 0

end_function:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
