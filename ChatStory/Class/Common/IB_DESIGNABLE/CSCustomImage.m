//
//  CSCustomImage.m
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/12.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import "CSCustomImage.h"

@implementation CSCustomImage

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
