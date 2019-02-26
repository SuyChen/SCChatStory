//
//  CSDataHelper.h
//  ChatStory
//
//  Created by CSY on 2018/12/10.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSDataHelper : NSObject

//类别
+ (NSArray *)getComedyListArray;
+ (NSArray *)getHorrorListArray;
+ (NSArray *)getMysteryListArray;
+ (NSArray *)getRomanceListArray;
+ (NSArray *)getScienceListArray;
//other
+ (NSArray *)moreStoryWithSameType:(NSString *)type;
+ (CSStoryModel *)transferListModelToStoryModel:(CSListModel *)model;
//切换章节
+ (NSArray *)getStoryEpisodeWithModel:(CSStoryModel *)model;
+ (CSStoryModel *)getNextModelWithLastModel:(CSStoryModel *)storyModel;
//保存本地
+(void)saveReadingWithStoryModel:(CSStoryModel *)storyModel;
+ (CSStoryModel *)getReadingWithStoryModel:(CSStoryModel *)storyModel;
@end

NS_ASSUME_NONNULL_END
