//
//  YYMemoryTaskManager.h
//  YYMobile
//
//  Created by wzp on 2018/11/28.
//  Copyright © 2018 YY.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYChunkInfoQueue.h"
@interface YYMemoryTaskManager : NSObject
+ (instancetype)sharedInstance;

- (void)addTaskToQueue:(YYChunkInfo)task;
@end
