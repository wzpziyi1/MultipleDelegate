//
//  ZYHeaderBiggerPort.m
//  MethodForward
//
//  Created by wzp on 2018/9/26.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "ZYHeaderBiggerPort.h"

@interface ZYHeaderBiggerPort()
@property (nonatomic, assign) CGRect oringFrame;


@end

@implementation ZYHeaderBiggerPort

- (void)setImgView:(UIView *)imgView {
    _imgView = imgView;
    self.oringFrame = imgView.frame;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.imgView == nil) {
        return;
    }
    if (scrollView.contentOffset.y < 0) {
        CGFloat changeHeight = -scrollView.contentOffset.y;;
        CGFloat changeWidth = self.oringFrame.size.width / self.oringFrame.size.height * changeHeight;
        CGFloat width = self.oringFrame.size.width + changeWidth;
        CGFloat height = self.oringFrame.size.height + changeHeight;
        self.imgView.frame = CGRectMake(- changeWidth / 2, 0, width, height);
    }
    else {
        self.imgView.frame = CGRectMake(0, -scrollView.contentOffset.y, self.imgView.frame.size.width, self.imgView.frame.size.height);
    }
}

@end
