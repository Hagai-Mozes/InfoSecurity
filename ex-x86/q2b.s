# Declare the assembly flavor to use the intel syntax.
.intel_syntax noprefix

# Define a symbol to be exported from this file.
.global my_function

# Declare symbol type to be a function.
.type my_function, @function

# Code follows below.

my_function:
    # <<<< PUT YOUR CODE HERE >>>>
    # TODO:
    # 1. Read the input to the function from the stack.
	# 2. Save the result in the register EAX (and then return!).
	MOV EBX, DWORD PTR [ESP + 4]
	PUSH 0
	CMP EBX,0
	JLE _FAIL	#return 0 if input<=0
	DEC EBX
	PUSH 1
_LOOP:
	CMP EBX,0
	JE _FINISH
	DEC EBX
	POP ECX		#ECX=a_(n-1)
	POP EAX		#EAX=a_(n-2)
	PUSH ECX
	MUL EAX
	MOV ESI,EAX	#ESI=a_(n-2)^2
	MOV EAX,ECX
	MUL EAX		#EAX=a_(n-1)^2
	ADD ESI, EAX	#ESI=a_(n-2)^2+a_(n-1)^2=a_n
	CMP ESI,0
	JLE _FAIL	#if overflow return 0
	PUSH ESI
	JMP _LOOP
_FINISH:
	POP EAX
	POP EDX
	RET
_FAIL:
	POP EAX
	MOV EAX,0
	RET
