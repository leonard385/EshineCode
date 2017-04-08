//
//  MMEmployStatisticTipItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployStatisticTipItem.h"
@interface MMEmployStatisticTipItem ()
@property(nonatomic,strong)UIView *iconView;
@property(nonatomic,strong)UILabel *lableTitle;
@end

@implementation MMEmployStatisticTipItem
-(UIView *)iconView{
    if(_iconView == nil){
        _iconView = [UIView new];
        _iconView.layer.cornerRadius = 2.5f;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x262b2e)];
        [_lableTitle setFont:[UIFont systemFontOfSize:11.0f]];
    }
    return _lableTitle;
}

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title IconColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
         [self STSetUpSubviewsWithTitle:title IconColor:color];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title IconColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        [self STSetUpSubviewsWithTitle:title IconColor:color];
    }
    return self;
}

-(void)STSetUpSubviewsWithTitle:(NSString *)title IconColor:(UIColor *)color{
    [self addSubview:self.iconView];
    [self addSubview:self.lableTitle];
    _iconView.backgroundColor = color;
    _lableTitle.text = title;
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(5.0f);
        make.size.mas_equalTo(CGSizeMake(10.0f, 10.0f));
        make.centerY.mas_equalTo(self);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
         make.left.mas_equalTo(_iconView.mas_right).with.offset(5.0f);
         make.right.mas_equalTo(self).with.offset(-5.0f);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
