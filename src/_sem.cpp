#include "../h/_sem.hpp"

void _sem::lock(){
    register uint64 swapWith = 1;
    while(swapWith==1) {
        __asm__ volatile("amoswap.d.aq %[reg], %[rs2], %[rs1]"
                :[reg] "=r"(swapWith), [rs1] "+A"(this->lck)
        :[rs2] "r"(swapWith));
    }
}
void _sem::unlock(){
    lck = 0;
}
int _sem::wait() {
    int return_code = 0 ;
    _sem::lock();
    if(--val<0) return_code = block();
    _sem::unlock();
    return return_code;
}

int _sem::signal() {
    int return_code = 0 ;
    _sem::lock();
    if(++val<=0) return_code = unblock();
    _sem::unlock();
    return return_code;
}

int _sem::block() {
    TCB* running = TCB::running;
    blockedQueue.addLast(running);
    TCB::timeSliceCounter = 0;
    TCB::dispatch(false, this);
    if(TCB::running->semaphoreDestroyed){
        TCB::running->clearSemaphoreDestroyed();
        return -1;
    }else{
        TCB::running->clearSemaphoreDestroyed();
        return 0;
    }

}

int _sem::unblock() {
    TCB* blocked = blockedQueue.removeFirst();
    if(blocked){
        Scheduler::put(blocked);
        return 0;
    }
    return -1;
}

void* _sem::operator new(size_t size) {
    return MemoryAllocator::malloc_bytes(size);
}
void* _sem::operator new(size_t size, void *memory) {
    return (_sem*) memory;
}
void _sem::operator delete(void *memory) {
    MemoryAllocator::free(memory);
}

_sem::~_sem() {
    while (TCB* temp = blockedQueue.removeFirst()) {
        temp->setSemaphoreDestroyed();
        Scheduler::put(temp);

    }
}


void signalWait (_sem* s, _sem* w){
    s->lock();
    if (s && s->val++<0) s->unblock();
    s->unlock();
    w->lock();
    if (w && --w->val<0) w->block();
    w->unlock();
}