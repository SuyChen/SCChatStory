//
//  NSString+SizeCalculate.h
//  ucar_customer
//
//  Created by nia_wei on 15-4-29.
//  Copyright (c) 2015年 gogotown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SizeCalculate)

/**
 *  根据 fontSize大小 ，固定高度，计算文本宽度
 */
- (CGFloat)sc_calculateWidthInFontSize:(CGFloat)fontSize withStableHeight:(CGFloat)stableHeight;

/**
 *  根据 fontSize大小 ，固定宽度，计算文本高度
 */
- (CGFloat)sc_calculateHeightInFontSize:(CGFloat)fontSize withStableWidth:(CGFloat)stableWidth;
/**
 *  根据 fonte大小 ，固定高度，计算文本宽度
 */
- (CGFloat)sc_calculateWidthInFont:(UIFont *)font withStableHeight:(CGFloat)stableHeight;

/**
 *  根据 font大小 ，固定宽度，计算文本高度
 */
- (CGFloat)sc_calculateHeightInFont:(UIFont *)font withStableWidth:(CGFloat)stableWidth;
/**
 *  根据 font大小 ,计算文本size
 */
- (CGSize)sc_calculateSizeInFont:(UIFont *)font withStableSize:(CGSize)size;

@end
