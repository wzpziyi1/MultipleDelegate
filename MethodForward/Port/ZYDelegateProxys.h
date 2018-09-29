//
//  ZYDelegateProxys.h
//  MethodForward
//
//  Created by wzp on 2018/9/26.
//  Copyright © 2018 wzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDelegateProxys : NSObject
@property (nonatomic, weak) id owner;

- (void)configureDelegateTargets:(NSArray *)targets;
@end
