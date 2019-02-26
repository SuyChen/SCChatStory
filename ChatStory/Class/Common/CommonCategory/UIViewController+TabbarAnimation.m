//
//  UIViewController+TabbarAnimation.m
//  SY_Customer
//
//  Created by 刘志会 on 2016/7/28.
//
//

#import "UIViewController+TabbarAnimation.h"

@implementation UIViewController (TabbarAnimation)
- (void)hideTabbarWithAnimation
{
    UITabBar* tabbar = [CSCommonUtil currentNC].tabBarController.tabBar;
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabbar.frame;
                         tabbar.transform = CGAffineTransformMakeTranslation(tabFrame.size.width, tabFrame.size.height);
                     }completion:^(BOOL finished) {
                         if (finished) {
                             [tabbar setHidden:YES];
                         }
                     }];
}

- (void)showTabbarWithAnimation
{
    UITabBar* tabbar = [CSCommonUtil currentNC].tabBarController.tabBar;
    tabbar.hidden = NO;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         CGRect tabFrame = tabbar.frame;
                         tabFrame.origin.y = [CSCommonUtil currentNC].view.frame.size.height - 49 + [self adjustIphoneX];
                         tabbar.frame = tabFrame;
//                         [tabbar setAlpha:1];


                     }];
}

- (void)hideTabbarNoAnimation
{
    UITabBar* tabbar = [CSCommonUtil currentNC].tabBarController.tabBar;
    CGRect tabFrame = tabbar.frame;
    tabFrame.origin.y = [CSCommonUtil currentNC].view.frame.size.height + [self adjustIphoneX];
    tabbar.frame = tabFrame;
//    [tabbar setAlpha:0];
    [tabbar setHidden:YES];


}

- (void)showTabbarNoAnimation
{
    UITabBar* tabbar = [CSCommonUtil currentNC].tabBarController.tabBar;
    CGRect tabFrame = tabbar.frame;
    tabFrame.origin.y = [CSCommonUtil currentNC].view.frame.size.height - 49 + [self adjustIphoneX];
    tabbar.frame = tabFrame;
//    [tabbar setAlpha:1];
    [tabbar setHidden:NO];


}

- (CGFloat)adjustIphoneX
{
    if (Is_Iphone_X) {
        return -34;
    }
    return 0.f;
}

@end
