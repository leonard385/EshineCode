//
//  MMEmployeeHeadBtnItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployeeHeadBtnItem.h"

@interface MMEmployeeHeadBtnItem()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIView *line;
@end

@implementation MMEmployeeHeadBtnItem

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:29.0f]];
        [_lableTitle setTextAlignment:NSTextAlignmentCenter];
        [_lableTitle setTextColor:HEXCOLOR(0x1d1d26)];
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:11.0f]];
        [_lableSubtitle setTextAlignment:NSTextAlignmentCenter];
        [_lableSubtitle setTextColor:HEXCOLOR(0x636367)];
    }
    return _lableSubtitle;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
    }
    return _line;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        [self EHSetUpSubviews];
    }
    return self;
}

-(void)EHSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.lableSubtitle];
    [self addSubview:self.line];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(15.0f);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(35.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(11.0f);
        make.height.mas_equalTo(15.0f);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableSubtitle.mas_bottom).with.offset(9.5f);
        make.size.mas_equalTo(CGSizeMake(18.0f, 3.0f));
        make.centerX.mas_equalTo(_lableSubtitle);
    }];

}

-(void)setEHsubtitle:(NSString *)EHsubtitle{
    _lableSubtitle.text  = EHsubtitle;
}

-(void)setEHtitle:(NSString *)EHtitle{
    _lableTitle.text = EHtitle;
}

-(void)setEHlineColor:(UIColor *)EHlineColor{
    _line.backgroundColor = EHlineColor;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
