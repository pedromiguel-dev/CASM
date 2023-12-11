%include "inc/stdio.inc"
%include "inc/inc_string_to_number.inc"

section .data
  hello  db  "-----CALCULATOR-----",0xA,0
  hello_size  equ $-hello
  
  message  db  "type an operation",0xA,0
  message_size  equ  $-message
  
  options  db  "sum: sub: div: mul:",0xA,0
  options_size  equ  $-options
  
section .bss
  expression  resb  1024
  expression_size  equ 1024
  
  num_one  resb  1
  num_two  resb  1
  
  
section .text
global _start

_start:
	mov  eax, hello
	mov  ebx, hello_size
	call inc_print_console
	
	mov  eax, message
	mov  ebx, message_size
	call inc_print_console
	
	mov  eax, options
	mov  ebx, options_size
	call inc_print_console
	
	call calculator_loop
	call inc_exit
	

calculator_loop:
	call inc_read_console ; eax has number of bytes read
	mov eax, expression
	call inc_string_to_number