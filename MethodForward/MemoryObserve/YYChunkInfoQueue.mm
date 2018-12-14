//
//  YYChunkInfoQueue.m
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "YYChunkInfoQueue.h"
#import "YYMemoryMacro.h"

static priority_queue<YYChunkInfo>infoQueue;
static NSLock *_queueLock = [[NSLock alloc] init];

void addInfoToQueue(const YYChunkInfo &info) {
    [_queueLock lock];
    if (infoQueue.size() > max_queue_count) {
        return;
    }
    infoQueue.push(info);
    [_queueLock unlock];
}
void deleteTopInfoFromQueue() {
    [_queueLock lock];
    if (infoQueue.size() > 0) {
        infoQueue.pop();
    }
    [_queueLock unlock];
}

YYChunkInfo queueTopInfo() {
    [_queueLock lock];
    YYChunkInfo info = infoQueue.top();
    [_queueLock unlock];
    return info;
}
