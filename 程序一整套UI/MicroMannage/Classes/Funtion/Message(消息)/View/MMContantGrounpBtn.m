//
//  MMContantGrounpBtn.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMContantGrounpBtn.h"
@interface MMContantGrounpBtn()
@property(nonatomic,strong)UIImageView  *headImageView;
@property(nonatomic,strong)UILabel *lableTitle;
@end
@implementation MMContantGrounpBtn

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bth_icon_qunzu"]];
    }
    return _headImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.text = @"我的群组";
    }
    return _lableTitle;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self CGSetUpSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CGSetUpSubviews];
    }
    return self;
}

-(void)CGSetUpSubviews{
    [self addSubview:self.headImageView];
    [self addSubview:self.lableTitle];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(12.0f);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(35.0f, 35.0f));
    }];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(10.0f);
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).with.offset(-12.0f);
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
