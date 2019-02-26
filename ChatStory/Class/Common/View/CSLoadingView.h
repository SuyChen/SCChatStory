//
//  CSLoadingView.h
//  ChatStory
//
//  Created by CSY on 2018/12/19.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSLoadingView : UIView
+ (void)showHUDInView:(UIView *)view;

+ (void)hideHUDInView:(UIView *)view;

+ (void)showAlertString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
