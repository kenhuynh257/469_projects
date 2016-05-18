  .data
A: .word 7          # addr 0
B: .word 5          # addr 1
C: .word 2          # addr 2
D: .word 4          # addr 3
  .text
main:
  addi $t2 $zero 3  # 0x1
  lw $t3 A          # 0x2 
  lw $t4 B          # 0x3
  sub $t7 $t3 $t4   # 0x4
  bgt $t7 $t2 if    # 0x5
  
  lw $t5 C          # 0x6
  sll $t5 $t5 3     # 0x7
  sll $t5 $t5 2     # 0x8
  addi $t1 $zero 7  # 0x9
  sw $t1 D          # 0xA
  sw $t5 C          # 0xB
  j ext             # 0xC

if:
  lw $t6 D          # 0xD
  addi $t1 $zero 6  # 0xE
  sw $t1 C          # 0xF
  sll $t6 $t6 2     # 0x10
  sw $t6 D          # 0x11
  j ext             # 0x12

ext:
  j ext             # 0x13
