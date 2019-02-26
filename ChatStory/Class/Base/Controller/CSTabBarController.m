//
//  CSTabBarController.m
//  CSYIntegralWall
//
//  Created by CSY on 2018/11/8.
//  Copyright © 2018年 wdys. All rights reserved.
//

#import "CSTabBarController.h"
#import "CSCategoryViewController.h"
#import "CSNavigationController.h"


@interface CSTabBarController ()
@property (nonatomic, strong) NSTimer *vipTimer;
@end

@implementation CSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTabbarUI];
    [self configControllers];
}

- (void)configTabbarUI
{
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, CSY_WIDTH, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,CoCo_Color(@"363636").CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    //设置tabbar背景颜色
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CoCo_Color(@"1F1F20");
    view.frame = CGRectMake(0, 0, CSY_WIDTH, CSY_TabBarHeight);
    [[UITabBar appearance] insertSubview:view atIndex:0];
    
}
- (void)configControllers
{
    //设置子控制器
    CSCategoryViewController *homeVC  = [[CSCategoryViewController alloc]init];
    CSNavigationController *homeNavi = [[CSNavigationController alloc]initWithRootViewController:homeVC];
    CSCategoryViewController *categoryVC  = [[CSCategoryViewController alloc]init];
    CSNavigationController *categoryNavi = [[CSNavigationController alloc]initWithRootViewController:categoryVC];
    CSCategoryViewController *mineVC  = [[CSCategoryViewController alloc]init];
    CSNavigationController *mineNavi = [[CSNavigationController alloc]initWithRootViewController:mineVC];
    
    self.viewControllers = @[homeNavi,categoryNavi,mineNavi];
    
    homeNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Home" image:[[UIImage imageNamed:@"CS_home_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"CS_tabbar_home_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    categoryNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Category" image:[[UIImage imageNamed:@"CS_home_cate_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"CS_home_cate_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mineNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Mine" image:[[UIImage imageNamed:@"CS_home_mine_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"CS_home_mine_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //选中颜色
    [homeNavi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CoCo_Color(@"666666")} forState:UIControlStateNormal];
    [homeNavi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CoCo_Color(@"ffffff")} forState:UIControlStateSelected];
    [categoryNavi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CoCo_Color(@"666666")} forState:UIControlStateNormal];
    [categoryNavi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CoCo_Color(@"ffffff")} forState:UIControlStateSelected];
    [mineNavi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CoCo_Color(@"666666")} forState:UIControlStateNormal];
    [mineNavi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CoCo_Color(@"ffffff")} forState:UIControlStateSelected];
    
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
