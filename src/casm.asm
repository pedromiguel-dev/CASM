%include "inc/stdio.inc"
%include "inc/inc_string_to_number.inc"
%include "inc/inc_number_to_string.inc"

section .data
  clear_msg db "\033[2J", 0  ; ANSI escape code to clear the screen
  clear_len equ $ - clear_msg  ; Calculate the length of the message
  
  hello  db  "-----CALCULATOR-----",0xA,0
  hello_size  equ $-hello
  
  message  db  "type an operation",0xA,0
  message_size  equ  $-message
  
  options  db  "sum: 1 sub: 2 div: 3 mul: 4",0xA,0
  options_size  equ  $-options
  
  invalid_num  db "this number is invalid please try again...",0xA,0
  invalid_num_size  equ $-invalid_num
  
  divide equ 10
section .bss
  calc  resb  14 ; one trillion why not
  calc_size  equ  14

  expression  resb  64
  expression_size  equ 64
  
  num_one  resb  12
  num_two  resb  12
  operation  resb 1
  
  result_size  resb 32
  result  resb 1
  
  
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
  call calculate
  
  ; number should be in eax
  mov ebx, result
  call inc_number_to_string
  
  mov  ebx, eax ; eax has the size of the string
  mov  eax, result
  call inc_print_console

  call inc_exit
	

choose_operation:
  mov eax, expression
  mov ebx, expression_size
  call inc_read_console ; eax has number of bytes read
  ;convert the operation string to number so it be easier :P
  
  get_oper:
  mov eax, expression
  call inc_string_to_number
  mov [operation], eax
  
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
  mov  [num_one], eax

  call read_number
  mov  [num_two], eax
  ret
  
read_number:
  mov eax, calc
  mov ebx, calc_size
  call inc_read_console ; eax has number of bytes read
	
  mov eax, calc
  call inc_string_to_number
  ret
  
; TODO: calculate
calculate:
  mov eax, [num_one]
  mov ebx, [num_two]
  mov ecx, [operation]
  
  cmp ecx, 1
  je _sum
  cmp ecx, 2
  je _sub
  cmp ecx, 3
  je _div
  cmp ecx, 4
  je _mul
  ret
  
_sum:
  add eax, ebx
  ret
_sub:
  sub eax, ebx
  ret
_div:
  cdq
  idiv ebx
  ret
_mul:
  add eax, ebx
  ret