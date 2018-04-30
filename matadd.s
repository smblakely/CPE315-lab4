    /* This function has 5 parameters, and the declaration in the
       C-language would look like:

       void matadd (int **C, int **A, int **B, int height, int width)

       C, A, B, and height will be passed in r0-r3, respectively, and
       width will be passed on the stack.

       You need to write a function that computes the sum C = A + B.

       A, B, and C are arrays of arrays (matrices), so for all elements,
       C[i][j] = A[i][j] + B[i][j]

       You should start with two for-loops that iterate over the height and
       width of the matrices, load each element from A and B, compute the
       sum, then store the result to the correct element of C. 

       This function will be called multiple times by the driver, 
       so don't modify matrices A or B in your implementation.

       As usual, your function must obey correct ARM register usage
       and calling conventions. */

	.arch armv7-a
	.text
	.align	2
	.global	matadd
	.syntax unified
	.arm
matadd:
   push     {r4}
   ldr      r4, [sp, #4]
   push     {r0, r1, r2, r3, r5, r6, r7, r8, r9, r10, r11, r12, lr}
main:
   mov      r5, #4         @Set i to 0
   mul      r3, r3, r5
   mul      r4, r4, r5
   mov      r5, #0
oloop:
   mov      r6, #0         @Set j to 0
   ldr      r7, [r1, r5]   @Load r7 with A offset of i
   ldr      r8, [r2, r5]   @Load r8 with B offset of i
   ldr      r9, [r0, r5]   @Load r9 with C offset of i
   b        iloop
oloop2:
   add      r5, r5, #4
   cmp      r5, r3
   beq      end
   b        oloop
iloop:
   mov      r12, #0
   ldr      r10, [r7, r6]  @Load r10 with A[i] offset of j
   ldr      r11, [r8, r6]  @Load r11 with A[i] offset of j
   add      r12, r11, r10  @r12 = A[i][j] + B[i][j]
   str      r12, [r9, r6]  @Store sum into C[i] offset of j
   add      r6, r6, #4
   cmp      r6, r4
   beq      oloop2
   b        iloop
end:
   
   pop      {r0, r1, r2, r3, r5, r6, r7, r8, r9, r10, r11, r12, lr}
   pop      {r4}
   mov      pc, lr

printinfo:
   .word    string1
   .word    string2
string1:
   .asciz   "%d "
string2:
   .asciz   "\n"
