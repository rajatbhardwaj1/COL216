.global case_sensitive_comp , case_insensitive_comp

.text
@this function takes r1 and r2 as input pointing to the first and second string starting char's location
@return r5 = 1 if string1  > string2,  r5 = 2  if both equal  else r5 = 0
@return r5 = 3 if array1 is over , return r5 = 4 if array 2 is over else if both over than r5 = 5

case_sensitive_comp :stmfd	sp!, {r1-r4,lr}


@loop for comparison character wise and case sensitive 

comp :          

                @ cmp r5 , #0     

                @ beq first_string_finished
                @ cmp r6 , #0
                @ beq op_first_string_greater            @second_string_finished_but_not_first
                
                ldrb r3 , [r1]              @r3 = current char ascii in first string 
                ldrb r4 , [r2]              @r4 = curr char ascii in second string 
                 
                cmp r3 , #0x0
                beq array1over
                cmp r4 , #0x0
                beq array2over  
                
                cmp r3 , #0xD
                beq r3finished          @checking if \n

                
                cmp r4 , #0xD
                beq firstgreater

                cmp r3 , r4 

                
                add r1 , #1             @incrementing the memory location of r1 and r2 so that it points to the next char 
                add r2 , #1 

               
                beq comp                @if both chars are equal continue the loop else 

                blt secondgreater                @breaking the loop if the current chars are different
                bl firstgreater
               

r3finished :    cmp r4 , #0xd
                beq botheq 
                bl secondgreater

botheq :        mov r5 , #2
                ldmfd	sp!, {r1-r4,pc}
secondgreater : mov r5 , #0
                ldmfd	sp!, {r1-r4,pc}
firstgreater:   mov r5 , #1
                ldmfd	sp!, {r1-r4,pc}

array1over:     cmp r4 , #0x0 
                beq bothover
                mov r5 , #3
                ldmfd	sp!, {r1-r4,pc}


array2over:     mov r5 , #4 
                ldmfd	sp!, {r1-r4,pc}



bothover    :   mov r5 , #5 
                ldmfd	sp!, {r1-r4,pc}


case_insensitive_comp:  stmfd	sp!, {r1-r4,lr}
comp1 :          

                @ cmp r5 , #0     

                @ beq first_string_finished
                @ cmp r6 , #0
                @ beq op_first_string_greater            @second_string_finished_but_not_first
                
                ldrb r3 , [r1]              @r3 = current char ascii in first string 
                ldrb r4 , [r2]              @r4 = curr char ascii in second string 
                 
                cmp r3 , #0x0
                beq array1over
                cmp r4 , #0x0
                beq array2over  
                
                cmp r3 , #0xD
                beq r3finished          @checking if \n

                
                cmp r4 , #0xD
                beq firstgreater
                cmp r3 , #91
                blt less_than_91
cont1:          cmp r4 , #91
                blt less_than_91_1

                
cont2:          cmp r3 , r4 

                
                add r1 , #1             @incrementing the memory location of r1 and r2 so that it points to the next char 
                add r2 , #1 

               
                beq comp1                @if both chars are equal continue the loop else 

                blt secondgreater                @breaking the loop if the current chars are different
                bl firstgreater

less_than_91 : 
                        cmp r3 , #65                          @cmp r3 , #65
                        blt cont1
                        add r3 , #0x20
                        bl cont1

                
less_than_91_1:         cmp r4,#65
                        blt cont2
                        add r4 , #0x20
                        bl cont2


.data



.end
