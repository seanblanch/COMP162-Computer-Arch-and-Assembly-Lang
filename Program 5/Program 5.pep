;Sean Blanchard
;11/29/18
;Program 5 -> PLTL set



main2:   LDWA    0,i         
         STWA    stkPnt,d    ; stackpointer = 0
main:    STRO    s_input,d   
         LDWX    0,i         ; set the input index to 0
addChar: LDBA    charIn,d    
         CPBA    '\n',i      ; stop the user input loop if enter is found
         BREQ    nullChar    
         STBA    input,x     ; store the current character input
         ADDX    1,i         ; increment the input index
         CPBX    7,i         ; check for maximum char input
         BREQ    nullChar    
         BR      addChar     
nullChar:LDBA    0,i         
         STBA    input,x     ; put null byte after last character read
;
; Call Atoi and Check if Valid Input is passed
         SUBSP   4,i         ; allocate space or parameter and R.V
         LDWA    input,i     
         STWA    0,s         ; store input address on run time stack
         CALL    atoi        
         ADDSP   2,i         ; deallocate input address
         LDWA    0,s         ; load R.V into register A
         ADDSP   2,i         ; deallocate R.V
         BREQ    UserCmd       ;if equal, everything pass so branch to find user cmd
;
; Push R.V in calculator stack, remember to use stackpointer
         LDWX    stkPnt,d    ; load stackpointer
         CPWX    10,i        ; check for full calcStack
         BRGT    stackful    
         STWA    calcStk,x   ; store input into calcStack
         ADDX    2,i         ; stackpointer++
         STWX    stkPnt,d    ; store stackpointer
         BR      main        ;Branch back to main
;
; User Command
UserCmd: LDWX    0,i         ; set index register to 0
         LDBA    input,x     ; load char from input
         LDWX    stkPnt,d    ; load stackpointer into register X
;
         CPBA    'q',i       
         BREQ    quit        
;
         CPBA    'p',i       
         BREQ    pop         
;
         CPBA    'c',i       
         BREQ    clear       
;
         CPBA    'd',i       
         BREQ    display     
;
         CPBA    '=',i       
         BREQ    showtop     
;
         CPBA    '+',i       
         BREQ    add         
;
         CPBA    '-',i       
         BREQ    subtract    
;
         BR      unkcmd      
;
; quit
quit:    STRO    goodbye,d   
         STOP                
;
; pop
pop:     CPWX    0,i         ; stackpointer <= 0
         BRLE    empty       
         SUBX    2,i         ; stackpointer--
         STWX    stkPnt,d    ; store stackpointer
         BR      main        
;
; clear
clear:   LDWX    0,i         ; stackpointer = 0
         STWX    stkPnt,d    ; store stackpointer
         BR      main        
;
; display
display: CPWX    0,i         ;stackpointer > 0
         BRGT    print       
         BR      main        
print:   SUBX    2,i         ; stackpointer--
         DECO    calcStk,x   ; output integer from calcStk
         STRO    s_nl,d      
         BR      display     
;
; showtop
showtop: CPWX    0,i         ; stackpointer > 0
         BRGT    show        
         BR      main        
show:    SUBX    2,i         ; stackpointer--
         DECO    calcStk,x   ; output integer from stackAr
         ADDX    2,i         ; stackpointer++
         STRO    s_nl,d      
         BR      main        
