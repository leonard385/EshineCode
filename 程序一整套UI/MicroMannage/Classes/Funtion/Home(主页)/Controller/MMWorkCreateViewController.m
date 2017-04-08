//
//  MMWorkCreateViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkCreateViewController.h"
#import "MMWorkCreateHeadView.h"
#import "MMWorkCreateContentCell.h"
#import "MMWorkCreateTaskCell.h"

@interface MMWorkCreateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMWorkCreateHeadView *headView;

@property(nonatomic,strong)UIButton *btnAddTask;

@end

@implementation MMWorkCreateViewController



-(MMWorkCreateHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMWorkCreateHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 134.0f)];
    }
    return _headView;
}

-(UIButton *)btnAddTask{
    if(_btnAddTask == nil){
        _btnAddTask = [UIButton new];
        [_btnAddTask setImage:[UIImage imageNamed:@"bth_icon_tianjia"] forState:UIControlStateNormal];
        [_btnAddTask setTitle:@"添加任务模块" forState:UIControlStateNormal];
        [_btnAddTask setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnAddTask.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_btnAddTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnAddTask addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddTask;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"发布工作";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WCSetUpNavItem];
    [self WCSetUpSubViews];
    
    // Do any additional setup after loading the view.
}

-(void)WCSetUpNavItem{
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    completeBtn.frame = CGRectMake(0, 0, 40, 20);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [completeBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(WCcompleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;
}

-(void)WCSetUpSubViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMWorkCreateContentCell class] forCellReuseIdentifier:@"MMWorkCreateContentCell"];
    [self.tableView registerClass:[MMWorkCreateTaskCell class] forCellReuseIdentifier:@"MMWorkCreateTaskCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 160.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.headView];
    [self.view addSubview:self.btnAddTask];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0,0, 44.0f, 0));
    }];
    
    [_btnAddTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44.0f);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1.0f;
        }
            break;
        case 1:{
            return 3.0f;
        }
            break;
            
        default:{
            return  0.0f;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MMWorkCreateContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMWorkCreateContentCell"];
            if(cell == nil){
                cell = [[MMWorkCreateContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMWorkCreateContentCell"];
            }
            
            cell.tableView = self.tableView;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;

        }
            break;
        case 1:{
            MMWorkCreateTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMWorkCreateTaskCell"];
            if(cell == nil){
                cell = [[MMWorkCreateTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMWorkCreateTaskCell"];
            }
            cell.tableView = self.tableView;
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
            break;
            
        default:{
            return nil;
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 添加模块点击
-(void)btnAddClick{
  
}

#pragma mark - 完成点击
-(void)WCcompleteBtnClick{
    
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
