#include "../h/MemoryAllocator.hpp"

Block* MemoryAllocator::free_memory;
bool MemoryAllocator::initialized = false;
size_t MemoryAllocator::mem_block_offset = 0;

void MemoryAllocator::init(){

    // Finding offset of MEM_BLOCK_SIZE for shift operations.
    // For MEM_BLOCK_SIZE=64 offset is 5 (2^5=64)
    size_t i = MEM_BLOCK_SIZE;
    while (i >>= 1) {
        ++MemoryAllocator::mem_block_offset;
    }

    // Align heap forward if not aligned to MEM_BLOCK_SIZE
    uint64 aligned_heap_start;
    uint64 modulo = (uint64)HEAP_START_ADDR & ((uint64)MEM_BLOCK_SIZE-1);
    aligned_heap_start = modulo==0x0? (uint64)HEAP_START_ADDR: (uint64)HEAP_START_ADDR+(uint64)MEM_BLOCK_SIZE-modulo;

    // List of free segment has only one free segment
    // with size of whole available heap
    MemoryAllocator::free_memory = (Block*) aligned_heap_start;
    MemoryAllocator::free_memory->size = ((uint64)HEAP_END_ADDR - aligned_heap_start)/(uint64)MEM_BLOCK_SIZE;
    MemoryAllocator::free_memory->next = nullptr;
    MemoryAllocator::free_memory->prev = nullptr;

    MemoryAllocator::initialized = true;

}

void* MemoryAllocator::malloc(size_t size) {
    // Initialize class if malloc is called first time
    if(!initialized) {
        MemoryAllocator::init();
    }

    Block* current = MemoryAllocator::free_memory;

    // +1 MEM_BLOCK_SIZE for Block header
    size++;

    // First Fit
    for (; current!=nullptr; current=current->next)
        if (current->size >= size) break;

    // No Available memory on heap
    if(current == nullptr) {
        return nullptr;
    }

    // Size of remaining block
    size_t remaining_size = current->size - size;

    // No split, allocate whole block
    if(remaining_size < 2*MEM_BLOCK_SIZE){
        MemoryAllocator::remove_from_list(current);
        return (uint64*) ((uint64) current + MEM_BLOCK_SIZE);
    }
    // Split block into two blocks and return second one
    else{
        current->size  = remaining_size;
        Block* allocated_block = MemoryAllocator::calculate_next(current);
        allocated_block->size = size;
        return (uint64*) ((uint64) allocated_block + MEM_BLOCK_SIZE);
    }
}

int MemoryAllocator:: free(void* ptr){
    // Basic check, should not happen
    if(ptr==nullptr) return -1;
    // Get header in front of allocated block
    Block* header = (Block*) ((size_t)ptr - MEM_BLOCK_SIZE);
    if(header==nullptr) return -2;

    Block* current;

    if(MemoryAllocator::free_memory==nullptr || (uint64) header < (uint64) MemoryAllocator::free_memory){
        current = nullptr;
    }else{
        // Find Free Block before ptr block
        for (current = MemoryAllocator::free_memory; current!=nullptr
                                                     && current->next!=nullptr
                                                     && (uint64)current->next < (uint64)header;
             current=current->next);
    }


    if(current && MemoryAllocator::calculate_next(current) == header){
        // current is just behind header, merge them
        current->size += header->size;

        // current next is in front of header, merge them
        if(current->next && calculate_next(current)==current->next ){
            current->size+= current->next->size;
            current->next = current->next->next;
            if(current->next) current->next->prev = current;
        }
        return 0;

    }
    else{
        Block* next_block = current?current->next:MemoryAllocator::free_memory;
        if(next_block && MemoryAllocator::calculate_next(header)==next_block){
            // header is just behind next_block, merge them
            header->size+=next_block->size;
            // swap block in list with larger one (put header instead of next_block)
            header->next = next_block->next;
            header->prev = next_block->prev;
            if(next_block->prev) next_block->prev->next = header;
            else MemoryAllocator::free_memory= header;
            if(next_block->next) next_block->next->prev = header;
            return 0;
        }
    }

    header->prev = current;
    if(current) {
        header->next = current->next;
        current->next = header;
    }else{
        header->next = MemoryAllocator::free_memory;
        MemoryAllocator::free_memory=header;
    }
    if(header->next){
        header->next->prev = header;
    }

    return 0;
}

void* MemoryAllocator::malloc_bytes(size_t size)  {
    size_t size_in_blocks = size & (MEM_BLOCK_SIZE-1)? size/MEM_BLOCK_SIZE +1 : size/MEM_BLOCK_SIZE;
    return MemoryAllocator::malloc(size_in_blocks);
}


void MemoryAllocator::remove_from_list(Block* element){
    if (element == nullptr) return;

    if (MemoryAllocator::free_memory == element)
        MemoryAllocator::free_memory = element->next;

    if (element->next != nullptr)
        element->next->prev = element->prev;


    if (element->prev != nullptr)
        element->prev->next = element->next;

}



Block* MemoryAllocator::calculate_next(Block* element){
    if(element == nullptr) return nullptr;

    Block* next = (Block *) ((uint64) element + (element->size << mem_block_offset));

    if((uint64)next>=(uint64)HEAP_END_ADDR) {
        return nullptr;
    }

    return next;

}
