//
//  MMTrainDispathController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainDispathController.h"
#import "MMWorkDetailHeadFrame.h"
#import "MMWorkDetailHeadView.h"
#import "MMTrainCreateViewController.h"
@interface MMTrainDispathController ()
@property(nonatomic,strong)MMWorkDetailHeadFrame *headModel;
@property(nonatomic,strong)MMWorkDetailHeadView *headView;
@end

@implementation MMTrainDispathController
-(MMWorkDetailHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMWorkDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [_headView setFrameModel:self.headModel];
    }
    return _headView;
}

-(MMWorkDetailHeadFrame *)headModel{
    if(_headModel == nil){
        _headModel = [MMWorkDetailHeadFrame new];
        MMWorkDetailHeadModel *viewModel = [MMWorkDetailHeadModel new];
        viewModel.title = @"如何激励员工高效率";
        viewModel.userName = @"柳叶叶";
        viewModel.taskTime = @"09:10";
        viewModel.taskDate = @"2017-02-14";
        viewModel.content = @"店长培训店长培训店长培训店长培训店长培训店长培训店长培训店长培训店长培训店长培训店长培训店长培训店长培训";
        [_headModel setViewModel:viewModel];
    }
    return _headModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self TDSetUpNavItem];
    [self TDSetUpSubviews];
}

-(void)TDSetUpNavItem{
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    editBtn.frame = CGRectMake(0, 0, 40, 20);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [editBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(TDeditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;
    
    
}

-(void)TDSetUpSubviews{
    WeakSelf();
    self.title = @"培训详情";
    [self setWLtableHeadView:self.headView];
    [_headView setDropClickBlock:^(BOOL dropState) {
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakself.headModel.drop = dropState;
            [weakself.headView setFrameModel:weakself.headModel];
            [weakself setWLtableHeadView:weakself.headView];
        } completion:nil];
    }];
}

#pragma mark - 编辑
-(void)TDeditBtnClick{
    MMTrainCreateViewController *vc = [MMTrainCreateViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
