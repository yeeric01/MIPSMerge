#Name: Eric Ye
#NetID: EXY180001
#Explanation: I use a loop to compare the first elements of both lists, then store the smaller one on the stack. I decrement the list lengths each time I store an element from that list
#if either of the list is empty before the other list isn't, it branches to an appropriate loop to store the rest of the elements of the list that isn't empty
#I stored the starting stack address at the start of the program, which is where the smallest element is contained. When I print I print from that address and increment by 4 each time I print an element until
#all elements printed.
				.data
list1:			.word 1, 3, 4, 5, 6, 7, 8
list2:			.word -1, 0, 5, 9
list1len:		.word 7
list2len:		.word 4
aWord:			.asciiz	", "
				.text
main:
		lw		$t1, list1len
		lw		$t2, list2len		#store length of the two lists
		la		$t3, list1			#store the first element address of each list
		la		$t4, list2
		addi	$t8, $sp, -4
		
		
		add		$t6, $t1, $t2		#add both lengths
		
		

loop: 								#continuously compare the first element of both lists, store the smaller element in the stack, and loop until one list is empty
		beqz	$t2, storelist1		#branch if the second list is empty
		beqz	$t1, storelist2		#branch if the first list is empty
		lw 		$t5, 0($t3)			#get first elements of both lists
		lw		$t7, 0($t4)
		slt		$t0, $t5, $t7		#compare the elements
		beqz	$t0, secondBig		
		
firstBig:							#store the element in the first list in the stack
		addi	$sp, $sp, -4
		sw		$t5, 0($sp)
		addi	$t3, 4
		addi	$t1, -1
		j		loop
		
secondBig:							#store the element in the second list in the stack
		addi	$sp, $sp, -4
		sw		$t7, 0($sp)
		addi	$t4, 4
		addi	$t2, -1
		j		loop
		
		
		
storelist1:							#store rest of the first list
loop1:	
		beqz	$t1, printList
		lw		$t5, 0($t3)
		addi	$sp, $sp, -4
		sw		$t5, 0($sp)
		
		addi	$t3, $t3, 4
		addi	$t1, $t1, -1
		j		loop1
		


storelist2:							#store the rest of the second list
loop2:	
		beqz	$t2, printList
		lw		$t5, 0($t4)
		addi	$sp, $sp, -4
		sw		$t5, 0($sp)
		
		addi	$t4, $t4, 4
		addi	$t2, $t2, -1
		j		loop2
		


printList:							#print the list with commas starting from the address that $t8 stored, which is the original stack pointer address			
loop3:
		beqz	$t6, finish
		lw		$a0, 0($t8)
		li		$v0, 1
		syscall
		addi	$t8, -4
		addi	$t6, $t6, -1
		beqz	$t6, finish
		la		$a0, aWord
		li		$v0, 4
		syscall		
		j		loop3



finish:								#finish the program
		li		$v0, 10
		syscall
