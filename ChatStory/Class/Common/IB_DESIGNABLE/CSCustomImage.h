//
//  CSCustomImage.h
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/12.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CSCustomImage : UIImageView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@end
