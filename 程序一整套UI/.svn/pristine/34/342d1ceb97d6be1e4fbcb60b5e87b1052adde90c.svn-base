//
//  MMTrainCreateTaskCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainCreateTaskCell.h"
@interface MMTrainCreateTaskCell ()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIButton *btnDelete;
@property(nonatomic,strong)UILabel *lableContent;
@property(nonatomic,strong)UILabel *lableFiles;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation MMTrainCreateTaskCell
-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"现场管理篇";
    }
    return _lableTitle;
}



-(UIButton *)btnDelete{
    if(_btnDelete == nil){
        _btnDelete = [UIButton new];
        [_btnDelete setImage:[UIImage imageNamed:@"nav_shanchu"] forState:UIControlStateNormal];
        [_btnDelete.imageView setContentMode:UIViewContentModeCenter];
        [_btnDelete addTarget:self action:@selector(TCbtnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
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

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        _lableContent.font = [UIFont systemFontOfSize:14.0f];
        _lableContent.textColor = HEXCOLOR(0x666666);
        _lableContent.numberOfLines = 0.0f;
        _lableContent.text = @"现场管理现场管理现场管理现场管理现场管理现场管理现场管理现场管理现场管理";
    }
    return _lableContent;
}

-(UILabel *)lableFiles{
    if(_lableFiles == nil){
        _lableFiles = [UILabel new];
        _lableFiles.font = [UIFont systemFontOfSize:15.0f];
        _lableFiles.textColor = HEXCOLOR(0xff5d30);
        _lableFiles.text = @"10个文件";
    }
    return _lableFiles;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TCSetUpSubviews];
    }
    return self;
}

-(void)TCSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.btnDelete];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.lableContent];
    [self.contentView addSubview:self.lableFiles];
    [self.contentView addSubview:self.lineView];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(_btnDelete.mas_left).with.offset(-8.0f);
        make.bottom.mas_equalTo(_line.mas_top);
        make.top.mas_equalTo(self.contentView);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(44.0f);
        make.height.mas_equalTo(0.5f);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableTitle);
        make.width.mas_equalTo(25.0f);
        make.right.mas_equalTo(_line);
    }];
    
    
    [_lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).with.offset(12.0f);
        make.left.right.mas_equalTo(_line);
        make.height.mas_greaterThanOrEqualTo(78.0f);
        
    }];
    
    [_lableFiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableContent.mas_bottom).with.offset(12.0f);
        make.left.right.mas_equalTo(_line);
        make.height.mas_equalTo(21.0f);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableFiles.mas_bottom).with.offset(12.0f);
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10.0f);
    }];
}

-(void)TCbtnEditClick{
  
}


-(void)TCbtnDeleteClick{
  
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
