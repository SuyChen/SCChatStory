//
//  CSCustomView.h
//  ChatStory
//
//  Created by CSY on 2018/12/6.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface CSCustomView : UIView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@end

NS_ASSUME_NONNULL_END
