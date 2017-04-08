//
//  MMNoticeViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMNoticeViewController.h"
#import "MMNoticeTableViewCell.h"
@interface MMNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MMNoticeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"公告";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self NVSetUpSubviews];
}

#pragma mark - subViews
-(void)NVSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 93.0f;
    [self.tableView registerClass:[MMNoticeTableViewCell class] forCellReuseIdentifier:@"MMNoticeTableViewCell"];
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
    MMNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMNoticeTableViewCell"];
    if(cell == nil){
        cell = [[MMNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMNoticeTableViewCell"];
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
