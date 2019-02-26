//
//  CSMessageTableViewCell.m
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSMessageTableViewCell.h"

@implementation CSMessageTableViewCell

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
#pragma mark == setter
- (void)setMessageFrame:(CSMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    CSMessageModel *messageModel = self.messageFrame.message;
    self.nameLb.frame = messageFrame.nameF;
    self.nameLb.text = messageModel.sender.name;
    self.messageBtn.frame = messageFrame.contentF;
    
    if (messageModel.cellType == CSCellType_Left) {
        self.nameLb.textAlignment = NSTextAlignmentLeft;
        
    }else if (messageModel.cellType == CSCellType_Right){
        
        self.nameLb.textAlignment = NSTextAlignmentRight;
        
    }
}
#pragma mark == getter
- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.textColor = [UIColor whiteColor];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.font = [UIFont fontWithName:@"Futura-Medium" size:12];
        [self.contentView addSubview:_nameLb];
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
@end
