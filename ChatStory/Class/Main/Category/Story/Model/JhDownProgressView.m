//
//  JhDownProgressView.m
//  PersonalWage
//
//  Created by Jh on 2018/12/3.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "JhDownProgressView.h"

#define Kwidth  [UIScreen mainScreen].bounds.size.width
#define Kheight  [UIScreen mainScreen].bounds.size.height
#define JhColorAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define JhColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JhRandomColor JhColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))


/** 文字顶部底部间距 */
#define KMargin 15

#define KProgressBorderWidth 2.0f
#define KProgressPadding 1.0f
/** 长条形颜色 */
#define KProgressColor_rectangle [UIColor orangeColor]

@interface JhDownProgressView()

/** 百分百文字 */
@property (nonatomic, strong) UILabel *percentTextLabel;
/** 提示文字 */
@property (nonatomic, strong) UILabel *TextLabel;
/** 长条样式view */
@property (nonatomic, strong) UIView *rectangleView;


@end

@implementation JhDownProgressView



-(UILabel *)percentTextLabel{
    if (!_percentTextLabel) {
        
        UILabel *textLable = [[UILabel alloc]init];
        textLable.text = @"0%";
        textLable.textColor = _progressBarColor;
        textLable.font = [UIFont systemFontOfSize:13];
        textLable.textAlignment = NSTextAlignmentCenter;
        textLable.frame = self.bounds;
        _percentTextLabel = textLable;
        [self addSubview:self.percentTextLabel];

    }
    return _percentTextLabel;
}


-(UILabel *)TextLabel{
    if (!_TextLabel) {
        
        UILabel *textLable = [[UILabel alloc]init];
        textLable.text = @"正在下载...";
        textLable.textColor = _progressBarColor;
        textLable.font = [UIFont systemFontOfSize:15];
        textLable.textAlignment = NSTextAlignmentCenter;

        CGFloat textHeight = 25;
        CGFloat FrameWidth = self.bounds.size.width;
        CGFloat FrameHeight = self.bounds.size.height;
        
        textLable.frame = CGRectMake(0,FrameHeight-textHeight-KMargin, FrameWidth, textHeight);

        _TextLabel = textLable;
        [self addSubview:self.TextLabel];
        
        
    }
    return _TextLabel;
}

-(void)initDataAndSubviews{
    
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    self.progressBarColor = [UIColor whiteColor];
    self.progressViewBgColor = JhColor(45, 45, 45);
    self.backgroundColor =_progressViewBgColor;
    
    self.progressWidth = 5;
    _jhDownProgressViewStyle = JhStyle_percentAndText;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self initDataAndSubviews];
    
    }
    return self;
}


- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (_jhDownProgressViewStyle ==JhStyle_percentAndText || _jhDownProgressViewStyle == JhStyle_percentAndRing) {
        
     self.percentTextLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
        
    }else if (_jhDownProgressViewStyle ==JhStyle_Ring) {
        
        
    }else  if (_jhDownProgressViewStyle ==JhStyle_Sector) {

        
    }else if(_jhDownProgressViewStyle ==JhStyle_Rectangle){
        
        CGFloat margin = KProgressBorderWidth + KProgressPadding;
        CGFloat maxWidth = self.bounds.size.width - margin * 2;
        CGFloat heigth = self.bounds.size.height - margin * 2;
        self.rectangleView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
        
    }else if(_jhDownProgressViewStyle ==JhStyle_ball){
        
        self.percentTextLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
    }
    
    if (_progress >= 1.0) {
        [self removeFromSuperview];
    } else {
        [self setNeedsDisplay];
    }
    
}

-(void)setProgressWidth:(CGFloat)progressWidth{
    
    _progressWidth = progressWidth;
    [self setNeedsDisplay];
 
}

