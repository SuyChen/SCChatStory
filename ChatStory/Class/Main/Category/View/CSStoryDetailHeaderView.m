//
//  CSStoryDetailHeaderView.m
//  ChatStory
//
//  Created by CSY on 2018/12/7.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSStoryDetailHeaderView.h"
#import "CSStoryMessageController.h"
#import "CSEpisodesView.h"

@interface CSStoryDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *loveCount_btn;
@property (weak, nonatomic) IBOutlet UILabel *storyTitle_lb;
@property (weak, nonatomic) IBOutlet UILabel *storyAuthor_lb;
@property (weak, nonatomic) IBOutlet UILabel *storyDesc_lb;
@property (weak, nonatomic) IBOutlet UILabel *section_lb;
@property (weak, nonatomic) IBOutlet UIView *sectionLine_view;
@property (weak, nonatomic) IBOutlet UIButton *start_btn;
@property (weak, nonatomic) IBOutlet UIImageView *audio_img;
@property (nonatomic, strong) CSStoryModel *sModel;
@property (nonatomic, strong) CSEpisodesView *episodesView;
@end
@implementation CSStoryDetailHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)configUIWithModel:(id)model
{
    self.sModel = model;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.sModel.story.coverImageFile.url];
    if (!image) {
        
        [self.header_img sd_setImageWithURL:[NSURL URLWithString:self.sModel.story.coverImageFile.url] placeholderImage:[UIImage imageNamed:@"img_default"]];
    }else{
        self.header_img.image = image;
    }
    
    [self.loveCount_btn setTitle:self.sModel.story.loveCount.stringValue forState:UIControlStateNormal];
    self.storyTitle_lb.text = self.sModel.story.seriesTitle;
    self.storyAuthor_lb.text = self.sModel.story.author.fullName;
    self.storyDesc_lb.text = self.sModel.story.storyDescription;
    if (self.sModel.story.episodeCount.integerValue == 1) {
        self.sectionLine_view.hidden = YES;
    }else{
        self.sectionLine_view.hidden = NO;
        self.section_lb.text = [NSString stringWithFormat:@"ep.%@ of %@",self.sModel.story.episodeIndex, self.sModel.story.episodeCount];
    }
    if ([self.sModel.story.badge.text isEqualToString:@"AUDIO"]) {
        self.audio_img.hidden = NO;
    }else{
        self.audio_img.hidden = YES;
    }
    
}
- (IBAction)CSClickSection:(id)sender {
    
    [self.episodesView showViewWithArray:[CSDataHelper getStoryEpisodeWithModel:self.sModel]];
}

- (IBAction)CSClickStart:(id)sender {
    
    CSStoryMessageController *vc = [[CSStoryMessageController alloc] init];
    vc.storyModel = self.sModel;
    [[CSCommonUtil currentNC] pushViewController:vc animated:YES];

}

- (IBAction)CSClickReadLater:(id)sender {
}

- (CSEpisodesView *)episodesView
{
    if (!_episodesView) {
        _episodesView = CSY_LoadNib(@"CSEpisodesView");
        _episodesView.frame = CGRectMake(0, 0, CSY_WIDTH, CSY_HEIGHT);
        CSYWeakSelf(weakSelf);
        _episodesView.clickBlock = ^(CSStoryModel * _Nonnull model) {
            [weakSelf configUIWithModel:model];
        };
    }
    return _episodesView;
}

@end
