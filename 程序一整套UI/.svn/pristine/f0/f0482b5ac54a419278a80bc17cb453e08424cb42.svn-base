//
//  WLControllerContainerCell.m
//  taobaoViewControllers
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "WLSegmentContainerView.h"
@interface WLSegmentContainerView()<UIScrollViewDelegate,WLMenuDelegate>
@property(nonatomic,strong)WLSegmentMenuView *segmentMenu;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)WLPageViewConfigModel *configModel;
@property(nonatomic,strong)NSArray *controllers;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)UIViewController *parentController;
@end

@implementation WLSegmentContainerView

-(WLSegmentMenuView *)segmentMenu{
    if(_segmentMenu == nil){
        _segmentMenu  = [[WLSegmentMenuView alloc]initWithFrame:CGRectMake(0, 0, k_WL_Screen_Width, _configModel.menuHeight) withConfig:_configModel withTitles:_titles];
        _segmentMenu.delegate = self;
    }
    return _segmentMenu;
}

-(UIScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _configModel.menuHeight, k_WL_Screen_Width, k_visalViewHeight - _configModel.menuHeight)];
        _scrollView.contentSize = CGSizeMake( k_WL_Screen_Width * _controllers.count , 0);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        
        //添加子视图
        for (int i = 0;i < _controllers.count;i++){
            UIViewController *controller = (UIViewController *)(_controllers[i]);
            controller.view.frame = CGRectMake( i * k_WL_Screen_Width, 0,k_WL_Screen_Width,k_visalViewHeight);
            [_scrollView addSubview:controller.view];
            
            [_parentController addChildViewController:controller];
            [controller didMoveToParentViewController:_parentController];
        }
    }
    return _scrollView;
}



-(instancetype)initWithFrame:(CGRect)frame Controllers:(NSArray *)controllers Titles:(NSArray*)titles withConfig:(WLPageViewConfigModel*)config parentVc:(UIViewController *)Vc{
    self = [super initWithFrame:frame];
    if(self){
        _titles = titles;
        _controllers = controllers;
        _configModel = config;
        _parentController = Vc;
        [self SCSetUpSubviews];
    }
    return self;
}

-(void)SCSetUpSubviews{
    [self addSubview:self.segmentMenu];
    [self addSubview:self.scrollView];
    
}

-(void)WLMenuBtnClick:(NSInteger)index{
    [_scrollView setContentOffset:CGPointMake(index*k_WL_Screen_Width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger idex = self.scrollView.contentOffset.x / k_WL_Screen_Width;
    [_segmentMenu progressLineMoveTo:idex];
}



@end
