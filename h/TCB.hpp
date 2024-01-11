#ifndef TCB_HPP
#define TCB_HPP

#include "../lib/hw.h"

#include "Scheduler.hpp"
#include "_sem.hpp"
#include "MemoryAllocator.hpp"

class _sem;

class TCB {
public:

    using Body = void(*)(void*);

    static TCB * running;

    TCB(Body body, void* args, uint64* stack_space, uint64* kernel_stack_space, uint64 timeSlice, bool putInScheduler=false);

    ~TCB();

    static TCB * createThread(Body body, uint64* stack_space, uint64* kernel_stack_space, void* args=nullptr, bool putInScheduler=true);

    static void yield();

    bool isFinished() const {
        return finished;
    }

    void setFinished(bool value) {
        finished = value;
    }

    uint64 getTimeSlice() const {
        return timeSlice;
    }

    TCB *getAwaiting();
    void putAwaiting(TCB *ccb);
    void setSemaphoreDestroyed(){
        semaphoreDestroyed = true;
    }
    void clearSemaphoreDestroyed(){
        semaphoreDestroyed = false;
    }
    void* operator new(size_t size, void *memory);
    void operator delete(void *ptr);

    // using DEFAULT_STACK_SIZE from hw.h instead
    //static uint64 constexpr STACK_SIZE = 4096;
    static uint64 constexpr KERNEL_STACK_SIZE = 1024;

    static void wakeThreads();

    static void idleThread(void* arg);
    static void consoleWriteThread(void * arg);

    inline size_t getSleepTime(){
        return sleepTime;
    }
    inline void setSleepTime(size_t time){
        sleepTime=time;
    }
    inline void decreseSleepTime(){
        sleepTime--;
    }

    void setPingedPending(){
        pending_ping = true;
    }
    void clearPingedPending(){
        pending_ping = false;
    }

private:
    friend class RISCV;
    friend class _sem;

    static List<TCB> sleepingThreads;
    static uint64 timeSliceCounter;

    struct Context {
        uint64 kernelStackPointer;
    };

    Body body;
    uint64 * stack;
    uint64 * kernelStack;
    Context context;
    void* args;

    uint64 supervisorMode;
    uint64 timeSlice;
    bool finished;
    size_t sleepTime;
    List<TCB> awaitingThreads;

    bool semaphoreDestroyed;
    bool pending_ping = false;


    static void threadWrapper();

    static int sleep(size_t time);

    static void contextSwitch(Context * oldContext, Context * runningContext);

    static void dispatch(bool putInScheduler=true, _sem* lockedSem=nullptr);

    static void switchSupervisorMode(){
        TCB::running->supervisorMode= (TCB::running)->supervisorMode==0?1:0;
    }

    bool scheduled;
};

#endif // TCB_HPP