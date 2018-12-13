//
//  YYOOMDetector.m
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "YYOOMDetector.h"
#import "YYCommonMallocLogger.h"
#import "YYChunkInfo.h"

#if __has_feature(objc_arc)
#error This file must be compiled without ARC. Use -fno-objc-arc flag.
#endif

static NSDateFormatter *df = nil;

YYOOMDetector::YYOOMDetector(size_t chunkSize) : m_chunkSize(chunkSize) {}
YYOOMDetector::~YYOOMDetector() {}

void YYOOMDetector::beginDetector() {
    if (df == nil) {
        df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    }
    malloc_logger = malloc_stack_logger;
}
void YYOOMDetector::stopDetector() {
    malloc_logger = NULL;
}

void YYOOMDetector::getChunkStack(size_t size) {
    vm_address_t *stacks[max_stack_depth];
    size_t depth = backtrace((void**)stacks, max_stack_depth);
    NSString *dateStr1 = [df stringFromDate:[NSDate date]];
    
    YYChunkInfo info;
    info.m_chunkSize = size;
//    info.m_dateStr = [dateStr1 UTF8String];
    for (int i = 0; i < depth; i++) {
        info.m_stacks[i] = stacks[i];
    }
    
}


void callOCSystemBacktrace() {
    //    [_lock lock];
    NSLog(@"\n\n\ncallStack:----------------------------------------------------\n");
    int stackDeep = 35;
    void *callstack[stackDeep];
    int frames = backtrace(callstack, stackDeep);
    char** strs = backtrace_symbols(callstack, frames);
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (int i = 0; i < frames; i++) {
        char *callStr = strs[i];
        NSString *ocStr = [NSString stringWithUTF8String:callStr];
        [tmpArr addObject:ocStr];
        NSLog(@"%@", ocStr);
    }
    NSLog(@"\n\n\n");
    free(strs);
    //    [_lock unlock];
}
