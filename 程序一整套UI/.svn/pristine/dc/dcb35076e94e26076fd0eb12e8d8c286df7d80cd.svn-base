//
//  MMWorkDetailViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkMyDetailViewController.h"
#import "MMWorkDetailHeadView.h"
#import "MMWorkDetailHeadFrame.h"
#import "MMWorkDetailTaskCell.h"
#import "MMDetailTaskFrame.h"
#import "CommentInputView.h"
#import "IQKeyboardManager.h"
@interface MMWorkMyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CommentInputViewDelegate>
@property(nonatomic,strong)MMWorkDetailHeadView *headView;
@property(nonatomic,strong)MMWorkDetailHeadFrame *headModel;
@property(nonatomic,strong)CommentInputView *inputView;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMWorkMyDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"工作详情";
    }
    return self;
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
        [_headView setFrameModel:self.headModel];
    }
    return _headView;
}

-(CommentInputView *)inputView{
    if(_inputView == nil){
        _inputView = [[CommentInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64.0f)];
        _inputView.hidden = YES;
        _inputView.delegate = self;
    }
    return _inputView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [_inputView addNotify];
    [_inputView addObserver];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [IQKeyboardManager sharedManager].enable = YES;
    [_inputView removeNotify];
    [_inputView removeObserver];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WDSetUpNavItem];
    [self WDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)WDSetUpNavItem{
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    completeBtn.frame = CGRectMake(0, 0, 40, 20);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [completeBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(WDcompleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;
    
    
}

-(void)WDSetUpSubviews{
    WeakSelf();
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMWorkDetailTaskCell class] forCellReuseIdentifier:@"MMWorkDetailTaskCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
    [self.view addSubview:self.inputView];
    
    [_headView setDropClickBlock:^(BOOL dropState) {
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakself.headModel.drop = dropState;
            [weakself.headView setFrameModel:weakself.headModel];
            [weakself.tableView setTableHeaderView:weakself.headView];
            [weakself.tableView beginUpdates];
            [weakself.tableView endUpdates];
        } completion:nil];
       
    }];
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
        weakself.inputView.commentId = 0;
        weakself.inputView.hidden = NO;
        [weakself.inputView show];
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

#pragma mark - 完成点击
-(void)WDcompleteBtnClick{

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
