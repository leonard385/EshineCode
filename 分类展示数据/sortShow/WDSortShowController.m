//
//  WDSortShowController.m
//  新闻分类导航条
//
//  Created by eshine_33 on 16/7/15.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "WDSortShowController.h"
#import "WDScrollTableCell.h"


@interface WDSortShowController ()<UITableViewDataSource,UITableViewDelegate,WDTopMenuDelegate>

@property (nonatomic, strong) WDTopMenu *topMenu;
//菜单选项下面的tableView
@property (nonatomic, strong) UITableView *bottomTableView;
@end

@implementation WDSortShowController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //添加顶部菜单
    WDTopMenu *topMenu = [[WDTopMenu alloc]initWithFrame:self.topMenuFrame];
    self.topMenu = topMenu;
    topMenu.delegate = self;
    //设置顶部菜单的数据源数组
    topMenu.arrMTopMenuOptions = self.arrMOptionsData;
    
    //添加下面的tableView
    [self setUpBottomTableView];
    
    self.bottomTableView.backgroundColor = [UIColor redColor];
    NSLog(@"%@",NSStringFromCGRect(self.bottomTableViewFrame));
    [self.view addSubview:topMenu];
    
}

/**
 *  创建底部的TableView
 */
- (void)setUpBottomTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.bottomTableView = tableView;
    //tableView旋转270度
    tableView.transform = CGAffineTransformMakeRotation(270 * M_PI / 180);
    //旋转之后 设置frame值
    tableView.frame = self.bottomTableViewFrame;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.showsVerticalScrollIndicator = NO;
    tableView.pagingEnabled = YES;
    //去除cell的分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableView];
}


#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMOptionsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDScrollTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (cell == nil) {
        cell = [[WDScrollTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = [UIColor blueColor];
        }
    }
    
    //给cell上的talblView赋值
    cell.tableViewOfOption = self.arrMTableViewsOfOption[indexPath.row];
    
    return cell;
}

//之前tableview的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell的高度--%f",tableView.frame.size.width);
    //cell的高度和屏幕的宽度相等
    return tableView.frame.size.width;
}

#pragma mark - tableView滚动结束后调用的代理方法   修改顶部菜单的选中选项
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [self.bottomTableView indexPathForRowAtPoint:scrollView.contentOffset];
    NSLog(@"当前tableView在的row = %ld",indexPath.row);
    //要让菜单选项对应进行选择
    
    [self.topMenu selectBtnOptionWith:indexPath.row];
}




#pragma mark - 顶部菜单的代理方法
- (void)wdTopMenu:(WDTopMenu *)topMenu curSelectedBtnOptionIndex:(NSInteger)index
{
    //让底部TableView滚动到对应的tableView
    [self.bottomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}


#pragma mark - 懒加载
- (NSMutableArray *)arrMTableViewsOfOption
{
    if (!_arrMTableViewsOfOption) {
        _arrMTableViewsOfOption = [NSMutableArray array];
    }
    return _arrMTableViewsOfOption;
}

@end
