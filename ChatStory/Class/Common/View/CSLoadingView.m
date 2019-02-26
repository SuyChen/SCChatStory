//
//  CSLoadingView.m
//  ChatStory
//
//  Created by CSY on 2018/12/19.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSLoadingView.h"
#import "MBProgressHUD.h"

@implementation CSLoadingView

+ (void)showHUDInView:(UIView *)view {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView * gifImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Loading_iv"]];
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    // 围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI/2.0, 0.0, 0.0, 1.0) ];
    animation.duration = 0.2;
    animation.removedOnCompletion = NO;
    // 旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = HUGE_VALF;
    [gifImageView.layer addAnimation:animation forKey:nil];
    hud.customView = gifImageView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
}
+ (void)hideHUDInView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showAlertString:(NSString *)str
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.opacity = 0.9;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;
    [hud hideAnimated:YES afterDelay:3.f];

}

@end
