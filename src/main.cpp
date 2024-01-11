
#include "../lib/hw.h"
#include "../h/RISCV.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/TCB.hpp"
#include "../test/printing.hpp"
#include "../h/BoundedBuffer.hpp"
#include "../h/syscall_cpp.hpp"


extern void userMain(void* arg);
extern "C" void stvec_table();


thread_t mainThread;
thread_t userMainThread;
thread_t consoleThread;

BoundedBuffer<char>* inputBuffer;
BoundedBuffer<char>* outputBuffer;


int main()
{

    inputBuffer = new BoundedBuffer<char>(256);
    outputBuffer = new BoundedBuffer<char>(256);
    RISCV::setSTVEC2((uint64)(&stvec_table)|1);
    RISCV::setSTVEC(&stvec_table);


    void* allocated = MemoryAllocator::malloc_bytes(sizeof(uint64[TCB::KERNEL_STACK_SIZE]));
    uint64* kernelStack = (uint64*)allocated;

    mainThread = TCB::createThread(nullptr,nullptr,kernelStack);

    TCB::running = mainThread;

    Scheduler::setIdle(TCB::idleThread);
    

    RISCV::enableExternalInterrupts();
    RISCV::switchToUserLevelMode();

    thread_create(&consoleThread, TCB::consoleWriteThread,nullptr);


    thread_create(&userMainThread,userMain, nullptr );
    thread_join(userMainThread);
    //thread_join(consoleThread);
    return 0;
}