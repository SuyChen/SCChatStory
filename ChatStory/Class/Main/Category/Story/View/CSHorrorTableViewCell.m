//
//  CSHorrorTableViewCell.m
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSHorrorTableViewCell.h"
#import "CSTextView.h"

@interface CSHorrorTableViewCell ()
@property (nonatomic, strong) CSTextView *textView;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UIButton *messageBtn;
@end
@implementation CSHorrorTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setMessageFrame:(CSMessageFrame *)messageFrame
{
    CSMessageModel *messageModel = messageFrame.message;
    
    self.nameLb.text = messageModel.sender.name;
    self.messageBtn.frame = messageFrame.contentF;
    self.textView.text = messageModel.text;
    
    if (messageModel.cellType == CSCellType_Left) {
        
        self.nameLb.textAlignment = NSTextAlignmentLeft;
        self.nameLb.textColor = CoCo_Color(@"4A90E2");
        self.textView.textColor = CoCo_Color(@"333333");
        self.textView.font = [UIFont systemFontOfSize:15];
        
    }else if (messageModel.cellType == CSCellType_Right){
        
        self.nameLb.textAlignment = NSTextAlignmentRight;
        self.nameLb.textColor = CoCo_Color(@"B61B1B");
        self.textView.textColor = CoCo_Color(@"333333");
        self.textView.font = [UIFont systemFontOfSize:15];
        
    }else{
        self.nameLb.textAlignment = NSTextAlignmentCenter;
        self.textView.font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
        self.textView.textColor = CoCo_Color(@"C0C0C0");
    }
    
    [self setTextFrame:messageModel];
    
    [self setChatBackground:messageModel];
    
    [self setChatImage:messageModel];
    
}
//设置frame
- (void)setTextFrame:(CSMessageModel *)messageModel
{
    CGFloat name_h = 20;
    if (messageModel.cellType == CSCellType_Middle) {
        name_h = 0;
    }
    CGFloat name_x = kChat_margin;
    CGFloat name_y = 0;
    UIFont *font = [UIFont systemFontOfSize:15];
    if (font.lineHeight < kChat_Romance_min_h) {//为了使聊天内容与最小高度对齐
        name_y =  (kChat_Romance_min_h - font.lineHeight)/2;
    }
    self.nameLb.frame = CGRectMake(name_x, name_y, self.messageBtn.frame.size.width - 2*name_x, name_h);
    self.textView.frame = CGRectMake(kChat_margin, CGRectGetMaxY(self.nameLb.frame), self.messageBtn.frame.size.width - 2*kChat_margin, self.messageBtn.frame.size.height - 2*name_y - name_h);
}
// 设置聊天气泡背景
- (void)setChatBackground:(CSMessageModel *)messageModel
{
    UIImage *image = nil;
    if (messageModel.cellType == CSCellType_Left) {
        image = [UIImage imageNamed:@"thriller_chat_l_and_r"];
        self.messageBtn.layer.cornerRadius = 0;
        self.messageBtn.backgroundColor = [UIColor clearColor];
        
    }else if (messageModel.cellType == CSCellType_Right) {
        image = [UIImage imageNamed:@"thriller_chat_l_and_r"];
        self.messageBtn.layer.cornerRadius = 0;
        self.messageBtn.backgroundColor = [UIColor clearColor];
    }else{
        self.messageBtn.layer.cornerRadius = 20;
        self.messageBtn.layer.masksToBounds = YES;
        self.messageBtn.backgroundColor = CoCo_Color(@"3b3b3b");
    }
    [self.messageBtn setBackgroundImage:image forState:UIControlStateNormal];
}
- (void)setChatImage:(CSMessageModel *)messageModel
{
    //设置图片
    if (messageModel.imageFile) {
        
        self.messageBtn.userInteractionEnabled = YES;
        self.messageBtn.imageEdgeInsets = UIEdgeInsetsMake(30, 10, 10, 10);
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

#pragma mark == getter
- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont fontWithName:@"Futura-Medium" size:12];
        [self.messageBtn addSubview:_nameLb];
    }
    return _nameLb;
}
- (UIButton *)messageBtn
{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_messageBtn];
    }
    return _messageBtn;
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
