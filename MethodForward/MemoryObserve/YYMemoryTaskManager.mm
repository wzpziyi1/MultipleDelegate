//
//  YYMemoryTaskManager.m
//  YYMobile
//
//  Created by wzp on 2018/11/28.
//  Copyright © 2018 YY.inc. All rights reserved.
//

#import "YYMemoryTaskManager.h"
#import "YYWeakTimer.h"



@interface YYMemoryTaskManager()
{
    BOOL _isMax;
    YYWeakTimer *_timer;
}
@property (nonatomic, strong) NSMutableArray *taskArr;

@end

@implementation YYMemoryTaskManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initializeMemberValues];
        [self addNotification];
    }
    return self;
}

- (void)initializeMemberValues {
    self.taskArr = [NSMutableArray array];
    _isMax = NO;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)receiveEnterBackgroundNotification {
    [_timer invalidate];
    _timer = nil;
    _timer = [YYWeakTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(dealupTask) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(0, 0)];
}



- (void)receiveEnterForegroundNotification {
    [_timer invalidate];
    _timer = nil;
}

- (void)dealupTask {

}

- (void)addTaskToQueue:(YYChunkInfo)task {

}

- (void)reportMemoryTask:(NSString *)task {
    
    @autoreleasepool {
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        infoDict[@"satckInfo"] = task;
//        [[PRSReporter sharedObject] reportClientGeneralLogForScode:self.scode
//                                                              info:infoDict
//                                                            result:nil];
    }
}

@end
