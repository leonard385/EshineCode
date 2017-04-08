//
//  MMEmployeeHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployeeHeadView.h"
#import "MMEmployeeHeadBtnItem.h"
#define kBtntTagOffset 100
@interface MMEmployeeHeadView()
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIButton *dropBtn;
@property(nonatomic,strong)MMEmployeeHeadBtnItem *btnTotal;
@property(nonatomic,strong)MMEmployeeHeadBtnItem *btnLeave;
@property(nonatomic,strong)MMEmployeeHeadBtnItem *btnAdd;
@end
@implementation MMEmployeeHeadView

-(UIView *)containerView{
    if(_containerView == nil){
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        [_lableTitle setTextColor:HEXCOLOR(0x222222)];
        _lableTitle.text = @"汕头市员工动态";
    }
    return _lableTitle;
}

-(UIButton *)dropBtn{
    if(_dropBtn == nil){
        _dropBtn = [UIButton new];
        [_dropBtn setBackgroundColor:HEXCOLOR(0xd9ecff) forState:UIControlStateNormal];
        [_dropBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_dropBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_dropBtn setTitle:@"2017/3/10" forState:UIControlStateNormal];
    }
    return _dropBtn;
}

-(MMEmployeeHeadBtnItem *)btnTotal{
    if(_btnTotal == nil){
        _btnTotal = [[MMEmployeeHeadBtnItem alloc]init];
        [_btnTotal setEHtitle:@"57"];
        [_btnTotal setEHsubtitle:@"员工总数"];
        [_btnTotal setEHlineColor:HEXCOLOR(0xfdda4f)];
        _btnTotal.tag = kBtntTagOffset + 0;
        [_btnTotal setBackgroundColor:HEXCOLOR(0xf0f3f8) forState:UIControlStateHighlighted];
        [_btnTotal addTarget:self action:@selector(EHbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTotal;
}
-(MMEmployeeHeadBtnItem *)btnLeave{
    if(_btnLeave == nil){
        _btnLeave = [[MMEmployeeHeadBtnItem alloc]init];
        [_btnLeave setEHtitle:@"19"];
        [_btnLeave setEHsubtitle:@"离职员工"];
        [_btnLeave setEHlineColor:HEXCOLOR(0x5dd054)];
        _btnLeave.tag = kBtntTagOffset + 1;
        [_btnLeave setBackgroundColor:HEXCOLOR(0xf0f3f8) forState:UIControlStateHighlighted];
        [_btnLeave addTarget:self action:@selector(EHbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeave;
}
-(MMEmployeeHeadBtnItem *)btnAdd{
    if(_btnAdd == nil){
        _btnAdd = [[MMEmployeeHeadBtnItem alloc]init];
        [_btnAdd setEHtitle:@"4"];
        [_btnAdd setEHsubtitle:@"新增员工"];
        [_btnAdd setEHlineColor:HEXCOLOR(0x69a5e1)];
        _btnAdd.tag = kBtntTagOffset + 2;
        [_btnAdd setBackgroundColor:HEXCOLOR(0xf0f3f8) forState:UIControlStateHighlighted];
        [_btnAdd addTarget:self action:@selector(EHbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAdd;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self EHSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self EHSetUpSubviews];
    }
    return self;
}

-(void)EHSetUpSubviews{
    
     self.backgroundColor = HEXCOLOR(0xf0f3f8);
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.lableTitle];
    [self.containerView addSubview:self.dropBtn];
    [self.containerView addSubview:self.btnTotal];
    [self.containerView addSubview:self.btnLeave];
    [self.containerView addSubview:self.btnAdd];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 0.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dropBtn).with.offset(4.0f);
        make.left.mas_equalTo(self.containerView).with.offset(12.0f);
        make.height.mas_equalTo(16.0f);
        make.right.mas_equalTo(_dropBtn.mas_left).with.offset(-12.0f);
    }];
    
    [_dropBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView).with.offset(-12.0f);
        make.top.mas_equalTo(self.containerView).with.offset(8.0f);
        make.size.mas_equalTo(CGSizeMake(83.0f, 22.0f));
    }];
    
    [_btnTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dropBtn.mas_bottom).with.offset(9.0f);
        make.left.mas_equalTo(self.containerView).with.offset(12.0f);
        make.width.mas_equalTo(_btnLeave);
        make.height.mas_equalTo(106.0f);
    }];
    
    [_btnLeave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_btnTotal);
        make.left.mas_equalTo(self.btnTotal.mas_right);
        make.width.mas_equalTo(_btnTotal);
    }];
    
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_btnTotal);
        make.left.mas_equalTo(_btnLeave.mas_right);
        make.width.mas_equalTo(_btnLeave);
        make.right.mas_equalTo(self.containerView).with.offset(-12.0f);
    }];

}

-(void)EHbtnClick:(UIButton *)btn{
    NSUInteger tag = btn.tag - kBtntTagOffset;
    _EHBtnClickBlock ? _EHBtnClickBlock(tag):nil;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
