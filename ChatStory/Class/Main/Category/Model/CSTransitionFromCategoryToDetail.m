//
//  CSTransitionFromCategoryToDetail.m
//  ChatStory
//
//  Created by CSY on 2018/12/11.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSTransitionFromCategoryToDetail.h"
#import "CSBaseViewController.h"


@implementation CSTransitionFromCategoryToDetail
#pragma mark - UIViewControllerAnimatedTransitioning必须实现的两个方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    CSBaseViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    
    [containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:duration animations:^{
        
        toViewController.view.alpha = 1.0;
        
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
#pragma mark - 过渡的持续时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
@end
