//
//  CSEpisodesView.h
//  ChatStory
//
//  Created by CSY on 2018/12/17.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBlock)(CSStoryModel *model);
@interface CSEpisodesView : UIView
@property (nonatomic, copy) ClickBlock clickBlock;
- (void)showViewWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
