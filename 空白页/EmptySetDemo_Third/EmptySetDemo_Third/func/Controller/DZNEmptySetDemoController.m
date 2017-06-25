//
//  DZNEmptySetDemoController.m
//  EmptySetDemo_Third
//
//  Created by 倪望龙 on 2017/6/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "DZNEmptySetDemoController.h"
@interface DZNEmptySetDemoController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

#define cellIdentifier @"demoCell"
@implementation DZNEmptySetDemoController

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
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self httpDataRequest];
    }];
    
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
                NSNumber *stateCode = ((NSDictionary *)responseObject)[@"errorCode"];
                NSString *msg = ((NSDictionary *)responseObject)[@"message"];
                [self setEmptyType:requestComplete];
                if([stateCode unsignedIntegerValue] == 200){//正常数据请求
                    //数据如果是空白的
                    NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObjectsFromArray:array];
                }else{//出错(服务器可以处理的错误)
                    //弹出HUD
        
                }
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
