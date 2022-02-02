.extern prints, fgets, case_sensitive_comp,case_sensitive, case_insensitive
.global buffermem1,bufferlength1 , bufferlength2,  array1 , array2 , buffermem2 , buffermem3 , buffercase , text4
_start  : 
.text 
@ output please enter the first string list, strings seperated by space, hit enter when done
// the string input ins stored at buffermem1 and the pointers to the strings are stored in array1


                ldr r0 , = text5
                bl prints

                ldr r0 ,= bufferlength1
                mov r1 , #50
                mov  r2 , #0
                bl fgets
                bl atoi 
                ldr r1 ,= bufferlength1
                str r0 , [r1]
                mov r6, r0

                ldr r0 , =text 
                bl prints


@ take input of list of strings, 

take_inp1_ :    ldr r1, =input_para
                ldr r2 , = array1
                ldr r3 , [r1, #4]
                str r3 , [r2], #4

                bl take_inp1



take_inp1 :     bl startloop


startloop :     
                cmp r6 , #0x0           
                beq  nextbranch   
                mov r0 , #6 
                swi 0x123456
                ldr r3 , [r1, #4]

                ldrb r4 , [r3]          @r3 has the memory location of the last input ascii
                cmp r4 , #0xd     @encoutring space key , store index in array
                beq storeinarray1
returnhere :    add r5 , #1 

                add r3 , #1 
                str r3 , [r1, #4]
                

                bl take_inp1




               
@printing : Enter 1 for case sensitive ans 0 for case insensitive



storeinarray1 :     mov r7 , r3 
                    
                    add r7 , #1
                    
                    str r7 , [r2], #4

                    sub r6 , #1

                    bl returnhere
nextbranch :    


nextbranch1:    ldr r0 , =text3
                bl prints

@take 1 or 0 as input and go to respective branch 
@if 1 then go to case insensitive else case sensitive
                ldr r0,=buffercase
                mov r1 , #4
                mov r2 , #0
                bl fgets
                ldr r0, =buffercase
                ldrb r0 , [r0]
                cmp r0 , #0x31
                beq case_sensitive_mergesort
                bl case_insensitive_mergesort


case_sensitive_mergesort:   @if r7=1 then it does case insensitive comparison

@print Enter 1 for removing the duplicates and 0 otherwise
                ldr r0 , =text4
                bl prints
                ldr r0,=buffercase
                mov r1 , #4
                mov r2 , #0
                bl fgets
                ldr r0, =buffercase
                ldrb r0 , [r0]
                cmp r0 , #0x31
                beq dist1

                bl dups1
                mov r0 , #0x18                  //change 

                swi 0x123456

case_insensitive_mergesort:     mov r7 , #1
                                bl case_sensitive_mergesort

mov r0, #0x18
swi 0x123456

.data 

para1 : .word 0
        .word buffer1
        .word 1
buffer1 : .space 1000

input_para :    .word 0 
                .word buffermem1 
                .word 1

buffermem1 :  .space 1000
input_para1 :    .word 0 
                .word buffermem2
                .word 1

buffermem2 :  .space 1000
buffercase : .space 8

buffermem3 : .space 1000

array1 : .space 1000
array2 : .space 1000 

bufferlength1 : .space 50
bufferlength2 : .space 50

        

text : .asciz "Please enter the first string list, strings seperated by enter\n\0"
text1 : .asciz "Please enter the second string list, strings seperated by enter\n\0"
text3 : .asciz "Enter 1 for case sensitive and 0 for case insensitive\n: \0"
text4 : .asciz "Enter 1 for removing the duplicates and 0 otherwise\n: \0"
text5 : .asciz "Please enter length of the first string\n: \0"
text6: .asciz "Please enter the length of the second string\n: \0"
.end
