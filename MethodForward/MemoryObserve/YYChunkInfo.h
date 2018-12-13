//
//  YYChunkInfo.h
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//
#ifndef YYChunkInfo_H
#define YYChunkInfo_H
#import <Foundation/Foundation.h>
#include <iostream>
#include "YYMemoryMacro.h"
#import <libkern/OSAtomic.h>
#import <sys/mman.h>
#import <mach/mach_init.h>
#import <mach/vm_statistics.h>
using namespace std;

class YYChunkInfo {
    friend bool operator<(const YYChunkInfo &info1, const YYChunkInfo &info2) {
        return (info1.m_chunkSize >= info2.m_chunkSize);
    }
public:
    size_t m_chunkSize = 0;
    char *m_dateStr = NULL;
    vm_address_t *m_stacks[max_stack_depth];
};

#endif
