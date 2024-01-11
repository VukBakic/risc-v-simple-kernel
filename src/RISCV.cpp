#include "../h/RISCV.hpp"
#include "../h/TCB.hpp"
#include "../test/printing.hpp"
#include "../h/BoundedBuffer.hpp"

extern BoundedBuffer<char>* inputBuffer;
extern BoundedBuffer<char>* outputBuffer;

void RISCV::switchToUserLevelMode() {
    uint64 ra;
    __asm__ volatile ("mv %0, ra": "=r" (ra));
    uint64 mask = 0x100;
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(ra));
    __asm__ volatile("ld s0,8(sp)");
    __asm__ volatile("addi sp,sp,16");

    __asm__ volatile("sret");
}

void RISCV::popSppSpie()
{
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("call restoreContext");
}

inline uint64 RISCV::r_sepc()
{
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    return sepc;
}


void RISCV::sys_call_mem_alloc(){
    loadArguments();
    uint64 volatile a1 = riscv_rd_a1();
    uint64 volatile sepc = riscv_csrr_sepc();
    void* ptr = MemoryAllocator::malloc((size_t)a1);
    //__asm__ volatile ("sd %0, 10*8(fp)" : : "r"(ptr));
    riscv_wr_a0((uint64)ptr);
    riscv_csrw_sepc(sepc + 4);
};
void RISCV::sys_call_mem_free(){
    loadArguments();
    uint64 volatile a1 = riscv_rd_a1();
    uint64 volatile sepc = riscv_csrr_sepc();
    uint64 return_value = (uint64) MemoryAllocator::free((void*)a1);
    //__asm__ volatile ("sd %0, 10*8(fp)" : : "r"(return_value));
    riscv_wr_a0((uint64)return_value);
    riscv_csrw_sepc(sepc + 4);
};
void RISCV::sys_call_thread_create(){

    uint64 volatile sepc = riscv_csrr_sepc();
    loadArguments();

    thread_t* volatile handle = (thread_t*)riscv_rd_a1();
    TCB::Body volatile body = (TCB::Body) riscv_rd_a2();
    void* volatile args = (void*) riscv_rd_a3();
    uint64* volatile stack_space = ( uint64*) riscv_rd_a6();;
    uint64* volatile kernel_stack_space =( uint64*) riscv_rd_a7();;

    TCB* tcb = TCB::createThread(body, stack_space, kernel_stack_space, args);
    if(tcb != nullptr){
        __asm__ volatile ("sd %[src], (%[dest])" :: [src] "r" (tcb), [dest] "r" (handle));
        riscv_wr_a0(1);
    }else{
        riscv_wr_a0(0);
    }
    riscv_csrw_sepc(sepc + 4);
};
void RISCV::sys_call_thread_exit(){
    loadArguments();
    TCB* running = TCB::running;
    running->setFinished(true);
    RISCV::sys_call_thread_dispatch();
};

void RISCV::sys_call_thread_dispatch(){
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();
    TCB::timeSliceCounter = 0;
    TCB::dispatch();
    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);
}
void RISCV::sys_call_thread_join(){
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();
    thread_t other = (thread_t) riscv_rd_a1();
    other->putAwaiting(TCB::running);
    TCB::timeSliceCounter = 0;
    TCB::dispatch(false);
    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);

};
void RISCV::sys_call_sem_open(){
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();
    sem_t* handle = (sem_t*)riscv_rd_a1();
    unsigned init = (unsigned)riscv_rd_a2();
    sem_t sem = new _sem(init);
    if(!sem){
        riscv_wr_a0(-1);
    }else{
        *(handle) = sem;
        riscv_wr_a0(0);
    }
    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);

}

void RISCV::sys_call_sem_close(){
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();
    sem_t id = (sem_t)riscv_rd_a1();
    if(!id){
        riscv_wr_a0(-1);
    }else{
        delete id;
        riscv_wr_a0(1);
    }
    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);
}

void RISCV::sys_call_sem_wait(){
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();

    sem_t handle = (sem_t)riscv_rd_a1();
    uint64 code = handle->wait();
    riscv_wr_a0(code);
    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);

};
void RISCV::sys_call_sem_signal() {
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();

    sem_t handle = (sem_t)riscv_rd_a1();
    uint64 code = handle->signal();
    riscv_wr_a0(code);

    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);
}

void RISCV::sys_call_time_sleep()  {
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();

    size_t time = (size_t)riscv_rd_a1();

    TCB::sleep(time);

    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);
}

