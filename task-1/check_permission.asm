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

    movzx ecx, al ; save the id and extend it to 4 bytes
    mov edx, dword [ant_permissions + ecx * 4]  ; save the permissions of the ant with the given id

    shr eax, 8 ; remove the id
    
    mov ecx, 24

    mov dword [ebx], 1

check_each_room:
    test eax, ebx  ; check if the current room is requested
    jnz is_requested
    jmp isnt_requested

is_requested:
    test edx, ebx  ; check if the ant has permission
    jz doesnt_have_permission

isnt_requested:
    shr eax, 1
    shr edx, 1
    loop check_each_room

    jmp end_function

doesnt_have_permission:
    mov dword [ebx], 0

end_function:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
