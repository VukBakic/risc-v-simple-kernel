#include "../h/TCB.hpp"
#include "../test/printing.hpp"
#include "../h/BoundedBuffer.hpp"
#include "../lib/hw.h"

extern BoundedBuffer<char>* outputBuffer;
TCB * TCB::running = nullptr;

uint64 TCB::timeSliceCounter = 0;
List<TCB> TCB::sleepingThreads;

void*::TCB::operator new(size_t size, void *memory) {
    return (TCB*) memory;
}
void TCB::operator delete(void *ptr) {
    MemoryAllocator::free(ptr);
}
TCB::TCB(Body body, void* args, uint64* stack_space, uint64* kernel_stack_space, uint64 timeSlice, bool putInScheduler) {
    this -> body = body;
    this -> args = args;

    this -> stack = stack_space;

    this -> timeSlice = timeSlice;
    this -> finished = false;
    this -> semaphoreDestroyed = false;
    this -> scheduled = putInScheduler;
    this -> supervisorMode = 0;
    kernelStack = kernel_stack_space;

    context = {
            (uint64) & kernelStack[KERNEL_STACK_SIZE]
    };

    context.kernelStackPointer -= 256;
    *((uint64 * )(context.kernelStackPointer + 8)) = (uint64) & threadWrapper; //ra
    *((uint64 * )(context.kernelStackPointer + 16)) = (stack != nullptr) ? (uint64) & stack[DEFAULT_STACK_SIZE]: 0; //sp

    if (body != nullptr && putInScheduler==true) {
        Scheduler::put(this);
    }

}
TCB::~TCB() {
    delete[] stack;
    delete[] kernelStack;
}


TCB * TCB::createThread(Body body, uint64* stack_space, uint64* kernel_stack_space, void* args, bool putInScheduler) {

     uint64 size = sizeof(TCB);
     size = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
     void* allocated = MemoryAllocator::malloc(size);


     return  new (allocated) TCB(body, args, stack_space,kernel_stack_space, DEFAULT_TIME_SLICE, putInScheduler);
    // return new TCB(body, TIME_SLICE);
}

void TCB::yield() {
    riscv_wr_a0(RISCV_SYS_THREAD_DISPATCH);
    __asm__ volatile("ecall");
}

void TCB::dispatch(bool putInScheduler, _sem* lockedSem) {
    if(lockedSem) lockedSem->unlock();
    TCB * old = running;
    if (!old -> isFinished() && putInScheduler && old->scheduled) {
        Scheduler::put(old);
    }
    running = Scheduler::get();

    if(old !=running) {

        TCB::contextSwitch(&old->context, &running->context);
    }
}

void TCB::threadWrapper() {
    RISCV::popSppSpie();
    running -> body(running->args);
    running -> setFinished(true);
    while (true){
        TCB* temp  = running -> awaitingThreads.removeFirst();
        if(!temp ) break;
        Scheduler::put(temp);


    }
    TCB::yield();
}

TCB *TCB::getAwaiting()
{
    return awaitingThreads.removeFirst();
}

void TCB::putAwaiting(TCB *ccb)
{
    awaitingThreads.addLast(ccb);
}

int TCB::sleep(size_t time){
    if(time>0){
        TCB::running->sleepTime=time;
        TCB::sleepingThreads.addInOrder(TCB::running);
        TCB::dispatch(false);
        return 0;
    }
    return 0;
}

void TCB::wakeThreads(){
    TCB* sleeping = TCB::sleepingThreads.peekFirst();
    if(sleeping){
        sleeping->decreseSleepTime();
        if(sleeping->getSleepTime()==0){
            TCB* temp = TCB::sleepingThreads.removeFirst();
            while(temp){
                if(temp->isFinished()==false) Scheduler::put(temp);
                temp = TCB::sleepingThreads.peekFirst();

                if(!temp || temp->getSleepTime()!=0) break;
                temp = TCB::sleepingThreads.removeFirst();
            }
        }
    }
}

void TCB::idleThread(void *arg) {
    while(true){
        //printString("Idle thread working...\n");
        //for(int i=0;i<100000000;i++);
    }
}


void TCB::consoleWriteThread(void *arg) {
    while(true){
        while((*((char*)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT)){
            char c = outputBuffer->receiveSys();
            *((char*)CONSOLE_TX_DATA) = c;
        }
    }
}



