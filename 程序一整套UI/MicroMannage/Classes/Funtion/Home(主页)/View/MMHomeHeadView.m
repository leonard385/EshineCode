//
//  MMHomeHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMHomeHeadView.h"
#import "SDCycleScrollView.h"
#import "MMHomeFuncBtnItem.h"
#import "MMHomeBtnItemModel.h"
#import "YYText.h"

#define kcycleViewH 209.0f
#define kfuncScrollerH 100.0f
#define kTagOffset 100

@interface MMHomeHeadView()<SDCycleScrollViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *cycleView;//轮播图
@property(nonatomic,strong)UIView  *funcContent;//功能Content
@property(nonatomic,strong)NSArray *titles;//titles
@property(nonatomic,strong)NSMutableArray *itemsArray;//按钮数组titles
@property(nonatomic,strong)UIView *barLine;
@property(nonatomic,strong)UIButton *btnTip;
@end

@implementation MMHomeHeadView

-(NSMutableArray *)itemsArray{
    if(_itemsArray == nil){
        _itemsArray = [NSMutableArray new];
    }
    return _itemsArray;
}

-(SDCycleScrollView *)cycleView{
    if(_cycleView == nil){
//  _cycleView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -kNavigationBarAndStateBarHeight, kScreenWidth, kcycleViewH) delegate:self placeholderImage:[UIImage imageNamed:@"camera"]];
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kScreenWidth, kcycleViewH) shouldInfiniteLoop:YES imageNamesGroup:@[@"bg",@"bg",@"bg"]];
        _cycleView.pageDotColor = HEXCOLOR(0xcccccc);
        _cycleView.currentPageDotColor = HEXCOLOR(kBlueColor);
        _cycleView.delegate = self;
    }
    return _cycleView;
}

-(UIView *)funcContent{
    if(_funcContent == nil){
        _funcContent = [UIView new];
        _funcContent.backgroundColor = [UIColor whiteColor];
        _funcContent.frame = CGRectMake(0, kcycleViewH, kScreenWidth, kfuncScrollerH);
        //添加按钮
       [_titles enumerateObjectsUsingBlock:^(MMHomeBtnItemModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
           CGFloat BtnItemW = kScreenWidth / 4;
           CGFloat BtnItemH = kfuncScrollerH;
           MMHomeFuncBtnItem *btnItem = [[MMHomeFuncBtnItem alloc]initWithFrame:CGRectMake(idx+idx*BtnItemW, 0, BtnItemW, BtnItemH)];
           [btnItem setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
           [btnItem setTitle:model.title forState:UIControlStateNormal];
           [btnItem setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
           [btnItem.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
           [btnItem.titleLabel setTextAlignment:NSTextAlignmentCenter];
           btnItem.tag = kTagOffset + idx;
           [btnItem setHasTask:YES];
           [btnItem addTarget:self action:@selector(HHFuncBtnClick:) forControlEvents:UIControlEventTouchUpInside];
           [_funcContent addSubview:btnItem];
           [_itemsArray addObject:btnItem];
       }];
    }
    return _funcContent;
}

-(UIView *)barLine{
    if(_barLine == nil){
        _barLine = [UIView new];
        _barLine.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _barLine;
}

-(UIButton *)btnTip{
    if(_btnTip == nil){
        _btnTip = [UIButton new];
        [_btnTip setImage:[UIImage imageNamed:@"icon_gonggao"] forState:UIControlStateNormal];
        [_btnTip setAttributedTitle:[self getAtrstrWithNum:@"100"] forState:UIControlStateNormal];
        [_btnTip setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnTip addTarget:self action:@selector(btnTipClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTip;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self HHSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self HHSetUpSubviews];
    }
    return self;
}

-(instancetype)initWithItems:(NSArray *)array Frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = [array copy];
        [self HHSetUpSubviews];
    }
    return self;
}

#pragma mark  - SetUpSubviews
-(void)HHSetUpSubviews{
    [self addSubview:self.cycleView];
    [self addSubview:self.funcContent];
    [self addSubview:self.barLine];
    [self addSubview:self.btnTip];
    
    CGFloat barlineY = CGRectGetMaxY(self.funcContent.frame);
    _barLine.frame = CGRectMake(0, barlineY, kScreenWidth, 0.5f);
    
    CGFloat btnTipX = 0.0f;
    CGFloat btnTipY = CGRectGetMaxY(_barLine.frame);
    CGFloat btnTipW = kScreenWidth;
    CGFloat btnTipH = 44.0f;
    _btnTip.frame = CGRectMake(btnTipX, btnTipY, btnTipW, btnTipH);
    
}

#pragma mark - 功能按钮点击
-(void)HHFuncBtnClick:(UIButton *)sender{
    NSUInteger tag = sender.tag - kTagOffset;
    NSLog(@"%lu",tag);
    _FuncBtnClickBlock?_FuncBtnClickBlock(tag):nil;
}

#pragma mark - 轮播器点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    _ADClickBlock?_ADClickBlock(index):nil;
}

-(void)setADClickBlock:(ADClick)ADClickBlock FuncBtnClickBlock:(FuncBtnClick)FuncBtnClickBlock{
    _ADClickBlock = ADClickBlock;
    _FuncBtnClickBlock = FuncBtnClickBlock;
}

-(void)setADImagePaths:(NSArray *)ADImagePaths{
    _ADImagePaths = ADImagePaths;
    [_cycleView setImageURLStringsGroup:ADImagePaths];
}

#pragma mark - 通知点击
-(void)btnTipClick{
  
}

#pragma mark - 富文本处理
-(NSMutableAttributedString*)getAtrstrWithNum:(NSString *)num{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"你关注的知识有%@条动态更新",num]];
    [text yy_setFont:[UIFont systemFontOfSize:13.0f] range:text.yy_rangeOfAll];
    [text yy_setColor:HEXCOLOR(0x333333) range:text.yy_rangeOfAll];
    NSRange range0 = [[text string] rangeOfString:num options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:13.0f] range:range0];
    [text yy_setColor:HEXCOLOR(kBlueColor) range:range0];
    return text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
