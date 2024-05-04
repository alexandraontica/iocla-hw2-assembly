sort_requests:
        push    ebp
        mov     ebp, esp
        push    edi
        push    esi
        push    ebx
        sub     esp, 80
        mov     eax, DWORD PTR [ebp+12]
        mov     ebx, DWORD PTR [ebp+8]
        imul    edx, eax, 55
        dec     eax
        mov     DWORD PTR [ebp-80], ebx
        mov     DWORD PTR [ebp-92], eax
        add     edx, ebx
        mov     DWORD PTR [ebp-88], edx
        xor     edx, edx
        mov     DWORD PTR [ebp-84], edx
.L2:
        mov     edx, DWORD PTR [ebp-84]
        cmp     DWORD PTR [ebp-92], edx
        jle     .L23
        inc     DWORD PTR [ebp-84]
        mov     edx, DWORD PTR [ebp-80]
        add     DWORD PTR [ebp-80], 55
        mov     eax, DWORD PTR [ebp-80]
.L3:
        mov     ebx, DWORD PTR [ebp-88]
        cmp     eax, ebx
        je      .L2
        mov     bl, BYTE PTR [eax]
        mov     cl, BYTE PTR [edx]
        cmp     bl, 1
        jne     .L4
        test    cl, cl
        je      .L21
.L4:
        cmp     bl, cl
        jne     .L5
        mov     bl, BYTE PTR [edx+1]
        mov     cl, BYTE PTR [eax+1]
        cmp     cl, bl
        jb      .L21
        cmp     bl, cl
        jne     .L5
        xor     esi, esi
.L7:
        mov     cl, BYTE PTR [edx+4+esi]
        mov     bl, BYTE PTR [eax+4+esi]
        test    cl, cl
        je      .L8
        test    bl, bl
        je      .L8
        cmp     cl, bl
        jne     .L8
        inc     esi
        jmp     .L7
.L8:
        cmp     bl, cl
        jge     .L5
.L21:
        lea     edi, [ebp-67]
        mov     ecx, 55
        mov     esi, edx
        rep movsb
        mov     ecx, 55
        mov     edi, edx
        mov     esi, eax
        rep movsb
        lea     esi, [ebp-67]
        mov     ecx, 55
        mov     edi, eax
        rep movsb
.L5:
        add     eax, 55
        jmp     .L3
.L23:
        add     esp, 80
        pop     ebx
        pop     esi
        pop     edi
        pop     ebp
        ret
