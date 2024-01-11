#ifndef RISCV_HPP
#define RISCV_HPP

#include "../lib/hw.h"
#include "../lib/console.h"


#define RISCV_SSTATUS_SPP  (1UL << 8)      // Previous mode, 1=Supervisor, 0=User
#define RISCV_SSTATUS_SPIE (1UL << 5)      // Supervisor Previous Interrupt Enable
#define RISCV_SSTATUS_UPIE (1UL << 4)      // User Previous Interrupt Enable
#define RISCV_SSTATUS_SIE  (1UL << 1)      // Supervisor Interrupt Enable
#define RISCV_SSTATUS_UIE  (1UL << 0)      // User Interrupt Enable


#define RISCV_SCAUSE_SOFTWARE_INTERRUPT      0x8000000000000001UL
#define RISCV_SCAUSE_HARDWARE_INTERRUPT      0x8000000000000009UL
#define RISCV_SCAUSE_ILLEGAL_INSTRUCTION     0x0000000000000002UL
#define RISCV_SCAUSE_ILLEGAL_MEMORY_READ     0x0000000000000005UL
#define RISCV_SCAUSE_ILLEGAL_MEMORY_WRITE    0x0000000000000007UL
#define RISCV_SCAUSE_ECALL_USER_MODE         0x0000000000000008UL
#define RISCV_SCAUSE_ECALL_SUPERVISOR_MODE   0x0000000000000009UL


/* Supervisor Interrupt Registers (sip and sie) */

#define RISCV_SIP_SSIP  (1UL << 1)      // Software Interrupt Pending, Writable
#define RISCV_SIP_STIP  (1UL << 5)      // Timer Interrupt Pending, Read only
#define RISCV_SIP_SEIP  (1UL << 9)      // External Hardware Interrupt Pending, Read only

#define RISCV_SIE_SSIE  (1UL << 1)      // Software Interrupt Enabled
#define RISCV_SIE_STIP  (1UL << 5)      // Timer Interrupt Enabled
#define RISCV_SIE_SEIE  (1UL << 9)      // External Hardware Interrupt Enabled


#define RISCV_SYS_MEM_ALLOC           0x01UL
#define RISCV_SYS_MEM_FREE            0x02UL
#define RISCV_SYS_THREAD_CREATE       0x11UL
#define RISCV_SYS_THREAD_EXIT         0x12UL
#define RISCV_SYS_THREAD_DISPATCH     0x13UL
#define RISCV_SYS_THREAD_JOIN         0x14UL
#define RISCV_SYS_SEM_OPEN            0x21UL
#define RISCV_SYS_SEM_CLOSE           0x22UL
#define RISCV_SYS_SEM_WAIT            0x23UL
#define RISCV_SYS_SEM_SIGNAL          0x24UL
#define RISCV_SYS_TIME_SLEEP          0x31UL
#define RISCV_SYS_GETC                0x41UL
#define RISCV_SYS_PUTC                0x42UL
#define RISCV_SYS_PING                0x03UL




/*  CONTROL STATUS REGISTER (CSR) INSTRUCTIONS                      */

#define GENERATE_CSRR(REG)                                           \
    inline uint64 riscv_csrr_ ## REG () {                            \
        uint64 volatile value;                                       \
        __asm__ volatile ( "csrr %0," # REG :"=r"(value));           \
        return value;                                                \
    }                                                                \


#define GENERATE_CSRW(REG)                                           \
    inline void riscv_csrw_ ## REG (uint64 value) {                  \
         __asm__ volatile ("csrw " #REG ", %0" : : "r"(value));      \
    }                                                                \


#define GENERATE_CSRC(REG)                                           \
    inline void riscv_csrc_ ## REG (uint64 mask) {                   \
         __asm__ volatile ("csrc " #REG ", %0" : : "r"(mask));       \
    }                                                                \

#define GENERATE_CSRS(REG)                                           \
    inline void riscv_csrs_ ## REG (uint64 mask) {                   \
         __asm__ volatile ("csrs " #REG ", %0" : : "r"(mask));       \
    }                                                                \

