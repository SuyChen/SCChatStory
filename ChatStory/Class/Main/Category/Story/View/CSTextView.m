//
//  CSTextView.m
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSTextView.h"

@interface CSTextView ()<UITextViewDelegate>

@end
@implementation CSTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //配置
        [self setup];
    }
    return self;
}

#pragma mark - 配置
- (void)setup{
    
    CGFloat padding = self.textContainer.lineFragmentPadding;
    
    self.editable = NO;
    self.scrollEnabled = NO;
    self.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
    self.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    self.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(nonnull NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    return YES;
}


@end
