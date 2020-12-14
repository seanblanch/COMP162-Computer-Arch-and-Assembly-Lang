;Sean Blanchard
;10/25/18
;Program 4 - Collatz' conjecture
         BR      main        
prompt:  .ASCII  "N:\x00"    
gb:      .ASCII  "Goodbye\x00"
nl:      .ASCII  "\n\x00"    
of:      .ASCII  "Overflow\x00"
steps:   .ASCII  " steps\x00"
main:    STRO    prompt,d    
         DECI    0,s         ;save user input on stack 0
         LDWA    0,s         ; load user input on stack
         CPWA    0,i         ; If zero branch to done
         BREQ    done        ;branch to done
         LDWX    0,i         
         STWX    4,s         
Oloop:   CPWA    1,i         ;check user input to 1
         BREQ    found       
         ADDX    1,i         ;implement counter / user intered invalid number
         STWX    4,s         ;Store counter to 4 on stack
         ANDA    1,i         
         CPWA    0,i         
         BREQ    even        
         LDWA    0,s         ; Start ODD    
         ASLA                
         BRC     over        ; brach to over if carry
         ADDA    0,s         
         BRC     over       ;branch to over if carry 
         ADDA    1,i         
         BRC     over        ;branch to over if carry
         ADDX    1,i         ;impletment counter
         STWX    4,s         
         STWA    0,s         
even:    LDWA    0,s         
         ASRA                ;divide by 2
         ANDA    32767,i     ;check for overflow     
         STWA    0,s         
         BR      Oloop       ;branch to Oloop
over:    STRO    of,d        
         STRO    nl,d        
         BR      main        ;get new user input
found:   DECO    4,s         ; output counter
         STRO    steps,d     ;output steps
         STRO    nl,d        ;output new line
         BR      main        ; get new entry
done:    STRO    gb,d        
         STOP                
         .END                  