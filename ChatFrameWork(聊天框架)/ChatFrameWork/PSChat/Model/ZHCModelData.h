//
//  ZHCModelData.h
//  ZHChat
//
//  Created by aimoke on 16/8/10.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHCMessages.h"
#import "ZHCLocationMediaItem.h"
@class ZHCPhotoMediaItem;



static NSString * const kZHCDemoAvatarDisplayNameCook = @"Tim Cook";
static NSString * const kZHCDemoAvatarDisplayNameJobs = @"Jobs";

static NSString * const kZHCDemoAvatarIdCook = @"468-768355-23123";
static NSString * const kZHCDemoAvatarIdJobs = @"707-8956784-57";


@interface ZHCModelData : NSObject
@property (strong, nonatomic) NSMutableArray *messages;//消息数组
@property (strong, nonatomic) NSDictionary *avatars;//图片数据
@property (strong, nonatomic) NSDictionary *users;//名字
@property (strong, nonatomic) ZHCMessagesBubbleImage *outgoingBubbleImageData;//发送的泡泡view

@property (strong, nonatomic) ZHCMessagesBubbleImage *incomingBubbleImageData;//接收的paopaoview


- (void)addPhotoMediaMessage;//添加图片消息
- (void)addLocationMediaMessageCompletion:(ZHCLocationMediaItemCompletionBlock)completion;//添加地理位置消息
- (void)addVideoMediaMessage;//添加Video消息
- (void)addAudioMediaMessage;//添加音频消息

@end
