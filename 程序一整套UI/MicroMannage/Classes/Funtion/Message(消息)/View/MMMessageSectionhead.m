//
//  MMMessageSectionhead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMessageSectionhead.h"
@interface MMMessageSectionhead()
@property(nonatomic,strong)UILabel *lableTitle;
@end
@implementation MMMessageSectionhead

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return _lableTitle;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self MSSetUpSubviews];
    }
    return self;
}

-(void)MSSetUpSubviews{
    self.contentView.backgroundColor = HEXCOLOR(0xefeff4);
    [self.contentView addSubview:self.lableTitle];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 12.0, 0.0f, 12.0f));
    }];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _lableTitle.text = title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
