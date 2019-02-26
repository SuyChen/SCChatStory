//
//  NSObject+SwizzleMethod.h
//  test
//
//  Created by yehuawei on 2018/4/10.
//  Copyright © 2018年 postop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SwizzleMethod)
+(void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
