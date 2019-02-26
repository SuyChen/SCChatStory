//
//  CSBaseCollectionViewCell.h
//  ChatStory
//
//  Created by CSY on 2018/12/6.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseCollectionViewCell : UICollectionViewCell
- (void)configCellWithModel:(id)model;
+ (CGFloat)configHeightWithModel:(id)mdoel;
@end

NS_ASSUME_NONNULL_END
