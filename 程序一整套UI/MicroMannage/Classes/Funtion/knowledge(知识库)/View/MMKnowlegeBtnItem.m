//
//  MMKnowlegeBtnItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/28.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeBtnItem.h"
@interface MMKnowlegeBtnItem()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@end
@implementation MMKnowlegeBtnItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UILabel *)lableTitle{
    if(_lableTitle ==  nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:20.0f]];
        [_lableTitle setTextColor:HEXCOLOR(kBlueColor)];
        [_lableTitle setTextAlignment:NSTextAlignmentCenter];
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle ==  nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:12.0f]];
        [_lableSubtitle setTextAlignment:NSTextAlignmentCenter];
    }
    return _lableSubtitle;
}

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self EDSetUpSubviews];
        _lableSubtitle.text = title;
    }
    return self;
}

-(void)EDSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.lableSubtitle];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(_lableSubtitle);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(_lableTitle);
        make.top.mas_equalTo(_lableTitle.mas_bottom);
    }];
    
}

-(void)setNum:(NSString *)num{
    _num = num;
    _lableTitle.text = num;
}

@end
