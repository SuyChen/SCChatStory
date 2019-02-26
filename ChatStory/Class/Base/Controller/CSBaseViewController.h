//
//  CSBaseViewController.h
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/8.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
//- (void)showLoadingView;
//- (void)hideLoadindView;
@end
