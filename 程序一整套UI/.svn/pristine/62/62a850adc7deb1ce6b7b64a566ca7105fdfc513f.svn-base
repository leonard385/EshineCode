//
//  MMEmployMannagerBottomBar.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployMannagerBottomBar.h"
#import "MMEmployMannagerBtnItem.h"
@interface MMEmployMannagerBottomBar()
@property(nonatomic,strong)MMEmployMannagerBtnItem *selectAllBtn;
@property(nonatomic,strong)UIButton *delectBtn;
@end
@implementation MMEmployMannagerBottomBar

-(MMEmployMannagerBtnItem *)selectAllBtn{
    if(_selectAllBtn == nil){
        _selectAllBtn = [MMEmployMannagerBtnItem new];
        [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"selected_wxz"] forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"selected_yxz"] forState:UIControlStateSelected];
        [_selectAllBtn.imageView setContentMode:UIViewContentModeCenter];
        [_selectAllBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_selectAllBtn setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [_selectAllBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectAllBtn addTarget:self action:@selector(selectedAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

-(UIButton *)delectBtn{
    if(_delectBtn == nil){
        _delectBtn = [UIButton new];
        [_delectBtn setTitle:@"删除帐号" forState:UIControlStateNormal];
        [_delectBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_delectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_delectBtn setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_delectBtn addTarget:self action:@selector(delectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectBtn;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self EMSetUpSubviews];
    }
    return self;
}

-(void)EMSetUpSubviews{
    [self addSubview:self.selectAllBtn];
    [self addSubview:self.delectBtn];
    
    [_selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self);
        make.width.mas_equalTo(_delectBtn);
    }];
    [_delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self);
        make.width.mas_equalTo(_selectAllBtn);
        make.left.mas_equalTo(_selectAllBtn.mas_right);
    }];
}

-(void)selectedAllBtnClick:(UIButton *)sender{
    bool state = sender.selected;
    state = !state;
    
    _selectAllBlock ? _selectAllBlock(state):nil;
    sender.selected = state;
    
}

-(void)setSelectAllBlock:(selectAll)selectAllBlock DeleteBtnClickBlock:(deleteBtnClick)deleteBtnClickBlock{
    _selectAllBlock = selectAllBlock;
    _deleteBtnClickBlock = deleteBtnClickBlock;
}

-(void)delectBtnClick{
    _deleteBtnClickBlock?_deleteBtnClickBlock():nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
