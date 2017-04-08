//
//  MMWorkDispatchTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkDispatchTableViewCell.h"
#import <MBCircularProgressBar/MBCircularProgressBarView.h>
@interface MMWorkDispatchTableViewCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *lableTime;
@property(nonatomic,strong)MBCircularProgressBarView *progressView;
@end

@implementation MMWorkDispatchTableViewCell

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(0x999999)];
        _lableSubtitle.numberOfLines = 1.0f;
        _lableSubtitle.lineBreakMode = NSLineBreakByTruncatingTail;
        [_lableSubtitle setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _lableSubtitle;
}

-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

-(UILabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [UILabel new];
        [_lableTime setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _lableTime;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _cellLine;
}

-(MBCircularProgressBarView *)progressView{
    if(_progressView == nil){
        _progressView = [MBCircularProgressBarView new];
        _progressView.valueFontSize = 12.0f;
        _progressView.unitFontSize = 10.0f;
        _progressView.fontColor = HEXCOLOR(0x888888);
        _progressView.progressAngle = 100.0f;
        _progressView.emptyLineWidth = 2.0f;
        _progressView.emptyLineStrokeColor = HEXCOLOR(0xf8f8f8);
        _progressView.progressLineWidth = 2.0f;
        _progressView.progressColor = HEXCOLOR(kBlueColor);
        _progressView.progressStrokeColor = HEXCOLOR(kBlueColor);
        _progressView.progressRotationAngle = 50.0f;
        _progressView.maxValue = 100.0f;
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self WDSetUpSubviews];
    }
    return self;
}

-(void)WDSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.lableTime];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.cellLine];
    [self.contentView addSubview:self.progressView];
    
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(18.0f);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(21.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(10.0f);
        make.height.mas_equalTo(21.0f);
        make.left.right.mas_equalTo(_lableTitle);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_progressView);
        make.height.mas_equalTo(19.0f);
        make.right.mas_equalTo(_progressView.mas_left).with.offset(-8.0f);
        make.left.mas_equalTo(_iconImageView.mas_right).with.offset(5.0f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableSubtitle);
        make.size.mas_equalTo(CGSizeMake(14.0f, 14.0f));
        make.centerY.mas_equalTo(_lableTime);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.mas_equalTo(_lableSubtitle.mas_bottom).with.offset(10.0f);
        make.size.mas_equalTo(CGSizeMake(34.0f, 34.0f));
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)setCellModel:(MMWorkDispatchModel *)cellModel{
    _cellModel = cellModel;
    switch ([_cellModel.taskType integerValue]) {
        case overTimeType:{
            _iconImageView.image = [UIImage imageNamed:@"content_chaoshi"];
            _lableTime.textColor = HEXCOLOR(0xff6d48);
        }
            break;
        case unClaimType:{
            _iconImageView.image = [UIImage imageNamed:@"content_jieshou"];
            _lableTime.textColor = HEXCOLOR(kBlueColor);
        }
            break;
        case onProcessType:{
            _iconImageView.image = [UIImage imageNamed:@"content_jingxing"];
            _lableTime.textColor = HEXCOLOR(0x15c98d);
        }
            break;
        case completeType:{
            _iconImageView.image = [UIImage imageNamed:@"content_wancheng"];
            _lableTime.textColor = HEXCOLOR(0x999999);
        }
            break;
        default:
            break;
    }
    
    _lableTitle.text = cellModel.title;
    _lableSubtitle.text = cellModel.subTitle;
    _lableTime.text = cellModel.time;
    
    CGFloat progress = [cellModel.progress floatValue];
    [UIView animateWithDuration:2.0f animations:^{
        _progressView.value = progress;
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
