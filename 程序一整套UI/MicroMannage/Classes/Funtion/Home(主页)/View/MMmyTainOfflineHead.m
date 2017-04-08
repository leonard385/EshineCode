//
//  MMmyTainOfflineHead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMmyTainOfflineHead.h"
#import "MMTrainOfflineLocBtn.h"
#import "MMTrainOffdetailItem.h"
@interface MMmyTainOfflineHead()
@property(nonatomic,strong)UIView *locContent;//定位content
@property(nonatomic,strong)MMTrainOfflineLocBtn *btnCard;//签到
@property(nonatomic,strong)MMTrainOffdetailItem *btnMap;//查看地图
@property(nonatomic,strong)MMTrainOffdetailItem *btnReloc;//重新定位
@property(nonatomic,strong)UILabel *lableLocAddr;//定位地址

@property(nonatomic,strong)UIView *infoContent;
@property(nonatomic,strong)UIImageView *headImageView;//头像
@property(nonatomic,strong)UILabel *sendName;//作者名称
@property(nonatomic,strong)UILabel *sendTime;//时间
@property(nonatomic,strong)UIImageView *iconClock;//时间icon
@property(nonatomic,strong)UILabel *lableDate;//时间
@property(nonatomic,strong)UILabel *lableSpeaker;//主讲人
@property(nonatomic,strong)UIImageView *locIconImage;//定位图标
@property(nonatomic,strong)UILabel *lableAddr;//定位地址
@property(nonatomic,strong)UIView *lineView;
@end

@implementation MMmyTainOfflineHead

