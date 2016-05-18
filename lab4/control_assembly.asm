  .data
A: .word 7          # addr 0
B: .word 5          # addr 1
C: .word 2          # addr 2
D: .word 4          # addr 3
  .text
main:
  addi $t2 $zero 3  # 0x4
  lw $t3 A          # 0x8 
  lw $t4 B          # 0xC
  sub $t7 $t3 $t4   # 0x10
  bgt $t7 $t2 if    # 0x14
  
  lw $t5 C          # 0x18
  sll $t5 $t5 3     # 0x1C
  sll $t5 $t5 2     # 0x20
  addi $t1 $zero 7  # 0x24
  sw $t1 D          # 0x28
  sw $t5 C          # 0x2C
  j ext             # 0x30

if:
  lw $t6 D          # 0x34
  addi $t1 $zero 6  # 0x38
  sw $t1 C          # 0x3C
  sll $t6 $t6 2     # 0x40
  sw $t6 D          # 0x44
  j ext             # 0x48

ext:
  j ext             # 0x4C
