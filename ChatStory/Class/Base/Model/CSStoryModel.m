//
//  CSStoryModel.m
//  ChatStory
//
//  Created by CSY on 2018/12/11.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSStoryModel.h"

@implementation CSStoryModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"messages" : [CSMessageModel class]};
}
@end

@implementation CSMessageModel


@end
