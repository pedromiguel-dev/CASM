;inc_number_to_string
;  in:
;    eax: number
;    ebx: result buffer pointer
;  out:
;    reversed string is at pointer
;	 eax: size
inc_number_to_string:
  mov esi, 10
  xor ecx, ecx
  
  inc_number_to_string_loop:
  xor edx, edx			; the division remainder
  div esi
  add edx, 48
  mov [ebx + ecx], edx
  inc ecx
  cmp eax, 0			; if quotient is 0 then we're done
  je  inc_number_to_string_reverse_string
  jmp inc_number_to_string_loop
  
  inc_number_to_string_reverse_string:
  xor ebp, ebp 			; max loop number
  xor edx, edx
  
 
  ; the max loop number is half of the string's length
  mov eax, ecx
  mov edi, 2
  div edi
  mov ebp, eax
  
  mov eax, ecx
  xor edx, edx
  xor edi, edi
  xor esi, esi
  
  inc_number_to_string_reverse_string_loop:
  mov al, [ebx + ecx - 1]
  mov dl, [ebx + esi]
  mov [ebx + esi], al
  mov [ebx + ecx - 1], dl
  inc esi
  dec ecx
  cmp esi, ebp
  je done
  jmp inc_number_to_string_reverse_string_loop
  
  done:
  mov [ebx + eax], byte 0xA ; add new line
  add eax, 1
  ret