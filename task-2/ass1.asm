push    ebp
        mov     ebp, esp
        push    edi
        push    esi
        push    ebx
        sub     esp, 92
        mov     eax, DWORD PTR [ebp+12]
        mov     edx, DWORD PTR [ebp+8]
        imul    ecx, eax, 55
        lea     ebx, [edx+55]
        dec     eax
        mov     DWORD PTR [ebp-100], eax
        add     edx, ecx
        mov     DWORD PTR [ebp-96], edx
        xor     edx, edx
        mov     DWORD PTR [ebp-92], edx
.L2:
        mov     esi, DWORD PTR [ebp-92]
        cmp     DWORD PTR [ebp-100], esi
        jle     .L12
        inc     DWORD PTR [ebp-92]
        mov     edx, ebx
.L3:
        mov     eax, DWORD PTR [ebp-96]
        cmp     edx, eax
        je      .L13
        mov     cl, BYTE PTR [edx]
        mov     al, BYTE PTR [ebx-55]
        cmp     cl, 1
        jne     .L4
        test    al, al
        je      .L10
.L4:
        cmp     cl, al
        jne     .L5
        mov     cl, BYTE PTR [ebx-54]
        mov     al, BYTE PTR [edx+1]
        cmp     al, cl
        jb      .L10
        cmp     cl, al
        jne     .L5
        push    eax
        push    eax
        lea     eax, [edx+4]
        mov     DWORD PTR [ebp-104], edx
        push    eax
        lea     eax, [ebx-51]
        push    eax
        call    strcmp
        add     esp, 16
        mov     edx, DWORD PTR [ebp-104]
        test    eax, eax
        jle     .L5
.L10:
        lea     edi, [ebp-79]
        lea     esi, [ebx-55]
        mov     ecx, 55
        rep movsb
        lea     edi, [ebx-55]
        mov     ecx, 55
        mov     esi, edx
        rep movsb
        lea     esi, [ebp-79]
        mov     ecx, 55
        mov     edi, edx
        rep movsb
.L5:
        add     edx, 55
        jmp     .L3
.L13:
        add     ebx, 55
        jmp     .L2
.L12:
        lea     esp, [ebp-12]
        pop     ebx
        pop     esi
        pop     edi
        pop     ebp
        ret
