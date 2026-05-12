.ORIG x3000

        ;; 1. Load the address of the pointer into R3
        ;; At x3000, incremented PC is x3002. 
        ;; Offset of 4 means: x3002 + (4 << 1) = x300A.
        LEA R3, #4              

        ;; 2. Load the actual target address (x4001) into R3
        LDW R3, R3, #0          

        ;; 3. Load the test data (xABCD) into R0
        LEA R0, #4              ; Points R0 to x3002 + (4 << 1) + 2 = x300E
        LDW R0, R0, #1          

        ;; 4. Set R1 = x01
        AND R1, R1, #0
        ADD R1, R1, #1

        ;; 5. STW R0 to x4000 (Aligned version of x4001)
        ;; This writes xCD to x4000 and xAB to x4001.
        STW R0, R3, #0          

        ;; 6. STB R1 to x4001 (The ODD address)
        ;; This should replace xAB with x01.
        STB R1, R3, #0          

        HALT

ADDR_PTR .FILL x4001           ; Located at x3010
DATA_VAL .FILL xABCD           ; Located at x3012
        .END