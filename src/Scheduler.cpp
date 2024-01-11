#include "../h/Scheduler.hpp"
#include "../h/syscall_c.hpp"

List<TCB> Scheduler::readyThreadQueue;
TCB* Scheduler::idleThread;

TCB *Scheduler::get()
{
    TCB* temp = readyThreadQueue.removeFirst();
    return temp?temp:idleThread;
}

void Scheduler::put(TCB *tcb)
{
    readyThreadQueue.addLast(tcb);
}
void Scheduler::setIdle(void(*start_routine)(void*))
{
    uint64* kernel_stack_space = new uint64[TCB::KERNEL_STACK_SIZE];
    if(!kernel_stack_space) {
       return;
    }
    uint64* stack_space = nullptr;
    if(start_routine) stack_space = new uint64[DEFAULT_STACK_SIZE];
    if(!stack_space) {
        delete[] kernel_stack_space;
        return;
    }
    idleThread =  TCB::createThread(start_routine, stack_space, kernel_stack_space, nullptr, false);


}