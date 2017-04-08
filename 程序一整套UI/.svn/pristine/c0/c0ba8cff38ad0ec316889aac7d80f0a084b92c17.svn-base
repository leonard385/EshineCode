//
//  MMNoticeTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMNoticeTableViewCell.h"
@interface MMNoticeTableViewCell()
@property (nonatomic,strong) UIImageView *logoImage;
@property (nonatomic,strong) UILabel *lableContent;
@property (nonatomic,strong) UILabel *lableUser;
@property (nonatomic,strong) UILabel *lableDate;

@end

@implementation MMNoticeTableViewCell

-(UIImageView *)logoImage{
    if(_logoImage == nil){
        _logoImage = [UIImageView new];
        _logoImage.backgroundColor = [UIColor redColor];
    }
    return _logoImage;
}

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        [_lableContent setTextColor:HEXCOLOR(kTitleColor)];
        [_lableContent setFont:[UIFont systemFontOfSize:15.0f]];
        [_lableContent setNumberOfLines:2];
        [_lableContent setLineBreakMode:NSLineBreakByTruncatingTail];
        _lableContent.text = @"测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻测试新闻";
    }
    return _lableContent;
}

-(UILabel *)lableUser{
    if(_lableUser == nil){
        _lableUser = [UILabel new];
        [_lableUser setTextColor:HEXCOLOR(0x999999)];
        [_lableUser setFont:[UIFont systemFontOfSize:13.0f]];
        [_lableUser setLineBreakMode:NSLineBreakByTruncatingTail];
        _lableUser.text = @"张一三";
    }
    return _lableUser;
}

-(UILabel *)lableDate{
    if(_lableDate == nil){
        _lableDate = [UILabel new];
        [_lableDate setTextColor:HEXCOLOR(0x999999)];
        [_lableDate setFont:[UIFont systemFontOfSize:11.0f]];
        [_lableDate setTextAlignment:NSTextAlignmentRight];
        [_lableDate setLineBreakMode:NSLineBreakByTruncatingTail];
        _lableDate.text = @"11:18";
    }
    return _lableDate;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _cellLine;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self NTSetUpSubviews];
    }
    return self;
}

-(void)NTSetUpSubviews{
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.lableContent];
    [self.contentView addSubview:self.lableUser];
    [self.contentView addSubview:self.lableDate];
    [self.contentView addSubview:self.cellLine];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(95.0f, 71.0f));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [_lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logoImage);
        make.left.mas_equalTo(_logoImage.mas_right).with.offset(12.0f);
        make.height.mas_equalTo(48.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_lableUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_logoImage);
        make.height.mas_equalTo(18.0f);
        make.left.mas_equalTo(_lableContent);
        make.right.mas_equalTo(_lableDate.mas_left).with.offset(-5.0f);
    }];
    
    [_lableDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableUser);
        make.width.mas_equalTo(60.0f);
        make.right.mas_equalTo(_lableContent).with.offset(-5.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];

}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
