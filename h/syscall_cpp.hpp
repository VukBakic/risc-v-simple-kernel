#ifndef SYSCALL_CPP_HPP
#define SYSCALL_CPP_HPP
#include "syscall_c.hpp"

void* operator new(size_t);
void* operator new[](size_t n);
void  operator delete(void*) noexcept;
void  operator delete[](void *p) noexcept;

class Thread {
public:
    Thread(void (*body)(void*), void* arg);
    virtual ~Thread ();
    int start ();
    void join();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread();
    virtual void run() {};
    void setFinished(){
        myHandle->setFinished(true);
    }
private:
    thread_t myHandle;
    void (*body)(void*); void* arg;
    static void wrapper(void*);
};

class Semaphore {
public:
    Semaphore (unsigned init = 1);
    virtual ~Semaphore ();
    int wait ();
    int signal ();
private:
    sem_t myHandle;
};


class PeriodicThread : public Thread {
public:
    void terminate (){
        setFinished();
    }
    void run() override{
        while(true) {
            Thread::sleep(period);
            periodicActivation();
        }
    }
protected:
    PeriodicThread (time_t period) :Thread() {
        this->period = period;
    }
    virtual void periodicActivation () {}
private:   time_t period;
};


class Console {
public:
    static char getc ();
    static void putc (char);
};

#endif //SYSCALL_CPP_HPP