-(UIView *)locContent{
    if(_locContent == nil){
        _locContent = [UIView new];
        _locContent.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _locContent;
}

-(MMTrainOfflineLocBtn *)btnCard{//110.0f 110.0f
    if(_btnCard == nil){
        _btnCard = [MMTrainOfflineLocBtn new];
        _btnCard.layer.cornerRadius = 55.0f;
        _btnCard.layer.borderWidth = 6.0f;
        _btnCard.layer.masksToBounds = YES;
        _btnCard.layer.borderColor = HEXCOLOR(0x62acf7).CGColor;
        [_btnCard setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCard setBackgroundColor:HEXCOLOR(0x757575) forState:UIControlStateHighlighted];
        [_btnCard addTarget:self action:@selector(TOCardClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCard;
}


-(MMTrainOffdetailItem *)btnMap{
    if(_btnMap == nil){
        _btnMap = [MMTrainOffdetailItem new];
        [_btnMap setImage:[UIImage imageNamed:@"icon_ckdt"] forState:UIControlStateNormal];
        [_btnMap setTitle:@"查看地图" forState:UIControlStateNormal];
        [_btnMap setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnMap addTarget:self action:@selector(TOMapClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMap;
}

-(MMTrainOffdetailItem *)btnReloc{
    if(_btnReloc == nil){
        _btnReloc = [MMTrainOffdetailItem new];
        [_btnReloc setImage:[UIImage imageNamed:@"icon_cxdw"] forState:UIControlStateNormal];
        [_btnReloc setTitle:@"重新定位" forState:UIControlStateNormal];
        [_btnReloc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnReloc addTarget:self action:@selector(TORelocClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnReloc;
}

-(UILabel *)lableLocAddr{
    if(_lableLocAddr == nil){
        _lableLocAddr = [UILabel new];
        [_lableLocAddr setFont:[UIFont systemFontOfSize:12.0f]];
        [_lableLocAddr setTextAlignment:NSTextAlignmentCenter];
        [_lableLocAddr setTextColor:[UIColor whiteColor]];
        _lableLocAddr.text = @"当前位置:广州市天河区建中路8号";
    }
    return _lableLocAddr;
}

-(UIView *)infoContent{
    if(_infoContent == nil){
        _infoContent = [UIView new];
        _infoContent.backgroundColor = [UIColor whiteColor];
    }
    return _infoContent;
}

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
        _headImageView.layer.cornerRadius = 13.0f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)sendName{
    if(_sendName == nil){
        _sendName = [UILabel new];
        [_sendName setFont:[UIFont systemFontOfSize:13.0f]];
        _sendName.textColor = HEXCOLOR(0x333333);
        _sendName.text = @"柳叶叶";
    }
    return _sendName;
}

-(UILabel *)sendTime{
    if(_sendTime == nil){
        _sendTime = [UILabel new];
        [_sendTime setFont:[UIFont systemFontOfSize:13.0f]];
        _sendTime.textColor = HEXCOLOR(0x999999);
        _sendTime.text = @"09:00";
    }
    return _sendTime;
}

-(UIImageView *)iconClock{
    if(_iconClock == nil){
        _iconClock = [UIImageView new];
        _iconClock.image = [UIImage imageNamed:@"content_jieshou"];
    }
    return _iconClock;
}

-(UILabel *)lableDate{
    if(_lableDate == nil){
        _lableDate = [UILabel new];
        [_lableDate setFont:[UIFont systemFontOfSize:13.0f]];
        _lableDate.textColor = HEXCOLOR(kBlueColor);
        _lableDate.text = @"2017-03-27";
    }
    return _lableDate;
}

-(UILabel *)lableSpeaker{
    if(_lableSpeaker == nil){
        _lableSpeaker = [UILabel new];
        [_lableSpeaker setFont:[UIFont systemFontOfSize:14.0f]];
        _lableSpeaker.textColor = HEXCOLOR(0x666666);
        _lableSpeaker.text = @"授课老师:柳教授";
    }
    return _lableSpeaker;
}

-(UIImageView *)locIconImage{
    if(_locIconImage == nil){
        _locIconImage = [UIImageView new];
        _locIconImage.image = [UIImage imageNamed:@"icon_ditu"];
    }
    return _locIconImage;
}

-(UILabel *)lableAddr{
    if(_lableAddr == nil){
        _lableAddr = [UILabel new];
        [_lableAddr setFont:[UIFont systemFontOfSize:14.0f]];
        _lableAddr.textColor = HEXCOLOR(0x666666);
        _lableAddr.text = @"当前位置:广州市天河区建中路8号";
    }
    return _lableAddr;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self TOSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self TOSetUpSubviews];
    }
    return self;
}

#pragma mark - 子视图
-(void)TOSetUpSubviews{
 
    [self addSubview:self.locContent];
    [self.locContent addSubview:self.btnCard];
    [self.locContent addSubview:self.btnMap];
    [self.locContent addSubview:self.btnReloc];
    [self.locContent addSubview:self.lableLocAddr];
    [self addSubview:self.infoContent];
    [self.infoContent addSubview:self.headImageView];
    [self.infoContent addSubview:self.sendName];
    [self.infoContent addSubview:self.sendTime];
    [self.infoContent addSubview:self.iconClock];
    [self.infoContent addSubview:self.lableDate];
    [self.infoContent addSubview:self.lableSpeaker];
    [self.infoContent addSubview:self.locIconImage];
    [self.infoContent addSubview:self.lableAddr];
    [self addSubview:self.lineView];
   
    [_locContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(174.0f);
    }];
    
    [_infoContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_locContent.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(140.0f);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(10.0f);
    }];
    [_lableLocAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_locContent).with.offset(15.0f);
        make.height.mas_equalTo(15.0f);
        make.left.right.mas_equalTo(_locContent);
    }];
    
    [_btnCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableLocAddr.mas_bottom).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(110.0f, 110.0f));
        make.centerX.mas_equalTo(_locContent);
    }];
    
    [_btnMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btnCard.mas_right).with.offset(24.0f);
        make.size.mas_equalTo(CGSizeMake(58.0f, 63.0f));
        make.bottom.mas_equalTo(_btnCard).with.offset(-4.0f);
    }];
    
    [_btnReloc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_btnCard.mas_left).with.offset(-24.0f);
        make.size.mas_equalTo(CGSizeMake(58.0f, 63.0f));
        make.bottom.mas_equalTo(_btnMap);
    }];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(_infoContent).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
    }];
    
    [_sendName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(7.0f);
        make.top.bottom.mas_equalTo(_headImageView);
        make.width.mas_equalTo(60.0f);
    }];
    
    [_sendTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_sendName.mas_right).with.offset(7.0f);
        make.top.bottom.mas_equalTo(_sendName);
        make.width.mas_equalTo(60.0f);
    }];
    
    [_lableDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(130.0f);
        make.top.bottom.mas_equalTo(_sendName);
        make.right.mas_equalTo(_infoContent).with.offset(-12.0f);
    }];
    
    [_iconClock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_lableDate.mas_left).with.offset(-7.0f);
        make.centerY.mas_equalTo(_lableDate);
        make.size.mas_equalTo(CGSizeMake(13.0f, 13.0f));
    }];
    
    [_lableSpeaker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(12.0f);
        make.left.mas_equalTo(_headImageView);
        make.right.mas_equalTo(_lableDate);
        make.height.mas_equalTo(20.0f);
    }];
    
    [_locIconImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableSpeaker);
        make.top.mas_equalTo(_lableSpeaker.mas_bottom).with.offset(5.0f);
        make.size.mas_equalTo(CGSizeMake(15.0f, 18.0f));
    }];
    
    [_lableAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_locIconImage.mas_right).with.offset(7.0f);
        make.top.bottom.mas_equalTo(_locIconImage);
        make.right.mas_equalTo(_infoContent).with.offset(-12.0f);
    }];
}

#pragma mark - 打卡
-(void)TOCardClick{
    _cardClickBlock?_cardClickBlock():nil;
}

#pragma mark - 查看地图
-(void)TOMapClick{
    _mapClickBlock?_mapClickBlock():nil;
}
#pragma mark - 定位
-(void)TORelocClick{
    _relocClickBlock?_relocClickBlock():nil;
}

#pragma mark - 调整时间
-(void)adjustTimeToNow{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
