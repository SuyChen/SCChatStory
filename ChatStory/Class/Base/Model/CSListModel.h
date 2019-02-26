//
//  CSListModel.h
//  ChatStory
//
//  Created by CSY on 2018/12/10.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CSAuthorModel,CSCoverImageModel,CSBadgeModel;

@interface CSListModel : NSObject
@property (nonatomic, strong) CSAuthorModel *author;
@property (nonatomic, copy) NSString *uid;//找到文章json的id
@property (nonatomic, copy) NSString *storyDescription;
@property (nonatomic, copy) NSString *seriesTitle;
@property (nonatomic, strong) NSNumber *loveCount;
@property (nonatomic, strong) CSBadgeModel *badge;//是否有音频
@property (nonatomic, strong) CSCoverImageModel *coverImageFile;
@property (nonatomic, strong) CSCoverImageModel *coverImageLoRes;
@property (nonatomic, strong) CSCoverImageModel *coverImageThumbnailFile;
@property (nonatomic, strong) NSNumber *episodeCount;//章节总数
@property (nonatomic, strong) NSNumber *episodeIndex;//第几章节
@property (nonatomic, copy) NSString *genre;//类别
@property (nonatomic, strong) NSArray *characters;//人物
@property (nonatomic, copy) NSString *audioSoundFileUrl;
@property (nonatomic, copy) NSString *audioSynchronizationData;
@property (nonatomic, copy) NSString *episodeTitle;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *searchTerms;
@end

@interface CSBadgeModel : NSObject
@property (nonatomic, copy) NSString *text;
@end

@interface CSAuthorModel : NSObject
@property (nonatomic, copy) NSString *canonicalUsername;//作家名字
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *objectId;
@end

@interface CSCoverImageModel : NSObject
@property (nonatomic, copy) NSString *url;
@end


NS_ASSUME_NONNULL_END
