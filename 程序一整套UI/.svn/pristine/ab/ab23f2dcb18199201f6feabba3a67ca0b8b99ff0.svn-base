//
//  MMEvaluationMannagerController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/15.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationMannagerController.h"
#import "MMEvaluationMannagerCell.h"
#import "MMEvaluationDetailViewController.h"
#import "MMEvaluationCompleteController.h"
@class MMEvaluationMannageModel;
@interface MMEvaluationMannagerController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMEvaluationMannagerController

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMEvaluationMannage.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMEvaluationMannageModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self EMSetUpSubviews];
    // Do any additional setup after loading the view.
}

#pragma mark - subViews
-(void)EMSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 88.0f;
    [self.tableView registerClass:[MMEvaluationMannagerCell class] forCellReuseIdentifier:@"MMEvaluationMannagerCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMEvaluationMannagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEvaluationMannagerCell"];
    if(cell == nil){
        cell = [[MMEvaluationMannagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEvaluationMannagerCell"];
    }
    
    if(indexPath.row == (self.plistArray.count - 1)){
        cell.cellLine.hidden = YES;
    }
    
    MMEvaluationMannageModel *model =_plistArray[indexPath.row];
    [cell setCellModel:model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *VCs = [NSArray arrayWithObjects:
                    [MMEvaluationCompleteController new],
                    [MMEvaluationCompleteController new],nil];
    
    NSArray *titles = [NSArray arrayWithObjects:
                       @"已通过",
                       @"未通过",nil];

    MMEvaluationDetailViewController *Vc = [[MMEvaluationDetailViewController alloc]initWithControllers:VCs titles:titles];
    [self.parentViewController.navigationController pushViewController:Vc animated:YES];
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
