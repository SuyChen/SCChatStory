//
//  CSStoryDetailHeaderView.h
//  ChatStory
//
//  Created by CSY on 2018/12/7.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSStoryDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *header_img;
- (void)configUIWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
