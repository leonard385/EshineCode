//
//  WLSegmentMenuView.m
//  taobaoViewControllers
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "WLSegmentMenuView.h"

@interface WLSegmentMenuView()
@property(nonatomic,strong)UIView *progressLine;
@property(nonatomic,strong)UIView *viewLine;
@property(nonatomic,strong)UIButton *currentSelectedBtn;
@property(nonatomic,strong)WLPageViewConfigModel *configModel;
@property(nonatomic,strong)NSMutableArray *btnItems;
@end

#pragma mark - implementation WLSegmentMenuView
@implementation WLSegmentMenuView

-(NSMutableArray *)btnItems{
    if(_btnItems == nil){
        _btnItems = [NSMutableArray new];
    }
    return _btnItems;
}

-(instancetype)initWithFrame:(CGRect)frame withConfig:(WLPageViewConfigModel *)configModel withTitles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if(self){
        _configModel = configModel;
        _titles = titles;
        [self SMSetUpSubviews];
    }
    return self;
}


#pragma mark  -  SMSetUpSubviews
-(void)SMSetUpSubviews{
    [_btnItems removeAllObjects];
    float avgWidth = (self.frame.size.width/_titles.count);
    for (int i = 0;i < _titles.count;i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(self.frame.size.width/self.titles.count),0, self.frame.size.width/_titles.count, k_menuHight);
        btn.tag = i;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_configModel.titleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:_configModel.titleColorSelected forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:_configModel.titleSizeNormal]];
        [self addSubview:btn];
        [_btnItems addObject:btn];
    }
    CGFloat linPading = 12.0f * 2.0f;
    CGFloat lineW = avgWidth - linPading;
    _progressLine = [[UILabel alloc]initWithFrame:CGRectMake( (avgWidth - lineW) / 2,self.frame.size.height - _configModel.progressHeight - 0.5f, lineW, _configModel.progressHeight)];
    _progressLine.backgroundColor = _configModel.progressColor;
    [self addSubview:_progressLine];
    
    _viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, k_WL_Screen_Width, 0.5f)];
    _viewLine.backgroundColor = WLHEXCOLOR(0xcccccc);
    [self addSubview:_viewLine];
}


#pragma mark - 按钮点击progress移动动画效果
-(void)menuBtnClick:(UIButton *)sender{
    [self progressLineMoveTo:sender.tag];
    if ([_delegate respondsToSelector:@selector(WLMenuBtnClick:)]){
        [_delegate WLMenuBtnClick:sender.tag];
    }
}

-(void)progressLineMoveTo:(NSUInteger)index{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint frame = self.progressLine.center;
        frame.x = self.frame.size.width/(self.titles.count*2) + (self.frame.size.width/self.titles.count) * index;
        self.progressLine.center = frame;
        [_currentSelectedBtn.titleLabel setFont:[UIFont systemFontOfSize:_configModel.titleSizeSelected]];
    }];
    
    UIButton *indexBtn = _btnItems[index];
    _currentSelectedBtn.selected = NO;
    _currentSelectedBtn = indexBtn;
    _currentSelectedBtn.selected = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
