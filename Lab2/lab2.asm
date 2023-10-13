 .data
 test: .ascii "12345"
 mem1: .byte 146 #10010010
 mem2: .byte 109 #01101101
 mem3: .byte 255
 head1: .asciiz "all 1"
 head2: .asciiz "not all 1"

 .text
 lbu $t1,mem1
 lbu $t2,mem2
 lbu $t4,mem3
 or $t3,$t1,$t2
 sub $t3,$t3,$t4
 beq $t3,$zero,good
 la $a0, head2 
 li $v0, 4 
 j print_h

good:
 la $a0, head1 
 li $v0, 4 
 
print_h:
 syscall 
