//
//  MainViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "WLPageViewController.h"
#import "WLTouchTableTableView.h"
#import "WLSegmentContainerView.h"

#define kHeadViewHeight 256.0f

@interface WLPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL canScroll;//子滑动视图能否滑动
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;//seactionHeadView能否滑动tableView

@property (nonatomic ,strong) WLTouchTableTableView * mainTableView;
@property(nonatomic,strong)UIView *headImageView;//头部UIview

@end

@implementation WLPageViewController
@synthesize mainTableView;

-(UIView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView= [[UIView alloc]init];
        _headImageView.frame=CGRectMake(0,0,k_WL_Screen_Width,kHeadViewHeight);
        _headImageView.backgroundColor = [UIColor redColor];
        _headImageView.userInteractionEnabled = YES;
        
    }
    return _headImageView;
}


-(UITableView *)mainTableView
{
    if (mainTableView == nil){
        mainTableView= [[WLTouchTableTableView alloc]initWithFrame:CGRectMake(0,64,k_WL_Screen_Width,k_WL_Screen_Height-64)];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.backgroundColor = [UIColor clearColor];
    
    }
    return mainTableView;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (instancetype)initWithControllers:(NSArray *)viewControlers titles:(NSArray *)titles config:(WLPageViewConfigModel*)config
{
    self = [super init];
    if (self) {
        self.viewControllers = viewControlers;
        self.titles = titles;
        self.configModel = config;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WLSetUpSubviews];
    
}

-(void)WLSetUpSubviews{
    [self.view addSubview:self.mainTableView];
    [self.mainTableView setTableHeaderView:self.headImageView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WLAcceptMsg:) name:k_leaveTopNotice object:nil];

}

#pragma mark - 通知
-(void)WLAcceptMsg : (NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

#pragma mark - scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     /*
     **处理联动
     */
    
    //1.获取滚动视图y值的偏移量
    CGFloat tabOffsetY = [mainTableView rectForSection:0].origin.y;//第一section 的原点
    CGFloat offsetY = scrollView.contentOffset.y;//contentoffset 在有headView在的情况下默认为 -headviewheight
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;

    if (offsetY >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    
    //2.滑动方向改变
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:k_goTopNotice object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
    
    //处理头部视图缩放效果
    if(offsetY < - kHeadViewHeight) {
        CGRect headBounds = self.headImageView.frame;
        headBounds.origin.y = offsetY ;
        headBounds.size.height =  -offsetY;
        headBounds.origin.y = offsetY;
        self.headImageView.frame = headBounds;
    }

}


#pragma marl - tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return k_visalViewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    WLSegmentContainerView * container = [[WLSegmentContainerView alloc]initWithFrame:CGRectMake(0, 0, k_WL_Screen_Width, k_visalViewHeight) Controllers:_viewControllers Titles:_titles withConfig:_configModel parentVc:self];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:container];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
