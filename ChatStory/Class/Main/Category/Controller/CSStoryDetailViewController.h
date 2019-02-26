//
//  CSStoryDetailViewController.h
//  ChatStory
//
//  Created by CSY on 2018/12/7.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSStoryDetailHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSStoryDetailViewController : CSBaseViewController
@property (nonatomic, strong) CSStoryDetailHeaderView *headerView;
@property (nonatomic, strong) CSStoryModel *model;
@end

NS_ASSUME_NONNULL_END
