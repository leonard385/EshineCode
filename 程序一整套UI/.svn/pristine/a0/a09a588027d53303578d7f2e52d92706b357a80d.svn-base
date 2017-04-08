//
//  MMTrainHeadFrameModel.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainHeadFrameModel.h"
#import "NSString+Size.h"
@implementation MMTrainHeadFrameModel
-(void)setViewModel:(MMTrainHeadModel *)viewModel{
    _viewModel = viewModel;
    
    if(viewModel.posterImageUrl != nil){
        CGFloat posterImageX = 0.0f;
        CGFloat posterImageY = 0.0f;
        CGFloat posterImageW = kScreenWidth;
        CGFloat posterImageH = 158.0f;
        _posterImageFrame = CGRectMake(posterImageX, posterImageY,posterImageW, posterImageH);
        _contentHeight = CGRectGetMaxY(_posterImageFrame);
    }
    
    CGFloat headImageX = 12.0f;
    CGFloat headImageY = _contentHeight + 12.0f;
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
    
    
    CGFloat dateY = headImageY;
    CGFloat dateH = headImageH;
    CGFloat dateW = 130.0f;
    CGFloat dateX = kScreenWidth - 12.0f - dateW;
    _dateFrame = CGRectMake(dateX, dateY, dateW, dateH);
    
    
    CGFloat iconH = 13.0f;
    CGFloat iconW = 13.0f;
    CGFloat iconX = CGRectGetMinX(_dateFrame) - iconW - 7.0f;
    CGFloat iconY = headImageY + (headImageH - iconH )/2;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    if(_drop){
        CGFloat contentW = kScreenWidth - 12.0f * 2.0f;
        CGFloat contentH = [viewModel.content sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToWidth:contentW].height;
        CGFloat contentX = headImageX;
        CGFloat contentY = CGRectGetMaxY(_iconFrame) + 15.0f;
        _contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        _contentLines = 0.0f;
    }else{
        CGFloat contentW = kScreenWidth - 12.0f * 2.0f;
        CGFloat contentH = 38.0f;
        CGFloat contentX = headImageX;
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
    
    CGFloat lineViewW = kScreenWidth;
    CGFloat lineViewH = 10.0f;
    CGFloat lineViewX = 0.0f;
    CGFloat lineViewY = CGRectGetMaxY(_btnDropFrame);
    _lineViewFrame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    
    _contentHeight  = CGRectGetMaxY(_lineViewFrame);
}

-(void)setDrop:(BOOL)drop{
    _drop = drop;
    [self refresh];
}

-(void)refresh{
    [self setViewModel:_viewModel];
}
@end
