;inc_string_to_number
;  in:
;    eax: buffer pointer
;  out:
;	 eax: number
inc_string_to_number:

	; initialize registers
	mov esi, eax
	
	xor ecx, ecx
	xor eax, eax
	xor ebx, ebx
	
	loop_input:
	; Load the current character from the string into bl
    mov bl, [esi + ecx] ; get first number
	
	; Check for the terminator (end of the string)
    cmp bl, 0xA
    je  done_parse
	
	; Convert ASCII to integer
    sub bl, 48
	
	; Multiply the current result by 10 (shift left by one decimal place)
	imul eax, 10
	add eax, ebx
		
	; Move to the next character in the string
    inc ecx
	
	; Repeat the loop
    jmp loop_input


	done_parse:
	ret