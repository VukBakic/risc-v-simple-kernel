#include "../h/syscall_cpp.hpp"


void *operator new(size_t n)
{
    return mem_alloc(n);
}

void *operator new[](size_t n)
{
    return mem_alloc(n);
}

void operator delete(void *p) noexcept
{
    mem_free(p);
}

void operator delete[](void *p) noexcept
{
    mem_free(p);
}


Thread::Thread(void (*body)(void *), void *arg) {
    this->body = body;
    this->arg = arg;
    this->myHandle = nullptr;
}

int Thread::start() {
    return thread_create(&this->myHandle, body, arg);
}

void Thread::join() {
    thread_join(this->myHandle);
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::sleep(time_t time) {
    return time_sleep(time);
}

Thread::~Thread() {
    delete this->myHandle;
}

Thread::Thread() {
    this->body = Thread::wrapper; //&wrapper ?
    this->arg = this;
    this->myHandle = nullptr;
}

void Thread::wrapper(void* ptr) {
    if(ptr) ((Thread*)ptr)->run();
}

char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

Semaphore::Semaphore(unsigned int init) {
    myHandle = new _sem(init);
}

Semaphore::~Semaphore() {
    delete myHandle;
}
