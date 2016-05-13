# Things to ask TA:
# - Immediates?
# - Pointers?
# - Exit Status?
# - Size of Instructions
# - 32 bit SRAM

int A = 7;
int B = 5;
int C = 2;
int D = 4;
int* dPtr = &D;
if (A – B) > 3
{
C = 6;
D = D << 2
}
else
{
C = C << 5;
*dPtr = 7;
} 

  .data
A: .word 7
B: .word 5
C: .word 2
D: .word 4
#assign pointer to D
  .text
main:
  li $t2 3
  lw $t3 A
  lw $t4 B
  lw $t5 C
  lw $t6 D
  sub $t7 $t3 $t4
  bgt $t7 $t2 if
  sll $t6 $t6 3
  sll $t6 $t6 2
  #update D from the pointer
  j ext
if: 
  #set c to six
  sll $t5 $t5 2
  j ext
ext:
  #loop
