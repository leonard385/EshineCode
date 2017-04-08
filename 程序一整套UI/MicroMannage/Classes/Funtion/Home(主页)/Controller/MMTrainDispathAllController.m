//
//  MMTrainDispathAllController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainDispathAllController.h"
#import "MMDispathDetailCell.h"
#import "MMTrainDispathDetailController.h"
@interface MMTrainDispathAllController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MMTrainDispathAllController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)TDSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    [self.tableView registerClass:[MMDispathDetailCell class] forCellReuseIdentifier:@"MMDispathDetailCell"];
    self.tableView.rowHeight = 78.0f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 43.0f, 0));
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMDispathDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMDispathDetailCell"];
    if(cell == nil){
        cell = [[MMDispathDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMDispathDetailCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MMTrainDispathDetailController *VC = [[MMTrainDispathDetailController alloc]init];
    [self.parentViewController.navigationController pushViewController:VC animated:YES];
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
