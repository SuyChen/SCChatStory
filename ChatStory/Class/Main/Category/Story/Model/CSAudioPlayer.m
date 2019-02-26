//
//  CSAudioPlayer.m
//  ChatStory
//
//  Created by CSY on 2018/12/14.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "JhDownProgressView.h"

#define AudioMaterialPlistPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Audio"]

@interface CSAudioPlayer ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) CSAudioModel *audioModel;
@property (nonatomic, assign) float voiceVolume;
@property (nonatomic, strong) JhDownProgressView *downloadProgress;
@end
@implementation CSAudioPlayer
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)init
{
    if (self = [super init]) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:AudioMaterialPlistPath]) {
             [[NSFileManager defaultManager] createDirectoryAtPath:AudioMaterialPlistPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playAudio:) name:@"playAudio" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAudio) name:@"stopAudio" object:nil];
        self.voiceVolume = 1.0;
    }
    return self;
}
#pragma mark - 播放音频
- (void)playAudio:(NSNotification *)notification
{
    CSAudioModel *audio = notification.userInfo[@"audio"];
    self.audioModel = audio;
}
- (void)stopAudio
{
    
    [self.audioPlayer stop];
    self.audioModel = nil;
}
#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.audioModel = nil;
}

#pragma mark - Setters
- (void)setAudioModel:(CSAudioModel *)audioModel
{
    _audioModel = audioModel;
    
    if (audioModel) {
        [self.audioPlayer stop];
        
        //查找音频文件
       NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Audio"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.MP3",audioModel.uid]];
        BOOL isfileExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (isfileExist) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"downLoadSuccess" object:@(1)];
            [self prepareToPlay:path];
           
        }else{
            
            [CSLoadingView showAlertString:@"Downloading..."];
            [[CSCommonUtil currentVC].view addSubview:self.downloadProgress];
            [CSCommonUtil currentVC].view.userInteractionEnabled = NO;
            [CSCommonUtil currentNC].navigationBar.userInteractionEnabled=NO;
            [self downloadAudioWithAudioModel:self.audioModel];
            
        }
        
    }
}

- (void)prepareToPlay:(NSString *)url
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:url] error:&error];
    self.audioPlayer.delegate =self;
    self.audioPlayer.currentTime = self.audioModel.currentTime;
    [self.audioPlayer prepareToPlay];
    if (error) {
        NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
    }
    //开始播放
    [self.audioPlayer play];
}

- (void)downloadAudioWithAudioModel:(CSAudioModel *)model
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:AudioMaterialPlistPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:AudioMaterialPlistPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.url]];
    
    CSYWeakSelf(weakSelf);
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        __block CGFloat progress =  1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Progress" object:@(progress)];
        NSLog(@"%f",progress);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{//只留下主线程返回的进度数据
            
            weakSelf.downloadProgress.progress = progress;
        }];
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *path = [AudioMaterialPlistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.MP3",model.uid]];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            [CSLoadingView showAlertString:@"Download failed, please try again"];
            [weakSelf.downloadProgress removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"downLoadSuccess" object:@(0)];
        }else{
            
            [weakSelf prepareToPlay:[filePath path]];
            [weakSelf.downloadProgress removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"downLoadSuccess" object:@(1)];
        }
        [CSCommonUtil currentVC].view.userInteractionEnabled = YES;
        [CSCommonUtil currentNC].navigationBar.userInteractionEnabled=YES;
        
    }];
    [download resume];
    
}
#pragma mark == getter
- (JhDownProgressView *)downloadProgress
{
    if (!_downloadProgress) {
        _downloadProgress= [[JhDownProgressView alloc] initWithFrame:CGRectMake((CSY_WIDTH - 150) / 2, (CSY_HEIGHT - 15) / 2, 150, 15)];
        _downloadProgress.jhDownProgressViewStyle = JhStyle_Rectangle;
    }
    return _downloadProgress;
}

@end
