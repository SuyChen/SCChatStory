//
//  CSStoryMessageController.m
//  ChatStory
//
//  Created by CSY on 2018/12/12.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSStoryMessageController.h"
#import "CSComedyTableViewCell.h"
#import "CSRomanceTableViewCell.h"
#import "CSMysteryTableViewCell.h"
#import "CSHorrorTableViewCell.h"
#import "CSSicenceTableViewCell.h"
#import "CSAudioPlayer.h"


@interface CSStoryMessageController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *title_lb;
@property (nonatomic, strong) NSMutableArray *dataArray;//模型数组
@property (nonatomic, assign) NSInteger index;//当前播放条数
@property (nonatomic, assign) CGFloat oldContentOffsetY;//控制table滑动隐藏
@property (weak, nonatomic) IBOutlet UIView *Topview;//导航
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;//进度条
@property (weak, nonatomic) IBOutlet UIButton *audio_btn;//声音开关
//下一张view
@property (weak, nonatomic) IBOutlet UIView *nextView;
@property (weak, nonatomic) IBOutlet UILabel *next_lb;
@property (weak, nonatomic) IBOutlet UIButton *next_btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextViewHeightConstraint;
@property (nonatomic, strong) CSAudioPlayer *audioPlayer;//语音播放器
@property (nonatomic, strong) NSArray *audioTimeArray;//播放语音的时间数组
@property (nonatomic, assign) BOOL isOpen;//控制声音开关
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CSStoryMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSMutableArray array];
    [self configUI];
    [self configUIWithData:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadSuccess:) name:@"downLoadSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackgrounds) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveReading];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark == configUI
- (void)configUI
{
    //防止闪屏
    self.table.estimatedRowHeight = 0;
    //把系统的进度条放大
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 2.0f);
    //结束的弹出框适配
    self.nextViewHeightConstraint.constant =  120 + CSY_SafeBottomHeight;
    [self.nextView layoutIfNeeded];
    self.nextView.transform = CGAffineTransformMakeTranslation(0, 120 + CSY_SafeBottomHeight);
    //初始化语音播放器
    self.audioPlayer = [[CSAudioPlayer alloc] init];
    
    if ([self.storyModel.story.genre isEqualToString:@"Romance"] || [self.storyModel.story.genre isEqualToString:@"Mystery"] || [self.storyModel.story.genre isEqualToString:@"Horror"]) {
        self.table.backgroundColor = CoCo_Color(@"252525");
    }else{
        self.table.backgroundColor = CoCo_Color(@"F1F3F6");
    }
    if ([self.storyModel.story.badge.text isEqualToString:@"AUDIO"]) {
        self.audio_btn.hidden = NO;
    }else{
        self.audio_btn.hidden = YES;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.table addGestureRecognizer:tap];
    [self.table registerClass:[CSComedyTableViewCell class] forCellReuseIdentifier:@"CSComedyTableViewCell"];
    [self.table registerClass:[CSRomanceTableViewCell class] forCellReuseIdentifier:@"CSRomanceTableViewCell"];
    [self.table registerClass:[CSMysteryTableViewCell class] forCellReuseIdentifier:@"CSMysteryTableViewCell"];
    [self.table registerClass:[CSSicenceTableViewCell class] forCellReuseIdentifier:@"CSSicenceTableViewCell"];
    [self.table registerClass:[CSHorrorTableViewCell class] forCellReuseIdentifier:@"CSHorrorTableViewCell"];
}
- (void)configUIWithData:(BOOL)isNext
{
    if (isNext) {
        self.storyModel = [CSDataHelper getNextModelWithLastModel:self.storyModel];
    }else {
        
        self.storyModel = [CSDataHelper getReadingWithStoryModel:self.storyModel];
    }
    self.audioTimeArray = [self.storyModel.story.audioSynchronizationData componentsSeparatedByString:@","];
    self.title_lb.text = self.storyModel.story.seriesTitle;
    self.index = self.storyModel.story.currentIndex;
    for (NSInteger i = 0; i < self.index + 1; i++) {
        CSMessageModel *message = self.storyModel.messages[i];
        CSMessageFrame *messageFrame = [[CSMessageFrame alloc] init];
        [messageFrame setMessage:message];
        [self.dataArray addObject:messageFrame];
    }
    [self.table reloadData];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
    [self updateReadingProgress];
}

