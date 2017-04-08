//
//  MMDispathTaskDetailController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/22.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMDispathTaskDetailController.h"
#import "MMTaskDetailHeadView.h"
#import "MMWorkDetailTaskCell.h"
#import "MMDetailTaskFrame.h"
@interface MMDispathTaskDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMTaskDetailHeadView *headView;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMDispathTaskDetailController
-(MMTaskDetailHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMTaskDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 88.0f)];
    }
    return _headView;
}

-(NSArray *)plistArray{
    if(_plistArray == nil){
        MMDetailTaskFrame *frame = [MMDetailTaskFrame new];
        MMDetailTaskModel *model = [MMDetailTaskModel new];
        model.title = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        model.name = @"张笑笑";
        model.time = @"10:30";
        model.chatContents = @[@"店长:完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查",@"我：完成100个用户调查完成100个用户调查",@"店长:完成100个用户调查完成100个用户调查",@"我：完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查"];
        [frame setViewModel:model];
        MMDetailTaskFrame *frame2 = [MMDetailTaskFrame new];
        MMDetailTaskModel *model2 = [MMDetailTaskModel new];
        model2.title = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        [frame2 setViewModel:model2];
        _plistArray = [NSArray arrayWithObjects:frame,frame2, nil];
    }
    return _plistArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"完成100个用户调查";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)TDSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMWorkDetailTaskCell class] forCellReuseIdentifier:@"MMWorkDetailTaskCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMDetailTaskFrame *frame = self.plistArray[indexPath.row];
    return frame.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf();
    MMWorkDetailTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMWorkDetailTaskCell"];
    if(cell == nil){
        cell = [[MMWorkDetailTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMWorkDetailTaskCell"];
    }
    MMDetailTaskFrame *frame = self.plistArray[indexPath.row];
    [cell setFrameModel:frame];
    [cell setTaskIdex:indexPath.row + 1];
    [cell setChatClickBlock:^{
        
    } CompleteClickBlock:^(UIButton *sender) {
        sender.selected = !sender.selected;
    } ShowAllClickBlock:^(BOOL isShowAll) {
        frame.showAll = isShowAll;
        [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
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
