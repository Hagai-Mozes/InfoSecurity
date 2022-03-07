# Declare the assembly flavor to use the intel syntax.
.intel_syntax noprefix

# Define a symbol to be exported from this file.
.global my_function

# Declare symbol type to be a function.
.type my_function, @function

# Code follows below.

my_function:
    # This code reads the first argument from the stack into EBX.
    # (If you need, feel free to edit/remove this line).
	MOV EBX, DWORD PTR [ESP + 4]
	CMP EBX, 1	#allow only input >=1 (for 0 return 0)
	JL _FAILED
	MOV ECX, 0	#ECX increment on each iteration
_LOOP:
	INC ECX
	MOV EAX,ECX
	MUL ECX		#EAX=ECX^2
	CMP EAX,0	#if number was overflow - fail
	JL _FAILED
    	CMP EAX,EBX	#if ECX^2>EBX - there is no integer root, stop looping
	JL _LOOP
	CMP EAX,EBX
	JNE _FAILED
	MOV EAX, ECX	#EAX=returned value
	JMP _FINISH
    # 1. Read the input to the function from EBX.
    # 2. Save the result in the register EAX.
    # This returns from the function (call this after saving the result in EAX).
	# (If you need, feel free to edit/remove this line).
_FAILED:
	MOV EAX,0
_FINISH:
	RET