#pragma mark == UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count) {
        return CSY_HEIGHT / 3;
    }
    CSMessageFrame *model = self.dataArray[indexPath.row];
    return model.cell_h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    CSMessageFrame *model = self.dataArray[indexPath.row];
    if ([self.storyModel.story.genre isEqualToString:@"Romance"]) {
        CSRomanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSRomanceTableViewCell" forIndexPath:indexPath];
        cell.messageFrame = model;
        [self displayTableviewCell:cell withAnimationAtIndexPath:indexPath];
        return cell;
    }else if ([self.storyModel.story.genre isEqualToString:@"Mystery"]) {
        CSMysteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSMysteryTableViewCell" forIndexPath:indexPath];
        cell.messageFrame = model;
        [self displayTableviewCell:cell withAnimationAtIndexPath:indexPath];
        return cell;
    }else if ([self.storyModel.story.genre isEqualToString:@"Horror"]) {
        CSHorrorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSHorrorTableViewCell" forIndexPath:indexPath];
        cell.messageFrame = model;
        [self displayTableviewCell:cell withAnimationAtIndexPath:indexPath];
        return cell;
    }else if ([self.storyModel.story.genre isEqualToString:@"Comedy"]) {
        CSComedyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSComedyTableViewCell" forIndexPath:indexPath];
        cell.messageFrame = model;
        [self displayTableviewCell:cell withAnimationAtIndexPath:indexPath];
        return cell;
    }else{
        CSSicenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSSicenceTableViewCell" forIndexPath:indexPath];
        cell.messageFrame = model;
        [self displayTableviewCell:cell withAnimationAtIndexPath:indexPath];
        return cell;
    }
}
#pragma mark == scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.dragging) {
        self.isOpen = YES;
        [self CSClickAudio:nil];
        if ([scrollView isEqual: self.table]) {
            if (self.table.contentOffset.y > self.oldContentOffsetY) {
                // 上滑
                [UIView animateWithDuration:0.5 animations:^{
                    self.Topview.alpha = 0;
                    self.progressView.alpha = 0;
                }];
            }
            else{
                // 下滑
                [UIView animateWithDuration:0.5 animations:^{
                    self.Topview.alpha = 1;
                    self.progressView.alpha = 1;
                }];
                
            }
        }
    }
    
  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    self.oldContentOffsetY = self.table.contentOffset.y;
    
}
#pragma mark == tool
- (void)displayTableviewCell:(UITableViewCell *)cell withAnimationAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        cell.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            cell.alpha = 1;
        }];
    }
}
//更新table
- (void)controlTableFrame
{
    [self.table reloadData];
    [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}
//下载成功后开始播放对话
- (void)downLoadSuccess:(NSNotification *)note
{
    NSNumber *isSuccess = note.object;
    if (!isSuccess.boolValue) {
        //下载失败
        [self CSClickAudio:nil];
    }else{
        
        [self autoAddDialogue];
    }
}
- (void)autoAddDialogue
{
    [self addMessage];
    //防止数组越界
    if (self.index + 1 >= self.audioTimeArray.count) {
        //特殊处理语音最后一段
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addMessage];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self addMessage];
            });
        });
        
    }else{
        NSString *str = self.audioTimeArray[self.index];
        NSString *str0 = self.audioTimeArray[self.index + 1];
        [self createTimerWithTime:str0.doubleValue - str.doubleValue];
    }
}
- (void)createTimerWithTime:(NSTimeInterval)time
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(autoAddDialogue) userInfo:nil repeats:NO];
}
#pragma mark == notification
- (void)appDidEnterBackgrounds
{
    [self saveReading];
}
//更新阅读进度
- (void)updateReadingProgress
{
    self.progressView.progress = 1.0 * self.index / self.storyModel.messages.count;
}
//保存数据
- (void)saveReading
{
    //如果读完了则不保存
    if (self.index >= self.storyModel.messages.count) {
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:CSReadingRecords];
        NSMutableArray *mutaArr = [CSStoryModel mj_objectArrayWithKeyValuesArray:arr];
        for (NSInteger i = 0; i < mutaArr.count; i++) {
            CSStoryModel *model = mutaArr[i];
            if ([model.story.uid isEqualToString:self.storyModel.story.uid]) {
                [mutaArr removeObject:model];
                break;
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:[CSStoryModel mj_keyValuesArrayWithObjectArray:mutaArr.copy].copy forKey:CSReadingRecords];
    }else{
        
        self.storyModel.story.currentIndex = self.index;
        [CSDataHelper saveReadingWithStoryModel:self.storyModel];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CSUpdateMyReading object:nil];
}
#pragma mark == Click
- (IBAction)CSClickAudio:(id)sender {
    
    if (!self.isOpen) {
        
        [self.audio_btn setImage:[UIImage imageNamed:@"CS_reading_audio_on"] forState:UIControlStateNormal];
        self.isOpen = YES;
        CSAudioModel *model = [[CSAudioModel alloc] init];
        model.url = self.storyModel.story.audioSoundFileUrl;
        model.uid = self.storyModel.story.uid;
        NSString *str = self.audioTimeArray[self.index];
        model.currentTime = str.doubleValue;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playAudio" object:nil userInfo:@{@"audio":model}];
        
    }else{
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        [self.audio_btn setImage:[UIImage imageNamed:@"CS_reading_audio_off"] forState:UIControlStateNormal];
        self.isOpen = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAudio" object:nil];
    }
    
}

- (void)CSClickTopView{
    [UIView animateWithDuration:0.5 animations:^{
        self.Topview.alpha = 0;
        self.progressView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)CSClickPop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//点击屏幕
- (void)tapScreen
{
    if (!self.isOpen) {
        
        [self addMessage];
    }
}

- (void)addMessage
{
    if (self.progressView.alpha == 1) {
        [self CSClickTopView];
    }
    self.index++;
    //判断是否结束
    if (self.index >= self.storyModel.messages.count) {
        
        [self finishReading];
        
    }else{
        
        CSMessageModel *message = self.storyModel.messages[self.index];
        CSMessageFrame *messageFrame = [[CSMessageFrame alloc] init];
        [messageFrame setMessage:message];
        [self.dataArray addObject:messageFrame];
        [self controlTableFrame];
        [self updateReadingProgress];
    }
    
}
//读完当前章节
- (void)finishReading
{
    [self saveReading];
    if (self.storyModel.story.episodeIndex == self.storyModel.story.episodeCount) {
        self.next_lb.text = @"The End";
        self.next_btn.hidden = YES;
    }else{
        self.next_lb.text = @"Next episode";
        self.next_btn.hidden = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.nextView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}
//下一章
- (IBAction)CSClickToNextPage:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.nextView.transform = CGAffineTransformMakeTranslation(0, 120 + CSY_SafeBottomHeight);
    } completion:^(BOOL finished) {
//        self.storyModel = [CSDataHelper getNextModelWithLastModel:self.storyModel];
        [self.dataArray removeAllObjects];
        
        [self configUIWithData:YES];
    }];
}

@end
