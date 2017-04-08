//
//  MMTrainDispathOfflineController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainDispathOfflineController.h"
#import "MMTrainOfflineDetailHead.h"
#import "MMTrainOfflineHeadFrame.h"
#import "MMOfflineQrcodeView.h"
#import "JCAlertView.h"
@interface MMTrainDispathOfflineController ()<TOMenuDelegate>
@property(nonatomic,strong)MMTrainOfflineDetailHead *headView;
@property(nonatomic,strong)MMTrainOfflineHeadFrame *headModel;
@property(nonatomic,strong)MMOfflineQrcodeView *qrAlertView;
@end

@implementation MMTrainDispathOfflineController

-(MMOfflineQrcodeView *)qrAlertView{
    if(_qrAlertView == nil){
        _qrAlertView = [[MMOfflineQrcodeView alloc]initWithFrame:CGRectMake(0, 0, 291.0f, 404.0f)];
        _qrAlertView.backgroundColor = [UIColor whiteColor];
        _qrAlertView.layer.cornerRadius = 5.0f;
        _qrAlertView.layer.masksToBounds = YES;
    }
    return _qrAlertView;
}

-(MMTrainOfflineHeadFrame *)headModel{
    if(_headModel == nil){
        _headModel = [MMTrainOfflineHeadFrame new];
        MMTrainOfflineHeadModel *viewModel = [MMTrainOfflineHeadModel new];
        viewModel.title = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        viewModel.userName = @"用户ABC";
        viewModel.trainTime = @"09:80";
        viewModel.trainDate = @"2017-02-04";
        viewModel.content = @"培训地址：广州市天河区建中路 培训店长相关课程培训店长相关课程培训店长相关课程培训店长相关课程培训店长相关课程培训店长相关课程";
        viewModel.segmentTitles = @[@"3-17 09:00",@"3-17 10:00",@"3-17 12:00",@"3-17 13:00",@"3-17 18:00"];
        [_headModel setViewModel:viewModel];
    }
    return _headModel;
}

-(MMTrainOfflineDetailHead *)headView{
    if(_headView == nil){
        _headView = [MMTrainOfflineDetailHead new];
        [_headView setFrameModel:self.headModel];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TDSetUpNavItem];
    [self TDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)TDSetUpNavItem{
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    completeBtn.frame = CGRectMake(0, 0, 40, 20);
    [completeBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [completeBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(TDeditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;

}


-(void)TDSetUpSubviews{
    WeakSelf();
    [self setWLtableHeadView:self.headView];
    [_headView setDropClickBlock:^(BOOL dropState) {
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakself.headModel.drop = dropState;
            [weakself.headView setFrameModel:weakself.headModel];
            [weakself setWLtableHeadView:weakself.headView];
        } completion:nil];
    }];
    _headView.delegate = self;
    
    [_headView setQrCodeClickBlock:^{
        [weakself openAlert];
    }];

}

-(void)openAlert{
  JCAlertView * alert = [[JCAlertView alloc]initWithCustomView:self.qrAlertView dismissWhenTouchedBackground:NO];
    [_qrAlertView setOQcloseClickBlock:^{
        [alert dismissWithCompletion:nil];
    }];
    [_qrAlertView setOQsaveClickBlock:^{
         [alert dismissWithCompletion:nil];
    }];
    [alert show];

}

#pragma mark - 编辑
-(void)TDeditBtnClick{
   
}

-(void)TOMenuBtnClick:(NSInteger)idex{
 
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
