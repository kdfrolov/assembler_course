.data
  a: .float -200208.17
  b: .float 10.06
  s: .float 0.0
  f1: .float 1.0
  ln2: .float 0.6931471806
  mes1: .asciiz "S = A"
  mes2: .asciiz "S < A"
  mes3: .asciiz "S > A"

.text
  lwc1 $f0, a
  lwc1 $f1, b
  lwc1 $f2, f1
  lwc1 $f3, ln2
  add.s $f4, $f0, $f1
  sub.s $f5, $f2, $f3
  mul.s $f6, $f4, $f5
  swc1 $f6, s
  
  c.eq.s 1, $f6, $f0
  bc1t 1, Equal
  
  c.lt.s 2, $f6, $f0
  bc1t 2, Less
  
  la $a0, mes3
  li $v0, 4
  j print_m
  
Equal:
  la $a0, mes1
  li $v0, 4
  j print_m
  
Less:
  la $a0, mes2
  li $v0, 4
  
 print_m:
   syscall