.extern prints, fgets, case_sensitive_comp, array1 , array2
.global case_sensitive, case_insensitive ,merge_them , dist1,merge_them_dist
.text 
@r6 and r10 has length of string 1 and string 2 

   @now we have pointers to the start of first and second string in buffermem1 and buffermem2 
                
merge_them:        


                @r11 has length 
                mov r11 , #0 
                @ ldr r3,= array1
                @ ldr r4 ,= array2
                ldr r1 , [r3],#4        @r3 and r4 has pointer to the next string always

                ldr r2 , [r4],#4
                ldr r8 , = buffermem3


loop1:                  cmp r6 , #0 
                        beq list1finished
returnback:             cmp r10 , #0
                        beq string2isgreater
                        cmp r7,#1               @checking for case sensitive or case insensitive
                    bne jii            
                    bl case_insensitive_comp
                    bl jii1
jii:                bl case_sensitive_comp
jii1  :              cmp r5 , #1
                    beq string1isgreater

                    cmp r5 , #0             @string 2 is greater
                    beq string2isgreater

                    cmp r5 , #2 
                    beq string1isgreater
                    
                    cmp r5 , #3
                    beq string1isgreater

                    cmp r5 , #4
                    beq string2isgreater

                    bl endfunction


list1finished : cmp r10, #0 
                beq endfunction 
                bl string1isgreater                  

@if string2 is smaller then the location of string2 is stored in buffermem3 and the address of r2 is incremented so that it pointes to the next string 
string1isgreater :  str r2 , [r8] , #4
                    ldr r2 , [r4] , #4
                    sub r10 , #1 
                    add r11 , #1 
                    bl loop1


                    

                    
string2isgreater:   str r1 , [r8] , #4
                    ldr r1 , [r3],#4
                    sub r6 , #1 
                    add r11 , #1 
                    bl loop1

//size of the output -- 

@if both the lists are finished  then simply printing the strings pointed by buffermem3 in sequence 
endfunction :       
                       

                        

                        @print the strings in buffermem3(it has address pointers to the strings)
                        ldr r4 , =buffermem3
                        bl backtomergesort 
                        
                         @[r4] has the addressed of first char of string
                        @ldr  x , [r4]    --- x  has address of first char

                         @loop for r1
loopforprint:      
                    ldr r2 , [r4]       @r2 has pointer to first char of string 
                    cmp r2 , #0         @check if strings finished
                    beq exitfunction
innerloop:          ldrb r3 , [r2] 
                    

                    cmp r3 , #0xD
                    beq nextstring

                    @printing char r3 ... address is in r2 
                    

                    
                    ldr r1 , =para
                    str r2 , [r1,#4] 


                    mov r0 , #5
                    swi 0x123456




                    add r2 , #1         @incrementing r2
                    bl innerloop






nextstring :            add r4 , #4
                        
                        @printing an empty space
                        ldr r1 ,= para2
                        mov r0 , #5
                        swi 0x123456


                        bl loopforprint
            




exitfunction :      mov r0 , #0x18
                    swi 0x123456


    
@ for distint list 
merge_them_dist:     mov r11 , #0 
                
   @r1 has pointer to the first string 
    @r2 has pointer to the second string
                
                
                    ldr r1 , [r3],#4        @r3 and r4 has pointer to the next string always

                    ldr r2 , [r4],#4
                    ldr r8 , = buffermem3      @r8 has pointer to the answer array strings


loop2:              cmp r7 , #1
                    bne j1 
                    bl case_insensitive_comp
                    bl j2           
 j1:                bl case_sensitive_comp
 j2:                cmp r5 , #1
                    beq string1isgreater1

                    cmp r5 , #0             @string 2 is greater
                    beq string2isgreater1

                    cmp r5 , #2 
                    beq string1isgreater1
                    
                    cmp r5 , #3
                    beq string1isgreater1

                    cmp r5 , #4
                    beq string2isgreater1

                    bl backtomergesort1


                    


string1isgreater1 : mov r9 , r1             @check if string 2 and 
                    sub r10  , r8 , #4
                    ldr r1 , [r10]
                    cmp r7 ,#1
                    bne f1
                    bl case_insensitive_comp
                    bl f2
f1 :                bl case_sensitive_comp 
f2:                 mov r1 , r9 
                    cmp r5 , #2
                    beq h1
                    str r2 , [r8] , #4
                    add r11 , #1
                   
h1:                 ldr r2 , [r4] , #4
                    @now comparing r2 and the previously stored string
                    @
                    bl loop2


                    

                    
string2isgreater1:  mov r9 , r2 
                    sub r10 , r8 , #4
                    ldr r2 , [r10]
                    cmp r7 , #1
                    bne k1
                    bl case_insensitive_comp    @here checking if the last string in our answe is equal to the new string to be inserted
                    bl k2
 k1:                bl case_sensitive_comp
  k2:               mov r2 , r9
                    cmp r5 ,#2
                    beq h2
                    str r1 , [r8] , #4
                     add r11 , #1
h2 :                ldr r1 , [r3],#4         @if the string is already present in the ans then dont store the string and simpy increment r3 to next string location 
                    bl loop2




@print Enter 1 for removing the duplicates and 0 otherwise
               

.data 

para:   .word 0
        .word 0 
        .word 1
para2:  .word 0
        .word emptytext
        .word 1
text7: .asciz "The merged string is \n\0"
emptytext : .ascii "\n"


.end
