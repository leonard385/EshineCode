//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "CETableViewBindingHelper.h"
#import "RWTSearchResultsTableViewCell.h"

@interface RWTSearchResultsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (strong, nonatomic) RWTSearchResultsViewModel *viewModel;//viewModel

@end

@implementation RWTSearchResultsViewController
- (instancetype)initWithViewModel:(RWTSearchResultsViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self TRSetUpSubviews];
    [self bindViewModel];
}
#pragma mark - 设置子视图
-(void)TRSetUpSubviews{
    [self.searchResultsTable registerNib:[UINib nibWithNibName:@"RWTSearchResultsTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchResults"];
    self.searchResultsTable.dataSource = self;
    self.searchResultsTable.delegate   = self;
}

#pragma mark - 数据绑定
- (void)bindViewModel {
    self.title = self.viewModel.title;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"searchResults";
    RWTSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RWTSearchResultsTableViewCell" owner:nil options:nil]lastObject];
    }
    [cell bindViewModel:self.viewModel.searchResults[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 206.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 搜索结果滑动效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *cells = [self.searchResultsTable visibleCells];
    for (RWTSearchResultsTableViewCell *cell in cells) {
        CGFloat value = -40 + (cell.frame.origin.y - self.searchResultsTable.contentOffset.y) / 5;
        [cell setParallax:value];
    }
   
}
@end
