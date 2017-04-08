//
//  MMContantViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMContantViewController.h"
#import "MMContantSectionHead.h"
#import "MMContantGrounpModel.h"
#import "MMContantFriendsCell.h"
#import "MMContantGrounpBtn.h"
#import "MMContantFriendsModel.h"

@interface MMContantViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,strong)MMContantGrounpBtn *btnGrounp;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMContantViewController
-(UISearchController *)searchController{
    if(_searchController == nil){
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.tintColor = HEXCOLOR(0xaaaaaa);
        _searchController.searchBar.barTintColor = HEXCOLOR(0xf0f3f8);
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.dimsBackgroundDuringPresentation = NO;
        [_searchController.searchBar sizeToFit];
        
    }
    return _searchController;
}

-(MMContantGrounpBtn *)btnGrounp{
    if(_btnGrounp == nil){
        _btnGrounp = [[MMContantGrounpBtn alloc]initWithFrame:CGRectMake(0, 47.0f, kScreenWidth, 55.0f)];
        [_btnGrounp setBackgroundColor:[UIColor whiteColor]];
        [_btnGrounp addTarget:self action:@selector(btnGrounpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGrounp;
}

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMContantGroups.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        [MMContantGrounpModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"friends" : @"MMContantFriendsModel",
                     };
        }];
        NSArray *models = [MMContantGrounpModel mj_objectArrayWithKeyValuesArray:listArray];

        _plistArray = models;
    }
    return _plistArray;
}


-(UIView *)headView{
    if(_headView == nil){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 115.0f)];
        _headView.backgroundColor = HEXCOLOR(0xefeff4);
        [_headView addSubview:self.searchController.searchBar];
        [_headView addSubview:self.btnGrounp];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CVSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)CVSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight - kTabbarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionHeaderHeight = 50.0f;
    self.tableView.rowHeight = 55.0f;
    [self.tableView registerClass:[MMContantSectionHead class] forHeaderFooterViewReuseIdentifier:@"MMContantSectionHead"];
    [self.tableView registerClass:[MMContantFriendsCell class] forCellReuseIdentifier:@"MMContantFriendsCell"];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.plistArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MMContantGrounpModel *model = self.plistArray[section];
    if(model.isDrop){
       return model.friends.count;
    }else{
        return 0.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMContantFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMContantFriendsCell"];
    if(cell== nil){
        cell = [[MMContantFriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMContantFriendsCell"];
    }
    MMContantGrounpModel *model = self.plistArray[indexPath.section];
    MMContantFriendsModel *cellModel = model.friends[indexPath.row];
    if(indexPath.row == model.friends.count - 1){
        cell.cellLine.hidden = YES;
    }else{
        cell.cellLine.hidden = NO;
    }
    [cell setCellModel:cellModel];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WeakSelf();
    MMContantSectionHead *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MMContantSectionHead"];
    if(view == nil){
        view = [[MMContantSectionHead alloc]initWithReuseIdentifier:@"MMContantSectionHead"];
    }
    MMContantGrounpModel *model = self.plistArray[section];
    
    [view setSectionClickBlock:^(BOOL state) {
        model.isDrop = state;
        [weakself.tableView reloadData];
    }];
    [view setHeadModel:model];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 点击
-(void)btnGrounpClick{
   
}

#pragma mark  - 更新代理

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //    [self.DateArray removeAllObjects];
    //    //执行搜索操作
    //    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",_searchController.searchBar.text];
    //    self.searchArray = [[self.DateArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    //    //刷新表格
    //    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
