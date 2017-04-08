//
//  MMEmployStatisticViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployStatisticViewController.h"
#import "MMEmployeeHeadView.h"
#import "MMEmployStatisticTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MMEmployStatisticModel.h"
#import "MMEmployStatisticChartCell.h"
#import "MMEmployIncreaseViewController.h"
#import "MMEmployLeaveViewController.h"
@interface MMEmployStatisticViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMEmployeeHeadView *headView;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMEmployStatisticViewController
-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"EmployStatistic.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMEmployStatisticModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

-(MMEmployeeHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMEmployeeHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 178.0f)];
    }
    return _headView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self ESSetupSubviews];
    // Do any additional setup after loading the view.
}

-(void)ESSetupSubviews{
    WeakSelf();
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.tableHeaderView = self.headView;
    [self.tableView registerClass:[MMEmployStatisticTableViewCell class] forCellReuseIdentifier:@"MMEmployStatisticTableViewCell"];
     [self.tableView registerClass:[MMEmployStatisticChartCell class] forCellReuseIdentifier:@"MMEmployStatisticChartCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_headView setEHBtnClickBlock:^(NSUInteger idx) {
        switch (idx) {
            case 0:{//员工总数
              
            }
                break;
            case 1:{//离职员工
                MMEmployLeaveViewController *leaveVC = [MMEmployLeaveViewController new];
                [weakself.parentViewController.navigationController pushViewController:leaveVC animated:YES];
            }
                break;
            case 2:{//新增员工
                MMEmployIncreaseViewController *increaseVC = [ MMEmployIncreaseViewController new];
                [weakself.parentViewController.navigationController pushViewController:increaseVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            return [tableView fd_heightForCellWithIdentifier:@"MMEmployStatisticTableViewCell" configuration:^(MMEmployStatisticTableViewCell* cell) {
                [cell setDatas:self.plistArray];
            }];
        }
            break;
        case 1:{
            return 254.0f;
        }
            
        default:{
            return 0.0f;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MMEmployStatisticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEmployStatisticTableViewCell"];
            if(cell == nil){
                cell = [[MMEmployStatisticTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEmployStatisticTableViewCell"];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDatas:self.plistArray];
            return cell;
        }
            break;
            
        case 1:{
            MMEmployStatisticChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEmployStatisticChartCell"];
            if(cell == nil){
                cell = [[MMEmployStatisticChartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEmployStatisticChartCell"];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
            break;
            
        default:{
            return  nil;
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell isKindOfClass:[MMEmployStatisticChartCell class]]){
        [cell setNeedsDisplay];
        [(MMEmployStatisticChartCell *)cell redraw];
    }
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
