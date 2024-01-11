


.extern _ZN3TCB7runningE

.macro context_save
    #Save a0 in SSCRATCH
    csrw sscratch, a0
   

    #A0 = TCB::running>context.kernelStackPointer
    ld a0, _ZN3TCB7runningE
    ld a0, 24(a0)

    #TCB::running->context.kernelStackPointer -= 256
    addi a0, a0, -256
    #Store All registers on kernel stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(a0)
    .endr

    #Store a0 trough t1 on kernel stack
    csrr t1, sscratch
    sd t1, 10*8(a0)

    #Switch to kernel stack
    mv sp, a0

    #Restore a0 argument for system calls
    csrr a0, sscratch


.endm

.macro context_load

    #A0 = TCB::running
    ld a0, _ZN3TCB7runningE

    #TCB::running->context.kernelStackPointer += 256
    mv a1, sp
    addi a1, a1, 256
    sd a1, 24(a0)

    #restore All registers (except sp)
    .irp index, 0,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr

    #Switch to user stack
    ld sp, 2*8(sp)



.endm

.global restoreContext
.align 4
restoreContext:

    csrw sscratch, a0

    #A0 = TCB::running->context.kernelStackPointer
    ld a0, _ZN3TCB7runningE
    ld a0, 24(a0)

    #Switch to user stack
    #and set ra to bodyWrapper
    ld ra, 1*8(a0)
    ld sp, 2*8(a0)


    #TCB::running->context.kernelStackPointer += 256
    mv a1, a0
    addi a1, a1, 256
    sd a1, 0(a0)
    csrr a0, sscratch
    sret



    
.macro store_registers
   addi sp, sp, -256
   .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
   sd x\index, \index * 8(sp)
   .endr
.endm

.macro load_registers
   .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
   ld x\index, \index * 8(sp)
   .endr
   addi sp, sp, 256
.endm




.extern _ZN5RISCV20handleSupervisorTrapEv
.align 4
.global _ZN5RISCV14supervisorTrapEv
.type _ZN5RISCV14supervisorTrapEv, @function
_ZN5RISCV14supervisorTrapEv:
    context_save
    call _ZN5RISCV20handleSupervisorTrapEv
    context_load
    sret

.extern _ZN5RISCV33handleSupervisorSoftwareInterruptEv
.align 4
.global _ZN5RISCV27supervisorSoftwareInterruptEv
.type _ZN5RISCV27supervisorSoftwareInterruptEv, @function
_ZN5RISCV27supervisorSoftwareInterruptEv:
    #save A0 in sscratch temporarily
    csrw sscratch, a0
    #A0 = TCB::running->supervisorMode
    ld a0, _ZN3TCB7runningE
    ld a0, 40(a0)
    #supervisorMode==1, there is no need to switch stacks
    #jump to simple store_registers macro
    bne a0, zero, already_in_kernel
    csrr a0, sscratch
    context_save
    jal zero,call_trap
    already_in_kernel:
    store_registers
    call_trap:

    call _ZN5RISCV33handleSupervisorSoftwareInterruptEv

    #save A0 in sscratch temporarily
    csrw sscratch, a0
    #A0 = TCB::running->supervisorMode
    ld a0, _ZN3TCB7runningE
    ld a0, 40(a0)
    #supervisorMode==1, there is no need to switch stacks
    #jump to simple load_registers macro
    bne a0, zero, already_in_kernel2
    csrr a0, sscratch
    context_load
    jal zero,call_trap2
    already_in_kernel2:
    load_registers
    call_trap2:

    sret



.extern _ZN5RISCV33handleSupervisorHardwareInterruptEv
.align 4
.global _ZN5RISCV27supervisorHardwareInterruptEv
.type _ZN5RISCV27supervisorHardwareInterruptEv, @function
_ZN5RISCV27supervisorHardwareInterruptEv:
    store_registers
    call _ZN5RISCV33handleSupervisorHardwareInterruptEv
    load_registers
    sret


.global stvec_table
.align 4

stvec_table:
.org stvec_table + 0*4
jal zero,_ZN5RISCV14supervisorTrapEv
.org stvec_table + 1*4
jal zero,_ZN5RISCV27supervisorSoftwareInterruptEv
.org stvec_table + 9*4
jal zero,_ZN5RISCV27supervisorHardwareInterruptEv

.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd sp, 0 * 8(a0)
    sd ra, 1 * 8(sp)

    ld sp, 0 * 8(a1)
    ld ra, 1 * 8(sp)
    ret
