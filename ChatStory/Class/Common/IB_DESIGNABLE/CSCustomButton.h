//
//  CSCustomButton.h
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/8.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CSCustomButton : UIButton
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;// 阴影透明度
@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;
@property (nonatomic, assign) IBInspectable BOOL masksToBounds;
@end
