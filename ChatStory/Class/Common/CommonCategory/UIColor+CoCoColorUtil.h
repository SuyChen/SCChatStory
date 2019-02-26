//
//  UIColor+CoCoColorUtil.h
//  Me&U Dating
//
//  Created by CSY on 2018/9/29.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CoCo_Color(aColorString) [UIColor CoCo_ColorFromString:aColorString]

@interface UIColor (CoCoColorUtil)

+ (UIColor *)CoCo_ColorFromString:(NSString *)aColorString;
+ (UIColor *)CoCo_ColorFromString:(NSString *)aColorString alpha:(CGFloat)aAlpha;
+ (NSString *)CoCo_StringFromColor:(UIColor *)aColor;

@end
