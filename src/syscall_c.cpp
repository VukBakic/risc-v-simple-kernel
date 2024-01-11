#include "../h/syscall_c.hpp"
#include "../h/print.hpp"

void* mem_alloc(size_t size){
    // Bytes to Blocks of MEM_BLOCK_SIZE
    size = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;

    riscv_wr_a1(size);
    riscv_wr_a0(RISCV_SYS_MEM_ALLOC);

    __asm__ volatile("ecall");

    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (void*)a0;
}


int mem_free(void* ptr){
    riscv_wr_a1((uint64)ptr);
    riscv_wr_a0(RISCV_SYS_MEM_FREE);

    __asm__ volatile("ecall");

    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;

}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg ){

    uint64* kernel_stack_space = new uint64[TCB::KERNEL_STACK_SIZE];
    if(!kernel_stack_space) {
        return -1;
    }
    uint64* stack_space = nullptr;

    if(start_routine) stack_space = new uint64[DEFAULT_STACK_SIZE];
    if(!stack_space) {
        delete[] kernel_stack_space;
        return -1;
    }



    riscv_wr_a7((uint64)kernel_stack_space);
    riscv_wr_a6((uint64)stack_space);
    riscv_wr_a3((uint64)arg);
    riscv_wr_a2((uint64)start_routine);
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_THREAD_CREATE);



    __asm__ volatile("ecall");


    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));

    if(a0==1){
        return 0;
    }else{
        return (int)a0;
    }


}

int thread_exit(){
    riscv_wr_a0(RISCV_SYS_THREAD_EXIT);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;
}
void thread_dispatch(){
    riscv_wr_a0(RISCV_SYS_THREAD_DISPATCH);
    __asm__ volatile("ecall");
}
void thread_join(thread_t handle){
    if(handle->isFinished()) return;
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_THREAD_JOIN);
    __asm__ volatile("ecall");
}

int sem_open(sem_t* handle, unsigned init){
    riscv_wr_a2((uint64)init);
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_SEM_OPEN);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;
}
int sem_close(sem_t handle){
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_SEM_CLOSE);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;
}
int sem_wait(sem_t id){
    riscv_wr_a1((uint64)id);
    riscv_wr_a0(RISCV_SYS_SEM_WAIT);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;
}
int sem_signal(sem_t id){
    riscv_wr_a1((uint64)id);
    riscv_wr_a0(RISCV_SYS_SEM_SIGNAL);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;
}

int time_sleep(time_t time){
    riscv_wr_a1((uint64)time);
    riscv_wr_a0(RISCV_SYS_TIME_SLEEP);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (int)a0;
}



char getc(){


    riscv_wr_a0(RISCV_SYS_GETC);
    __asm__ volatile("ecall");
    volatile long a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    return (char)a0;
}
void putc (char c){
    riscv_wr_a1((uint64)c);
    riscv_wr_a0(RISCV_SYS_PUTC);
    __asm__ volatile("ecall");
}


void ping(thread_t handle){
    riscv_wr_a1((uint64)handle);
    riscv_wr_a0(RISCV_SYS_PING);
    __asm__ volatile("ecall");
}