//
//  MMRankingActiveHeadItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMRankingActiveHeadItem.h"
#import "YYText.h"
#define kfirstBorderColor 0x785a36
#define ksecondBorderColor 0x3d4e5b
#define kthirdBorderColor 0x7d483b
#define kfirstIconW 31.5f
#define kotherIconW 28.5f
#define kfirstHeadW 98.0f
#define kotherHeadW 83.0f

@interface MMRankingActiveHeadItem()
@property(nonatomic,strong) UIImageView *iconImageView;//皇冠
@property(nonatomic,strong) UIImageView *headImageView;//头像
@property(nonatomic,strong) UILabel * lableName;//名字
@property(nonatomic,strong) YYLabel * lableTime;//时间
@end

@implementation MMRankingActiveHeadItem

-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
//        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)lableName{
    if(_lableName == nil){
      _lableName = [UILabel new];
      [_lableName setTextColor:HEXCOLOR(kTitleColor)];
      [_lableName setFont:[UIFont systemFontOfSize:14.0f]];
      [_lableName setLineBreakMode:NSLineBreakByTruncatingTail];
      [_lableName setTextAlignment:NSTextAlignmentCenter];
      _lableName.text = @"周莎莎";
    }
    return _lableName;
}

-(YYLabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [YYLabel new];
        NSMutableAttributedString *text = [self RAGetAttributeDateStr:@"200"];
        _lableTime.attributedText = text;
        [_lableTime setTextAlignment:NSTextAlignmentCenter];
    }
    return _lableTime;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self RASetUpSubviews];
    }
    return self;
}

- (instancetype)initWithType:(RAItemType)Type
{
    self = [super init];
    if (self) {
        _itemType = Type;
        [self RASetUpSubviews];
    }
    return self;
}

-(void)RASetUpSubviews{
    [self addSubview:self.iconImageView];
    [self addSubview:self.headImageView];
    [self addSubview:self.lableName];
    [self addSubview:self.lableTime];
    
    UIColor *boardColor = [UIColor new];
    CGFloat iconW = 0.0f;
    CGFloat headW = 0.0f;
    UIImage * iconImage = [UIImage new];
    switch (_itemType) {
        case firstType:{
            boardColor = HEXCOLOR(kfirstBorderColor);
            iconW = kfirstIconW;
            headW = kfirstHeadW;
            iconImage = [UIImage imageNamed:@"content_dym"];
        }
            break;
        case secondType:{
            boardColor = HEXCOLOR(ksecondBorderColor);
            iconW = kotherIconW;
            headW = kotherHeadW;
            iconImage = [UIImage imageNamed:@"content_dem"];
        }
            break;
        case thirdType:{
            boardColor = HEXCOLOR(kthirdBorderColor);
            iconW = kotherIconW;
            headW = kotherHeadW;
            iconImage = [UIImage imageNamed:@"content_dsm"];
        }
            break;
            
        default:
            break;
    }
    
    _headImageView.layer.borderColor = boardColor.CGColor;
    _headImageView.layer.borderWidth = 1.0f;
    _iconImageView.image = iconImage;
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).with.offset(10.0f);
        make.size.mas_equalTo(CGSizeMake(headW, headW));
    }];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(iconW, iconW));
    }];
    [_lableName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(5.0f);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(21.0f);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableName.mas_bottom);
        make.left.right.mas_equalTo(_lableName);
        make.height.mas_greaterThanOrEqualTo(15.0f);
    }];
    
    
}

-(NSMutableAttributedString*)RAGetAttributeDateStr:(NSString *)date{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@小时",date]];
    NSRange range0 = [[text string] rangeOfString:date options:NSCaseInsensitiveSearch];
    
    [text yy_setFont:[UIFont systemFontOfSize:12] range:range0];
    [text yy_setColor:HEXCOLOR(0xff4b0d) range:range0];
    
    NSRange range1 = [[text string] rangeOfString:@"小时" options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:11] range:range1];
    [text yy_setColor:HEXCOLOR(0x999999) range:range1];
    return text;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _headImageView.layer.cornerRadius = _headImageView.width/2.0f;
}


@end
