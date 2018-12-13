//
//  YYCommonMallocLogger.m
//  MethodForward
//
//  Created by wzp on 2018/10/27.
//  Copyright © 2018 wzp. All rights reserved.
//


#import "YYCommonMallocLogger.h"
#import "YYMemoryMacro.h"
#import "YYOOMDetector.h"

#if __has_feature(objc_arc)
#error This file must be compiled without ARC. Use -fno-objc-arc flag.
#endif
void malloc_stack_logger(uint32_t type, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3, uintptr_t result, uint32_t backtrace_to_skip)
{
    /*
     type : 这次捕获到的内存信息类型 32位的二进制： ... 0000 0000 0000 0000
     1<< 1 ,  malloc, realloc, etc...
     1<< 2 ,  free, realloc, etc...
     1<< 3 ,  NSZoneMalloc, etc...
     1<< 4 ,  vm_allocate or mmap
     1<< 5 ,  vm_deallocate or munmap
     具体情况可以看libmalloc源码中的stack_logging_disk.c文件
     */
    
    if (globalDetector == NULL) {
        return;
    }
    
    if (type & stack_logging_flag_zone) {
        type &= ~stack_logging_flag_zone;
    }
    
    if (type == (stack_logging_type_dealloc|stack_logging_type_alloc)) {
        if(arg3 > globalDetector->m_chunkSize){
            globalDetector->getChunkStack((size_t)arg3);
        }
    }
    else if((type & stack_logging_type_alloc) != 0){
        if(arg2 > globalDetector->m_chunkSize){
            globalDetector->getChunkStack((size_t)arg2);
        }
    }
}
