//
//  MMKnowlegeDetaiViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeDetaiViewController.h"
#import "MMKnowlegeDetailHeadView.h"
@interface MMKnowlegeDetaiViewController ()
@property(nonatomic,strong)MMKnowlegeDetailHeadView *headView;
@end

@implementation MMKnowlegeDetaiViewController

-(MMKnowlegeDetailHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMKnowlegeDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,190.0f)];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self KDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)KDSetUpSubviews{
    WeakSelf();
    self.title = @"人工智能";
    [self setWLtableHeadView:self.headView];
    [self.headView setFuncBtnClickBlock:^{
            CGRect frame = weakself.headView.frame;
            frame.size.height += 20.0f;
            weakself.headView.frame = frame;
            [weakself setWLtableHeadView:weakself.headView];
    }];
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