-(void)setProgressViewBgColor:(UIColor *)progressViewBgColor{
    _progressViewBgColor = progressViewBgColor;
}
-(void)setProgressBarColor:(UIColor *)progressBarColor{
    _progressBarColor = progressBarColor;
}
- (void)setJhDownProgressViewStyle:(JhDownProgressViewStyle)jhDownProgressViewStyle{
    
    _jhDownProgressViewStyle = jhDownProgressViewStyle;
    
    switch (_jhDownProgressViewStyle) {
            
            /** 百分百和文字 默认 */
        case JhStyle_percentAndText:
        {
            [self percentTextLabel];
            [self TextLabel];
        }
            break;
            
            /** 百分百和圆环 */
        case JhStyle_percentAndRing:
        {
            [self percentTextLabel];
        }
            break;
            
            /** 圆环 */
        case JhStyle_Ring:
        {
            
        }
            break;
            
            /** 扇形 */
        case JhStyle_Sector:
        {
             self.backgroundColor = JhColorAlpha(240, 240, 240, 0.9);
        }
            break;
            
            /** 长方形 */
        case JhStyle_Rectangle:
        {
             
             self.backgroundColor = JhColorAlpha(240, 240, 240, 0.9);
            
            /********************************* 长条形样式 ********************************/
            //底部边框
            UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
            borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
            borderView.layer.masksToBounds = YES;
            borderView.backgroundColor = _progressViewBgColor;
            borderView.layer.borderColor = [JhColorAlpha(240, 240, 240, 0.9) CGColor];
            borderView.layer.borderWidth = KProgressBorderWidth;
            
            [self addSubview:borderView];
            //进度
            UIView *rectangleView = [[UIView alloc] init];
            rectangleView.backgroundColor = _progressBarColor;
            rectangleView.layer.cornerRadius = (self.bounds.size.height - (KProgressBorderWidth + KProgressPadding) * 2) * 0.5;
            rectangleView.layer.masksToBounds = YES;
            [self addSubview:rectangleView];
            
            self.rectangleView = rectangleView;
            
            /********************************* 长条形样式 ********************************/
        }
            break;
            
            /** 球 */
        case JhStyle_ball:
        {
          [self percentTextLabel];
        }
            break;
            
        default:
            break;
    }
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect
{
    
    switch (_jhDownProgressViewStyle) {
            
        case JhStyle_percentAndText:
        {
            [self JhStyle_percentAndText:rect];
        }
            break;
            
        case JhStyle_percentAndRing:
        {
            [self JhStyle_percentAndRing:rect];
            
        }
            break;
            
        case JhStyle_Ring:
        {
             [self JhStyle_Ring:rect];
        }
            break;
            
        case JhStyle_Sector:
        {
             [self JhStyle_Sector:rect];
        }
            break;
            
        case JhStyle_Rectangle:
        {
            
        }
            break;
            
        case JhStyle_ball:
        {
            [self JhStyle_ball:rect];
        }
            break;
            
        default:
            break;
    }
    
}



#pragma mark - 百分百和文字 (默认)
-(void)JhStyle_percentAndText:(CGRect)rect{
    
    //    //  x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    //    // CGContextAddArc(<#CGContextRef  _Nullable c#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#int clockwise#>)
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.25 + KMargin;

    [_progressBarColor set];

    //设置圆环的宽度
    CGContextSetLineWidth(ctx, _progressWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
    //半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.3 - KMargin;
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextStrokePath(ctx);

    CGFloat FrameWidth = self.bounds.size.width;
    self.percentTextLabel.frame = CGRectMake(0, yCenter-10, FrameWidth, 20);
    
}




#pragma mark - 百分百和圆环
-(void)JhStyle_percentAndRing:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    [_progressBarColor set];
    
    //设置圆环的宽度
    CGContextSetLineWidth(ctx, _progressWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
    //半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.4 - KMargin;
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextStrokePath(ctx);

    CGFloat FrameWidth = self.bounds.size.width;
    self.percentTextLabel.frame = CGRectMake(0, yCenter-10, FrameWidth, 20);
    
}


#pragma mark - 圆环
-(void)JhStyle_Ring:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    [_progressBarColor set];
    
    //设置圆环的宽度
    CGContextSetLineWidth(ctx, _progressWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
    //半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.4 - KMargin;
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextStrokePath(ctx);
  
}


#pragma mark - 扇形
-(void)JhStyle_Sector:(CGRect)rect{
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - KMargin;
    //背景遮罩
    [_progressViewBgColor set];
    
    CGFloat lineW = MAX(rect.size.width, rect.size.height) * 0.5;
    CGContextSetLineWidth(context, lineW);
    CGContextAddArc(context, xCenter, yCenter, radius + lineW * 0.5 + 5, 0, M_PI * 2, 1);
    CGContextStrokePath(context);

    //进程圆(圆环)
//    [_progressViewBgColor set];
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, xCenter, yCenter);
    CGContextAddLineToPoint(context, xCenter, 0);
    CGFloat endAngle = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001;
    CGContextAddArc(context, xCenter, yCenter, radius, - M_PI * 0.5, endAngle, 1);
    CGContextFillPath(context);
    
    
}

#pragma mark - 球形
-(void)JhStyle_ball:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    [_progressBarColor set];
    
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - KMargin;
    
    //画椭圆
    CGFloat w = radius * 2;
//    CGFloat w = radius * 2 + 10;
    CGFloat h = w;
    CGFloat x = (rect.size.width - w) * 0.5;
    CGFloat y = (rect.size.height - h) * 0.5;
    CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
    CGContextFillPath(ctx);
    
    [[UIColor grayColor] set];
    CGFloat startAngle = M_PI * 0.5 - self.progress * M_PI;
    CGFloat endAngle = M_PI * 0.5 + self.progress * M_PI;
    CGContextAddArc(ctx, xCenter, yCenter, radius, startAngle, endAngle, 0);
    CGContextFillPath(ctx);
    
    CGFloat FrameWidth = self.bounds.size.width;
    self.percentTextLabel.frame = CGRectMake(0, yCenter-10, FrameWidth, 20);

}



/**
 * 弹出视图
 */
+ (id)show{
    
    CGFloat width = 150;
    CGFloat height = 120;
    CGRect frame = CGRectMake((Kwidth-width)/2,(Kheight-height)/2, width, height);
    return [[self alloc]initWithFrame:frame];

}

/**
 * 创建指定样式的下载进度条
 */
+ (id)showWithStyle:(JhDownProgressViewStyle)ViewStyle{
    
    
    CGFloat width = 150;
    CGFloat height = 120;
    
    if (ViewStyle ==JhStyle_Rectangle) {
        
        width = 150;
        height = 15;
        
    }
   
    CGRect frame = CGRectMake((Kwidth-width)/2,(Kheight-height)/2, width, height);
    JhDownProgressView *progress = [[self alloc]initWithFrame:frame];
    progress.jhDownProgressViewStyle = ViewStyle;
    
    
    return progress;
    
}


- (void)dismiss
{
   self.progress = 1.0;
}



@end
