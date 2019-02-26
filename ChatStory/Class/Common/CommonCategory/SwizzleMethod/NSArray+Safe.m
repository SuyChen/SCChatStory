//
//  NSArray+Safe.m
//  test
//
//  Created by yehuawei on 2018/4/10.
//  Copyright © 2018年 postop. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSArray (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"__NSArray0") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(emptyObjectIndex:)];
        [NSClassFromString(@"__NSArrayI") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(arrObjectIndex:)];
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(mutableObjectIndex:)];
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(mutableInsertObject:atIndex:)];
        [NSClassFromString(@"__NSSingleObjectArrayI") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(singleObjectIndex:)];
        
        
        [NSClassFromString(@"__NSArray0") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(emptyObjectAtIndexedSubscript:)];
        [NSClassFromString(@"__NSArrayI") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(arrObjectAtIndexedSubscript:)];
        [NSClassFromString(@"__NSArrayM") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(mutableObjectAtIndexedSubscript:)];
        [NSClassFromString(@"__NSSingleObjectArrayI") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(singleObjectAtIndexedSubscript:)];
        
    });
}

-(id)emptyObjectIndex:(NSInteger)index{
    return nil;
}

-(id)arrObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self arrObjectIndex:index];
}

-(id)mutableObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self mutableObjectIndex:index];
}

-(id)singleObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self singleObjectIndex:index];
}

-(void)mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self mutableInsertObject:object atIndex:index];
    }
}

-(id)emptyObjectAtIndexedSubscript:(NSInteger)index
{
    return nil;
}

-(id)arrObjectAtIndexedSubscript:(NSInteger)index
{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self arrObjectAtIndexedSubscript:index];
}

-(id)mutableObjectAtIndexedSubscript:(NSInteger)index
{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self mutableObjectAtIndexedSubscript:index];
}

-(id)singleObjectAtIndexedSubscript:(NSInteger)index
{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self singleObjectAtIndexedSubscript:index];
}

@end
