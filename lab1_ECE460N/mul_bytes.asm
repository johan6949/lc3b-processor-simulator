.ORIG x3000
    AND R2, R2, #0      ; R2 = Result (Total)
    AND R3, R3, #0      ; R3 = Overflow Flag
    
    LEA R4, OP1         ; R4 points to the address x3100
    LDW R0, R4, #0      ; R0 = x3100
    LDB R0, R0, #0      ; R0 = Value at x3100 (Multiplier)
    BRZ DONE            ; If multiplier is 0, skip to end

    LEA R4, OP2         ; R4 points to the address x3101
    LDW R1, R4, #0      ; R1 = x3101
    LDB R1, R1, #0      ; R1 = Value at x3101 (Multiplicand)
    BRZ DONE            ; If multiplicand is 0, skip to end

LOOP 
    ADD R2, R2, R1      ; Result = Result + Multiplicand
    
    
    LEA R4, MASK
    LDW R5, R4, #0      ; R5 = xFF00
    AND R5, R2, R5      ; Check if any bits above the first 8 are set
    BRZ NEXT
    ADD R3, R3, #1      ; Set overflow flag if bits found

NEXT 
    ADD R0, R0, #-1     ; Decrement Multiplier
    BRP LOOP            ; Loop until Multiplier is 0

DONE 
    LEA R4, RESULT
    LDW R4, R4, #0      ; R4 = x3102
    STB R2, R4, #0      ; Store result byte at x3102
    STB R3, R4, #1      ; Store overflow byte at x3103
    HALT

OP1     .FILL x3100
OP2     .FILL x3101
RESULT  .FILL x3102
MASK    .FILL xFF00
.END