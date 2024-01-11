#ifndef MEMORY_ALLOCATOR_HPP
#define MEMORY_ALLOCATOR_HPP

#include "../lib/hw.h"

struct Block {
    size_t size; // Size in blocks of MEM_BLOCK_SIZE
    Block* next;
    Block* prev;
};


class MemoryAllocator {
private:
    static Block* free_memory;
    static bool initialized ;
    static size_t mem_block_offset;
    static void init();
    static void remove_from_list(Block* element);
    static Block* calculate_next(Block* element);
public:
    static void* malloc(size_t size);
    static int free(void* ptr);
    static void* malloc_bytes(size_t size);
};


#endif //MEMORY_ALLOCATOR_HPP
