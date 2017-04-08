//
//  MMfilterSectionHead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMfilterSectionHead.h"
@interface MMfilterSectionHead()
@property(nonatomic,strong)UIButton *btnSelect;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIButton *btnContent;
@property(nonatomic,strong)UIView *cellLine;
@property(nonatomic,strong)UIView *topLine;
@end
@implementation MMfilterSectionHead

-(UIButton *)btnSelect{
    if(_btnSelect == nil){
        _btnSelect = [UIButton new];
        [_btnSelect setImage:[UIImage imageNamed:@"selected_wxz"] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage imageNamed:@"selected_yxz"] forState:UIControlStateSelected];
        [_btnSelect.imageView setContentMode:UIViewContentModeCenter];
        [_btnSelect addTarget:self action:@selector(btnSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSelect;
}

-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"icon_shouqi"];//13x13
    }
    return _iconImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:14.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"公司总部";
    }
    return _lableTitle;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _cellLine;
    
}
-(UIView *)topLine{
    if(_topLine == nil){
        _topLine = [UIView new];
        _topLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _topLine;
    
}

-(UIButton *)btnContent{
    if(_btnContent == nil){
        _btnContent = [UIButton new];
        [_btnContent addTarget:self action:@selector(btnContentClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnContent;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self CSSetUpSubviews];
    }
    return self;
}

-(void)CSSetUpSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.cellLine];
    [self.contentView addSubview:self.btnContent];
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.btnSelect];
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(13.0f, 13.0f));
    }];
    
    [_btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_btnSelect.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(_iconImageView.mas_left).with.offset(-9.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    [_btnContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(_iconImageView);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
}

-(void)btnSelectedClick:(UIButton*)sender{
    BOOL state = !_viewModel.isSelected;
    sender.selected = state;
    _sectionSeletedClickBlock ? _sectionSeletedClickBlock(state):nil;
}

-(void)setViewModel:(MMFilterGroupModel *)viewModel{
    _viewModel = viewModel;
    _lableTitle.text = viewModel.title;
    if(viewModel.isDrop){
        _iconImageView.image = [UIImage imageNamed:@"icon_zhankai"];
    }else{
        _iconImageView.image = [UIImage imageNamed:@"icon_shouqi"];
    }
    _btnSelect.selected = viewModel.isSelected;
}

-(void)btnContentClick:(UIButton*)sender{
    BOOL state = !_viewModel.isDrop;
    sender.selected = state;
    
    [UIView animateWithDuration:0.2 animations:^{
        if(state){
            _iconImageView.image = [UIImage imageNamed:@"icon_zhankai"];
        }else{
            _iconImageView.image = [UIImage imageNamed:@"icon_shouqi"];
        }
    }];
    
    _sectionClickBlock?_sectionClickBlock(state):nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
