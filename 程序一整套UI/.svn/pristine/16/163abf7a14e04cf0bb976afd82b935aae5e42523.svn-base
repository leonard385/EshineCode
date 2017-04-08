//
//  MMTrainOfflineDetailHead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOfflineDetailHead.h"
#import "MMTrainOfflineDetailBtnItem.h"
@interface MMTrainOfflineDetailHead()<UIScrollViewDelegate>
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIButton *btnQrCode;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *sendName;
@property(nonatomic,strong)UILabel *sendTime;
@property(nonatomic,strong)UIImageView *iconClock;
@property(nonatomic,strong)UILabel *lableDate;
@property(nonatomic,strong)UILabel *lableContent;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIButton *btnDrop;
@property(nonatomic,strong)UIScrollView *segScrollView;
@property(nonatomic,strong)UIView *segContentView;
@property(nonatomic,strong)UIView *progressView;
@property(nonatomic,strong)MMTrainOfflineDetailBtnItem *currentSelected;
@property(nonatomic,strong)NSMutableArray *btnItems;
@end
@implementation MMTrainOfflineDetailHead
-(NSMutableArray *)btnItems{
    if(_btnItems == nil){
        _btnItems = [NSMutableArray new];
    }
    return _btnItems;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:17.0f]];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.numberOfLines = 0.0f;
    }
    return _lableTitle;
}

-(UIButton *)btnQrCode{
    if(_btnQrCode == nil){
        _btnQrCode = [UIButton new];
        [_btnQrCode setImage:[UIImage imageNamed:@"icon_erweima"] forState:UIControlStateNormal];
        [_btnQrCode.imageView setContentMode:UIViewContentModeCenter];
        [_btnQrCode addTarget:self action:@selector(btnQrCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnQrCode;
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

-(UILabel *)sendTime{
    if(_sendTime == nil){
        _sendTime = [UILabel new];
        [_sendTime setFont:[UIFont systemFontOfSize:12.0f]];
        _sendTime.textColor = HEXCOLOR(0x999999);
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

-(UIScrollView *)segScrollView{
    if(_segScrollView == nil){
        _segScrollView = [UIScrollView new];
        _segScrollView.showsHorizontalScrollIndicator = NO;
        _segScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        _segScrollView.backgroundColor = HEXCOLOR(0xefeff4);
        _segScrollView.bounces = NO;
        _segScrollView.delegate = self;
    }
    return _segScrollView;
}

-(UIView *)progressView{
    if(_progressView == nil){
        _progressView = [UIView new];
        _progressView.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _progressView;
}

-(UIView *)segContentView{
    if(_segContentView == nil){
        _segContentView = [UIView new];
        _segContentView.backgroundColor = [UIColor whiteColor];
    }
    return  _segContentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _drop = NO;
        [self WDSetUpSubviews];
    }
    return self;
}

-(void)WDSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.headImageView];
    [self addSubview:self.btnQrCode];
    [self addSubview:self.sendName];
    [self addSubview:self.sendTime];
    [self addSubview:self.iconClock];
    [self addSubview:self.lableDate];
    [self addSubview:self.lableContent];
    [self addSubview:self.line];
    [self addSubview:self.btnDrop];
    [self addSubview:self.segScrollView];
    [self.segScrollView addSubview:self.segContentView];
    [self.segContentView addSubview:self.progressView];
}

-(void)setFrameModel:(MMTrainOfflineHeadFrame *)frameModel{
    _frameModel = frameModel;
    [self setFrameWithModel:frameModel];
    [self setViewModel:frameModel.viewModel];
    
    //segmentScroller
    if(_btnItems.count == 0){
    [self.segContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnItems removeAllObjects];
    NSArray *titles = frameModel.viewModel.segmentTitles;
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MMTrainOfflineDetailBtnItem *btnItem = [MMTrainOfflineDetailBtnItem new];
        NSValue *value = frameModel.btnFrames[idx];
        CGRect itemFrame;
        [value getValue:&itemFrame];
        btnItem.frame = itemFrame;
        [btnItem setTitle:obj];
        [btnItem setIdex:idx + 1];
        btnItem.tag = idx;
        if(idx == 0){
            self.progressView.frame = itemFrame;
            [_segContentView addSubview:self.progressView];
            _currentSelected = btnItem;
            _currentSelected.selected = YES;
            
        }
        [btnItem addTarget:self action:@selector(segBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_segContentView addSubview:btnItem];
        [_btnItems addObject:btnItem];
    }];
    }
    
}

-(void)setFrameWithModel:(MMTrainOfflineHeadFrame *)frameModel{
    _lableTitle.frame = frameModel.titleFrame;
    _btnQrCode.frame = frameModel.qrCodeFrame;
    _headImageView.frame = frameModel.headImageFrame;
    _sendName.frame = frameModel.userNameFrame;
    _sendTime.frame = frameModel.timeFrame;
    _iconClock.frame = frameModel.iconFrame;
    _lableDate.frame = frameModel.dateFrame;
    _lableContent.frame = frameModel.contentFrame;
    _lableContent.numberOfLines = frameModel.contentLines;
    _line.frame = frameModel.lineFrame;
    _btnDrop.frame = frameModel.btnDropFrame;
    _segScrollView.frame = frameModel.scrollerFrame;
    _segScrollView.contentSize = frameModel.scrollerContentSize;
    _segContentView.frame = frameModel.segContentFrame;
    
    CGRect contentFrame = self.frame;
    contentFrame.size.height = frameModel.contentHeight;
    self.frame = contentFrame;
}

-(void)setViewModel:(MMTrainOfflineHeadModel *)viewModel{
    _lableTitle.text = viewModel.title;
    _sendName.text = viewModel.userName;
    _sendTime.text = viewModel.trainTime;
    _lableDate.text = viewModel.trainDate;
    _lableContent.text = viewModel.content;
}

#pragma mark - 按钮点击
-(void)segBtnClick:(MMTrainOfflineDetailBtnItem *)sender{
    [self progressLineMoveTo:sender.tag];
    if ([_delegate respondsToSelector:@selector(TOMenuBtnClick:)]){
        [_delegate TOMenuBtnClick:sender.tag];
    }
}
#pragma mark - 背景移动
-(void)progressLineMoveTo:(NSUInteger)index{
    //btn选择
    MMTrainOfflineDetailBtnItem *indexBtn = _btnItems[index];
    CGPoint center = indexBtn.center;
    [UIView animateWithDuration:0.2 delay:0.0f usingSpringWithDamping:0.8 initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _currentSelected.selected = NO;
        _currentSelected = indexBtn;
        _currentSelected.selected = YES;
        self.progressView.center = center;
        [self refreshContenOffset];
    } completion:^(BOOL finished) {
      
    }];
}

#pragma mark - 移动居中
- (void)refreshContenOffset {
    CGRect frame = _currentSelected.frame;
    CGFloat itemX = frame.origin.x;
    CGFloat width = _segScrollView.frame.size.width;
    CGSize contentSize = _segScrollView.contentSize;
    if (itemX > width/2) {
        CGFloat targetX;
        if ((contentSize.width-itemX) <= width/2) {
            targetX = contentSize.width - width;
        } else {
            targetX = frame.origin.x - width/2 + frame.size.width/2;
        }
        // 应该有更好的解决方法
        if (targetX + width > contentSize.width) {
            targetX = contentSize.width - width;
        }
        [_segScrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    } else {
        [_segScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
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

#pragma mark - 二维码点击
-(void)btnQrCodeClick{
    
    
    _qrCodeClickBlock?_qrCodeClickBlock():nil;
}



@end
