//
//  CSStoryModel.h
//  ChatStory
//
//  Created by CSY on 2018/12/11.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CSStoryType){
    CSStoryType_Comedy = 1,
    CSStoryType_Horror,
    CSStoryType_Mystery,
    CSStoryType_Romance,
    CSStoryType_Science
};

typedef NS_ENUM(NSInteger, CSCellType){
    CSCellType_Left = 1,
    CSCellType_Right,
    CSCellType_Middle
};


@class CSMessageModel;

@interface CSStoryModel : NSObject
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) CSListModel *story;
@property (nonatomic, assign) BOOL isChecked;
@end

@interface CSMessageModel : NSObject
@property (nonatomic, strong) NSNumber *ordinalInStory;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) CSCoverImageModel *imageFile;
@property (nonatomic, strong) CSMessageModel *sender;
@property (nonatomic, assign) CSCellType cellType;
@property (nonatomic, assign) CSStoryType storyType;
@end

NS_ASSUME_NONNULL_END
