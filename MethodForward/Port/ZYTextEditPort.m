//
//  ZYTextEditPort.m
//  MethodForward
//
//  Created by wzp on 2018/9/29.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "ZYTextEditPort.h"

@implementation ZYTextEditPort

- (void)updateLimitCountUI {
    self.limitLabel.text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)self.textView.text.length, (unsigned long)self.maxCount];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    UITextRange *textRange = [textView markedTextRange];
    if (textRange) {
        return;
    }
    
    if (textView.text.length > self.maxCount) {
        NSString *text = self.textView.text;
        BOOL isSuccess = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
        if (isSuccess) {
            self.textView.text = [text substringToIndex:self.maxCount];
        }else {
            //对于emoji表情，会占用两个长度
            __block int idx = 0;
            [text enumerateSubstringsInRange:NSMakeRange(0, text.length)
                                     options:NSStringEnumerationByComposedCharacterSequences
                                  usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                      if (idx + substring.length > self.maxCount) {
                                          *stop = YES;
                                      }else {
                                          idx += substring.length;
                                      }
                                  }];
            self.textView.text = [text substringToIndex:idx];
        }
    }
    [self updateLimitCountUI];
}
@end
