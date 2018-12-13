//
//  YYMemoryDetectorManager.h
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYMemoryDetectorManager : NSObject
@property (nonatomic, assign, readonly) NSUInteger detectorSize;


+ (instancetype)sharedInstance;

- (void)beginMemoryDetector:(NSUInteger)size;
- (void)stopMemoryDetector;
@end
