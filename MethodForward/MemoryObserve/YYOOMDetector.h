//
//  YYOOMDetector.h
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//
#ifndef YYOOMDetector_H
#define YYOOMDetector_H

#import <Foundation/Foundation.h>
#include <iostream>
using namespace std;

static size_t const kDefaultChunkSize = 10 * 1024 *1024;
class YYOOMDetector {
public:
    size_t m_chunkSize;
    YYOOMDetector(size_t chunkSize = kDefaultChunkSize);
    ~YYOOMDetector();
    
    void beginDetector();
    void stopDetector();
    void getChunkStack(size_t size);
    
};
YYOOMDetector *globalDetector = NULL;
#endif
