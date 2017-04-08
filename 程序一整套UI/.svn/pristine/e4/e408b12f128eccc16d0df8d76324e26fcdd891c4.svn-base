//
//  MMWorkDispathDetailController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/22.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkDispathDetailController.h"
#import "MMWorkDetailHeadFrame.h"
#import "MMWorkDetailHeadView.h"

@interface MMWorkDispathDetailController ()
@property(nonatomic,strong)MMWorkDetailHeadFrame *headModel;
@property(nonatomic,strong)MMWorkDetailHeadView *headView;
@end

@implementation MMWorkDispathDetailController

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
        viewModel.title = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        viewModel.userName = @"用户ABC";
        viewModel.taskTime = @"09:80";
        viewModel.taskDate = @"2017-02-04";
        viewModel.content = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        [_headModel setViewModel:viewModel];
    }
    return _headModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WDSetUpNavItem];
    [self WDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)WDSetUpNavItem{
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    editBtn.frame = CGRectMake(0, 0, 40, 20);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [editBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(WDeditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = editBtnItem;
    
    
}

-(void)WDSetUpSubviews{
    WeakSelf();
    self.title = @"工作详情";
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
-(void)WDeditBtnClick{
  
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
