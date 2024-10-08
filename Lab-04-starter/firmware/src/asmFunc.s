/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    LDR r1,=balance
    LDR r2,[r1]
    ADD r0,r0,r2
.endif
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/

    /* Set output variables to 0 */
    LDR r1, =eat_out /* Load address of eat_out into r1 */
    MOVS r2, 0 /* Move 0 into r2 */
    STR r2, [r1] /* Store value of r2 into address of eat_out */
    
    LDR r1, =stay_in /* Load address of stay_in into r1 */
    STR r2, [r1] /* Store value of r2 (0 from before) into address of stay_in */
    
    LDR r1, =eat_ice_cream /* Load address of eat_ice_cream into r1 */
    STR r2, [r1] /* Store 0 into address of eat_ice_cream */
    
    LDR r1, =we_have_a_problem /* Load address of we_have_a_problem into r1 */
    STR r2, [r1] /* Store 0 into address of we_have_a_problem */
    
    /* Load balance and add transaction amount */
    LDR r1, =balance /* Load address of balance into r1 */
    LDR r3, [r1] /* Load value at address of r1 (balance) into r3 */
    ADDS r4, r3, r0 /* Store sum of balance and transaction amount (r0) into r4 */
    BVS problem /* If V flag set branch to problem */
    
    /* Check if transaction is out of range */
    CMP r0, 1000 /* Compare transaction (r0) to 1000 */
    BGT problem /* Branch to problem IF transaction > 1000 */
    CMP r0, -1000 /* Compare transaction (r0) to 1000 */
    BLT problem /* Branch to problem IF transaction < -1000 */
    
    /* Update balance and transaction */
    STR r4, [r1] /* Store tmp_balance (r4) into balance (r1) */
    LDR r1, =transaction /* Load address of transaction into r1 */
    STR r0, [r1] /* Store transaction amount (r0) into transaction */
    
    /* Check new balance */
    MOV r0, r4 /* Move tmp_balance (r4) into r0 */
    CMP r4, 0 /* Compare tmp_balance with 0 */
    BGT we_eat_out /* Branch to we_eat_out IF tmp_balance > 0 */
    BLT we_stay_in /* Branch to we_stay_in IF tmp_balance < 0 */
    
    LDR r1, =eat_ice_cream /* Load address of eat_ice_cream into r1 */
    MOVS r2, 1 /* Move 1 into r2 */
    STR r2, [r1] /* Store 1 (r2) into address of eat_ice_cream (r1) */
    B done /* Branch to done */
    
problem:
    /* Handle out of bounds transactions (-1000 to 1000) */
    LDR r1, =we_have_a_problem /* Load address of we_have_a_problem into r1 */
    MOVS r2, 1 /* Move 1 into r2 */
    STR r2, [r1] /* Store 1 (r2) into address of we_have_a_problem (r1) */
    
    /* Reset transaction to 0 */
    LDR r1, =transaction /* Load address of transaction into r1 */
    MOVS r2, 0 /* Move 0 into r2 */
    STR r2, [r1] /* Store 0 (r2) into address of transaction (r1) */
    
    MOV r0, r3 /* Move balance (r3) into r0 */
    B done /* Branch to done */

we_eat_out:
    LDR r1, =eat_out /* Load address of eat_out into r1 */
    MOVS r2, 1 /* Move 1 into r2 */
    STR r2, [r1] /* Store 1 (r2) into address of eat_out (r1) */
    B done /* Branch to done */

we_stay_in:
    LDR r1, =stay_in /* Load address of stay_in into r1 */
    MOVS r2, 1 /* Move 1 into r2 */
    STR r2, [r1] /* Store 1 (r2) into address of stay_in (r1) */
    B done /* Branch to done */
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




