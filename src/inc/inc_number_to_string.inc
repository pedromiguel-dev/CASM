inc_number_to_string:
  mov esi, 10
  xor ecx, ecx
  
  inc_number_to_string_loop:
  xor edx, edx
  div esi
  add edx, 48
  mov [ebx + ecx], edx
  inc ecx
  cmp eax, 0
  je  inc_number_to_string_reverse_string
  jmp inc_number_to_string_loop
  
  inc_number_to_string_reverse_string:
  xor ebp, ebp ; max number
  xor edx, edx
  mov eax, ecx
  mov edi, 2
  div edi
  mov ebp, eax
  
  xor eax, eax
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
  ret