//
//  MMTrainOfflineHeadFrame.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOfflineHeadFrame.h"
#import "NSString+Size.h"
@implementation MMTrainOfflineHeadFrame
-(void)setViewModel:(MMTrainOfflineHeadModel *)viewModel{
    _viewModel = viewModel;
    
    
    CGFloat qrCodeFrameY = 12.0f;
    CGFloat qrCodeFrameW = 27.0f;
    CGFloat qrCodeFrameH = qrCodeFrameW;
    CGFloat qrCodeFrameX = kScreenWidth - 12.0f - qrCodeFrameW;
    _qrCodeFrame = CGRectMake(qrCodeFrameX, qrCodeFrameY,qrCodeFrameW, qrCodeFrameH);
    
    
    CGFloat titleX = 12.0f;
    CGFloat titleY = 12.0f;
    CGFloat titleW = CGRectGetMinX(_qrCodeFrame) - 5.0f - titleX;
    CGFloat titleH = [viewModel.title sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToWidth:titleW].height;
    _titleFrame = CGRectMake(titleX, titleY,titleW, titleH);

    
    CGFloat headImageX = titleX;
    CGFloat headImageY = CGRectGetMaxY(_titleFrame) + 10.0f;
    CGFloat headImageW = 25.0f;
    CGFloat headImageH = headImageW;
    _headImageFrame = CGRectMake(headImageX, headImageY, headImageW, headImageH);
    
    CGFloat userNameX = CGRectGetMaxX(_headImageFrame) + 7.0f;
    CGFloat userNameY = headImageY;
    CGFloat userNameH = headImageH;
    CGFloat userNameW = [viewModel.userName sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToHeight:userNameH].width;
    if(userNameW > 60){
        userNameW = 60.0f;
    }
    _userNameFrame = CGRectMake(userNameX, userNameY, userNameW, userNameH);
    
    CGFloat timeX = CGRectGetMaxX(_userNameFrame) + 7.0f;
    CGFloat timeY = headImageY;
    CGFloat timeH = headImageH;
    CGFloat timeW = 40.0f;
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    CGFloat dateY = headImageY;
    CGFloat dateH = headImageH;
    CGFloat dateW = 80.0f;
    CGFloat dateX = CGRectGetMaxX(_qrCodeFrame) - dateW;
    _dateFrame = CGRectMake(dateX, dateY, dateW, dateH);
    
    
    CGFloat iconH = 13.0f;
    CGFloat iconW = 13.0f;
    CGFloat iconX = CGRectGetMinX(_dateFrame) - iconW - 7.0f;
    CGFloat iconY = headImageY + (headImageH - iconH )/2;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    if(_drop){
        CGFloat contentW = titleW;
        CGFloat contentH = [viewModel.content sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToWidth:contentW].height;
        CGFloat contentX = titleX;
        CGFloat contentY = CGRectGetMaxY(_iconFrame) + 15.0f;
        _contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        _contentLines = 0.0f;
    }else{
        CGFloat contentW = titleW;
        CGFloat contentH = 38.0f;
        CGFloat contentX = titleX;
        CGFloat contentY = CGRectGetMaxY(_iconFrame) + 15.0f;
        _contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        _contentLines = 2.0f;
    }
    
    CGFloat lineW = kScreenWidth;
    CGFloat lineH = 0.5f;
    CGFloat lineX = 0.0f;
    CGFloat lineY = CGRectGetMaxY(_contentFrame) + 15.0f;
    _lineFrame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat btnDropW = kScreenWidth;
    CGFloat btnDropH = 44.0f;
    CGFloat btnDropX = 0.0f;
    CGFloat btnDropY = lineY;
    _btnDropFrame = CGRectMake(btnDropX, btnDropY, btnDropW, btnDropH);
    
    CGFloat scrollW = kScreenWidth;
    CGFloat scrollH = 70.0f;
    CGFloat scrollX = 0.0f;
    CGFloat scrollY = CGRectGetMaxY(_btnDropFrame);
    _scrollerFrame = CGRectMake(scrollX, scrollY, scrollW, scrollH);
    
    
    NSArray *segments = viewModel.segmentTitles;
    CGFloat avgW = kScreenWidth / 4.0f;
    CGFloat avgH = 50.0f;
    __block CGFloat contentW = 0.0f;
    NSMutableArray *itemTemps = [NSMutableArray new];
    [segments enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect itemFrame = CGRectMake(avgW * idx, 0.0f, avgW, avgH);
        NSValue *value = [NSValue valueWithBytes:&itemFrame objCType:@encode(CGRect)];
        [itemTemps addObject:value];
        contentW = CGRectGetMaxX(itemFrame);
    }];
    _btnFrames = [itemTemps copy];
    
    _scrollerContentSize = CGSizeMake(contentW, avgH);
    _segContentFrame = CGRectMake(0, 10.0f, contentW, avgH);
    _contentHeight  = CGRectGetMaxY(_scrollerFrame);
}

-(void)setDrop:(BOOL)drop{
    _drop = drop;
    [self refresh];
}

-(void)refresh{
    [self setViewModel:_viewModel];
}
@end

