; %include "../include/io.mac"

; extern printf
; extern position
; global solve_labyrinth

; ; you can declare any helper variables in .data or .bss

; section .bss
;     row resb 30  ; assume maximum 30 columns
;     m resd 1
;     n resd 1

; section .text

; ; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
; solve_labyrinth:
;     ;; DO NOT MODIFY
;     push    ebp
;     mov     ebp, esp
;     pusha

;     mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
;     mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
;     mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
;     mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
;     mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
;     ;; DO NOT MODIFY
   
;     ;; Freestyle starts here
    
;     mov byte [eax], 0
;     mov byte [ebx], 0
;     mov dword [m], ecx
;     mov dword [n], edx

; labyrinth_loop:
;     mov ecx, 

;     ;; Freestyle ends here
; end:
;     ;; DO NOT MODIFY

;     popa
;     leave
;     ret
    
;     ;; DO NOT MODIFY
