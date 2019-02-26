//
//  CSAudioModel.h
//  ChatStory
//
//  Created by CSY on 2018/12/14.
//  Copyright © 2018 wdys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSAudioModel : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, strong) NSString *uid;
@end

NS_ASSUME_NONNULL_END
