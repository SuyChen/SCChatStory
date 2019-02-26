//
//  CSListModel.m
//  ChatStory
//
//  Created by CSY on 2018/12/10.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSListModel.h"

@implementation CSListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"characters" : [CSMessageModel class]};
}
@end

@implementation CSAuthorModel

@end

@implementation CSCoverImageModel


@end

@implementation CSBadgeModel


@end
