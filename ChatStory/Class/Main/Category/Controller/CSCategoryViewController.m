//
//  CSCategoryViewController.m
//  ChatStory
//
//  Created by CSY on 2018/12/5.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSCategoryViewController.h"
#import "CSStoryDetailViewController.h"
#import "CSTransitionFromCategoryToDetail.h"
@interface CSCategoryViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) CSCategoryMainView *romanceView;
@end

@implementation CSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}
#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if (fromVC == self && [toVC isKindOfClass:[CSStoryDetailViewController class]]) {
        return [[CSTransitionFromCategoryToDetail alloc] init];
    }
    else {
        return nil;
    }
}
#pragma mark == UI
- (void)configUI
{
    [self.view addSubview:self.romanceView];
    [self.romanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark == getter
- (CSCategoryMainView *)romanceView
{
    if (!_romanceView) {
        _romanceView = CSY_LoadNib(@"CSCategoryMainView");
        _romanceView.dataArray = [CSDataHelper getRomanceListArray];
    }
    return _romanceView;
}
@end
