//
//  MMTrainEndCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainEndSection.h"
@interface MMTrainEndSection()
@property(nonatomic,strong)UIImageView *iconEnd;
@property(nonatomic,strong)UILabel *lableTitle;
@end
@implementation MMTrainEndSection


-(UIImageView *)iconEnd{
    if(_iconEnd == nil){
        _iconEnd = [UIImageView new];
        _iconEnd.image = [UIImage imageNamed:@"content_jieshu"];
    }
    return _iconEnd;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.numberOfLines = 1.0f;
        _lableTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _lableTitle.text = @"恭喜你顺利完成课程";
    }
    return _lableTitle;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super  initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self TESetUpSubviews];
    }
    return self;
}

-(void)TESetUpSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.iconEnd];
    
    
    [_iconEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(19.0f);
        make.size.mas_equalTo(CGSizeMake(22.0, 22.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_iconEnd);
        make.left.mas_equalTo(_iconEnd.mas_right).with.offset(4.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
