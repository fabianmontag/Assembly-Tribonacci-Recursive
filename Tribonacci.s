.globl main
.text

// program start
main:
    addi a0, a0, 7
    jal tribonacci
    ebreak


// t0 => 0
// t1 => 0
// t2 => 1
// t(n) = t(n-1) + t(n-2) + t(n-3)
 
// in:
//    a0: n
// out:
//    a0: res
tribonacci:
    addi t0, zero, 2
    blt a0, t0, doneZero
    beq a0, t0, doneOne

    // allocate new stack space
    addi sp, sp, -16
    // save ra
    sw ra, 0(sp)
    // save a0
    sw a0, 4(sp)

    addi a0, a0, -1
    // first call
    jal tribonacci
    // save first result
    sw a0, 8(sp)

    // restore a0
    lw a0, 4(sp)
    addi a0, a0, -2
    // second call
    jal tribonacci
    // save second result
    sw a0, 12(sp)

    // restore a0
    lw a0, 4(sp)
    addi a0, a0, -3
    // third call
    jal tribonacci

    // load first and second result
    lw t0, 8(sp)
    lw t1, 12(sp)

    // end result
    add a0, a0, t0
    add a0, a0, t1

    // restore sp
    lw ra, 0(sp)    

    // reset sp
    addi  sp, sp, 16

    ret

    doneZero:
        addi a0, zero, 0
        ret
    doneOne:
        addi a0, zero, 1
        ret