//
//  MMDetailTaskFrame.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMDetailTaskFrame.h"
#import "NSString+Size.h"

@implementation MMDetailTaskFrame
-(void)setViewModel:(MMDetailTaskModel *)viewModel{
    _viewModel = viewModel;
    
    CGFloat titleFrameX = 12.0f;
    CGFloat titleFrameY = 0.0f;
    CGFloat titleFrameW = kScreenWidth - 12.0f * 2.0f;
    CGFloat titleFrameH = 44.0f;
    _titleFrame = CGRectMake(titleFrameX, titleFrameY,titleFrameW, titleFrameH);
    
    CGFloat titleContentX = 12.0f;
    CGFloat titleContentY = CGRectGetMaxY(_titleFrame);
    CGFloat titleContentW = kScreenWidth - 12.0f * 2.0f;
    CGFloat titleContentH = [viewModel.title sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToWidth:titleContentW].height;
    _titleContentFrame = CGRectMake(titleContentX, titleContentY,titleContentW, titleContentH);
   
    CGFloat taskLineX = titleContentX;
    CGFloat taskLineY = CGRectGetMaxY(_titleContentFrame) + 15.0f;
    CGFloat taskLineW = titleContentW;
    CGFloat taskLineH = 0.5f;
    _taskLineFrame = CGRectMake(taskLineX, taskLineY,taskLineW, taskLineH);
    
    _cellHeight = CGRectGetMaxY(_taskLineFrame);
    
    if(viewModel.name != nil){
        CGFloat headImageX = titleContentX;
        CGFloat headImageY = CGRectGetMaxY(_taskLineFrame) + 12.0f;
        CGFloat headImageW = 26.0f;
        CGFloat headImageH = headImageW;
        _headImageFrame = CGRectMake(headImageX, headImageY,headImageW, headImageH);
        
        
        CGFloat nameX = CGRectGetMaxX(_headImageFrame) + 12.0f;
        CGFloat nameY = headImageY;
        CGFloat nameW = kScreenWidth - nameX - 12.0f;
        CGFloat nameH = 16.0f;
        _nameFrame = CGRectMake(nameX, nameY,nameW, nameH);
        
        CGFloat timeX = nameX;
        CGFloat timeY = CGRectGetMaxY(_nameFrame) + 3.0f;
        CGFloat timeW = nameW;
        CGFloat timeH = 15.0f;
        _timeFrame = CGRectMake(timeX, timeY,timeW, timeH);
        
        NSString *firstChart = viewModel.chatContents.firstObject;
        CGFloat firstChatX = nameX;
        CGFloat firstChatY = CGRectGetMaxY(_timeFrame) + 6.0f;
        CGFloat firstChatW = nameW;
        CGFloat firstChatH = [firstChart sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToWidth:firstChatW].height;
        _firstChatFrame = CGRectMake(firstChatX, firstChatY,firstChatW, firstChatH);
        
        //chartContent
        CGFloat chatContentX = firstChatX;
        CGFloat chatContentY = CGRectGetMaxY(_firstChatFrame) + 10.0f;
        CGFloat chatContentW = firstChatW;
    
        NSMutableArray *frames = [NSMutableArray new];
        NSArray *chart = viewModel.chatContents;
        __block CGFloat totalY = 7.0f;
        CGFloat chatAvgW = chatContentW - 10.0f * 2.0f;
        [chart enumerateObjectsUsingBlock:^(NSString *  _Nonnull content, NSUInteger idx, BOOL * _Nonnull stop) {
            if(_showAll){//显示全部
              CGFloat itemHeight = [content sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToWidth:chatAvgW].height;
              CGRect frame = CGRectMake(10.0f, totalY + 5.0f, chatAvgW, itemHeight);
              NSValue *value = [NSValue valueWithBytes:&frame objCType:@encode(CGRect)];
              totalY = CGRectGetMaxY(frame);
              [frames addObject:value];
            }else{//只显示头两条
                CGRect frame;
                CGFloat itemHeight = [content sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToWidth:chatAvgW].height;
                if(idx < 2){
                    frame = CGRectMake(10.0f, totalY + 5.0f, chatAvgW, itemHeight);
                }else{
                    frame = CGRectMake(10.0f, totalY + 5.0f, chatAvgW, 0.0f);
                }
                NSValue *value = [NSValue valueWithBytes:&frame objCType:@encode(CGRect)];
                totalY = CGRectGetMaxY(frame);
                [frames addObject:value];
            }
        }];
        
        //按钮
        CGFloat btnShowAllX = 10.0f;
        CGFloat btnShowAllY = totalY + 5.0f;
        CGFloat btnShowAllW = chatAvgW;
        CGFloat btnShowAllH = 21.0f;
        _btnShowAllFrame = CGRectMake(btnShowAllX, btnShowAllY, btnShowAllW, btnShowAllH);
        totalY = CGRectGetMaxY(_btnShowAllFrame);
        
        _contentFrames  = [frames copy];
        CGFloat chatContentH = totalY + 12.0f;
        _chatContentFrame = CGRectMake(chatContentX, chatContentY,chatContentW, chatContentH);
        
        CGFloat contentLineX = taskLineX;
        CGFloat contentLineY = CGRectGetMaxY(_chatContentFrame) + 15.0f;
        CGFloat contentLineW = taskLineW;
        CGFloat contentLineH = 0.5f;
        _contentLineFrame = CGRectMake(contentLineX, contentLineY,contentLineW, contentLineH);
        _cellHeight = CGRectGetMaxY(_contentLineFrame);
    }
    
    CGFloat btnCompleteX = CGRectGetMaxX(_taskLineFrame) - 32.0f;
    CGFloat btnCompleteY = _cellHeight;
    CGFloat btnCompleteW = 32.0f;
    CGFloat btnCompleteH = 44.0f;
    _btnCompleteFrame = CGRectMake(btnCompleteX, btnCompleteY,btnCompleteW, btnCompleteH);
   
    CGFloat  btnChartX = CGRectGetMinX(_btnCompleteFrame) - 50.0f - 5.0f;
    CGFloat  btnCharteY = btnCompleteY;
    CGFloat  btnChartW = 50.0f;
    CGFloat  btnChartH = 44.0f;
    _btnChartFrame = CGRectMake(btnChartX, btnCharteY,btnChartW, btnChartH);
    
    CGFloat cellLineX = 0;
    CGFloat cellLineY = CGRectGetMaxY(_btnChartFrame);
    CGFloat cellLineW = kScreenWidth;
    CGFloat cellLineH = 10.0f;
    _cellLineFrame = CGRectMake(cellLineX, cellLineY,cellLineW, cellLineH);
    
    _cellHeight = CGRectGetMaxY(_cellLineFrame);
}

-(void)setShowAll:(BOOL)showAll{
    _showAll = showAll;
    [self setViewModel:_viewModel];
}
@end
