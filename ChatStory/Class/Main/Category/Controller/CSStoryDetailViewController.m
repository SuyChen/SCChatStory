//
//  CSStoryDetailViewController.m
//  ChatStory
//
//  Created by CSY on 2018/12/7.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSStoryDetailViewController.h"
#import "NSString+SizeCalculate.h"

@interface CSStoryDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSArray *moreArray;
@end

@implementation CSStoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}
#pragma mark == UI
- (void)configUI
{
    if (@available(iOS 11.0, *)) {
        self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat height = [self.model.story.seriesTitle sc_calculateHeightInFont:[UIFont systemFontOfSize:30] withStableWidth:CSY_WIDTH - 90];
    height += [self.model.story.storyDescription sc_calculateHeightInFont:[UIFont boldSystemFontOfSize:12] withStableWidth:CSY_WIDTH - 30];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CSY_WIDTH, 280 / 375.0 * CSY_WIDTH + 160 + height)];
    [header addSubview:self.headerView];
    self.headerView.frame = header.bounds;
    self.table.tableHeaderView = header;
    [self.table registerNib:[UINib nibWithNibName:@"CSHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSHomeTableViewCell"];
    self.table.tableFooterView = [UIView new];
}

#pragma mark ==UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
#pragma mark == Click
- (IBAction)CSClickPop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark == getter&setter
- (CSStoryDetailHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = CSY_LoadNib(@"CSStoryDetailHeaderView");
    }
    return _headerView;
}

- (void)setModel:(CSStoryModel *)model
{
    _model = model;
    self.moreArray = [CSDataHelper moreStoryWithSameType:model.story.genre];
    [self.headerView configUIWithModel:model];
    [self.table reloadData];
}

@end