;
; add
add:     CPWX    2,i         ; stackpointer > 2
         BRLE    oprnds      ;
         SUBX    4,i         ; stackpointer - 2
         LDWA    calcStk,x   ; calcStk[stackpointer - 1]
         ADDX    2,i         ; stackpointer++
         ADDA    calcStk,x   ; calcStk[stacl[pointer]
         CALL    chkovf      
         SUBX    2,i         ; stackpointer--
         STWA    calcStk,x   ; calcStk[stackpointer - 1] = calcStk[stackpointer - 1] + calcStk[stackpointer]
         ADDX    2,i         ; stackpointer++
         STWX    stkPnt,d    ; store stackpointer
         BR      main        
;
; sub
subtract:CPWX    2,i         ; stackpointer > 2
         BRLE    oprnds      ; print not enough operands in stack if cant compair
         SUBX    4,i         ; stackpointer - 2
         LDWA    calcStk,x   ; calcStk[stackpointer - 1]
         ADDX    2,i         ; stackpointer++
         SUBA    calcStk,x   ; calcStk[stacl[pointer]
         CALL    chkovf      ; check for overflow
         SUBX    2,i         ; stackpointer--
         STWA    calcStk,x   ; calcStk[stackpointer - 1] = calcStk[stackpointer - 1] - calcStk[stackpointer]
         ADDX    2,i         ; stackpointer++
         STWX    stkPnt,d    ; store stackpointer
         BR      main        
;
; calcStk full
stackful:STRO    s_full,d  ;Print that stack is overflow  
         BR      main      ;Branch back to main to get new user input  
;
; calcStk empty
empty:   STRO    s_empty,d ;Print that stack is empty  
         BR      main      ;branch back to main to get new user input  
;
; not enough operands for operation
oprnds:  STRO    s_oprnds,d ;Print not enough operands for operation 
         BR      main       ;Branch back to main for new user input
;
; warning overflow
chkovf:  BRV     ovf         
         RET                 
ovf:     STRO    s_wrnOvf,d  
         RET                 
;
; unknown command
unkcmd:  STRO    s_unkCmd,d  ;print Uknown user command
         BR      main        ;So branch back to main to find a new userCommand


;
; atoi
atoi:    SUBSP   10,i        ; for locals and saved registers
         STWA    6,s         
         STWX    8,s         ; registers saved on entry
         LDWX    0,i         
         STWX    0,s         ; sign = 0 (positive)
         STWX    14,s        ; return value = 0
         STWX    4,s         ; result = 0
         LDBA    12,sfx      ; 1st char of string
         BREQ    atoiexit    ; null string exit returning 0
         CPBA    '-',i       
         BRNE    atoiloop    ; not a negative number
         LDWA    -1,i        
         STWA    0,s         ; sign = -1
         ADDX    1,i         ; move past sign
atoiloop:LDWA    0,i         ; clear register A
         LDBA    12,sfx      
         BREQ    atoiretv    ; if reached end of string
         CPBA    '0',i       
         BRLT    atoiexit    ; non-digit char - return 0
         CPBA    '9',i       
         BRGT    atoiexit    ; non-digit char - return 0
         SUBA    '0',i       
         STWA    2,s         ; temp = digit value
         LDWA    4,s         ; result so far
         ASLA                ; 2*result
         BRV     atoiexit    
         ASLA                ; 4*result
         BRV     atoiexit    
         ADDA    4,s         ; 5*result
         BRV     atoiexit    
         ASLA                ; 10*result
         BRV     atoiexit    
         STWA    4,s         ; result = result * 10
         LDWA    0,s         ; sign indicator
         BRNE    atoineg     ; branch if number is negative
         LDWA    4,s         ; result
         ADDA    2,s         ; digit
         BRV     atoiexit    
         STWA    4,s         ; result = result * 10 + digit
         ADDX    1,i         
         BR      atoiloop    
atoineg: LDWA    4,s         ; result
         SUBA    2,s         ; digit (subtracted because negative number)
         BRV     atoiexit    
         STWA    4,s         ; result = result * 10 - digit
         ADDX    1,i         
         BR      atoiloop    
;
atoiretv:LDWA    4,s         
         STWA    14,s        
atoiexit:LDWA    6,s         
         LDWX    8,s         ; registers restored
         ADDSP   10,i        
         RET 


;
; Variables
input:   .BLOCK  7           
calcStk: .BLOCK  12          
stkPnt:  .BLOCK  2           
s_input: .ASCII  ":\x00"     
s_nl:    .ASCII  "\n\x00"    
s_unkCmd:.ASCII  "Error: unrecognized command\n\x00"
s_empty: .ASCII  "Error: stack empty\n\x00"
s_full:  .ASCII  "Error: stack overflow\n\x00"
s_oprnds:.ASCII  "Error: not enough operands for operation\n\x00"
s_wrnOvf:.ASCII  "Warning: Overflow\n\x00"
goodbye: .ASCII  "Goodbye!\x00"                
         .END                  