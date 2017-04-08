//
//  MMTrainEditFileCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainEditFileCell.h"
@interface MMTrainEditFileCell ()
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIButton *btnDelete;
@property(nonatomic,strong)UIView *line;
@end

@implementation MMTrainEditFileCell
-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
    }
    return _headImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"文件.ppt";
    }
    return _lableTitle;
}

-(UIButton *)btnDelete{
    if(_btnDelete == nil){
        _btnDelete = [UIButton new];
        [_btnDelete setImage:[UIImage imageNamed:@"nav_shanchu"] forState:UIControlStateNormal];
        [_btnDelete.imageView setContentMode:UIViewContentModeCenter];
        [_btnDelete addTarget:self action:@selector(TEbtnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnDelete;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TESetUpSubviews];
    }
    return self;
}
#pragma mark - 子视图
-(void)TESetUpSubviews{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.btnDelete];
    [self.contentView addSubview:self.line];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(38.0f, 47.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_headImageView);
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(9.0f);
        make.right.mas_equalTo(_btnDelete.mas_left).with.offset(-9.0f);
    }];
    
    [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.bottom.mas_equalTo(_lableTitle);
        make.width.mas_equalTo(25.0f);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];

}
#pragma mark - 删除按钮
-(void)TEbtnDeleteClick{
   
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
