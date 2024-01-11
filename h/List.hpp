
#ifndef LIST_HPP
#define LIST_HPP

#include "MemoryAllocator.hpp"
template<typename T>
class List
{
private:
    struct Elem
    {
        T *data;
        Elem *next;

        Elem(T *data, Elem *next) : data(data), next(next) {}

        void* operator new(size_t size, void *memory) {
            return (Elem*) memory;
        }
        void operator delete (void *ptr) {
            MemoryAllocator::free(ptr);
        }
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}

    List(const List<T> &) = delete;

    List<T> &operator=(const List<T> &) = delete;

    void addFirst(T *data)
    {
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
        Elem *elem = new (allocated) Elem(data, head);
        head = elem;
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
        Elem *elem = new (allocated) Elem(data, 0);

        if (tail)
        {
            tail->next = elem;
            tail = elem;
        } else
        {
            head = tail = elem;
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }

        T *ret = elem->data;
        delete elem;
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
        return head->data;
    }

    T *removeLast()
    {
        if (!head) { return 0; }

        Elem *prev = 0;
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
        {
            prev = curr;
        }

        Elem *elem = tail;
        if (prev) { prev->next = 0; }
        else { head = 0; }
        tail = prev;

        T *ret = elem->data;
        delete elem;
        return ret;
    }

    T *peekLast()
    {
        if (!tail) { return 0; }
        return tail->data;
    }

    void addInOrder(T *data){
        void* allocated = MemoryAllocator::malloc_bytes(sizeof(Elem));
        Elem *elem = new (allocated) Elem(data, 0);

        Elem* prev = 0;
        Elem* current  = head;

        size_t actualSleepTime = data->getSleepTime();
        size_t sum = 0;

        while(current){
            sum += current->data->getSleepTime();
            if(sum>=actualSleepTime) {
                sum -= current->data->getSleepTime();
                break;
            }
            prev = current;
            current = current->next;
        }

        if(prev==0){
            elem->next = current;
            head = elem;
            if(elem->next) elem->next->data->setSleepTime(elem->next->data->getSleepTime()-actualSleepTime);
        }else{
            size_t relativeSleepTime = actualSleepTime - sum;
            elem->data->setSleepTime(relativeSleepTime);
            prev->next = elem;
            elem->next = current;
            if(elem->next==0) tail = elem;
            else{
                elem->next->data->setSleepTime(elem->next->data->getSleepTime()-relativeSleepTime);
            }
        }



    }
};

#endif //LIST_HPP
