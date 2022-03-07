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
    # 3. Make sure to include a recursive function call (the recursive function
	#    can be this function, or a helper function defined later in this file).
	# EBX=n
	# EAX=returned value (a_n)
	# EDX=auxilary tmp register 
	MOV EBX, DWORD PTR [ESP + 4]
	CMP EBX, 0
	JL _FAILED
	call sq_fib_rec		#EAX=a_n
	RET
_FAILED:
	MOV EAX,0
	RET
	
sq_fib_rec:
	CMP EBX, 1		#comp to base cases
	JLE _BASE
	PUSH EBX		#preserve n
	DEC EBX			#EBX=n-1
	call sq_fib_rec		#EAX=a_(n-1)
	MUL EAX			#EAX=a_(n-1)^2
	PUSH EAX		#preserve intermediate value
	DEC EBX			#EBX=n-2
	call sq_fib_rec		#EAX=a_(n-2)
	MUL EAX			#EAX=a_(n-2)^2
	POP EDX			#EDX=a_(n-1)^2
	ADD EAX,EDX		#EAX=a_(n-1)^2+a_(n-2)^2
	POP EBX			#EBX=n
	CMP EAX,0
	JL _FAIL		#if overflow return 0
	RET
_BASE:
	MOV EAX, EBX 		#for n<=1: a_n=n (base case)
	RET
_FAIL:
	MOV EAX,0
	RET