void RISCV::sys_call_getc(){
    TCB::switchSupervisorMode();
    loadArguments();
    uint64 volatile sepc = r_sepc()+4;
    uint64 volatile sstatus = riscv_csrr_sstatus();




    char c = __getc();
    //char c = inputBuffer->receive();

    /*
    while(inputBuffer->receive(&c)==0){

    };*/



    riscv_wr_a0((uint64)c);

    riscv_csrw_sepc(sepc);
    riscv_csrw_sstatus(sstatus);

    TCB::switchSupervisorMode();

}


void RISCV::sys_call_putc(){
    TCB::switchSupervisorMode();
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();


    char c = (char)riscv_rd_a1();

    __putc(c);
    //outputBuffer->send(c);

    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);
    TCB::switchSupervisorMode();

}

void RISCV::sys_call_ping(){
    loadArguments();
    uint64 volatile sepc = r_sepc() + 4;
    uint64 volatile sstatus = riscv_csrr_sstatus();

    thread_t handle = (thread_t)riscv_rd_a1();
    handle->setPingedPending();

    riscv_csrw_sstatus(sstatus);
    riscv_csrw_sepc(sepc);
}



void( * RISCV::pf[67])() {
        nullptr,
        RISCV::sys_call_mem_alloc,
        RISCV::sys_call_mem_free,
        RISCV::sys_call_ping,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        RISCV::sys_call_thread_create,
        RISCV::sys_call_thread_exit,
        RISCV::sys_call_thread_dispatch,
        RISCV::sys_call_thread_join,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        RISCV::sys_call_sem_open,
        RISCV::sys_call_sem_close,
        RISCV::sys_call_sem_wait,
        RISCV::sys_call_sem_signal,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        RISCV::sys_call_time_sleep,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        nullptr,
        RISCV::sys_call_getc,
        RISCV::sys_call_putc,

};


void RISCV::handleSupervisorTrap()
{
    saveArguments();

    uint64 scause = riscv_csrr_scause();

    switch(scause){
        case RISCV_SCAUSE_ILLEGAL_INSTRUCTION: {
            printString("Illegal Instruction\n");
            break;
        }
        case RISCV_SCAUSE_ECALL_USER_MODE:
        case RISCV_SCAUSE_ECALL_SUPERVISOR_MODE: {
            uint64 volatile syscall_code =riscv_rd_a0();


            pf[syscall_code]();
            uint64 volatile a0 = riscv_rd_a0();
            __asm__ volatile ("sd %0, 10*8(fp)" : : "r"(a0));
            break;


        }
        case RISCV_SCAUSE_HARDWARE_INTERRUPT: {
            printString("Should not happen in this routine.\n");
            break;
        }
        case RISCV_SCAUSE_ILLEGAL_MEMORY_READ:
        case RISCV_SCAUSE_ILLEGAL_MEMORY_WRITE: {
            printString("Illegal Memmory\n");
            break;
        }
        default: {
            printString("-------------------------\n");
            printString("FATAL ERROR\n");
            printString("Scause=");
            printInt(scause);
            printString("-------------------------\n");
            break;
        }
    };
    __asm__ volatile ("addi sp, sp, 40");
}

void RISCV::handleSupervisorSoftwareInterrupt(){
    uint64 scause = riscv_csrr_scause();

    switch(scause){
        case RISCV_SCAUSE_SOFTWARE_INTERRUPT: {
            riscv_csrc_sip(RISCV_SIP_SSIP);
            TCB::timeSliceCounter++;
            TCB::wakeThreads();
            if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
            {
                uint64 volatile sepc = riscv_csrr_sepc();
                uint64 volatile sstatus = riscv_csrr_sstatus();
                TCB::timeSliceCounter = 0;
                TCB::dispatch();
                riscv_csrw_sstatus(sstatus);
                riscv_csrw_sepc(sepc);
            }
            break;
        }
        default: {

            break;
        }
    }
}



void RISCV::handleSupervisorHardwareInterrupt(){
    console_handler();
    /*
    int claim = plic_claim();
    if(claim==0x0a){
        //keyboard interrupt
        while (*((char*)(CONSOLE_STATUS)) & CONSOLE_RX_STATUS_BIT) {
            char c = (*(char*)CONSOLE_RX_DATA);
            inputBuffer->send(c);
        }
    }
    plic_complete(claim);*/
}


