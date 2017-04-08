//
//  MMWorkDetailViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkDetailViewController.h"
#import "MMWorkDetailHeadView.h"
#import "MMWorkDetailHeadFrame.h"
@interface MMWorkDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMWorkDetailHeadView *headView;
@property(nonatomic,strong)MMWorkDetailHeadFrame *headModel;
@end

@implementation MMWorkDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"工作详情";
    }
    return self;
}

-(MMWorkDetailHeadFrame *)headModel{
    if(_headModel == nil){
        _headModel = [MMWorkDetailHeadFrame new];
        MMWorkDetailHeadModel *viewModel = [MMWorkDetailHeadModel new];
        viewModel.title = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        viewModel.userName = @"用户ABC";
        viewModel.taskTime = @"09:80";
        viewModel.taskDate = @"2017-02-04";
        viewModel.content = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        [_headModel setViewModel:viewModel];
    }
    return _headModel;
}
-(MMWorkDetailHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMWorkDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WDSetUpSubviews];
    [self performSelector:@selector(headerSet) withObject:nil afterDelay:0.8];
    // Do any additional setup after loading the view.
}

-(void)WDSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.rowHeight = 100.0f;
//    [self.tableView registerClass:[MMWorkMyCell class] forCellReuseIdentifier:@"MMWorkMyCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MM"];
 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)headerSet{
    CGRect frame = self.headView.frame;
    frame.size.height = self.headModel.contentHeight;
    self.headView.frame = frame;
    [self.headView setFrameModel:self.headModel];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
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
