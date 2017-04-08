//
//  MMRankingActiveHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMRankingActiveHeadView.h"
#import "MMRankingActiveHeadItem.h"

@interface MMRankingActiveHeadView()
@property(nonatomic,strong)MMRankingActiveHeadItem *firstItem;
@property(nonatomic,strong)MMRankingActiveHeadItem *secondItem;
@property(nonatomic,strong)MMRankingActiveHeadItem *thirdItem;
@end

@implementation MMRankingActiveHeadView
-(MMRankingActiveHeadItem *)firstItem{
    if(_firstItem == nil){
        _firstItem = [[MMRankingActiveHeadItem alloc]initWithType:firstType];
    }
    return _firstItem;
}
-(MMRankingActiveHeadItem *)secondItem{
    if(_secondItem == nil){
        _secondItem = [[MMRankingActiveHeadItem alloc]initWithType:secondType];
    }
    return _secondItem;
}
-(MMRankingActiveHeadItem *)thirdItem{
    if(_thirdItem == nil){
        _thirdItem = [[MMRankingActiveHeadItem alloc]initWithType:thirdType];
    }
    return _thirdItem;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self RASetUpSubviews];
    }
    return self;
}

-(void)RASetUpSubviews{
    [self addSubview:self.firstItem];
    [self addSubview:self.secondItem];
    [self addSubview:self.thirdItem];
    [_firstItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).with.offset(14.0f);
        make.size.mas_equalTo(CGSizeMake(122.0f, 148.0f));
    }];
    [_secondItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstItem).with.offset(7.0f);
        make.right.mas_equalTo(_firstItem.mas_left).with.offset(5.0f);
        make.size.mas_equalTo(CGSizeMake(105.0f, 136.0f));
    }];
    [_thirdItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstItem).with.offset(7.0f);
        make.left.mas_equalTo(_firstItem.mas_right).with.offset(5.0f);
        make.size.mas_equalTo(CGSizeMake(105.0f, 136.0f));
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
