//
//  JhDownProgressView.h
//  PersonalWage
//
//  Created by Jh on 2018/12/3.
//  Copyright © 2018 Jh. All rights reserved.
//

/** 

 JhDownProgressView *progressView = [JhDownProgressView showWithStyle:JhStyle_percentAndText];
 [self.view addSubview:progressView];
 
 CGFloat progressValue =  1.0 *progress.completedUnitCount/progress.totalUnitCount;
 NSLog(@" precent %f ",precent);
 progressView.progress = progressValue;
 
 */



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JhDownProgressViewStyle)
{
    /** 百分百和文字 默认 */
    JhStyle_percentAndText = 0,
    /** 百分百和圆环 */
    JhStyle_percentAndRing,
    /** 圆环 */
    JhStyle_Ring,
    /** 扇形 */
    JhStyle_Sector,
    /** 长条形 */
    JhStyle_Rectangle,
    /** 球 */
    JhStyle_ball,
    
};


@interface JhDownProgressView : UIView

/**
 下载进度,内部按1.0计算
 */
@property (nonatomic, assign) CGFloat progress;
/**
 宽度 默认10
 */
@property (nonatomic, assign) CGFloat progressWidth;

/** 进度条View背景颜色 */
@property(nonatomic,strong) UIColor *progressViewBgColor;
/** 进度条颜色 */
@property(nonatomic,strong) UIColor *progressBarColor;

@property (nonatomic, assign) JhDownProgressViewStyle jhDownProgressViewStyle;



/**
 * 创建指定样式的下载进度条
 */
+ (id)showWithStyle:(JhDownProgressViewStyle )ViewStyle;


@end

NS_ASSUME_NONNULL_END
