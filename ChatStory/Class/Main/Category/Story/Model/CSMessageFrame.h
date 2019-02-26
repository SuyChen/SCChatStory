//
//  CSMessageFrame.h
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <Foundation/Foundation.h>

//消息中控件与内容间隔
static NSInteger const kChat_margin = 15;
//Romance单行气泡高度
static NSInteger const kChat_Romance_min_h = 40;


NS_ASSUME_NONNULL_BEGIN

//聊天内容计算model
@interface CSMessageFrame : NSObject
//名字CGRect
@property (nonatomic, assign, readonly) CGRect nameF;
//内容CGRect
@property (nonatomic, assign, readonly) CGRect contentF;
//整体cell高度
@property (nonatomic, assign, readonly) CGFloat cell_h;
//消息模型
@property (nonatomic, strong) CSMessageModel *message;


@end

NS_ASSUME_NONNULL_END
