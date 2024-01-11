#ifndef _SEM_HPP
#define _SEM_HPP

#include "RISCV.hpp"
#include "TCB.hpp"

class _sem {
    public:
        _sem(unsigned short init = 1) : val(init){}
        ~_sem();

        void lock();
        void unlock();
        int wait();
        int signal();
        int value(){
            return val;
        }
        void* operator new (size_t size);
        void* operator new(size_t size, void *memory);
        void operator delete (void *memory);

        friend void signalWait (_sem* s, _sem* w);
    protected:
        int block();
        int unblock();
    private:
        int val;
        uint64 lck = 0;
        List<TCB> blockedQueue;


};
#endif //_SEM_HPP
