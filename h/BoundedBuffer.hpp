#ifndef BOUNDED_BUFFER_HPP
#define BOUNDED_BUFFER_HPP

#include "_sem.hpp"
#include "MemoryAllocator.hpp"



template <class T>
class BoundedBuffer {
public:
    BoundedBuffer(int size=256){
        this-> mutex = new _sem(1);
        this-> notEmpty = new _sem(0);
        this-> notFull = new _sem(0);
        this-> size = size;
        this->front=this->rear = -1;
        this->buffer = (T*) MemoryAllocator::malloc_bytes(size*sizeof(T));
    }
    ~BoundedBuffer() {
        this->mutex->wait();
        //********
    }
    void send(T obj){
        mutex->wait();
        while (isFull()) {
            signalWait(mutex,notFull);
            mutex->wait();
        }
        bufferPut(obj);
        if (notEmpty->value()<0) notEmpty->signal();
        mutex->signal();
    }

    T receive(){
        mutex->wait();
        while (isEmpty()) {
            signalWait(mutex,notEmpty);
            mutex->wait();
        }
        T temp= bufferGet();
        if (notFull->value()<0) notFull->signal();
        mutex->signal();
        return temp;
    }

    T receiveSys(){
        sem_wait(mutex);
        //mutex->wait();
        while (isEmpty()) {

            sem_signal(mutex);
            sem_wait(notEmpty);

            sem_wait(mutex);
        }
        T temp= bufferGet();
        if (notFull->value()<0) sem_signal(notFull);
        sem_signal(mutex);
        return temp;
    }


    int receive(T* t){
        mutex->wait();
        if (isEmpty()) {
            mutex->signal();
            return 0;
        }

        *t=bufferGet();
        if (notFull->value()<0)
            notFull->signal();
        mutex->signal();
        return 1;
    }
    void clear   ();
    T*  first    ();

    bool isEmpty(){
        if (front == -1) return true;
        else return false;
    }
    bool isFull(){
        if ((front == 0 && rear == size - 1) || (rear == (front - 1) % (size - 1)))
            return true;
        else return false;
    }

    void* operator new(size_t size){
        return MemoryAllocator::malloc_bytes(size);
    }
    void operator delete (void *memory){
        MemoryAllocator::free(memory);
    }

private:
    T* buffer;
    int size;
    int rear, front;

    _sem *mutex;
    _sem *notEmpty;
    _sem *notFull;

    void bufferPut(T value){
        if ((front == 0 && rear == size - 1) || (rear == (front - 1) % (size - 1))) {
                return;
        } else if (front == -1){
                front = rear = 0;
                buffer[rear] = value;
        } else if (rear == size - 1 && front != 0) {
                rear = 0;
            buffer[rear] = value;
        } else {
                rear++;
            buffer[rear] = value;
        }
    }

    T bufferGet (){
        if (front == -1){
            // ???
            return buffer[0];
        }

        int data = buffer[front];
        buffer[front] = -1;

        if (front == rear)
        {
            front = -1;
            rear = -1;
        }

        else if (front == size - 1)
            front = 0;

        else
            front++;
        return data;

    }
};



#endif //BOUNDED_BUFFER_HPP
