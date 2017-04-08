//
//  MMEvaluationCompleteController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationCompleteController.h"
#import "MMRankingActiveHeadView.h"
#import "MMRankingTimeTableViewCell.h"
#import "MMRankingTimeFooterView.h"
@interface MMEvaluationCompleteController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMRankingActiveHeadView *headView;
@property(nonatomic,strong)MMRankingTimeFooterView *footView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MMEvaluationCompleteController
-(MMRankingActiveHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMRankingActiveHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 168.0f)];
    }
    return _headView;
}

-(MMRankingTimeFooterView *)footView{
    if(_footView == nil){
        _footView = [MMRankingTimeFooterView new];
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self CCSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)CCSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight - 50.0f - 43.0f) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 50.0f;
    [self.tableView registerClass:[MMRankingTimeTableViewCell class] forCellReuseIdentifier:@"MMRankingTimeTableViewCell"];
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
    
    [_footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.tableView);
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.height.mas_equalTo(50.0f);
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMRankingTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMRankingTimeTableViewCell"];
    
    if(cell == nil){
        cell = [[MMRankingTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellStyleDefault"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == 9.0f){
        cell.cellLine.hidden = YES;
    }
    cell.index = [NSString stringWithFormat:@"%ld",indexPath.row + 3];
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
