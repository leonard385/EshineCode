//
//  MMEmployMannagerCollectionViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployMannagerCollectionViewCell.h"
@interface MMEmployMannagerCollectionViewCell()
@property(nonatomic,strong)UIButton *btnSelect;
@property(nonatomic,strong)UIImageView *imageHeadView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;

@end
@implementation MMEmployMannagerCollectionViewCell

-(UIButton *)btnSelect{
    if(_btnSelect == nil){
        _btnSelect = [UIButton new];
        [_btnSelect setImage:[UIImage imageNamed:@"selected_wxz"] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage imageNamed:@"selected_yxz"] forState:UIControlStateSelected];
        [_btnSelect.imageView setContentMode:UIViewContentModeCenter];
        [_btnSelect addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSelect;
}

-(UIImageView *)imageHeadView{
    if(_imageHeadView == nil){
        _imageHeadView = [UIImageView new];
        _imageHeadView.layer.cornerRadius = 32.5f;
        _imageHeadView.backgroundColor = [UIColor redColor];
        _imageHeadView.layer.masksToBounds = YES;
    }
    return _imageHeadView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        [_lableTitle setTextAlignment:NSTextAlignmentCenter];
        [_lableTitle setNumberOfLines:2];
        [_lableTitle setLineBreakMode:NSLineBreakByTruncatingTail];
        _lableTitle.text = @"蔡华";
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:12.0f]];
        [_lableSubtitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubtitle setTextAlignment:NSTextAlignmentCenter];
        _lableSubtitle.numberOfLines = 1;
        _lableSubtitle.text = @"区域经理";
    }
    return _lableSubtitle;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self MCsetUpSubview];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self MCsetUpSubview];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)MCsetUpSubview{
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.borderColor = HEXCOLOR(0xcccccc).CGColor;
    self.contentView.layer.shadowOpacity = 0.5;
    self.contentView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentView.layer.shadowRadius = 2.0f;
    self.contentView.layer.shadowOffset  = CGSizeMake(1, 1);
    
    [self.contentView addSubview:self.btnSelect];
    [self.contentView addSubview:self.imageHeadView];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    _btnSelect.hidden = YES;
    
    [_btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(3.0f);
         make.left.mas_equalTo(self.contentView).with.offset(5.0f);
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
    }];
    
    [_imageHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).with.offset(20.0f);
        make.size.mas_equalTo(CGSizeMake(65.0f, 65.0F));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageHeadView.mas_bottom).with.offset(7.0f);
        make.left.mas_equalTo(self.contentView).with.offset(5.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-5.0f);
        make.height.mas_equalTo(20.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16.0f);
        make.left.right.mas_equalTo(_lableTitle);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(0.0f);
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editEnable:) name:kMemberEditNotice object:nil];

}

-(void)btnFuncClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

#pragma mark - 编辑通知
-(void)editEnable:(NSNotification *)notice{
    NSDictionary *userInfo = notice.userInfo;
    NSNumber *editState = userInfo[kMemberEditIsEdit];
    if(NotNilAndNull(editState)){
        _btnSelect.hidden = ![editState boolValue];
    }
    
}


@end
