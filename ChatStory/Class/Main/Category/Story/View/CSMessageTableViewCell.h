//
//  CSMessageTableViewCell.h
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMessageFrame.h"
#import "CSTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLb;

@property (nonatomic, strong) CSMessageFrame *messageFrame;

@property (nonatomic, strong) UIButton *messageBtn;
@end

NS_ASSUME_NONNULL_END
