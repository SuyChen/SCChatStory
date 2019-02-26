//
//  CSCategoryMainView.m
//  ChatStory
//
//  Created by CSY on 2018/12/6.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSCategoryMainView.h"
#import "CSCategoryCollectionViewCell.h"
#import "CSStoryDetailViewController.h"

@interface CSCategoryMainView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *showedIndexPath;
@end
@implementation CSCategoryMainView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.showedIndexPath = [NSMutableArray array];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CSCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CSCategoryCollectionViewCell"];
}
#pragma mark == collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSCategoryCollectionViewCell" forIndexPath:indexPath];
    [cell configCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.showedIndexPath containsObject:indexPath]) {
        return;
    }else{
        cell.alpha = 0.3;
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            cell.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (CSY_WIDTH - 45) / 2 - 1;
    return CGSizeMake(width, width / 3 * 4 + 90);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.0;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSStoryDetailViewController *vc = [[CSStoryDetailViewController alloc] init];
    vc.model = [CSDataHelper transferListModelToStoryModel:self.dataArray[indexPath.item]];
    [vc hideTabbarWithAnimation];
    [[CSCommonUtil currentNC] pushViewController:vc animated:YES];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
@end
