//
//  YYMemoryDetectorManager.m
//  MethodForward
//
//  Created by wzp on 2018/12/13.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "YYMemoryDetectorManager.h"
#import "YYOOMDetector.h"

#if !__has_feature(objc_arc)
#error  does not support Objective-C Automatic Reference Counting (ARC)
#endif

YYOOMDetector *globalDetector = NULL;
inline void dispatch_safe_main_async(void(^block)(void)) {
    if (!block) return;
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}
@interface YYMemoryDetectorManager ()
@property (nonatomic, assign, readwrite) NSUInteger detectorSize;
@end

@implementation YYMemoryDetectorManager
+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)beginMemoryDetector:(NSUInteger)size {
    dispatch_safe_main_async(^{
        if (globalDetector == NULL) {
            globalDetector = new YYOOMDetector((size_t)size);
        }
        else {
            [self stopMemoryDetector];
            globalDetector = new YYOOMDetector((size_t)size);
        }
        self.detectorSize = (NSUInteger)globalDetector->m_chunkSize;
        globalDetector->beginDetector();
    });
}
- (void)stopMemoryDetector {
    dispatch_safe_main_async(^{
        if (globalDetector) {
            globalDetector->stopDetector();
            delete globalDetector;
            globalDetector = NULL;
            self.detectorSize = 0;
        }
    });
}
@end
