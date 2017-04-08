//
//  MMSDropCell.m
//  jobCompany
//
//  Created by 逸信Mac on 16/2/1.
//  Copyright © 2016年 liaolx. All rights reserved.
//

#import "MMSDropCell.h"

@interface MMSDropCell()
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIButton *Btndelete;
@end

@implementation MMSDropCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self DCSetUpSubViews];
    }
    return self;
}

-(void)DCSetUpSubViews
{
    _LableTitle = [UILabel new];
    [_LableTitle setFont:[UIFont systemFontOfSize:16.0f]];
    [_LableTitle setTextColor:HEXCOLOR(0x333333)];
    [self.contentView addSubview:_LableTitle];
    
    _Btndelete  = [UIButton new];
    [_Btndelete setImage:[UIImage imageNamed:@"Delete_count"] forState:UIControlStateNormal];
    [_Btndelete addTarget:self action:@selector(DCDelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_Btndelete];
    
    
    _lineView = [UIView new];
    _lineView.backgroundColor = HEXCOLOR(0xf4f4f4);
    [self.contentView addSubview: _lineView];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(8.0f);
        make.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1.0f);
    }];
    
    [_Btndelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-8.0f);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(35.0f);
    }];
    
    [_LableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lineView);
        make.right.mas_equalTo(_Btndelete.mas_left).with.offset(-4.0f);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)DCDelectBtnClick:(id)sender {


   if(_DeleteClickBlock){
       _DeleteClickBlock();
   }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
