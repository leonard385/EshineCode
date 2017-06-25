//
//  DZNEmptySetDemoController.m
//  EmptySetDemo_Third
//
//  Created by 倪望龙 on 2017/6/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "DemoTableViewController.h"
@interface DemoTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

#define cellIdentifier @"demoCell"
@implementation DemoTableViewController

-(NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ESSetUpSubviews];
    [self performSelector:@selector(httpDataRequest) withObject:nil afterDelay:0.5];
    // Do any additional setup after loading the view.
}

-(void)ESSetUpSubviews{
    _tableView.rowHeight = 44.0f;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self httpDataRequest];
    }];
    NSArray *magesArray = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"loading1.png"],
                           [UIImage imageNamed:@"loading2.png"],
                           [UIImage imageNamed:@"loading3.png"],
                           [UIImage imageNamed:@"loading4.png"],
                           [UIImage imageNamed:@"loading5.png"],
                           [UIImage imageNamed:@"loading6.png"],
                           [UIImage imageNamed:@"loading7.png"],
                           [UIImage imageNamed:@"loading8.png"],
                           [UIImage imageNamed:@"loading9.png"],
                           [UIImage imageNamed:@"loading10.png"],
                           [UIImage imageNamed:@"loading11.png"],
                           [UIImage imageNamed:@"loading12.png"],
                           [UIImage imageNamed:@"loading13.png"],
                           nil];

    [header setImages:magesArray forState:MJRefreshStateIdle];
    [header setImages:magesArray forState:MJRefreshStatePulling];
    [header setImages:magesArray forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;

    __weak typeof(self)weakself = self;
    [self setDidTapEmptyViewBlock:^{
        [weakself setEmptyType:loading];
        [weakself.tableView reloadEmptyDataSet];
        [weakself httpDataRequest];
    }];
}

-(void)httpDataRequest{
    AFHTTPSessionManager *mannage = [AFHTTPSessionManager manager];
    mannage.requestSerializer.timeoutInterval = 20.0f;
    NSString *url = [NSString stringWithFormat:@"%@",@"http://soft.xunyijia.cn:6161/app/noticeAppCtrl/homeForNoticeList"];
    [mannage GET:url
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [self setEmptyType:requestComplete];
             NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
             [self.dataArray removeAllObjects];
             [self.dataArray addObjectsFromArray:array];
             [self.tableView reloadData];
             [self.tableView.mj_header endRefreshing];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             long errorCode = error.code;
             NSString *errorDesc = [self errorTipHandleWithCode:errorCode];
             NSLog(@"%@",errorDesc);
             [self.tableView reloadData];
             [self.tableView.mj_header endRefreshing];
         }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个cell",(long)indexPath.row];
    return cell;
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
