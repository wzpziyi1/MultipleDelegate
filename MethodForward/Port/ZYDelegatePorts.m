//
//  ZYDelegatePorts.m
//  MethodForward
//
//  Created by wzp on 2018/9/26.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "ZYDelegatePorts.h"

@interface ZYDelegatePorts()

/**
 弱引用
 */
@property (nonatomic, strong) NSPointerArray *refTargets;
@end

@implementation ZYDelegatePorts

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)configureDelegateTargets:(NSArray *)targets {
    for (id obj in targets) {
        [self.refTargets addPointer:(__bridge void * _Nullable)(obj)];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    for (id obj in self.refTargets) {
        if ([obj respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        for (id obj in self.refTargets) {
            if ((sig = [obj methodSignatureForSelector:aSelector])) {
                break;
            }
        }
    }
    return sig;
}

//转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id obj in self.refTargets) {
        if ([obj respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:obj];
        }
    }
}

- (NSPointerArray *)refTargets {
    if (!_refTargets) {
        _refTargets = [NSPointerArray weakObjectsPointerArray];
    }
    return _refTargets;
}
@end
