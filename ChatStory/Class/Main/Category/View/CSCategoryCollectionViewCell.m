//
//  CSCategoryCollectionViewCell.m
//  ChatStory
//
//  Created by CSY on 2018/12/6.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSCategoryCollectionViewCell.h"


@interface CSCategoryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet CSCustomImage *back_img;
@property (weak, nonatomic) IBOutlet UIButton *loveCount_btn;
@property (weak, nonatomic) IBOutlet UILabel *title_lb;
@property (weak, nonatomic) IBOutlet UILabel *author_lb;
@property (weak, nonatomic) IBOutlet UIImageView *audio_img;
@end
@implementation CSCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCellWithModel:(id)model
{
    CSListModel *sModel = model;
//
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:sModel.coverImageFile.url];
//    if (!image) {

    [self.back_img sd_setImageWithURL:[NSURL URLWithString:sModel.coverImageFile.url] placeholderImage:[UIImage imageNamed:@"img_default"]];
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:sModel.coverImageFile.url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//
//            [[SDImageCache sharedImageCache] storeImage:image forKey:sModel.coverImageFile.url toDisk:YES completion:^{
//                self.back_img.image = image;
//            }];
//
//        }];
//    }else{
//        self.back_img.image = image;
//    }

    self.title_lb.text = sModel.seriesTitle;
    self.author_lb.text = sModel.author.fullName;
    [self.loveCount_btn setTitle:sModel.loveCount.stringValue forState:UIControlStateNormal];
    if ([sModel.badge.text isEqualToString:@"AUDIO"]) {
        self.audio_img.hidden = NO;
    }else{
        self.audio_img.hidden = YES;
    }
}


@end
