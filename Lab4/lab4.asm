.data
  mes1: .asciiz " res - "
  mes2: .asciiz " count - "
  mes3: .asciiz " last element's adress - "
  mes4: .asciiz " no such elements\n"
  A: .word 4 2 10 4 5 4 4 1 7 10 2 1
  n_str: .word 4
  n_stl: .word 3
  n_stl_size: .word 12
  res: .word 0
  count: .word 0
  b: .word 1
  adress: .word 0
  
.text
  add $sp, $sp, -16
  la $t0, A+4
  sw $t0, 12($sp)
  la $t1, n_str
  lw $t1, 0($t1)
  sw $t1, 8($sp)
  lw $t6, b
  sw $t6, 4($sp)
  lw $t7, n_stl_size
  sw $t7, 0($sp)
  jal proc
  lw $t3, 8($sp)
  lw $t4, 4($sp)
  lw $t5, 0($sp)
    add $sp,$sp,12
    
  beq $t3, 0, no_elements
  j print_res
  
no_elements:
  la $a0, mes4
  li $v0, 4
  syscall
  
print_res:
  la $a0, mes2
  li $v0, 4
  syscall

  la $a0, ($t3)
  li $v0, 1
  syscall
  
  la $a0, mes1
  li $v0, 4
  syscall
  
  la $a0, ($t4)
  li $v0, 1
  syscall
  
  la $a0, mes3
  li $v0, 4
  syscall
  
  la $a0, ($t5)
  li $v0, 1
  syscall
  j stop
  
proc:
  lw $t0, 12($sp)
  lw $t1, 8($sp)
  lw $t6, 4($sp)
  lw $t7, 0($sp)
  loop:
  lw $t2, 0($t0)
  ble $t2, $t6, met
  add $t3, $t3, 1
  add $t4, $t4, $t2
  la $t5, ($t0)
met:
  add $t1, $t1, -1
  add $t0, $t0, $t7
  bgtz $t1, loop
  
  add $sp,$sp,16
  
  add $sp,$sp,-12
  
  sw $t3, 8($sp)
  sw $t4, 4($sp)
  sw $t5, 0($sp)
  jr $ra
  
stop:
  g:nop