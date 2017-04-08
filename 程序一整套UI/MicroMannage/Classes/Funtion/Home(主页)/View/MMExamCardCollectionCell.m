//
//  MMExamCardCollectionCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamCardCollectionCell.h"
@interface MMExamCardCollectionCell()
@property(nonatomic,strong)UIButton *btnIndexItem;
@end
@implementation MMExamCardCollectionCell
-(UIButton *)btnIndexItem{
    if(_btnIndexItem == nil){
        _btnIndexItem = [UIButton new];
        [_btnIndexItem setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_btnIndexItem setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _btnIndexItem.layer.borderWidth = 1.0f;
        _btnIndexItem.layer.borderColor = HEXCOLOR(0xcccccc).CGColor;
        _btnIndexItem.layer.cornerRadius = 24.0f;
        _btnIndexItem.layer.masksToBounds = YES;
    }
    return _btnIndexItem;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self ECSetUpSubview];
    }
    return self;
}

-(void)ECSetUpSubview{
    [self addSubview:self.btnIndexItem];
    [_btnIndexItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - 设置cell类型
-(void)setCellType:(ExamCardCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case ECundoType:{
            [_btnIndexItem setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
            [_btnIndexItem setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
             _btnIndexItem.layer.borderColor = HEXCOLOR(0xcccccc).CGColor;
        }
            break;
        case ECdoAlreadyType:{
            [_btnIndexItem setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
            [_btnIndexItem setBackgroundColor:HEXCOLOR(0xf8f9fd) forState:UIControlStateNormal];
            _btnIndexItem.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        }
            break;
        case ECcurrentType:{
            [_btnIndexItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btnIndexItem setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
            _btnIndexItem.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        }
            break;
            
        default:
            break;
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [_btnIndexItem setTitle:title forState:UIControlStateNormal];
}


@end
