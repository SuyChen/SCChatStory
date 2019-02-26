//
//  CSBaseViewController.m
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/8.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import "CSBaseViewController.h"

@interface CSBaseViewController ()
//@property (nonatomic, strong) CoCoIndicatorView *loadingView;
@end

@implementation CSBaseViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc - %@",[self class]);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark == Loading
- (void)showLoadingView;
{
//    [ERHUD showHUDInView:self.view];
//    [self hideLoadindView];
//    if (self.view.superview)
//    {
//        return [self showLoadingViewInView:self.view.superview];
//    }
//    else if (self.navigationController.view)
//    {
//        return [self showLoadingViewInView:self.navigationController.view];
//    }
//    else
//    {
//        return [self showLoadingViewInView:self.view];
//    }
//    return nil;
}
//- (CoCoIndicatorView *)showLoadingViewInView:(UIView *)aView
//{
//    [self hideLoadindView];
//    [self setLoadingView:[CoCoIndicatorView showLoadingInView:aView]];
//    return self.loadingView;
//}
//- (void)hideLoadindView
//{
//    [ERHUD hideHUDInView:self.view];
//}

#pragma mark == Click
- (void)CoCo_OnBackButtonTapped
{
    if (self.navigationController)
    {
        if (self.navigationController.viewControllers.count == 1)
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = CoCo_Color(@"1F2020");
    self.TopConstraint.constant = CSY_StatusBarHeight;
   
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1)
        {
            self.bottomConstraint.constant = CSY_SafeBottomHeight;
        }else{
             self.bottomConstraint.constant = CSY_TabBarHeight;
        }
        self.navigationController.view.backgroundColor = [UIColor whiteColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
