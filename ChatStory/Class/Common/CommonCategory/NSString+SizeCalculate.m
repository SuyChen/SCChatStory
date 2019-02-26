//
//  NSString+SizeCalculate.m
//  ucar_customer
//
//  Created by nia_wei on 15-4-29.
//  Copyright (c) 2015年 gogotown. All rights reserved.
//

#import "NSString+SizeCalculate.h"

@implementation NSString (SizeCalculate)

- (CGFloat)sc_calculateWidthInFontSize:(CGFloat)fontSize withStableHeight:(CGFloat)stableHeight
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT , stableHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    result = resultSize.width;
    result = ceilf(result);
    
    if (self.length==0) result = 0.0;
    return result;
}

- (CGFloat)sc_calculateHeightInFontSize:(CGFloat)fontSize withStableWidth:(CGFloat)stableWidth
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:CGSizeMake(stableWidth , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    result = resultSize.height;
    result = ceilf(result);
    
    if (self.length==0) result = 0.0;
    return result;
}

- (CGFloat)sc_calculateWidthInFont:(UIFont *)font withStableHeight:(CGFloat)stableHeight
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT , stableHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    result = resultSize.width;
    result = ceilf(result);
    
    if (self.length==0) result = 0.0;
    return result;
}

- (CGFloat)sc_calculateHeightInFont:(UIFont *)font withStableWidth:(CGFloat)stableWidth
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:CGSizeMake(stableWidth , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    result = resultSize.height;
    result = ceilf(result);
    
    if (self.length==0) result = 0.0;
    return result;
}

- (CGSize)sc_calculateSizeInFont:(UIFont *)font withStableSize:(CGSize)size
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return resultSize;
}
@end
