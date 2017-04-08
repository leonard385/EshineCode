//
//  MMNoticeMessageTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMNoticeMessageTableViewCell.h"
#import "AYBubbleView.h"
@interface MMNoticeMessageTableViewCell()
@property(nonatomic,strong)UIImageView  *headImageView;
@property(nonatomic,strong)AYBubbleView *BubbleView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UILabel *lableTime;
@end

@implementation MMNoticeMessageTableViewCell

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bth_icon_tianjiaqunzu"]];
        _headImageView.layer.cornerRadius = 5.0f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.text = @"系统通知";
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(0x666666)];
        _lableSubtitle.numberOfLines = 1.0f;
        _lableSubtitle.lineBreakMode = NSLineBreakByTruncatingTail;
        [_lableSubtitle setFont:[UIFont systemFontOfSize:12.0f]];
        _lableSubtitle.text = @"新政策已下发务必落实";
    }
    return _lableSubtitle;
}

-(UILabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [UILabel new];
        [_lableTime setTextColor:HEXCOLOR(0x999999)];
        [_lableTime setFont:[UIFont systemFontOfSize:12.0f]];
        [_lableTime setTextAlignment:NSTextAlignmentRight];
        _lableTime.text = @"08:00";
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
    _BubbleView.unReadLabel.text = @"4";
    
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.lableTime];
    [self.contentView addSubview:self.cellLine];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(15.0f);
        make.top.mas_equalTo(_headImageView);
        make.right.mas_equalTo(_lableTime.mas_left).with.offset(-10.0f);
        make.height.mas_equalTo(21.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(4.0f);
        make.height.mas_equalTo(21.0f);
        make.left.right.mas_equalTo(_lableTitle);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle);
        make.height.mas_equalTo(19.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.width.mas_equalTo(60.0f);
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
