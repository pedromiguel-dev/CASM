%include "inc/stdio.inc"
%include "inc/inc_string_to_number.inc"
%include "inc/inc_number_to_string.inc"

section .data
	hello  db  "-----CALCULATOR-----",0xA,0
	hello_size  equ $-hello

	message  db  "type an operation",0xA,0
	message_size  equ  $-message

	options  db  "sum: 1 sub: 2 div: 3 mul: 4 exit: 5",0xA,0
	options_size  equ  $-options

	invalid_num  db "this number is invalid please try again...",0xA,0
	invalid_num_size  equ $-invalid_num
  
	num_one_msg  db "First number is: ",0
	num_one_msg_s equ $-num_one_msg
	num_two_msg  db "Second number is: ",0
	num_two_msg_s equ $-num_two_msg
	
	erro_nan_msg  db "Sorry this is not a number...", 0xA, 0
	erro_nan_msg_s  equ $-erro_nan_msg
  
	divide equ 10
	
section .bss
	calc  resb  14
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
	call print_wellcome
	call choose_operation
	
	mov eax, [operation]
	cmp eax, 5 ; exit code
	je inc_exit
	
	call get_input_numbers
	call calculate
	
	mov ebx, result ; eax has number
	call inc_number_to_string
	
	mov  ebx, eax 	; eax has the size of the string
	mov  eax, result
	call inc_print_console
	jmp _start
	
	call inc_exit
  
print_wellcome:
	mov  eax, hello
	mov  ebx, hello_size
	call inc_print_console

	mov  eax, message
	mov  ebx, message_size
	call inc_print_console

	mov  eax, options
	mov  ebx, options_size
	call inc_print_console
	
	ret

choose_operation:
	mov eax, expression
	mov ebx, expression_size
	call inc_read_console 

	get_oper:
	mov eax, expression
	call inc_string_to_number
	mov [operation], eax

	compare:
	cmp eax, 5
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
	first_number:
		mov eax, num_one_msg
		mov ebx, num_one_msg_s
		call inc_print_console
		
		call read_number
		mov  [num_one], eax
		cmp ebx, 1
		call error_handler
		je first_number
	
	second_number:
		mov eax, num_two_msg
		mov ebx, num_two_msg_s
		call inc_print_console

		call read_number
		mov  [num_two], eax
		cmp ebx, 1
		call error_handler
		je second_number
	ret
	
	error_handler:
		jne error_handler_ret
		
		mov eax, erro_nan_msg
		mov ebx, erro_nan_msg_s
		call inc_print_console
		
		error_handler_ret:
		ret
  
read_number:
	mov eax, calc
	mov ebx, calc_size
	call inc_read_console ; eax has number of bytes read

	mov eax, calc
	call inc_string_to_number
	ret
  
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
	imul eax, ebx
	ret