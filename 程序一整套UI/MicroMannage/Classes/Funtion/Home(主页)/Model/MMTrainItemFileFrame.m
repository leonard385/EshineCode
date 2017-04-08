//
//  MMTrainItemFileFrame.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainItemFileFrame.h"
#import "NSString+Size.h"
@interface  MMTrainItemFileFrame ()
@property(nonatomic,assign)CGFloat selfWidth;
@end

@implementation MMTrainItemFileFrame
- (instancetype)initWithSuperViewWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        _selfWidth = width;
    }
    return self;
}


-(void)setCellModel:(MMTrainItemFileModel *)cellModel{
    _cellModel = cellModel;
    
    
    CGFloat iconFrameX = 12.0f;
    CGFloat iconFrameY = 5.0f;
    CGFloat iconFrameW = 13.0f;
    CGFloat iconFrameH = 13.0f;
    _iconFrame = CGRectMake(iconFrameX, iconFrameY,iconFrameW, iconFrameH);
    
    
    CGFloat contentFrameX = CGRectGetMaxX(_iconFrame) + 5.0f;
    CGFloat contentFrameY = 5.0f;
    CGFloat contentFrameW = _selfWidth - contentFrameX - 12.0f;
    CGFloat contentFrameH = [cellModel.fileTitles sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToWidth:contentFrameW].height;
    _contentFrame =  CGRectMake(contentFrameX, contentFrameY, contentFrameW, contentFrameH);
    
    _cellHeight = CGRectGetMaxY(_contentFrame) + 5.0f;
}
@end
