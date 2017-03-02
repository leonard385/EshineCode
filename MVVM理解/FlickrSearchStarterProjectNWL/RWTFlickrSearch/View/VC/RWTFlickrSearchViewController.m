//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTFlickrSearchImpl.h"
#import "RWTRecentSearchItemTableViewCell.h"


@interface RWTFlickrSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;//weak属性

@end

@implementation RWTFlickrSearchViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel
{
    self = [super init];
    if (self)
    {
        _viewModel = viewModel;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [self FSSetUpSubViews];
  [self bindViewModel];// 设置viewmode数据
}

#pragma mark - 子视图
-(void)FSSetUpSubViews{
    //导航按钮样式设计
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - 绑定view和viewmodel
- (void)bindViewModel
{
    self.title = self.viewModel.title;
    
    //Reactive cocoa数据绊定  view <-->view model
    RAC(self.viewModel,searchText) = self.searchTextField.rac_textSignal;
    
    self.searchButton.rac_command = self.viewModel.executeSearch;
    
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.executeSearch.executing;
    
    RAC(self.loadingIndicator, hidden) = [self.viewModel.executeSearch.executing not];
    
    //关闭键盘
    [self.viewModel.executeSearch.executionSignals subscribeNext:^(id x) {
        [self.searchTextField resignFirstResponder];
    }];
    
    [RACObserve(self.viewModel, SearchHistory)subscribeNext:^(NSArray* dataArray) {
        if(dataArray.count != 0){
            [self.searchHistoryTable reloadData];
        }
    } completed:^{
        
    }];
    
    UINib *nib = [UINib nibWithNibName:@"RWTRecentSearchItemTableViewCell" bundle:nil];
    [_searchHistoryTable registerNib:nib forCellReuseIdentifier:@"myCell"];
    [_searchHistoryTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _searchHistoryTable.delegate = self;
    _searchHistoryTable.dataSource = self;
    
    [_viewModel.connectionErrors subscribeNext:^(NSError *error) {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                   message:@"There was a problem reaching Flickr."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
    }];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.SearchHistory.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RWTRecentSearchItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[NSBundle mainBundle]loadNibNamed:@"RWTRecentSearchItemTableViewCell" owner:nil options:nil].firstObject;
    }
    [cell bindViewModel:self.viewModel.SearchHistory[indexPath.row]];
    return cell;
}

@end
