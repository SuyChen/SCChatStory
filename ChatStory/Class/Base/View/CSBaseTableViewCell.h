//
//  CSBaseTableViewCell.h
//  CSYLive
//
//  Created by CSY on 2018/11/21.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseTableViewCell : UITableViewCell
- (void)configCellWithModel:(id)model;
+ (CGFloat)configHeightWithModel:(id)mdoel;
@end

NS_ASSUME_NONNULL_END
