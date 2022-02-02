.extern prints, fgets, case_sensitive_comp, array1 , array2
.global dist1 , dups1 , backtomergesort
.text 


dups1:     //r7 = 1 then it is case sensitve else case insensitive

//the string list is stored in buffermem1 and the array which has pointers to this string is stored in array1

//The length of the list is stored in bufferlength1 

//storing array1 in r3

ldr r3, = array1



//storing the length in r11

ldr r11 ,= bufferlength1
ldr r11 , [r11]

//r1 points to the first input string and r5 has the length 

// merge(mergesort(a) , mergesort(b))

//merge should return the length 

//let us store the length of the first string in r3 and the second string in r4

//now applying mergesort shall change the r5 , i.e the length of the final string 

//r3 has pointer to the start of first string 
//r4 has pointer to the start of the second string 
 

//the merged string get stored at buffermem3 then overwriting array1 by merged string 






mergesort_loop :    stmfd sp! , {r0 -r11, lr}

                    cmp r11 , #0

                    beq returnelement 

                    cmp r11 , #1 
                    beq returnelement    


                     //length of first list
                    mov r6 , r11 , lsr #1
//length of second string 
                    sub r10 , r11 , r6 
                    
                    add r4 , r3 , r6 , lsl #2


                    stmfd sp! , {r3,r4,r6,r11}
                    mov r11 , r6 
                    bl mergesort_loop
        
                   
                    

                    mov r3 , r4 
                    mov r11 , r10 
                    bl mergesort_loop

                   
                    ldmfd sp! , {r3,r4,r6,r11}
                    stmfd sp! , {r3 , r4}
                    bl merge_them  //it merge r3 and r4 and store in buffermem3
                    //we overwrite array3 with the sorted part of buffermemory 3 




                     
backtomergesort:    
                    ldmfd sp! , {r3 , r4} 
                    stmfd sp! , {r3}
                    ldr r8 , = buffermem3
                    ldr r7 , [r8] , #4  
                    mov r9 , #0
 l:                 cmp r9 , r11
                    beq exit_l
                    add r9 , #1 
                    str r7 , [R3] ,#4
                    ldr r7 , [r8] , #4  
                    bl l 
//the merged string get stored at buffermem3 then overwriting array1 by merged string 



                    



exit_l  :            ldmfd sp!, {r3}
                    ldmfd sp!, {r0 - r11,pc}
       




                    



                   

                    


returnelement :     


                    ldmfd sp! , { r0 - r11, pc} 






   


    
                
dist1 :   



.data 





.end
