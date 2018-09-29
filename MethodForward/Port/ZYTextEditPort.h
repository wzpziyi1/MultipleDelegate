//
//  ZYTextEditPort.h
//  MethodForward
//
//  Created by wzp on 2018/9/29.
//  Copyright © 2018 wzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTextEditPort : NSObject<UITextViewDelegate>
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UILabel *limitLabel;

@property (nonatomic, assign) NSUInteger maxCount;
@end
