
#ifndef SCHEDULER_HPP
#define SCHEDULER_HPP

#include "List.hpp"


class TCB;

class Scheduler
{
private:
    static TCB* idleThread;
    static List<TCB> readyThreadQueue;

public:
    static TCB *get();
    static void put(TCB *tcb);
    static void setIdle(void(*start_routine)(void*));

};

#endif //SCHEDULER_HPP
