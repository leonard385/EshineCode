//
//  MMKnowlegeSelectViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/29.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeSelectViewController.h"
#import "MMbaseSelectCell.h"
@interface MMKnowlegeSelectViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISearchController *searchController;
@end

@implementation MMKnowlegeSelectViewController

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

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"从知识库导入";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self KSSetUpSubviews];
    // Do any additional setup after loading the view.
}
#pragma mark - subViews
-(void)KSSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.rowHeight = 51.0f;
    [self.tableView registerClass:[MMbaseSelectCell class] forCellReuseIdentifier:@"MMbaseSelectCell"];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMbaseSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMbaseSelectCell"];
    if(cell == nil){
        cell = [[MMbaseSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMbaseSelectCell"];
    }
    if(indexPath.row == 9.0f){
        cell.cellLine.hidden = YES;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
