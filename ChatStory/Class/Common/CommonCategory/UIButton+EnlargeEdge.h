//
//  UIButton+EnlargeEdge.h
//  aaaaaaaaa
//
//  Created by APPLE on 15/12/15.
//  Copyright (c) 2015年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
