//
//  YYCommonMallocLogger.h
//  MethodForward
//
//  Created by wzp on 2018/10/27.
//  Copyright © 2018 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <malloc/malloc.h>
#import "execinfo.h"

#ifdef __cplusplus
extern "C" {
#endif
    
    typedef void (malloc_logger_t)(uint32_t type, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3, uintptr_t result, uint32_t num_hot_frames_to_skip);
    
    void malloc_stack_logger(uint32_t type, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3, uintptr_t result, uint32_t backtrace_to_skip);
    
    extern malloc_logger_t *malloc_logger;
    
#ifdef __cplusplus
    }
#endif
