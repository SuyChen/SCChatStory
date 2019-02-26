//
//  CSCustomLabel.m
//  ChatStory
//
//  Created by CSY on 2018/12/7.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSCustomLabel.h"

@implementation CSCustomLabel

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

@end
