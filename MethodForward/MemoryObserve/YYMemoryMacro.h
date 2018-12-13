//
//  YYMemoryMacro.h
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//

#ifndef YYMemoryMacro_h
#define YYMemoryMacro_h

#define stack_logging_type_alloc    2    /* malloc, realloc, etc... */
#define stack_logging_type_dealloc    4    /* free, realloc, etc... */
#define stack_logging_type_vm_allocate  16      /* vm_allocate or mmap */
#define stack_logging_type_vm_deallocate  32    /* vm_deallocate or munmap */
#define stack_logging_flag_zone        8    /* NSZoneMalloc, etc... */
#define stack_logging_flag_cleared    64    /* for NewEmptyHandle */
#define stack_logging_type_mapped_file_or_shared_mem 128

#define max_stack_depth 30

#endif /* YYMemoryMacro_h */
