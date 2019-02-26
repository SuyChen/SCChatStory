//
//  CSSicenceTableViewCell.m
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSSicenceTableViewCell.h"

@interface CSSicenceTableViewCell ()
@property (nonatomic, strong) CSTextView *textView;
@end
@implementation CSSicenceTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMessageFrame:(CSMessageFrame *)messageFrame
{
    [super setMessageFrame:messageFrame];
    CSMessageModel *messageModel = messageFrame.message;
    self.nameLb.textColor = CoCo_Color(@"999999");
    self.textView.text = messageModel.text;
    if (messageModel.cellType == CSCellType_Middle) {
        self.textView.font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
        self.textView.textColor = CoCo_Color(@"767676");
    }else if (messageModel.cellType == CSCellType_Left){
        self.textView.font = [UIFont systemFontOfSize:15];
        self.textView.textColor = CoCo_Color(@"333333");
    }else{
        self.textView.font = [UIFont systemFontOfSize:15];
        self.textView.textColor = [UIColor whiteColor];
    }
    
    [self setTextFrame];
    
    [self setChatBackground:messageModel];
    
    [self setChatImage:messageModel];
}
//设置frame
- (void)setTextFrame
{
    CGFloat view_y = kChat_margin;
    if ([UIFont systemFontOfSize:15].lineHeight < kChat_Romance_min_h) {//为了使聊天内容与最小高度对齐
        view_y = (kChat_Romance_min_h - [UIFont systemFontOfSize:15].lineHeight)/2;
    }
    self.textView.frame = CGRectMake(kChat_margin, view_y, self.messageBtn.frame.size.width - 2*kChat_margin, self.messageBtn.frame.size.height - 2*view_y);
}
// 设置聊天气泡背景
- (void)setChatBackground:(CSMessageModel *)messageModel
{
    UIImage *image = nil;
    if (messageModel.cellType == CSCellType_Left) {
        image = [UIImage imageNamed:@"comedy_chat_left"];
        self.messageBtn.backgroundColor = [UIColor clearColor];
        self.messageBtn.layer.cornerRadius = 0;
    }else if (messageModel.cellType == CSCellType_Right) {
        
        image = [UIImage imageNamed:@"sci-fi_chat_right"];
        self.messageBtn.backgroundColor = [UIColor clearColor];
        self.messageBtn.layer.cornerRadius = 0;
    }else{
        self.messageBtn.layer.cornerRadius = 20;
        self.messageBtn.layer.masksToBounds = YES;
        self.messageBtn.backgroundColor = CoCo_Color(@"e4e6e9");
    }
    [self.messageBtn setBackgroundImage:image forState:UIControlStateNormal];
}
- (void)setChatImage:(CSMessageModel *)messageModel
{
    //设置图片
    if (messageModel.imageFile) {
        
        self.messageBtn.userInteractionEnabled = YES;
        self.messageBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.messageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:messageModel.imageFile.url];
        if (!image) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:messageModel.imageFile.url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                
                [[SDImageCache sharedImageCache] storeImage:image forKey:messageModel.imageFile.url toDisk:YES completion:^{
                    
                    [self.messageBtn setImage:image forState:UIControlStateNormal];
                }];
                
            }];
        }else{
            
            [self.messageBtn setImage:image forState:UIControlStateNormal];
            
        }
    }else{
        
        [self.messageBtn setImage:nil forState:UIControlStateNormal];
    }
}
- (CSTextView *)textView{
    //文本
    if (!_textView) {
        _textView = [[CSTextView alloc]init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.userInteractionEnabled = NO;
        [self.messageBtn addSubview:_textView];
    }
    return _textView;
}
@end
