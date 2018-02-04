//
//  LYSelfSizeCellDemo.m
//  autoLayoutDemo
//
//  Created by leo on 2018/2/2.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYSelfSizeCellDemo.h"
#import "LYSelfSizeCell.h"
@interface LYSelfSizeCellDemo ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation LYSelfSizeCellDemo
-(NSArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [NSArray arrayWithObjects:@"测试数据",@"测试数据sdas5a4s5d",@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据",@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据",nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self SSSetUpSubviews];
}

- (void)SSSetUpSubviews{
    [self.tableView registerClass:[LYSelfSizeCell class] forCellReuseIdentifier:@"LYSelfSizeCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80.0f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYSelfSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LYSelfSizeCell"];
    if(cell == nil){
        cell = [[LYSelfSizeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LYSelfSizeCell"];
    }
    NSString *content = self.dataArray[indexPath.row];
    cell.title = content;
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
