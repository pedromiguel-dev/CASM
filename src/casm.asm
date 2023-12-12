%include "inc/stdio.inc"
%include "inc/inc_string_to_number.inc"

section .data
  hello  db  "-----CALCULATOR-----",0xA,0
  hello_size  equ $-hello
  
  message  db  "type an operation",0xA,0
  message_size  equ  $-message
  
  options  db  "sum: 1 sub: 2 div: 3 mul: 4",0xA,0
  options_size  equ  $-options
  
  invalid_num  db "this number is invalid please try again...",0xA,0
  invalid_num_size  equ $-invalid_num
  
section .bss
  calc  resb  14 ; one trillion why not
  calc_size  equ  14

  expression  resb  2
  expression_size  equ 2
  
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

  call choose_operation

  call get_input_numbers

  call inc_exit
	

choose_operation:
  mov eax, expression
  mov ebx, expression_size
  call inc_read_console ; eax has number of bytes read
  ;convert the operation string to number so it be easier :P
  
  get_oper:
  mov eax, expression
  call inc_string_to_number
  mov [expression], eax
  
  compare:
  cmp eax, 4
  jg invalid_number
  cmp eax, 1
  jl invalid_number
  ret
  
  invalid_number:
  mov  eax, invalid_num
  mov  ebx, invalid_num_size
  call inc_print_console
  jmp choose_operation
  ret
  
get_input_numbers:
  call read_number
  mov  eax, num_one

  call read_number
  mov  eax, num_two
  ret
  
read_number:
  mov eax, calc
  mov ebx, calc_size
  call inc_read_console ; eax has number of bytes read
	
  mov eax, calc
  call inc_string_to_number
  ret
