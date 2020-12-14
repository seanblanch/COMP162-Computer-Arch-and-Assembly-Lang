;Sean Blanchard
;Program 3
;10/11/18
         BR      main        
rabbits: .BLOCK  2           ;Total rabbits
tGoodR:  .BLOCK  2           ;Total good rabbits
tDfctR:  .BLOCK  2           ;Defective rabbits
tIDfctR: .BLOCK  2           ;total individual defective rabbits
tGIdvR:  .BLOCK  2           ;total Good Individual rabbits
DCrate:  .BLOCK  2           ;crate that can hold 32 defective rabbits
gBox:    .BLOCK  2           ; box that can hold 8 good rabbits
CCost:   .BLOCK  2           ; total crate cost to ship
IRCost:  .BLOCK  2           ; total individual rabbit cost
BCost:   .BLOCK  2           ; total box cost to ship
GRCost:  .BLOCK  2           ;total good rabbit cost
ZCost:   .BLOCK  2           ;Load zero cost
TCost:   .BLOCK  2           ; total cost
;
;String
;
S_Number:.ASCII  "Enter N: \x00"
S_Rcd:   .ASCII  "Number of rabbits received: \x00"
S_TDfctR:.ASCII  "Number unsuitable: \x00"
S_TDfctC:.ASCII  "Number of containers of bad rabbits: \x00"
S_TIDR:  .ASCII  "Number of individual bad rabbits: \x00"
S_TGR:   .ASCII  "Number of good rabbits: \x00"
S_GBox:  .ASCII  "Number of boxes of good rabbits: \x00"
S_TIGR:  .ASCII  "Number of individual good rabbits: \x00"
S_CDRS:  .ASCII  "Pounds to ship the containers: \x00"
S_CIDRS: .ASCII  "Pounds to ship individual bad rabbits: \x00"
S_CGRS:  .ASCII  "Pounds to mail the boxes: \x00"
S_CIGRS: .ASCII  "Pounds to mail individual good rabbits: \x00"
S_TCost: .ASCII  "Total shipping and mailing costs: \x00"
S_Pounds:.ASCII  " pounds \x00"
S_NLine: .ASCII  "\n\x00"    
;
;Main
;
main:    STRO    S_Number,d  ; Call String Number output
         DECI    rabbits,d   ;Scan function/Get function for rabbits
         STRO    S_Rcd,d     ; Call String Received output
         DECO    rabbits,d   ;Scan Out / output total rabbits
         STRO    S_NLine,d   ;create a new line
;
;Calculating Defective Rabbits
;
         LDWA    rabbits,d   ;Get # of rabbits
         ASRA                
         ASRA                
         ASRA                
         ASRA                ;Get # of defective rabbits
         STWA    tDfctR,d    ;Store # of defective rabbits
         STRO    S_TDfctR,d  ; Call String Total Defective Rabbits output
         DECO    tDfctR,d    ;Scan Out / output total defective rabbits
         STRO    S_NLine,d   ; New Line
;
; Get number of crates full of bad rabbits
;
         LDWA    tDfctR,d    ;load number of defective rabbits
         ASRA                
         ASRA                
         ASRA                
         ASRA                
         ASRA                
         STWA    DCrate,d    ;Store # of defective rabbits that can fit in container
         STRO    S_TDfctC,d  ; Call String Total Defective Crate
         DECO    DCrate,d    ;Scan Out / output total number of crates of bad rabbits
         STRO    S_NLine,d   ; New Line
;
; Get number of individual bad rabbits
;
         LDWA    tDfctR,d    ; Get number of defective rabbits
         ANDA    31,i        ;Given the number converted to binary, we use 31 to check last 5 didgets
; then give us the remainder using AND statement on last 5 didgets
         STWA    tIDfctR,d   ;Store # of Individual bad rabbits
         STRO    S_TIDR,d    ; Call String Total Individual Defective Rabbits
         DECO    tIDfctR,d   ;Scan Out/ output total individual defective rabbits
         STRO    S_NLine,d   ; New Line
;
;SUBA - Subtract number of bad rabbits from total rabbits to get good rabbits
;
         LDWA    rabbits,d   ;Get number of rabbits
         SUBA    tDfctR,d    ;Subtract total defective rabbits
         STWA    tGoodR,d    ; store # of good rabbits
         STRO    S_TGR,d     ;Call String Total Good Rabbits
         DECO    tGoodR,d    ;Scan Out/output total good rabbits
         STRO    S_NLine,d   ; New Line
;
; Number of boxes of good rabbits
;
         LDWA    tGoodR,d    ;Get number of good rabbits
         ASRA                
         ASRA                
         ASRA                
         STWA    gBox,d      ;Store # of good rabbits in box
         STRO    S_GBox,d    ;Call total good box of rabbits
         DECO    gBox,d      ;Scan Out/output total # of good rabbits in box
         STRO    S_NLine,d   ; new line
;
; Number of Individual good rabbits
;
         LDWA    tGoodR,d    ;Get number of good rabbits
         ANDA    7,i         ;check the last didgets in binary
         STWA    tGIdvR,d    ;Store # of individual good rabbits
         STRO    S_TIGR,d    ;Call total individual good rabbits
         DECO    tGIdvR,d    ;Output total # of good rabbits
         STRO    S_NLine,d   ;New Line
;
; Pounds to ship the containers
;
         LDWA    DCrate,d    ;Get number of crates of defective rabbits
         ASLA                
         ASLA                
         ADDA    DCrate,d    ;Add shipping cost for total number of boxes
         STWA    CCost,d     ; Store to cost
         STRO    S_CDRS,d    ; Call total pounds to ship the containers
         DECO    CCost,d     ; Output total cost to ship container
         STRO    S_NLine,d   ; New Line
;
;Pounds to ship individual Bad Rabbits
;
         LDWX    tIDfctR,d   ;Load total individual defective rabbits
         STRO    S_CIDRS,d   ;Call pounds to ship individual bad rabbits
         DECO    tIDfctR,d   ;Output total cost to ship individual rabbits
         STRO    S_NLine,d   ; New Line
;
;Pounds to mail the boxes
;
         LDWA    gBox,d      ; Load total number of boxes of good rabbits
         ASLA                
         ASLA                
         ASLA                
         ADDA    gBox,d      ; Add shipping cost for total number of boxes
         STWA    BCost,d     ;Store to Box cost
         STRO    S_CGRS,d    ; Call Pounds to mail the boxes
         DECO    BCost,d     ; Output total cost to ship box
         STRO    S_NLine,d   ; New Line
;
;Pounds to mail individual good rabbits
;
         LDWX    tGIdvR,d    ;Load totl number of good rabbits
         ASLX                
         STWX    GRCost,d    ; store to good rabbit cost
         STRO    S_CIGRS,d   ;Call Pounds to mail individual good rabbits
         DECO    GRCost,d    ;output total cost to ship individual good rabbits
         STRO    S_NLine,d   ; New Line
;
;Total Shipping and mailing costs
;
         LDWA    ZCost,d     ; Load zero into register A
         ADDA    GRCost,d    ;ADD Good Individual Rabbit cost
         ADDA    BCost,d     ;ADD Box Cost
         ADDA    tIDfctR,d   ;ADD Individual defective rabbit cos
         ADDA    CCost,d     ;ADD Crate Cost
         STWA    TCost,d     ;Store to Total Cost
         STRO    S_TCost,d   ;Call Totalt shipping and mailing costs
         DECO    TCost,d     ;Output total shipping and mailing costs
         STRO    S_Pounds,d  ;Output pounds at end
         STRO    S_NLine,d   ;New Line
         STOP                
         .END                  