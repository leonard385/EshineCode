//
//  MMWorkCreateTaskCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkCreateTaskCell.h"

@interface MMWorkCreateTaskCell()<UITextViewDelegate>
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIButton *btnDelete;
@property(nonatomic,strong)UITextView *textViewContent;
@end

@implementation MMWorkCreateTaskCell

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"任务";
    }
    return _lableTitle;
}

-(UITextView *)textViewContent{
    if(_textViewContent == nil){
        _textViewContent = [UITextView new];
        [_textViewContent setFont:[UIFont systemFontOfSize:15.0f weight:22.0f]];
        [_textViewContent setTextColor:HEXCOLOR(0x999999)];
        [_textViewContent setScrollEnabled:NO];
        _textViewContent.delegate = self;
    }
    return _textViewContent;
}

-(UIButton *)btnDelete{
    if(_btnDelete == nil){
        _btnDelete = [UIButton new];
        [_btnDelete setImage:[UIImage imageNamed:@"nav_shanchu"] forState:UIControlStateNormal];
        [_btnDelete addTarget:self action:@selector(btnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnDelete;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self MCSetUpSubviews];
    }
    return self;
}

-(void)MCSetUpSubviews{
    
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.textViewContent];
    [self.contentView addSubview:self.btnDelete];
    [self.contentView addSubview:self.lineView];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10.0f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.btnDelete.mas_left).with.offset(-12.0f);
        make.top.mas_equalTo(_lineView.mas_bottom);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.bottom.mas_equalTo(_lableTitle);
        make.width.mas_equalTo(25.0f);
    }];
    
    [_textViewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom);
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(_btnDelete);
        make.height.mas_greaterThanOrEqualTo(30.0f);
        make.bottom.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    
}

#pragma mark - 删除点击
-(void)btnDeleteClick{
  
}

-(void)textViewDidChange:(UITextView *)textView{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

-(void)setTaskIdex:(NSUInteger)taskIdex{
    _lableTitle.text = [NSString stringWithFormat:@"任务%lu",taskIdex];
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
