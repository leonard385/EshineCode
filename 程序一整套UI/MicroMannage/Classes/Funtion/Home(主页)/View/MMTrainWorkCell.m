//
//  MMTrainWorkCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainWorkCell.h"
#import "AYBubbleView.h"
#import "NSString+Size.h"
@interface MMTrainWorkCell()
@property(nonatomic,strong)UIImageView  *headImageView;
@property(nonatomic,strong)AYBubbleView *BubbleView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *lableTime;
@property(nonatomic,strong)UIImageView *iconPeople;
@property(nonatomic,strong)UILabel *lableAttend;
@end

@implementation MMTrainWorkCell

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor orangeColor];
        _headImageView.layer.cornerRadius = 2.5f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
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

-(UIImageView *)iconPeople{
    if(_iconPeople == nil){
        _iconPeople = [UIImageView new];
        _iconPeople.image = [UIImage imageNamed:@"content_renyuan"];
        _iconPeople.contentMode = UIViewContentModeCenter;
    }
    return _iconPeople;
}

-(UILabel *)lableAttend{
    if(_lableAttend == nil){
        _lableAttend = [UILabel new];
        _lableAttend.textColor = HEXCOLOR(0x999999);
        [_lableAttend setTextAlignment:NSTextAlignmentRight];
        [_lableAttend setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _lableAttend;
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
        [self WBSetUpSubviews];
    }
    return self;
}

-(void)WBSetUpSubviews{
    [self.contentView addSubview:self.headImageView];
    self.headImageView.frame = CGRectMake(12.0f, 16.0f, 50.0f, 50.0f);
    CGFloat bubbleCenterX = CGRectGetMaxX(_headImageView.frame);
    CGFloat bubbleCenterY = CGRectGetMinY(_headImageView.frame);
    CGPoint bubbleCenter =  CGPointMake(bubbleCenterX, bubbleCenterY);
    _BubbleView = [[AYBubbleView alloc]initWithCenterPoint:bubbleCenter bubleRadius:10.0f addToSuperView:self.contentView];
    _BubbleView.decayCoefficent = .2;
    _BubbleView.bubbleColor = [UIColor redColor];
    _BubbleView.unReadLabel.font = [UIFont systemFontOfSize:9.0f];
    
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.lableTime];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.iconPeople];
    [self.contentView addSubview:self.lableAttend];
    [self.contentView addSubview:self.cellLine];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(15.0f);
        make.top.mas_equalTo(_headImageView);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(21.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(4.0f);
        make.height.mas_equalTo(21.0f);
        make.left.right.mas_equalTo(_lableTitle);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableSubtitle.mas_bottom).with.offset(8.0f);
        make.height.mas_equalTo(19.0f);
        make.right.mas_equalTo(_iconPeople.mas_left).with.offset(-8.0f);
        make.left.mas_equalTo(_iconImageView.mas_right).with.offset(5.0f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableSubtitle);
        make.size.mas_equalTo(CGSizeMake(14.0f, 14.0f));
        make.centerY.mas_equalTo(_lableTime);
    }];
    
    [_lableAttend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.width.mas_equalTo(30.0f);
        make.top.bottom.mas_equalTo(_lableTime);
    }];
    
    [_iconPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_lableAttend.mas_left).with.offset(-2.0f);
        make.size.mas_equalTo(CGSizeMake(14.0f, 14.0f));
        make.centerY.mas_equalTo(_lableTime);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    WeakSelf();
    [_BubbleView setCleanMessageBlock:^(BOOL isClean) {
        [weakself cleanMessage:isClean];
    }];
    
}


#pragma mark - 气泡事件
-(void)cleanMessage:(bool)isClean{
    
}

-(void)setCellModel:(MMTrainWorkModel *)cellModel{
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
    
    NSString *unReadStr;
    NSUInteger unReadNum  = [cellModel.unRead integerValue];
    if(unReadNum > 99){
        unReadStr = @"99+";
    }else{
        unReadStr = [cellModel.unRead stringValue];
    }
    
    _BubbleView.unReadLabel.text = unReadStr;
    [_BubbleView showBubbleView];
    
    _lableAttend.text = [cellModel.attend stringValue];
   
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
