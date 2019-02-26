//
//  CSCommonUtil.h
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/9.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCommonUtil : NSObject
//获取当前导航
+ (UINavigationController *)currentNC;
//获取当前控制器
+ (UIViewController *)currentVC;
//获取当前时间
+ (NSString *)getCurrentTime;

+ (void)showVipVC;

+ (void)savePurchaseMessageWithDay:(NSString *)day;

+ (BOOL)compareDate;
@end
