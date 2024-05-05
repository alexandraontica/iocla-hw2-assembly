%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss

section .bss
    m resd 1
    n resd 1
    var resd 1

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    
    mov dword [eax], 0
    mov dword [ebx], 0
    mov dword [m], ecx
    mov dword [n], edx

labyrinth_loop:
    ; set current element to '1'
    mov edi, dword [eax]
    mov ecx, [esi + edi * 4] ; current row in matrix, 
                             ; * 4 because that is the size of a pointer
    mov edi, dword [ebx]
    mov byte [ecx + edi], '1'

    mov edx, [m]
    dec edx
    cmp [eax], edx
    jge end
    
    ; check the element below
    mov edi, dword [eax]
    inc edi
    mov ecx, [esi + edi * 4]
    mov edi, dword [ebx]
    cmp byte [ecx + edi], '0'
    jne next_if1
    
    inc dword [eax]
    jmp cond

next_if1:
    cmp dword [eax], 0
    jle next_if2

    ; check the element above
    mov edi, dword [eax]
    dec edi
    mov ecx, [esi + edi * 4]
    mov edi, dword [ebx]
    cmp byte [ecx + edi], '0'
    jne next_if2

    dec dword [eax]
    jmp cond

next_if2:
    mov edx, [n]
    dec edx
    cmp [ebx], edx
    jge end

    mov edi, dword [eax]
    mov ecx, [esi + edi * 4]
    mov edi, dword [ebx]
    inc edi
    cmp byte [ecx + edi], '0'
    jne next_if3

    inc dword [ebx]
    jmp cond

next_if3:
    cmp dword [ebx], 0
    jle cond

    ; check the element above
    mov edi, dword [eax]
    mov ecx, [esi + edi * 4]
    mov edi, dword [ebx]
    dec edi
    cmp byte [ecx + edi], '0'
    jne cond

    dec dword [ebx]

cond:
    mov edi, dword [eax]
    mov ecx, [esi + edi * 4] ; current row in matrix, *4 bc that is the size of a pointer
    mov edi, dword [ebx]
    cmp byte [ecx + edi], '0'
    jne end
    jmp labyrinth_loop

    ;; Freestyle ends here
end:
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
