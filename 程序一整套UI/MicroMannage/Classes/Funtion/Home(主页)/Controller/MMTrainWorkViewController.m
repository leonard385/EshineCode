//
//  MMTrainWorkViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainWorkViewController.h"
#import "MMTrainWorkCell.h"
#import "MMMyTrainDetailViewController.h"
#import "MMMyTrainOfflineDetailController.h"
@class MMTrainWorkModel;
@interface MMTrainWorkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMTrainWorkViewController
-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMTrainWork.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMTrainWorkModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self TWSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)TWSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.rowHeight = 100.0f;
    [self.tableView registerClass:[MMTrainWorkCell class] forCellReuseIdentifier:@"MMTrainWorkCell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"sectionHead"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(-10.0f, 0, 0, 0);
    
    [self.view addSubview:self.tableView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.plistArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.plistArray[section];
    return array.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHead"];
    if(headView == nil){
        UITableViewHeaderFooterView *headView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"sectionHead"];
        headView.backgroundView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMTrainWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainWorkCell"];
    
    if(cell == nil){
        cell = [[MMTrainWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainWorkCell"];
    }

    NSArray *array = self.plistArray[indexPath.section];
    MMTrainWorkModel *model = array[indexPath.row];
    [cell setCellModel:model];
    if(indexPath.row == (array.count - 1)){
        cell.cellLine.hidden = YES;
    }
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row % 2){
      MMMyTrainDetailViewController *vc = [MMMyTrainDetailViewController new];
      [self.parentViewController.navigationController pushViewController:vc animated:YES];
    }else{
      MMMyTrainOfflineDetailController *myVC = [MMMyTrainOfflineDetailController new];
      [self.parentViewController.navigationController pushViewController:myVC animated:YES];
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
