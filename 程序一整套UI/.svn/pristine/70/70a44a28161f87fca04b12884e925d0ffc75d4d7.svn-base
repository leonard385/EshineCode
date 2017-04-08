//
//  MMTrainCellFrameModel.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainCellFrameModel.h"
#import "NSString+Size.h"
@implementation MMTrainCellFrameModel
-(void)setCellModel:(MMTrainItemModel *)cellModel{
    _cellModel = cellModel;
    
    CGFloat verLineX = 28.5f;
    CGFloat verLineY = 0.0f;
    CGFloat verLineW = 2.0f;
    
    CGFloat titleFrameX = verLineX + verLineW + 18.0f;
    CGFloat titleFrameY = 0.0f;
    CGFloat titleFrameW = kScreenWidth - 12 - titleFrameX;
    CGFloat titleFrameH = 0.0f;
    if(_drop){//展开
        _titleLines = 0.0f;
        titleFrameH = [cellModel.subtitle sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToWidth:titleFrameW].height;
        _titleFrame = CGRectMake(titleFrameX, titleFrameY,titleFrameW, titleFrameH);
        //tableview frameModel
        
        CGFloat tableViewX = titleFrameX;
        CGFloat tableViewY = CGRectGetMaxY(_titleFrame) + 15.0f;
        CGFloat tableViewW = titleFrameW;
        
        __block CGFloat totalH = 0.0f;
        NSArray *files = cellModel.files;
        NSMutableArray *subframeModels = [NSMutableArray new];
        [files enumerateObjectsUsingBlock:^(MMTrainItemFileModel*  _Nonnull fileModel, NSUInteger idx, BOOL * _Nonnull stop) {
            MMTrainItemFileFrame *fameModel = [[MMTrainItemFileFrame alloc]initWithSuperViewWidth:tableViewW];
            [fameModel setCellModel:fileModel];
            [subframeModels addObject:fameModel];
            totalH += fameModel.cellHeight;
        }];
        _subCellFrameModels = [subframeModels copy];
        CGFloat tableViewH = totalH + 7.0f * 2.0f;//tableview的偏移量上下各7.0f
        _tableviewFrame = CGRectMake(tableViewX,tableViewY, tableViewW, tableViewH);
        _cellHeight =  CGRectGetMaxY(_tableviewFrame);
    }else{
        _titleLines = 3.0f;//三行
        titleFrameH = [cellModel.subtitle sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToWidth:titleFrameW].height;
        if(titleFrameH >= 50.0){
            titleFrameH = 50.0f;
        }
        _titleFrame = CGRectMake(titleFrameX, titleFrameY,titleFrameW, titleFrameH);
        _tableviewFrame = CGRectZero;
        _cellHeight = CGRectGetMaxY(_titleFrame);
    }
    
    CGFloat verLineH = _cellHeight + 15.0f;
    _verLineFrame = CGRectMake(verLineX, verLineY, verLineW, verLineH);
    _cellHeight = CGRectGetMaxY(_verLineFrame);
}

-(void)setDrop:(BOOL)drop{
    _drop = drop;
    [self refresh];
}



#pragma mark - 刷新
-(void)refresh{
    [self setCellModel:_cellModel];
  
}
@end
