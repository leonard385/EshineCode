//
//  MMTrainOfflineDetailBtnItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOfflineDetailBtnItem.h"
@interface  MMTrainOfflineDetailBtnItem()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@end
@implementation MMTrainOfflineDetailBtnItem

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:13.0f]];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.numberOfLines = 2.0f;
        [_lableTitle setTextAlignment:NSTextAlignmentCenter];
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:13.0f]];
        _lableSubtitle.textColor = HEXCOLOR(0x333333);
        _lableSubtitle.lineBreakMode = NSLineBreakByTruncatingTail;
         [_lableSubtitle setTextAlignment:NSTextAlignmentCenter];
    }
    return _lableSubtitle;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self DBSetUpSubviews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self DBSetUpSubviews];
    }
    return self;
}

-(void)DBSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.lableSubtitle];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(_lableSubtitle);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom);
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(_lableTitle);
    }];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _lableTitle.text = title;
}

-(void)setIdex:(NSUInteger)idex{
    _idex = idex;
    _lableSubtitle.text = [NSString stringWithFormat:@"阶段%lu",idex];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    UIColor *textColor = [UIColor new];
    if(selected){
        textColor = [UIColor whiteColor];
    }else{
        textColor = HEXCOLOR(0x333333);
    }
    
    _lableSubtitle.textColor = textColor;
    _lableTitle.textColor = textColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
