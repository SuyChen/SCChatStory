//
//  CSHomeCollectionViewCell.m
//  ChatStory
//
//  Created by CSY on 2018/12/6.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSHomeCollectionViewCell.h"

@interface CSHomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *back_img;
@property (weak, nonatomic) IBOutlet UILabel *title_lb;
@property (weak, nonatomic) IBOutlet UILabel *author_lb;
@property (weak, nonatomic) IBOutlet UIButton *loveCount_btn;
@property (weak, nonatomic) IBOutlet UIImageView *audio_img;

@end
@implementation CSHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(id)model
{
    CSListModel *sModel = model;
    [self.back_img sd_setImageWithURL:[NSURL URLWithString:sModel.coverImageFile.url] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.title_lb.text = sModel.seriesTitle;
    self.author_lb.text = sModel.author.fullName;
    [self.loveCount_btn setTitle:sModel.loveCount.stringValue forState:UIControlStateNormal];
    if (sModel.badge.text.length > 0) {
        self.audio_img.hidden = NO;
    }else{
        self.audio_img.hidden = YES;
    }

}
@end
