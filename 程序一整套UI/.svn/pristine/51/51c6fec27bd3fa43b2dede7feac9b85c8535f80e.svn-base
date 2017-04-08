//
//  MMTainTableHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTainTableHeadView.h"
@interface  MMTainTableHeadView()
@property(nonatomic,strong)UIImageView *posterImageView;//海报
@property(nonatomic,strong)UIImageView *headImageView;//头像
@property(nonatomic,strong)UILabel *sendName;//作者名称
@property(nonatomic,strong)UIImageView *iconClock;//时间icon
@property(nonatomic,strong)UILabel *lableDate;//时间
@property(nonatomic,strong)UILabel *lableContent;//内容
@property(nonatomic,strong)UIView *line;//线
@property(nonatomic,strong)UIButton *btnDrop;//按钮
@property(nonatomic,strong)UIView *lineView;//线
@end
@implementation MMTainTableHeadView

-(UIImageView *)posterImageView{
    if(_posterImageView == nil){
        _posterImageView = [UIImageView new];
        _posterImageView.backgroundColor = [UIColor redColor];
    }
    return _posterImageView;
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
    }
    return _sendName;
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
    }
    return _lableDate;
}

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        [_lableContent setFont:[UIFont systemFontOfSize:14.0f]];
        _lableContent.textColor = HEXCOLOR(0x999999);
        _lableContent.numberOfLines = 2.0f;
        _lableContent.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _lableContent;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line;
}

-(UIButton *)btnDrop{
    if(_btnDrop == nil){
        _btnDrop = [UIButton new];
        [_btnDrop setImage:[UIImage imageNamed:@"icon_zhankai"] forState:UIControlStateNormal];
        [_btnDrop addTarget:self action:@selector(dropBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDrop;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _drop = NO;
        [self TTSetUpSubviews];
    }
    return self;
}

-(void)TTSetUpSubviews{
    [self addSubview:self.posterImageView];
    [self addSubview:self.headImageView];
    [self addSubview:self.sendName];
    [self addSubview:self.iconClock];
    [self addSubview:self.lableDate];
    [self addSubview:self.lableContent];
    [self addSubview:self.line];
    [self addSubview:self.btnDrop];
    [self addSubview:self.lineView];
}

#pragma mark - 展开点击
-(void)dropBtnClick:(UIButton *)sender{
    BOOL dropState = _frameModel.isDrop;
    dropState = !dropState;
    [UIView animateWithDuration:0.8 animations:^{
        if(dropState){
            sender.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            sender.transform = CGAffineTransformIdentity;
        }
    }];
    
    _dropClickBlock?_dropClickBlock(dropState):nil;
}

-(void)setFrameModel:(MMTrainHeadFrameModel *)frameModel{
    _frameModel = frameModel;
    [self setFrameWithModel:frameModel];
    [self setViewModel:frameModel.viewModel];
}

-(void)setFrameWithModel:(MMTrainHeadFrameModel *)frameModel{
    _posterImageView.frame = frameModel.posterImageFrame;
    _headImageView.frame = frameModel.headImageFrame;
    _sendName.frame = frameModel.userNameFrame;
    _iconClock.frame = frameModel.iconFrame;
    _lableDate.frame = frameModel.dateFrame;
    _lableContent.frame = frameModel.contentFrame;
    _lableContent.numberOfLines = frameModel.contentLines;
    _line.frame = frameModel.lineFrame;
    _btnDrop.frame = frameModel.btnDropFrame;
    _lineView.frame = frameModel.lineViewFrame;
    
    CGRect contentFrame = self.frame;
    contentFrame.size.height = frameModel.contentHeight;
    self.frame = contentFrame;
}

-(void)setViewModel:(MMTrainHeadModel *)viewModel{
    _sendName.text = viewModel.userName;
    _lableDate.text = viewModel.date;
    _lableContent.text = viewModel.content;
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
