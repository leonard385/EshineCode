//
//  MMSProgressView.m
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/28.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "MMSProgressView.h"
@interface MMSProgressView()
@property(nonatomic,strong)UIView *ProgressView;//进度父视图
@property(nonatomic,strong)CAShapeLayer *BackGroudLayer;//背景动图
@property(nonatomic,strong)UILabel *LableProgress;//进度显示

@property(nonatomic,strong)UIView *RetryView;//进度父视图
@property(nonatomic,strong)UIImageView *ReupdateImage;
@property(nonatomic,strong)UILabel *LableTip;

@property(nonatomic,strong)UITapGestureRecognizer  *tap;

//@property(nonatomic,assign)CGFloat Height;
@end
@implementation MMSProgressView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    _Height = self.bounds.size.height;
}

-(instancetype)init
{
    self = [super init];
    if(self){
        [self PgSetUpSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(UIView *)ProgressView
{
    if(_ProgressView == nil){
        
        _ProgressView = [UIView new];
        _ProgressView.backgroundColor = [UIColor clearColor];
    }
    return _ProgressView;
}


-(UILabel *)LableProgress
{
    if(_LableProgress == nil){
        _LableProgress = [UILabel new];
        [_LableProgress setTextColor:[UIColor whiteColor]];
         _LableProgress.numberOfLines = 0;
        [_LableProgress setFont:[UIFont systemFontOfSize:10.0f]];
        [_LableProgress setTextAlignment:NSTextAlignmentCenter];
    }
    return _LableProgress;
}

-(UIView *)RetryView
{
    if(_RetryView == nil){
        
        _RetryView = [UIView new];
        _RetryView.backgroundColor = HEXCOLOR(0xf7f7f7);
    }
    return _RetryView;
}

-(UIImageView *)ReupdateImage
{
    if(_ReupdateImage == nil){
        _ReupdateImage = [UIImageView new];
        _ReupdateImage.image = [UIImage imageNamed:@"uploadRetry"];
        [_ReupdateImage setContentMode:UIViewContentModeCenter];
    }
    return _ReupdateImage;
}

-(UITapGestureRecognizer *)tap
{
    if(_tap == nil){
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retryClick)];
    }
    return _tap;
}

-(UILabel *)LableTip
{
    if(_LableTip == nil){
        
        _LableTip = [UILabel new];
        [_LableTip setTextColor:HEXCOLOR(0xFF6E6E)];
        [_LableTip setFont:[UIFont systemFontOfSize:10.0f]];
        _LableTip.text = @"重新上传";
        [_LableTip setTextAlignment:NSTextAlignmentCenter];
    }
    return _LableTip;
}

-(void)PgSetUpSubViews
{
    
    
    [self addSubview:self.RetryView];
    [self.RetryView addSubview:self.ReupdateImage];
    [self.RetryView addSubview:self.LableTip];
    [self.RetryView addGestureRecognizer:self.tap];
    _RetryView.hidden = YES;
    
    [self addSubview:self.ProgressView];
    [self.ProgressView addSubview:self.LableProgress];
    
    [self.ProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.LableProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_ProgressView);
        make.bottom.mas_equalTo(_ProgressView.mas_bottom).with.offset(-10.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    [self.RetryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.ReupdateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_RetryView);
        make.size.mas_equalTo(CGSizeMake(14.0f, 13.0f));
    }];
    [self.LableTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ReupdateImage.mas_bottom).with.offset(4.0f);
        make.left.right.mas_equalTo(_RetryView);
        make.height.mas_equalTo(14.0f);
    }];
}

-(void)setProgress:(CGFloat)Progress
{
    
    _ProgressView.hidden = NO;
    _RetryView.hidden = YES;
    
    Progress = MAX( MIN(Progress, 1.0), 0.0); // keep it between 0 and 1
    
    if (_Progress == Progress) {
        return;
    }
    
    CGFloat height = (CGRectGetHeight(_ProgressView.frame)*(1.0f - Progress));
    [_BackGroudLayer removeFromSuperlayer];
    _BackGroudLayer = nil;

   UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(_ProgressView.frame)-height, CGRectGetWidth(_ProgressView.frame), height) cornerRadius:0];
    _BackGroudLayer = [CAShapeLayer layer];
    _BackGroudLayer.path = path.CGPath;
    _BackGroudLayer.fillColor = HEXCOLOR(kBlueColor).CGColor;
   [_ProgressView.layer addSublayer:_BackGroudLayer];
    
    _Progress = Progress;
    
    _LableProgress.text = [NSString stringWithFormat:@"正在上传\n%0.f%%",Progress * 100];
    [_ProgressView bringSubviewToFront:_LableProgress];
}


#pragma mark  - 重新点击
-(void)retryClick
{
    _RetryClickBlock?_RetryClickBlock():nil;
    _RetryView.hidden = YES;
}

-(void)setUploadFailed
{
    _ProgressView.hidden = YES;
    _RetryView.hidden = NO;
}

//uploadRetry


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