#define GENERATE_CSR(REG)                                            \
    GENERATE_CSRR(REG);                                              \
    GENERATE_CSRW(REG);                                              \
    GENERATE_CSRC(REG);                                              \
    GENERATE_CSRS(REG);                                              \


/*  WRITE AND READ REGISTER INSTRUCTIONS                            */
#define GENERATE_WR(REG)                                             \
    inline void riscv_wr_ ## REG (uint64 value) {                    \
         __asm__ volatile ("mv " #REG ", %0" : : "r"(value));        \
    }                                                                \


#define GENERATE_RD(REG)                                             \
    inline uint64 riscv_rd_ ## REG () {                              \
        uint64 volatile value;                                       \
         __asm__ volatile ("mv %0," #REG : "=r"(value));             \
         return value;                                               \
    }                                                                \

#define GENERATE_WRRD(REG)                                           \
    GENERATE_WR(REG);                                                \
    GENERATE_RD(REG);                                                \


/* Supervisor mode available registers */
GENERATE_CSR(sstatus);
GENERATE_CSR(sip);
GENERATE_CSR(sie);
GENERATE_CSR(scratch);
GENERATE_CSR(sepc);
GENERATE_CSR(scause);
GENERATE_CSR(stvec);

/* User and Supervisor mode available registers */
GENERATE_WRRD(ra)
GENERATE_WRRD(sp)
GENERATE_WRRD(gp)
GENERATE_WRRD(tp)
GENERATE_WRRD(a0);
GENERATE_WRRD(a1);
GENERATE_WRRD(a2);
GENERATE_WRRD(a3);
GENERATE_WRRD(a4);
GENERATE_WRRD(a5);
GENERATE_WRRD(a6);
GENERATE_WRRD(a7);

class RISCV
{
public:

    // pop sstatus.spp and sstatus.spie bits (has to be a non inline function)
    static void popSppSpie();

    static void switchToUserLevelMode();

    static inline void enableExternalInterrupts(){
        riscv_csrs_sstatus(RISCV_SSTATUS_SIE);
    }
    static inline void setSTVEC(void(*stvec_table)()){
        __asm__ volatile("csrw stvec, %[vector]":: [vector] "r" ((uint64)(stvec_table)|0x1));
    }
    static inline void setSTVEC2(uint64 wtf);
    static uint64 r_sepc();
    static void (* pf[67])();

private:
    // system calls
    static void sys_call_mem_alloc();
    static void sys_call_mem_free();
    static void sys_call_thread_create();
    static void sys_call_thread_exit();
    static void sys_call_thread_dispatch();
    static void sys_call_thread_join();
    static void sys_call_sem_open();
    static void sys_call_sem_close();
    static void sys_call_sem_wait();
    static void sys_call_sem_signal();
    static void sys_call_time_sleep();
    static void sys_call_getc();
    static void sys_call_putc();
    static void sys_call_ping();


    // trap handlers
    static void handleSupervisorTrap();
    static void handleSupervisorHardwareInterrupt();
    static void handleSupervisorSoftwareInterrupt();

    static inline void loadArguments(){
        __asm__ volatile ("ld a1, 0 * 8(fp)");
        __asm__ volatile ("ld a2, 1 * 8(fp)");
        __asm__ volatile ("ld a3, 2 * 8(fp)");
        __asm__ volatile ("ld a4, 3 * 8(fp)");
        __asm__ volatile ("ld a5, 4 * 8(fp)");
    }
    // must restore sp to +40 after this function call
    static inline void saveArguments(){
        __asm__ volatile ("addi sp, sp, -40");
        __asm__ volatile ("sd a1, 0 * 8(sp)");
        __asm__ volatile ("sd a2, 1 * 8(sp)");
        __asm__ volatile ("sd a3, 2 * 8(sp)");
        __asm__ volatile ("sd a4, 3 * 8(sp)");
        __asm__ volatile ("sd a5, 4 * 8(sp)");
    }

};

 inline void RISCV::setSTVEC2(uint64 wtf){

     __asm__ volatile("csrw stvec, %[wtf]"::[wtf]"r"(wtf));
}

#endif //RISCV_HPP

