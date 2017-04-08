//
//  MMTrainCreateContentCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainCreateContentCell.h"
@interface MMTrainCreateContentCell ()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableContent;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation MMTrainCreateContentCell

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"培训描述";
    }
    return _lableTitle;
}

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        _lableContent.font = [UIFont systemFontOfSize:14.0f];
        _lableContent.textColor = HEXCOLOR(0x666666);
        _lableContent.numberOfLines = 0.0f;
    }
    return _lableContent;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TCSetUpSubviews];
    }
    return self;
}

-(void)TCSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableContent];
    [self.contentView addSubview:self.lineView];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(44.0f);
        make.top.mas_equalTo(self.contentView);
    }];
    
    [_lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lableTitle);
        make.top.mas_equalTo(_lableTitle.mas_bottom);
        make.bottom.mas_equalTo(_lineView.mas_top).with.offset(-12.0f);
        make.height.mas_greaterThanOrEqualTo(78.0f);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10.0f);
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
