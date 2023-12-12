;inc_print_console
;    input:
;      eax: buffer
;      ebx: buffer_size
inc_print_console:
  mov  ecx, eax
  mov  edx, ebx
  
  mov  eax, 4
  mov  ebx, 1
  int  80h
  ret

;inc_print_console
;    input:
;      eax: buffer
;      ebx: buffer_size
inc_read_console:
  mov  ecx, eax
  mov  edx, ebx

  mov  eax, 3
  xor  ebx, ebx
  int 80h
  ret
	
;inc_exit
;    input:
;      eax: error_code
inc_exit:
  mov ebx, eax
  mov eax, 1
  int 80h
  ret