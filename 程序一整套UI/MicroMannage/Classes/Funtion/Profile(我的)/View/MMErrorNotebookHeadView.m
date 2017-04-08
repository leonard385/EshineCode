//
//  MMErrorNotebookHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMErrorNotebookHeadView.h"
#import "MMErrorNotebookItem.h"
#import "MMUpDownButton.h"

@interface MMErrorNotebookHeadView()
@property(nonatomic,strong)MMErrorNotebookItem* errorNumView;
@property(nonatomic,strong)MMUpDownButton *btnPractice;
@property(nonatomic,strong)MMUpDownButton  *btnExam;
@end

@implementation MMErrorNotebookHeadView

-(MMErrorNotebookItem *)errorNumView{
    if(_errorNumView == nil){
        _errorNumView = [MMErrorNotebookItem new];
        _errorNumView.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        _errorNumView.layer.borderWidth = 1.5f;
        _errorNumView.layer.cornerRadius = 53.5f;
        _errorNumView.num = @"80";
    }
    return _errorNumView;
}

-(MMUpDownButton *)btnPractice{
    if(_btnPractice == nil){
        _btnPractice = [MMUpDownButton new];
        [_btnPractice setTitle:@"练习错题" forState:UIControlStateNormal];
        [_btnPractice.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_btnPractice setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [_btnPractice setImage:[UIImage imageNamed:@"content_ks"] forState:UIControlStateNormal];
        [_btnPractice addTarget:self action:@selector(ENpraticeClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnPractice;
}
-(MMUpDownButton *)btnExam{
    if(_btnExam == nil){
        _btnExam = [MMUpDownButton new];
        [_btnExam setTitle:@"考试错题" forState:UIControlStateNormal];
        [_btnExam.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_btnExam setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [_btnExam setImage:[UIImage imageNamed:@"content_cuotiben"] forState:UIControlStateNormal];
        [_btnExam addTarget:self action:@selector(ENexamClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnExam;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self ENSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ENSetUpSubviews];
    }
    return self;
}

-(void)ENSetUpSubviews{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.btnPractice];
    [self addSubview:self.errorNumView];
    [self addSubview:self.btnExam];
    
    [_errorNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(107.0f, 107.0f));
    }];
    
    [_btnPractice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(84.0f, 84.0f));
        make.centerY.mas_equalTo(_errorNumView);
        make.right.mas_equalTo(_errorNumView.mas_left).with.offset(-26.0f);
    }];
    
    [_btnExam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(84.0f, 84.0f));
        make.centerY.mas_equalTo(_errorNumView);
        make.left.mas_equalTo(_errorNumView.mas_right).with.offset(26.0f);
    }];
    
    
}

-(void)ENpraticeClick{
    _ENpraticeClickBlock?_ENpraticeClickBlock():nil;
}

-(void)ENexamClick{
    _ENexamClickBlock ? _ENexamClickBlock():nil;
}

-(void)setNum:(NSString *)num{
    _errorNumView.num = num;
}

-(void)setENpraticeClickBlock:(ENpraticeClick)ENpraticeClickBlock examClickBlock:(ENexamClick)ENexamClickBlock{
    _ENpraticeClickBlock = ENpraticeClickBlock;
    _ENexamClickBlock  = ENexamClickBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
