//
//  CSEpisodesView.m
//  ChatStory
//
//  Created by CSY on 2018/12/17.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSEpisodesView.h"

@interface CSEpisodesView ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *background_btn;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomConstraint;
@end
@implementation CSEpisodesView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorColor = CoCo_Color(@"4F4E4E");
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (void)showViewWithArray:(NSArray *)array
{
    self.dataArray = array;
    CGFloat height = 60 * self.dataArray.count;
    self.tableHeightConstraint.constant = height;
    [self.table reloadData];
    [[CSCommonUtil currentVC].view addSubview:self];
    [self layoutIfNeeded];
    self.table.transform = CGAffineTransformMakeTranslation(0, height);
    [UIView animateWithDuration:0.3 animations:^{
        self.table.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
}
- (IBAction)hide:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.table.transform = CGAffineTransformMakeTranslation(0, 60 * self.dataArray.count);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSStoryModel *model = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = model.story.episodeTitle;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = CoCo_Color(@"363535");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide:nil];
    if (self.clickBlock) {
        CSStoryModel *model = self.dataArray[indexPath.row];
        self.clickBlock(model);
    }
}

@end
