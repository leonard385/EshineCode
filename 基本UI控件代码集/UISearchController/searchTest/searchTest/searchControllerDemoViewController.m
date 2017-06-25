//
//  searchControllerDemoViewController.m
//  searchTest
//
//  Created by 倪望龙 on 2017/6/25.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "searchControllerDemoViewController.h"
#define kTableCell @"tablecell"
@interface searchControllerDemoViewController ()<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)UISearchController *searchController;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *searchResults;//接收数据源结果
@end

@implementation searchControllerDemoViewController

-(NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = @[@"国服第一臭豆腐 No.1 Stinky Tofu CN.",
                                @"比尔吉沃特(Bill Ji walter)",
                                @"瓦洛兰 Valoran",
                                @"祖安 Zaun",
                                @"德玛西亚 Demacia",
                                @"诺克萨斯 Noxus",
                                @"艾欧尼亚 Ionia",].mutableCopy;
    }
    return _dataArray;
}

-(UISearchController *)searchController{
    if(_searchController == nil){
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.active = NO;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        [_searchController.searchBar sizeToFit];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)setUpSubviews{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.0f;
    _tableView.tableHeaderView = self.searchController.searchBar;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableCell];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.searchController.active ? self.searchResults:self.dataArray;
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableCell];
    }
    NSArray *array = self.searchController.active ? self.searchResults:self.dataArray;
    NSString *item = array[indexPath.row];
    cell.textLabel.text = item;
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchResults removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchController.searchBar.text];
    self.searchResults = [[self.dataArray filteredArrayUsingPredicate:searchPredicate]mutableCopy];
    [self.tableView reloadData];
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
