//
//  CSMessageFrame.m
//  ChatStory
//
//  Created by CSY on 2018/12/13.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSMessageFrame.h"

//名字与屏幕的左右间距
static NSInteger const kname_horizontal_margin = 15;
//名字与屏幕的上下间距
static NSInteger const kname_Top_margin = 25;
//name
//名字高度
static NSInteger const kChat_name_h = 15;

@implementation CSMessageFrame
- (void)setMessage:(CSMessageModel *)message
{
    _message = message;
    
    switch (message.storyType) {
        case CSStoryType_Romance:
        {
            [self setRomanceMessage:message];
        }
            break;
        case CSStoryType_Comedy:
        {
            [self setComedyMessage:message];
        }
            break;
        case CSStoryType_Horror:
        {
            [self setMysteryMessage:message];
        }
            break;
        case CSStoryType_Mystery:
        {
            [self setMysteryMessage:message];
        }
            break;
        case CSStoryType_Science:
        {
            [self setComedyMessage:message];
        }
            break;
            
        default:
            break;
    }
}
- (void)setComedyMessage:(CSMessageModel *)message
{
    CSCellType cellType = self.message.cellType;
    
    CGFloat content_y = 0;
    content_y = kname_Top_margin;
    
    // 计算整体聊天气泡的Size
    CGSize contentSize = CGSizeZero;
    //判断消息类型
    if (self.message.imageFile) {
        
        contentSize = CGSizeMake(200, 250);
        
    }else{
        
        UIFont *font = nil;
        if (cellType == CSCellType_Middle) {
            font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
        }else{
            font = [UIFont systemFontOfSize:15];
        }
        contentSize = [message.text sc_calculateSizeInFont:font withStableSize:CGSizeMake(260, CGFLOAT_MAX)];
        //其他微调
        if (font.lineHeight < kChat_Romance_min_h) {//为了使聊天内容与最小高度对齐
            contentSize.height += (kChat_Romance_min_h - font.lineHeight);
        }else{
            contentSize.height += 2*kChat_margin;
        }
        contentSize.width += 2*kChat_margin;
    }
    
    CGFloat content_x = 0;
    if (cellType == CSCellType_Middle) {
        
        content_x = (CSY_WIDTH - contentSize.width) / 2;
        
    }else{
        if (cellType == CSCellType_Left) {
            
            content_x = kname_horizontal_margin;
        }else{
            content_x = CSY_WIDTH - kname_horizontal_margin - contentSize.width;
        }
    }
    //聊天气泡frame
    _contentF = CGRectMake(content_x, content_y, contentSize.width, contentSize.height);
    
    //计算名字
    CGFloat name_x = 0;
    if (cellType == CSCellType_Left) {
        
        name_x  = kname_horizontal_margin;
        
    }else if (cellType == CSCellType_Right){
        
        name_x = CSY_WIDTH - kname_horizontal_margin;
    }
    _nameF = CGRectMake(name_x, CGRectGetMaxY(_contentF) + 5, CSY_WIDTH - 2 * name_x, kChat_name_h);
    
    //cell高度
    _cell_h = CGRectGetMaxY(_nameF);
    
}
- (void)setMysteryMessage:(CSMessageModel *)message
{
    CSCellType cellType = self.message.cellType;
    
    // 计算整体聊天气泡的Size
    CGSize contentSize = CGSizeZero;
    //判断消息类型
    if (self.message.imageFile) {
        
        contentSize = CGSizeMake(200, 250);
        
    }else{
        
        UIFont *font = nil;
        if (cellType == CSCellType_Middle) {
            font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
        }else{
            font = [UIFont systemFontOfSize:15];
        }
        contentSize = [message.text sc_calculateSizeInFont:font withStableSize:CGSizeMake(260, CGFLOAT_MAX)];
        //其他微调
        if (font.lineHeight < kChat_Romance_min_h) {//为了使聊天内容与最小高度对齐
            contentSize.height += (kChat_Romance_min_h - font.lineHeight);
        }else{
            contentSize.height += 2*kChat_margin;
        }
        contentSize.width += 2*kChat_margin;
    }
    
    if (contentSize.width < 100) {
        contentSize.width = 100;
    }
    CGFloat content_y = kname_Top_margin;
    CGFloat content_x = 0;
    if (cellType == CSCellType_Middle) {
        
        content_x = (CSY_WIDTH - contentSize.width) / 2;
        
        //聊天气泡frame
        _contentF = CGRectMake(content_x, content_y, contentSize.width, contentSize.height);
        //cell高度
        _cell_h = CGRectGetMaxY(_contentF);
        
    }else{
        if (cellType == CSCellType_Left) {
            
            content_x = kname_horizontal_margin;
        }else{
            content_x = CSY_WIDTH - kname_horizontal_margin - contentSize.width;
        }
        //name所占高度
        contentSize.height += 20;
        
        //聊天气泡frame
        _contentF = CGRectMake(content_x, content_y, contentSize.width, contentSize.height);
        //cell高度
        _cell_h = CGRectGetMaxY(_contentF);
    }
}


- (void)setRomanceMessage:(CSMessageModel *)message
{
    CSCellType cellType = self.message.cellType;
    
    CGFloat content_y = 0;
    CGFloat name_x = 0;
    content_y = kname_Top_margin;
    //计算名字
    if (cellType == CSCellType_Left) {
        
        name_x  = kname_horizontal_margin;
        
    }else if (cellType == CSCellType_Right){
        
        name_x = CSY_WIDTH - kname_horizontal_margin;
    }
    _nameF = CGRectMake(name_x, content_y, CSY_WIDTH - 2 * name_x, kChat_name_h);
    // 计算整体聊天气泡的Size
    CGSize contentSize = CGSizeZero;
    //判断消息类型
    if (self.message.imageFile) {
        
        contentSize = CGSizeMake(200, 250);
        
    }else{
        
        UIFont *font = nil;
        if (cellType == CSCellType_Middle) {
            font = [UIFont fontWithName:@"Helvetica-Oblique" size:15];
        }else{
            font = [UIFont systemFontOfSize:15];
        }
        contentSize = [message.text sc_calculateSizeInFont:font withStableSize:CGSizeMake(260, CGFLOAT_MAX)];
        //其他微调
        if (font.lineHeight < kChat_Romance_min_h) {//为了使聊天内容与最小高度对齐
            contentSize.height += (kChat_Romance_min_h - font.lineHeight);
        }else{
            contentSize.height += 2*kChat_margin;
        }
        contentSize.width += 2*kChat_margin;
    }
    
    CGFloat content_x = 0;
    if (cellType == CSCellType_Middle) {
        
        content_x = (CSY_WIDTH - contentSize.width) / 2;
        
        //聊天气泡frame
        _contentF = CGRectMake(content_x, content_y, contentSize.width, contentSize.height);
        //cell高度
        _cell_h = CGRectGetMaxY(_contentF);
        
    }else{
        if (cellType == CSCellType_Left) {
            
            content_x = name_x;
        }else{
            content_x = name_x - contentSize.width;
        }
        content_y = CGRectGetMaxY(_nameF) + 7;
        //聊天气泡frame
        _contentF = CGRectMake(content_x, content_y, contentSize.width, contentSize.height);
        //cell高度
        _cell_h = CGRectGetMaxY(_contentF);
    }
}
@end
