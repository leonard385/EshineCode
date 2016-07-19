//
//  WDTopMenu.m
//  新闻分类导航条
//
//  Created by eshine_33 on 16/7/15.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "WDTopMenu.h"

#define KLeftMargin 15
#define KFont(fontSize) [UIFont systemFontOfSize:fontSize]

//类扩展
@interface WDTopMenu ()

//顶部菜单的scrollView
@property (nonatomic, strong) UIScrollView *scrollViewOfTopMenu;
@end


@implementation WDTopMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
        self.scrollViewOfTopMenu = scrollView;
        //关闭滚动指示器
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        //设置菜单颜色
        scrollView.backgroundColor = [UIColor orangeColor];
        
        //添加scrollView到当前view上
        [self addSubview:scrollView];
    }
    return self;
}

/**
 *  重写菜单选项数据源数组的set方法
 *
 *  @param arrMTopMenuOptions 菜单选项数据源数组
 */
- (void)setArrMTopMenuOptions:(NSMutableArray *)arrMTopMenuOptions
{
    _arrMTopMenuOptions = arrMTopMenuOptions;
    //根据数据源数组 把按钮添加到scrollview中
    [self addOptionBtnToTopMenuWith:arrMTopMenuOptions];
}

/**
 *  根据数据源 添加选项按钮到菜单上
 *
 *  @param optionsArr 数据源数组
 */
- (void)addOptionBtnToTopMenuWith:(NSMutableArray *)optionsArr
{
    
    for (int i = 0; i < optionsArr.count; ++i) {
        UIButton *btnOption = [UIButton buttonWithType:UIButtonTypeCustom];
        btnOption.tag = i;
        //设置btn上的文字
        [btnOption setTitle:optionsArr[i] forState:UIControlStateNormal];
        btnOption.titleLabel.font = KFont(16);
        
        //按钮背景色
        btnOption.backgroundColor = [UIColor brownColor];
        
        //设置字体颜色
        [btnOption setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnOption setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        
        [btnOption addTarget:self action:@selector(btnOptionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnOptionX = KLeftMargin;
        //布局选项按钮
        if (self.scrollViewOfTopMenu.subviews.count > 0) {
            btnOptionX = CGRectGetMaxX(self.scrollViewOfTopMenu.subviews.lastObject.frame) + KLeftMargin;
        }
        
        //计算按钮的宽度
        CGRect btnOptionRect =  [optionsArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KFont(16)} context:nil];
        
        //设置按钮的frame
        btnOption.frame = CGRectMake(btnOptionX, 0, btnOptionRect.size.width, self.scrollViewOfTopMenu.bounds.size.height);
     
        [self.scrollViewOfTopMenu addSubview:btnOption];
        
        //计算菜单scrollView的水平滚动范围
        if (self.scrollViewOfTopMenu.subviews.count > 0) {
            self.scrollViewOfTopMenu.contentSize = CGSizeMake(CGRectGetMaxX(self.scrollViewOfTopMenu.subviews.lastObject.frame) + KLeftMargin   , 0);
        }
        
        
        //默认选中第一个按钮
        if (i == 0) {
            [self performSelector:@selector(btnOptionClick:) withObject:btnOption];
        }
    }
    
}

/**
 *  菜单选项btn 的单击事件
 *
 *  @param sender 当前被单击的选项按钮
 */
- (void)btnOptionClick:(UIButton *)sender
{
    
    NSLog(@"单击的按钮是:%@---%ld",sender.currentTitle,sender.tag);
    
    //如果单击的按钮是当前选中的按钮
    if (self.btnCurSelected == sender) {
        return;
    }
    
    //取消之前选中按钮的状态 并记录当前的按钮
    self.btnCurSelected.selected = NO;
    sender.selected = YES;
    self.btnCurSelected = sender;
    
    NSLog(@"选中的按钮是:%@---%ld",self.btnCurSelected.currentTitle,self.btnCurSelected.tag);

    if (_delegate && [_delegate respondsToSelector:@selector(wdTopMenu:curSelectedBtnOptionIndex:)]) {
        [_delegate wdTopMenu:self curSelectedBtnOptionIndex:sender.tag];
    }
}

/**
 *  根据小标索引选中菜单选项中 指定的选项按钮
 *
 *  @param index 指定的索引
 */
- (void)selectBtnOptionWith:(NSInteger )index
{
    UIButton *btn = self.scrollViewOfTopMenu.subviews[index];
    
    if (self.btnCurSelected.tag == btn.tag) {
        return;
    }else{
        self.btnCurSelected.selected = NO;
        btn.selected = YES;
        self.btnCurSelected = btn;
    }
    
    
    //计算scrollview偏移量 尽量把当前选中的选项移到屏幕的中心位置
    //选中的选项菜单项中心距离 菜单中心的距离
    CGFloat originX = self.btnCurSelected.center.x - CGRectGetMidX(self.scrollViewOfTopMenu.frame);
    CGFloat maxOffsetX = self.scrollViewOfTopMenu.contentSize.width - self.scrollViewOfTopMenu.frame.size.width;
    
    NSLog(@"originX--%f--maxOffsetX--%f",originX,maxOffsetX);
    if (originX < 0) {
        //说明当前选项还在 中心的左边无需滚动
        originX = 0;
    }else if (originX > maxOffsetX){
        //说明选项超出 总的偏移量
        originX = maxOffsetX;
    }
    //设置scrollView的偏移值
    [self.scrollViewOfTopMenu setContentOffset:CGPointMake(originX, 0) animated:YES];
}
@end
