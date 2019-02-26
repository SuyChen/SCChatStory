//
//  NSDictionary+Safe.m
//  test
//
//  Created by yehuawei on 2018/4/10.
//  Copyright © 2018年 postop. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSDictionary (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [NSClassFromString(@"__NSDictionaryM") swizzleMethod:@selector(setObject:forKey:) swizzledSelector:@selector(mutableSetObject:forKey:)];
            [NSClassFromString(@"__NSDictionaryM") swizzleMethod:@selector(setObject:forKeyedSubscript:) swizzledSelector:@selector(mutableSetObject:forKeyedSubscript:)];
            [NSClassFromString(@"__NSDictionaryM") swizzleMethod:@selector(removeObjectForKey:) swizzledSelector:@selector(mutableRemoveObjectForKey:)];
        }
    });
}

-(void)mutableSetObject:(id)obj forKey:(NSString *)key{
    if (obj && key) {
        [self mutableSetObject:obj forKey:key];
    }
}

-(void)mutableSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (obj && key) {
        [self mutableSetObject:obj forKeyedSubscript:key];
    }
}
-(void)mutableRemoveObjectForKey:(id)key
{
    if (key) {
        [self mutableRemoveObjectForKey:key];
    }
}


@end

