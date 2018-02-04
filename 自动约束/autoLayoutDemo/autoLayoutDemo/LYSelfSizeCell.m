//
//  LYSelfSizeCell.m
//  autoLayoutDemo
//
//  Created by leo on 2018/2/2.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYSelfSizeCell.h"
@interface LYSelfSizeCell()
@property (nonatomic,strong) UILabel *labelTitle;
@end
@implementation LYSelfSizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UILabel *)labelTitle{
    if(_labelTitle == nil){
        _labelTitle = [UILabel new];
        _labelTitle.font = [UIFont systemFontOfSize:15.0f];
        _labelTitle.textColor = [UIColor blackColor];
        _labelTitle.numberOfLines = 0;
    }
    return _labelTitle;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.labelTitle.text = title;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self SSSetUpSubviews];
    }
    return self;
}

- (void)SSSetUpSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(8.0f, 10.0f, 8.0f, 10.0f));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
