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

    	mov ecx, dword[num_rounds] ; load number of rounds

ciphertext_loop:
	movzx eax, byte [esi]       ; load t
	mov ebx, eax                ; copy t

	movzx eax, byte [edi]       ; load key[i % 8]
	add ebx, eax                ; t = t + key[i % 8]

	movzx eax, byte [ebx + sbox] ; load sbox[t]
	mov edx, dword [esi + 1]    ; load text[(i + 1) % 8]
	add eax, edx                ; t = sbox[t] + text[(i + 1) % 8]

	rcl al, 1                   ; t = (t << 1) | (t >> 7)

	mov [esi + 1], al           ; text[(i + 1) % 8] = t

	inc esi                     ; move to next byte in text
	inc edi                     ; move to next byte in key

	loop ciphertext_loop

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
