//
//  ZYTextVc.m
//  MethodForward
//
//  Created by wzp on 2018/9/29.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "ZYTextVc.h"
#import "ZYDelegatePorts.h"
#import "ZYTextEditPort.h"

@interface ZYTextVc ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;

@property (nonatomic, strong) ZYDelegatePorts *ports;
@property (nonatomic, strong) ZYTextEditPort *textPort;
@end

@implementation ZYTextVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textPort = [[ZYTextEditPort alloc] init];
    self.textPort.textView = self.textView;
    self.textPort.limitLabel = self.limitLabel;
    self.textPort.maxCount = 20;
    
    self.ports = [[ZYDelegatePorts alloc] init];
    [self.ports configureDelegateTargets:@[self.textPort]];
    
    self.textView.delegate = (id<UITextViewDelegate>)self.ports;
}

- (void)dealloc {
    NSLog(@"销毁成功：%s", __func__);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"输入完毕：%s", __func__);
}

@end
