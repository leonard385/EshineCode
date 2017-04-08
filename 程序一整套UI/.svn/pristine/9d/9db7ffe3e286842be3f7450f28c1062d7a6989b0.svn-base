//
//  MMExamTitleView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamTitleView.h"
#import "YYText.h"
@interface MMExamTitleView()
@property(nonatomic,strong)YYLabel *lableTitle;
@end
@implementation MMExamTitleView

-(YYLabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [YYLabel new];
    }
    return _lableTitle;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ETSetUpSubviews];
    }
    return self;
}

-(void)ETSetUpSubviews{
    [self addSubview:self.lableTitle];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)setTotal:(NSString *)total{
    _total = total;
    [self setCurrentPage:@"1"];
}

-(void)setCurrentPage:(NSString *)currentPage{
    _currentPage = currentPage;
    NSMutableAttributedString *str = [self getAtrstrWithCurrent:_currentPage total:_total];
    _lableTitle.attributedText = str;
}

-(NSMutableAttributedString*)getAtrstrWithCurrent:(NSString *)current total:(NSString *)total{
    NSString *totalStr = [NSString stringWithFormat:@"/%@",total];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",current,totalStr]];
    NSRange range0 = [[text string] rangeOfString:current options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:16.0f] range:range0];
    [text yy_setColor:HEXCOLOR(kBlueColor) range:range0];

    NSRange range1 = [[text string] rangeOfString:totalStr options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:16.0f] range:range1];
    [text yy_setColor:HEXCOLOR(0xcccccc) range:range1];
    [text yy_setAlignment:NSTextAlignmentCenter range:text.yy_rangeOfAll];
    return text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
